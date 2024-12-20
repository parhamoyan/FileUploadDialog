#include "FakeUploadManager.h"
#include <QRandomGenerator>

FakeUploadManager::FakeUploadManager(QObject* parent)
    : QObject(parent) {
    connect(&m_timer, &QTimer::timeout, this, &FakeUploadManager::updateProgress);
}

void FakeUploadManager::startUpload() {
    m_progress = 0;
    emit progressChanged();

    m_timer.start(20); // Simulate progress every 100ms
}

void FakeUploadManager::updateProgress() {
    if (m_progress < 100) {
        float increment = 1.0f + QRandomGenerator::global()->bounded(1.0f);

        m_progress += increment; // Increment progress
        emit progressChanged();
    } else {
        m_timer.stop();
        emit uploadFinished();
    }
}

Q_INVOKABLE void FakeUploadManager::getFileSize(const QString &filePath, QObject *callback) {
    QFileInfo fileInfo(filePath);
    if (fileInfo.exists() && fileInfo.isFile()) {
        const qint64 fileSize = fileInfo.size();
        QMetaObject::invokeMethod(callback, "callback", Q_ARG(QVariant, fileSize));
    } else {
        QMetaObject::invokeMethod(callback, "callback", Q_ARG(QVariant, -1)); // Invalid file
    }
}

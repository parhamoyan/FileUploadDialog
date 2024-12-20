#include "FileUtilities.h"
#include <QFileInfo>


FileUtilities::FileUtilities(QObject *parent)
    : QObject{parent}
{}


Q_INVOKABLE QString FileUtilities::getFileExtension(const QString &filePath) const {
    QFileInfo fileInfo(filePath);
    if (fileInfo.exists() && fileInfo.isFile()) {
        return fileInfo.suffix(); // Return the file extension
    }
    return ""; // Return empty string if file doesn't exist
}

// Get the file size (volume) in bytes
Q_INVOKABLE qint64 FileUtilities::getFileSize(const QString &filePath) const {
    QFileInfo fileInfo(filePath);
    if (fileInfo.exists() && fileInfo.isFile()) {
        return fileInfo.size(); // Return file size in bytes
    }
    return -1; // Return -1 if file doesn't exist
}

Q_INVOKABLE QString FileUtilities::getFormattedFileSize(const QString &filePath) const {
    QFileInfo fileInfo(filePath);
    if (!fileInfo.exists() || !fileInfo.isFile()) {
        return "File does not exist";
    }

    qint64 sizeInBytes = fileInfo.size();
    return formatSize(sizeInBytes);
}

QString FileUtilities::formatSize(qint64 bytes) const {
    const double KB = 1024.0;
    const double MB = KB * 1024.0;
    const double GB = MB * 1024.0;

    if (bytes < KB) {
        return QString::number(bytes) + " Bytes";
    } else if (bytes < MB) {
        return QString::number(bytes / KB, 'f', 2) + " KB";
    } else if (bytes < GB) {
        return QString::number(bytes / MB, 'f', 2) + " MB";
    } else {
        return QString::number(bytes / GB, 'f', 2) + " GB";
    }
}

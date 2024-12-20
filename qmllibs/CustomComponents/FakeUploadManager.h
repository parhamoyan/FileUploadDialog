#include <QObject>
#include <QQmlEngine>
#include <QTimer>
#include <QFileInfo>

class FakeUploadManager : public QObject {
    QML_ELEMENT
    Q_OBJECT
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)

public:
    explicit FakeUploadManager(QObject* parent = nullptr);

    Q_INVOKABLE void startUpload();

    int progress() const { return m_progress; }

    Q_INVOKABLE void getFileSize(const QString &filePath, QObject *callback);

signals:
    void progressChanged();
    void uploadFinished();

private slots:
    void updateProgress();

private:
    QTimer m_timer;
    int m_progress = 0;
};

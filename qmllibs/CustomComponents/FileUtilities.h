#ifndef FILEUTILITIES_H
#define FILEUTILITIES_H

#include <QObject>
#include <QQmlEngine>

class FileUtilities : public QObject
{
    QML_ELEMENT
    Q_OBJECT
public:
    explicit FileUtilities(QObject *parent = nullptr);

    Q_INVOKABLE QString getFileExtension(const QString &filePath) const;
    Q_INVOKABLE qint64 getFileSize(const QString &filePath) const;
    Q_INVOKABLE QString getFormattedFileSize(const QString &filePath) const;

private:
    QString formatSize(qint64 bytes) const;

};

#endif // FILEUTILITIES_H

#ifndef CUSTOM_WINDOW_H
#define CUSTOM_WINDOW_H

#include <QQuickWindow>
#include <QGuiApplication>
#include <QScreen>

class CustomWindow : public QQuickWindow {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit CustomWindow(QWindow *parent = nullptr);

    Q_INVOKABLE void mergeTitleBarWithContent();

protected:
    void showEvent(QShowEvent *event) override;

private:
    void setupWindow();
};


#endif // CUSTOM_WINDOW_H

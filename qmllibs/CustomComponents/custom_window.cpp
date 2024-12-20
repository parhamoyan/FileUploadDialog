#include "custom_window.h"
#include "macos_utils.h"


CustomWindow::CustomWindow(QWindow *parent)
    : QQuickWindow(parent) {
    setupWindow();
}

void CustomWindow::setupWindow() {
    // Basic window setup (size, title, etc.)
    setTitle("Custom Window");
    resize(800, 600);
    show();
}

void CustomWindow::showEvent(QShowEvent *event) {
    QQuickWindow::showEvent(event);
    merge_title_bar_and_content_area(this);
}

void CustomWindow::mergeTitleBarWithContent() {
    merge_title_bar_and_content_area(this);
}

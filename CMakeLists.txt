cmake_minimum_required(VERSION 3.16)

project(FileUploadApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Gui QuickControls2 REQUIRED)
set(QT_QML_GENERATE_QMLLS_INI ON)


add_subdirectory(qmllibs/CustomComponents)
set(QML_IMPORT_PATH ${PWD}/qmllibs/CustomComponents)

qt6_add_executable(FileUploadApp
    main.cpp
)

qt6_add_qml_module(FileUploadApp
    URI main
    VERSION 1.0

    QML_FILES
        Main.qml

    DEPENDENCIES
        QtQuick
)

target_link_libraries(FileUploadApp PRIVATE Qt6::Gui Qt6::Quick Qt6::QuickControls2)


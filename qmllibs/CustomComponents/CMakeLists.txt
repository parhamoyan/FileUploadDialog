set_source_files_properties(CustomFonts.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

set(QT_QML_GENERATE_QMLLS_INI ON)

qt6_add_qml_module(CustomComponents
    URI qmllibs.CustomComponents
    VERSION 1.0
    SOURCES
        macos_utils.h
        macos_utils.mm
        custom_window.cpp
        custom_window.h

    SOURCES FakeUploadManager.h FakeUploadManager.cpp
    SOURCES FileUtilities.h FileUtilities.cpp

    QML_FILES
        DashedBorderFrame.qml
        FileUploadDialog.qml
        CustomFonts.qml
        DownloadItem.qml


    RESOURCES
        ../../resources/fonts/Lexend-Black.ttf
        ../../resources/fonts/Lexend-Bold.ttf
        ../../resources/fonts/Lexend-ExtraBold.ttf
        ../../resources/fonts/Lexend-ExtraLight.ttf
        ../../resources/fonts/Lexend-Light.ttf
        ../../resources/fonts/Lexend-Medium.ttf
        ../../resources/fonts/Lexend-Regular.ttf
        ../../resources/fonts/Lexend-SemiBold.ttf
        ../../resources/fonts/Lexend-Thin.ttf
        ../../resources/icons/upload_icon.svg
        ../../resources/icons/text_flat_ico.svg
        ../../resources/icons/x.svg
        ../../resources/icons/CSV.svg

    DEPENDENCIES
        QtQuick
        QML_FILES

)

target_link_libraries(CustomComponents
    PRIVATE Qt6::Quick
)


install(TARGETS CustomComponents
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml/qmllibs/CustomComponents)
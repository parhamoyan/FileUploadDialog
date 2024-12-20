import qmllibs.CustomComponents 1.0
import QtQuick 6.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import QtQml

CustomWindow {
    id: root

    visible: true
    width: 716
    height: defaultHeight
    title: ""

    // Constants for configuration
    readonly property int animationDuration: 400
    readonly property double maxFileSizeMB: 100
    readonly property string supportedFormat: ".CSV"

    // Properties to manage window dimensions and download items
    property list<QtObject> downloadItems: []
    property double defaultHeight: 608
    property double expandedHeight: 768

    // Smooth height animation when resizing
    Behavior on height {
        NumberAnimation {
            duration: animationDuration
            easing.type: Easing.InOutSine
        }
    }

    // Upload manager for handling file uploads
    FakeUploadManager {
        id: uploadManager

        onProgressChanged: {
            rootContent.progressValue = uploadManager.progress / 100;
            if (root.downloadItems.length > 0) {
                root.downloadItems[0].progressValue = rootContent.progressValue;
            }
        }

        onUploadFinished: {
            console.log("Upload finished");
            rightButton.rightButtonActive = true;
        }
    }

    // Handler for enabling window dragging
    DragHandler {
        grabPermissions: TapHandler.DragThreshold
        onActiveChanged: {
            if (active) {
                console.log("Window drag started");
                root.startSystemMove();
            }
        }
    }

    // Utility function to extract file details
    function getFileDetails(fileUrl) {
        console.log("Getting file details for: ", fileUrl);
        const filePath = fileUrl.replace("file://", "");
        return {
            name: filePath.split("/").pop(),
            extension: filePath.split(".").pop(),
            size: fileUtilities.getFormattedFileSize(filePath)
        };
    }

    // Function to handle file download logic
    function downloadFile(fileUrl) {
        console.log("Starting download for file: ", fileUrl);
        const fileDetails = getFileDetails(fileUrl);

        root.height = expandedHeight;

        if (fileAlreadyChosen()) {
            console.log("File already chosen, removing current item");
            removeCurrentItem();
        }

        let newItem = createDownloadItem(fileDetails);

        newItem.closeButtonClicked.connect(function() {
            console.log("Close button clicked for item");
            removeCurrentItem();
            rightButton.state = "Base State";
            root.height = root.defaultHeight;
        });

        root.downloadItems.push(newItem);

        newItem.display();

        uploadManager.startUpload();
    }

    // Check if a file is already chosen
    function fileAlreadyChosen() {
        return root.downloadItems.length > 0;
    }

    // Remove the current download item
    function removeCurrentItem() {
        console.log("Removing current download item");
        let oldestItem = getOldItem();
        oldestItem.hide();
        root.downloadItems.shift(); // Remove it from the list
    }

    // Get the oldest download item
    function getOldItem() {
        return root.downloadItems[0];
    }

    // Create a new download item with given file details
    function createDownloadItem(fileDetails) {
        console.log("Creating download item for: ", fileDetails);
        const newItem = downloadItemComponent.createObject(root, {
            "x": 32,
            "y": 500,
            "opacity": 0,
            "rotation": 5,
            "filename": fileDetails.name,
            "extension": fileDetails.extension,
            "volume": fileDetails.size,
            "progressValue": uploadManager.progress
        });
        return newItem;
    }

    // File dialog for selecting a file
    FileDialog {
        id: fileDialog
        title: "Select a File"

        onAccepted: {
            console.log("File selected: ", fileDialog.selectedFile);
            root.downloadFile(String(fileDialog.selectedFile));
        }
    }

    Item {
        id: rootContent

        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: "white"
        }

        // Signals for user interactions
        signal attachFiles
        signal downloadItemCloseButtonClicked

        // Alias properties for button mouse areas
        property alias leftButtonMouseArea: leftButtonMouseArea
        property double progressValue: uploadManager.progress

        visible: true

        // Drop area for drag-and-drop functionality
        DropArea {
            id: dropArea
            anchors.fill: parent

            onEntered: {
                console.log("File entered drop area");
                rootContent.state = "dragEntered";
            }

            onExited: {
                console.log("File exited drop area");
                if (root.downloadItems.length === 0) {
                    rootContent.state = "Base State";
                }
            }

            FileUtilities {
                id: fileUtilities
            }

            onDropped: (drop) => {
                if (drop.hasUrls) {
                    console.log("File dropped: ", drop.urls[0]);
                    rootContent.state = "Attach Enabled";
                    if (root.downloadItems.length !== 0) {
                        rightButton.state = "Base State";
                    }
                    const fileUrl = String(drop.urls[0]);
                    root.downloadFile(fileUrl);
                }
            }
        }

        // Frame and layout definitions for UI elements
        Frame {
            id: mainFrame
            anchors.fill: parent
            anchors.margins: 20
            background: null

            ColumnLayout {
                anchors.fill: parent
                spacing: 20

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: uploadFileText.height
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                    Text {
                        id: uploadFileText
                        text: "Upload file"
                        font.pointSize: 28
                        font.family: CustomFonts.lexendRegular
                    }
                }

                ColumnLayout {
                    id: dragAndDropLayout
                    spacing: 6

                    DashedBorderFrame {
                        id: content
                        Layout.fillWidth: true
                        Layout.preferredHeight: 330
                        Layout.preferredWidth: 1
                        lineWidth: 2.2

                        Frame {
                            id: frame
                            width: 258
                            height: 200
                            background: null
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter

                            Image {
                                id: image1
                                x: 73
                                y: 22
                                width: 57
                                height: 76
                                source: "resources/icons/text_flat_ico.svg"
                                sourceSize.width: 57
                                sourceSize.height: 76
                                fillMode: Image.PreserveAspectFit
                            }

                            Image {
                                id: image
                                x: 115
                                y: 67
                                width: 43
                                height: 43
                                source: "resources/icons/upload_icon.svg"
                                sourceSize.width: 43
                                sourceSize.height: 43
                                fillMode: Image.PreserveAspectFit
                            }

                            RowLayout {
                                id: rowLayout1
                                y: 138
                                height: 25
                                anchors.horizontalCenter: parent.horizontalCenter

                                Text {
                                    id: _text
                                    text: qsTr("Drag and drop file here or")
                                    font.pixelSize: 20
                                    font.family: CustomFonts.lexendRegular
                                }

                                Button {
                                    id: chooseFileText
                                    rightPadding: 0
                                    bottomPadding: 0
                                    leftPadding: 0
                                    topPadding: 0

                                    onClicked: fileDialog.open()

                                    background: Rectangle {
                                        color: "transparent"
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                        }
                                    }

                                    contentItem: Text {
                                        color: "#0055ff"
                                        text: qsTr("Choose File")
                                        font.pixelSize: 20
                                        font.underline: true
                                        font.family: CustomFonts.lexendRegular
                                    }
                                }
                            }
                        }
                    }

                    Frame {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 20
                        rightPadding: 0
                        bottomPadding: 0
                        leftPadding: 0
                        topPadding: 0
                        Layout.topMargin: 10
                        background: null

                        Text {
                            color: Qt.rgba(131 / 255, 137 / 255, 149 / 255, 1)
                            text: qsTr("Maximum file size: " + maxFileSizeMB + "MB")
                            font.pixelSize: 16
                            font.family: CustomFonts.lexendRegular
                            anchors.left: parent.left
                            Layout.fillHeight: true
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            color: Qt.rgba(131 / 255, 137 / 255, 149 / 255, 1)
                            text: qsTr("Supported Format: " + supportedFormat)
                            font.pixelSize: 16
                            font.family: CustomFonts.lexendRegular
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            Layout.fillHeight: true
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Item { Layout.fillHeight: true }

                Rectangle {
                    id: buttonsBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 62
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom

                    RowLayout {
                        id: rowLayout
                        anchors.fill: parent
                        anchors.margins: 0
                        spacing: 12

                        Button {
                            id: leftButton
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            Layout.preferredWidth: (rowLayout.width - rowLayout.spacing) / 2

                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                                radius: 12
                                border.color: "#c3cfdd"
                                border.width: 1.2

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }

                            contentItem: Text {
                                text: qsTr("Cancel")
                                color: "#303133"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 20
                                font.family: CustomFonts.lexendRegular
                            }

                            MouseArea {
                                id: leftButtonMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor

                                onClicked: {
                                    console.log("Cancel button clicked");
                                    root.close();
                                }
                            }
                        }

                        Button {
                            id: rightButton

                            property bool rightButtonActive: false

                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            Layout.preferredWidth: (rowLayout.width - rowLayout.spacing) / 2

                            background: Rectangle {
                                id: rightButtonRect
                                anchors.fill: parent
                                color: rightButton.rightButtonActive ? "#333338" : "#575759";
                                radius: 12

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }

                                Behavior on color {
                                    PropertyAnimation {
                                        duration: animationDuration
                                    }
                                }
                            }

                            contentItem: Text {
                                text: qsTr("Attach Files")
                                color: "#FFFFFF"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: CustomFonts.lexendRegular
                                font.pointSize: 20
                            }
                        }
                    }
                }
            }
        }

        Component {
            id: downloadItemComponent

            DownloadItem {
                id: downloadItem

                // Display the download item with animation
                function display() {
                    console.log("Displaying download item");
                    downloadItem.y = 520;
                    downloadItem.rotation = 0;
                    downloadItem.opacity = 1;
                }

                // Hide the download item with animation
                function hide() {
                    console.log("Hiding download item");
                    downloadItem.shouldDestroy = true;
                    downloadItem.y = 520 + 100;
                    downloadItem.opacity = 0;
                }

                opacity: 0
                rotation: 5
                x: 32
                y: 370
                width: content.width
                height: 100

                // Animations for appearance changes
                Behavior on opacity {
                    PropertyAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutQuad
                        onFinished: {
                            if (downloadItem.shouldDestroy) {
                                console.log("Destroying download item");
                                downloadItem.destroy();
                            }
                        }
                    }
                }

                Behavior on y {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutSine
                    }
                }

                Behavior on rotation {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.InOutSine
                    }
                }
            }
        }

        // States for drag-and-drop visual feedback
        states: [
            State {
                name: "dragEntered"

                PropertyChanges {
                    image {
                        x: 120 + 10
                        rotation: 15
                    }
                    image1 {
                        x: 78 - 10
                        rotation: -15
                    }
                    content {
                        fillColor: "#f2f4ff"
                        strokeColor: "#2263E5"
                    }

                }
            }
        ]

        // Transitions for state changes
        transitions: [
            Transition {
                id: transition
                PropertyAnimation {
                    target: content
                    properties: "fillColor, strokeColor"
                    duration: 150
                }

                PropertyAnimation {
                    target: rightButtonRect
                    property: "color"
                    duration: 150
                }

                ParallelAnimation {
                    PropertyAnimation {
                        target: image1
                        property: "rotation"
                        duration: 150
                    }

                    PropertyAnimation {
                        target: image1
                        property: "x"
                        duration: 150
                    }
                }

                ParallelAnimation {
                    PropertyAnimation {
                        target: image
                        property: "rotation"
                        duration: 150
                    }

                    PropertyAnimation {
                        target: image
                        property: "x"
                        duration: 150
                    }
                }
                to: "*"
                from: "*"
            }
        ]
    }
}

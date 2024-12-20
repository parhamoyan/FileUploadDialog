import qmllibs.CustomComponents 1.0
import QtQuick 6.2
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQml

Frame {
    id: root
    height: 100
    width: 600

    signal closeButtonClicked

    property double progressValue
    property string filename
    property string extension
    property string volume

    property bool shouldDestroy: false

    property string description: root.extension + " . " + root.volume

    background: Rectangle {
        border.color: "#B6C4D5"
        border.width: 1
        radius: 16
    }

    Rectangle {
        id: rectangle
        x: 444
        width: 28
        height: 28
        border.color: "#B6C4D5"
        border.width: 1
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.topMargin: 0
        radius: width / 2

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.closeButtonClicked();
            }
        }

        Image {
            id: image3
            width: parent.width * 32 / 56
            height: parent.height * 32 / 56
            anchors.verticalCenter: parent.verticalCenter
            source: "resources/icons/x.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: 50
        height: 50
        radius: 6
        border.color: "#b6c4d5"
        border.width: 1
        Image {
            id: image4
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            source: "resources/icons/CSV.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            cache: false
        }
    }

    Text {
        id: _text2
        y: 0
        height: 15
        text: root.filename
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 64
        anchors.rightMargin: 50
        font.pixelSize: 18
        font.family: CustomFonts.lexendRegular
    }

    Text {
        id: _text3
        y: 25
        height: 15
        color: "#838995"
        text: root.description
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 64
        anchors.rightMargin: 50
        font.pixelSize: 16
        font.family: CustomFonts.lexendRegular
    }

    RowLayout {
        id: progressLayout
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 20

        ProgressBar {
            id: control
            value: root.progressValue
            Layout.fillWidth: true

            Behavior on value {
                NumberAnimation {
                    duration: 100
                }
            }

            contentItem: Item {
                Rectangle {
                    implicitHeight: 6
                    implicitWidth: control.width * control.value
                    height: 6
                    color: Qt.rgba(0, 85 / 255, 255 / 255, 1)
                    radius: height / 2
                }
            }

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 6
                height: 6
                radius: height / 2
                color: Qt.rgba(195 / 255, 207 / 255, 221 / 255, 1)
            }
        }

        Text {
            id: progressText
            text: qsTr("%1%").arg(Math.round(root.progressValue * 100))
            font.pixelSize: 16
            horizontalAlignment: Text.AlignRight
            Layout.preferredWidth: 30
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            font.family: CustomFonts.lexendRegular
            color: "#303133"
        }
    }
}

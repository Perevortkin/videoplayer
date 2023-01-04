import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.3

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Video player")

    FileDialog {
        id: _fileDialog
        title: "Please choose a video file"
        folder: shortcuts.home
        onFileUrlChanged: {
            if (_fileDialog.fileUrl) {
                _loader.active = true;
            }
        }
    }

    Rectangle {
        id: _selectFileButton
        anchors.centerIn: parent
        width: 300
        height: 100
        radius: 50
        scale: _mouseArea.clicked ? 0.95 : 1
        color: "lightblue"
        visible: !_loader.active

        Text {
            anchors.centerIn: parent
            text: "Select file"
        }
        MouseArea {
            id: _mouseArea
            anchors.fill: parent
            onClicked: {
                _fileDialog.visible = true;
            }
        }
    }

    Loader {
        id: _loader
        anchors.fill: parent
        active: false
        source: "qrc:/VideoPlayer.qml"

        onLoaded: {
            item.fileUrl = _fileDialog.fileUrl
        }
    }
}

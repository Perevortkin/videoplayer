import QtQuick 2.15

Image {
    id: root

    property bool isPlaying: false
    signal clicked()

    width: 50
    height: 50
    scale: _mouseArea.pressed ? 0.9 : 1.0
    source: "qrc:/assets/%1.png".arg(root.isPlaying ? "pause" : "play")

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

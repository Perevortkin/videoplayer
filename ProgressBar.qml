import QtQuick 2.15

Item {
    id: root

    signal seek(var progress)

    function changeProgress(progress) {
        if (!_mouseArea.pressed) {
            internal.progress = progress;
        }
    }

    QtObject {
        id: internal

        // from 0 to 1
        property double progress: 0

        function changeProgress(mouseX) {
            internal.progress = Math.min(mouseX / root.width, 1);
        }
    }

    height: 50

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: 30
        color: "grey"
        clip: true

        Rectangle {
            anchors.fill: parent
            anchors.rightMargin: parent.width - parent.width * internal.progress
            color: "red"
        }

        Rectangle {
            height: 30
            width: 30
            x: parent.width * internal.progress - 15
            color: "green"
            radius: 30
            visible: _mouseArea.pressed
        }
    }

    MouseArea {
        id: _mouseArea

        anchors.fill: parent

        onMouseXChanged: {
            if (_mouseArea.pressed) {
                internal.changeProgress(mouseX);
            }
        }
        onPressed: {
            internal.changeProgress(mouseX);
        }
        onReleased: {
            root.seek(internal.progress);
        }
    }
}

import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Layouts 1.3

Item {
    id: root

    property string fileUrl: ""

    anchors.fill: parent

    Video {
        id: _video
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _rowLayout.top
        source: root.fileUrl
        autoPlay: true

        onPositionChanged: {
            _progressBar.changeProgress(position / duration);
        }
    }

    Button {
        property bool isScaled: _video.fillMode === VideoOutput.Stretch

        width: 50
        height: 50
        source: "qrc:/assets/%1.svg".arg(isScaled ? "original" : "scale")
        onClicked: {
            _video.fillMode = isScaled  ? VideoOutput.PreserveAspectFit : VideoOutput.Stretch;
        }
    }

    RowLayout {
        id: _rowLayout
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: 50
        spacing: 10

        Button {
            isPlaying: _video.playbackState == MediaPlayer.PlayingState
            onClicked: {
                if (isPlaying) {
                    _video.pause();
                } else {
                    _video.play();
                }
            }
        }

        ProgressBar {
            id: _progressBar
            Layout.fillWidth: true

            onSeek: {
                _video.seek(_video.duration * progress);
            }
        }
    }
}

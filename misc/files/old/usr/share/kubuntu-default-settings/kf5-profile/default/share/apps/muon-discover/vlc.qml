import QtQuick 2.0

Rectangle {
    anchors.fill: parent
    color: "black"
    height: icon.height ; width: icon.width

    Image {
        id: icon
        source: "vlc-kf5.png"
        anchors.centerIn: parent
        width: 128
        height: 128
    }
}

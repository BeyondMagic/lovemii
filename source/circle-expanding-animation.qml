import QtQuick
import Quickshell

PanelWindow {
    id: root

    anchors {
        top: true; bottom: true; left: true; right: true
    }
    color: "transparent"

    property bool active: false

    readonly property real expandedSize: Math.sqrt(width * width + height * height) * 1.05
    readonly property real collapsedSize: 100

    // Only the circle is interactive; everything else is click-through.
    mask: Region { item: circle }

    MouseArea {
        anchors.fill: parent
        onClicked: root.active = !root.active
    }

    Rectangle {
        id: circle

        anchors.centerIn: parent
        width:  root.active ? root.expandedSize : root.collapsedSize
        height: width
        radius: width / 2
        color:  "#1e1e2e"
        clip:   true

        Behavior on width {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutCubic
            }
        }

        Item {
            id: content
            width:  root.width
            height: root.height
            anchors.centerIn: parent

            opacity: root.active ? 1 : 0
            Behavior on opacity {
                NumberAnimation { duration: 250 }
            }

            Text {
                anchors.centerIn: parent
                text: "Hello World"
                color: "white"
                font.pixelSize: 32
            }
        }
    }
}
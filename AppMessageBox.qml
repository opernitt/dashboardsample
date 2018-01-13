import QtQuick 2.0
import QtQuick.Controls 2.2

Popup {
    id: popup
    x: (root.width) / 2 - (width / 2)
    y: (root.height) / 2 - (height / 2)
    width: 320
    height: 100
    modal: true
    dim: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property string name
    property string icon
    property string desc
    property string msg
    property string color

    Rectangle {
        color: popup.color
        anchors.fill: parent

        Image {
            id: icon
            source: popup.icon
            width: 64
            height: width
            x: 5
            y: 5
        }

        Text {
            id: name
            text: popup.name + ":"
            color: "white"
            x: icon.x + icon.width + 5
            y: 5
        }

        Text {
            id: msg
            text: popup.msg
            color: "white"
            x: icon.x + icon.width + 5
            y: name.y + name.height + 5
        }

        Text {
            id: desc
            text: popup.desc
            color: "white"
            x: icon.x + icon.width + 5
            y: msg.y + msg.height + 5
        }
    }

    // Close the popup when it is clicked
    // It is automatically closed after clicking outside of it
    MouseArea {
        anchors.fill: parent
        onClicked: popup.close()
    }
}

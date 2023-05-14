import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.2

Window {
    id: window
    width: 350
    height: 700
    visible: true
    title: qsTr("Gdzie jedziemy?")
    Image {
        id: image
        x: 0
        y: 0
        width: 73
        height: 73
        source: "zdj/bus_n.png"
        autoTransform: true
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: rectangle
        x: 112
        y: 0
        width: 290
        height: 73
        color: "#182444"
        radius: 36.5
        border.width: 0
        anchors.right: parent.right
        anchors.rightMargin: -52

        Text {
            id: text1
            x: 46
            y: 26
            width: 155
            height: 21
            color: "#ffffff"
            text: qsTr("GDZIE JEDZIEMY?")
            font.letterSpacing: 1.1
            font.pixelSize: 16
            font.family: "Arial"
        }
    }

    StackView {
        id: stack
        x: 0
        y: 0
        initialItem: Qt.createComponent("Menu.qml")
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}D{i:2}D{i:4}D{i:3}D{i:6}D{i:7}D{i:8}D{i:9}D{i:10}D{i:5}
D{i:11}D{i:1}
}
##^##*/


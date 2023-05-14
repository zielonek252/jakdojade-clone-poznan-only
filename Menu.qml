import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.2

Item {
    anchors.fill: parent
    id: item1
    width: 350
    height: 700
    Rectangle {
        id: rectangle1
        y: 168
        height: 200
        color: "#93bdff"
        radius: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.leftMargin: 8

        Text {
            id: text2
            y: 8
            height: 23
            color: "#ffffff"
            text: qsTr("WYBIERZ CEL JAZDY")
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 18
            anchors.rightMargin: 77
            anchors.leftMargin: 77
            font.weight: Font.DemiBold
        }

        Text {
            id: text3
            y: 71
            color: "#ffffff"
            text: qsTr("PODAJ PRZYSTANEK")
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 15
            anchors.rightMargin: 96
            anchors.leftMargin: 96
        }

        TextInput {
            id: przystanek
            y: 102
            height: 20
            color: "#ffffff"
            text: qsTr("Pisz...")
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 12
            anchors.rightMargin: 158
            anchors.leftMargin: 96
        }

        Image {
            id: image1
            y: 62
            width: 36
            height: 36
            anchors.left: parent.left
            source: "zdj/przystanek.png"
            anchors.leftMargin: 54
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rectangle2
            y: 121
            height: 1
            color: "#182444"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 52
            anchors.leftMargin: 96
        }
    }

    Button {
        id: button
        y: 326
        height: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 122
        anchors.leftMargin: 122
        background: Rectangle {
            color: parent.down ? "#233566" : "#182444"
            radius: 30
        }
        contentItem: Text {
            color: "#ffffff"
            text: qsTr("Szukaj")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked: {
            var nazwaPrzystanku = przystanek.text
            console.log(nazwaPrzystanku)
            stack.push("Przystanki.qml", {
                           "przystanekMenu": nazwaPrzystanku
                       })
        }
    }
}

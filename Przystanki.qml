import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.2

Item {
    property string przystanekMenu
    width: 350
    height: 700
    id: item1
    anchors.fill: parent

    function zapytanie() {
        var url = "https://www.peka.poznan.pl/vm/method.vm?ts=1648833618272"

        var xhr = new XMLHttpRequest()
        xhr.open("POST", url)

        xhr.setRequestHeader(
                    "User-Agent",
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0")
        xhr.setRequestHeader(
                    "Accept",
                    "text/javascript, text/html, application/xml, text/xml, */*")
        xhr.setRequestHeader("Accept-Language", "pl,en-US;q=0.7,en;q=0.3")
        xhr.setRequestHeader("Accept-Encoding", "gzip, deflate, br")
        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
        xhr.setRequestHeader("X-Prototype-Version", "1.7")
        xhr.setRequestHeader("Content-type",
                             "application/x-www-form-urlencoded; charset=UTF-8")
        xhr.setRequestHeader("Origin", "https://www.peka.poznan.pl")
        xhr.setRequestHeader("Connection", "keep-alive")
        xhr.setRequestHeader("Referer", "https://www.peka.poznan.pl/vm/")
        xhr.setRequestHeader("Cookie",
                             "JSESSIONID=e3rNhPmokI06gPx3JbWuukfl.undefined")
        xhr.setRequestHeader("Sec-Fetch-Dest", "empty")
        xhr.setRequestHeader("Sec-Fetch-Mode", "cors")
        xhr.setRequestHeader("Sec-Fetch-Site", "same-origin")

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                console.log(xhr.status)
                console.log(xhr.responseText)
                var jsonObject = JSON.parse(xhr.responseText)
                console.log(jsonObject.success[0].name)
                var ilosc = Object.keys(jsonObject.success).length
                console.log(ilosc)
                var listaPrzystankow
                var symbol

                for (var i = 0; i <= ilosc + 1; i++) {
                    console.log(jsonObject.success[i].name)
                    listaPrzystankow = jsonObject.success[i].name
                    przystanki.append({
                                          "listaPrzystankow": jsonObject.success[i].name
                                      })
                }
            }
        }
        var data = "method=getStopPoints&p0=%7B%22pattern%22%3A%22" + przystanekMenu + "%22%7D"
        xhr.send(data)
    }
    ListModel {
        id: przystanki
    }
    ListView {
        id: listView
        y: 176
        height: 402
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        orientation: ListView.Vertical
        model: przystanki
        ScrollBar.vertical: ScrollBar {
            active: true
        }

        delegate: Item {
            x: 5
            width: 300
            height: 42
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                id: row1
                spacing: 40
                Button {
                    id: button
                    width: 300
                    height: 40
                    background: Rectangle {
                        color: parent.down ? "#233566" : "#182444"
                        radius: 30
                    }
                    contentItem: Text {
                        color: "#ffffff"
                        text: listaPrzystankow
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        console.log("Przekazuje: " + listaPrzystankow)
                        stack.push("Kierunki.qml", {
                                       "nazwaPrzystanku": listaPrzystankow
                                   })
                    }
                }
            }
        }
        Component.onCompleted: {
            zapytanie()
        }
    }
    Button {
        id: button2
        y: 593
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.leftMargin: 25
        background: Rectangle {
            color: parent.down ? "#233566" : "#182444"
            radius: 30
        }
        contentItem: Text {
            color: "#ffffff"
            text: "Powrót"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked: {
            stack.pop("Przystanki.qml", {})
        }
    }
}

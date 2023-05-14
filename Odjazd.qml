import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.2

Item {

    property string przekazanyPrzystanek
    property string przekazanaLinia
    property string przekazanyKierunek
    anchors.fill: parent
    id: item1
    width: 350
    height: 700
    function wyswietlOdjazdy() {
        przystanki.clear()
        var timeStampInMs = window.performance && window.performance.now
                && window.performance.timing
                && window.performance.timing.navigationStart ? window.performance.now(
                                                                   ) + window.performance.timing.navigationStart : Date.now()
        var url = "https://www.peka.poznan.pl/vm/method.vm?ts=" + timeStampInMs
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
                console.log(jsonObject.success.times)
                var ilosc = Object.keys(jsonObject.success.times).length
                var nazwaPrzystanku = jsonObject.success.bollard.name
                console.log(ilosc)
                var kodKoloru = "#182444"

                for (var i = 0; i <= ilosc + 1; i++) {
                    console.log(jsonObject.success.times[i].minutes)
                    console.log(jsonObject.success.times[i].line)
                    przystanki.append({
                                          "kierunek": jsonObject.success.times[i].direction,
                                          "linia": jsonObject.success.times[i].line,
                                          "czasOdjazdu": jsonObject.success.times[i].minutes,
                                          "kodKoloru": kodKoloru
                                      })
                }
            }
        }
        var data = "method=getTimes&p0=%7B%22symbol%22%3A%22" + przekazanyPrzystanek + "%22%7D"
        xhr.send(data)
        console.log(przekazanyPrzystanek)
        console.log(przekazanaLinia)
        console.log(przekazanyKierunek)
    }
    Rectangle {
        id: rectangle
        y: 208
        height: 27
        color: "#182444"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.leftMargin: 12

        Text {
            id: text1
            x: 0
            y: 3
            width: 326
            height: 18
            color: "#ffffff"
            text: "Symbol przystanku: " + przekazanyPrzystanek
            //+ " | Nazwa przystanku: " + nazwaPrzystanku
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
        }
    }
    ListModel {
        id: przystanki
    }
    ListView {
        id: listView
        y: 176
        height: 467
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
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
                Rectangle {
                    id: rectangle1
                    x: 13
                    y: 74
                    width: 32
                    height: 32
                    color: "#182444"
                    Component.onCompleted: {
                        rectangle.color = "#182444"
                        console.log("czas odjazdu to: " + czasOdjazdu)
                        if (czasOdjazdu > 5) {
                            kodKoloru = "#182444"
                        } else {
                            kodKoloru = "#ff0000"
                        }
                        color: kodKoloru
                    }

                    Text {
                        id: text2
                        x: 0
                        y: 9
                        width: 32
                        height: 15
                        color: "#ffffff"
                        text: czasOdjazdu
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Text {
                    id: text3
                    x: 20
                    y: 79
                    width: 274
                    height: 22
                    text: "Linia: <font color=\"#182444\"><b>" + linia
                          + "</b></font> | kierunek: <font color=\"#182444\"><b>"
                          + kierunek + "</b></font>"
                    font.pixelSize: 14
                }
            }
        }
        Component.onCompleted: {
            setInterval(wyswietlOdjazdy(), 10000)
        }
        Timer {
            interval: 10000
            running: true
            repeat: true
            onTriggered: wyswietlOdjazdy()
        }
    }
    Button {
        id: button
        y: 652
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

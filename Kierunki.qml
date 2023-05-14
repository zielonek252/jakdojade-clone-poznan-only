import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.2

Item {
    property string nazwaPrzystanku
    width: 350
    height: 700
    id: item1
    anchors.fill: parent
    function zapytanie() {
        var przystanek = nazwaPrzystanku.replace(" ", "%20")
        console.log(przystanek)
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
                console.log("status: " + xhr.status)
                console.log("odpowiedź " + xhr.responseText)
                var jsonObject = JSON.parse(xhr.responseText)
                console.log("jsonobject: " + jsonObject)
                console.log("zwrotka: " + jsonObject.success.bollards[1].directions[1])
                var glownyLicznik = Object.keys(
                            jsonObject.success.bollards).length
                console.log("liczba glowna: " + glownyLicznik)
                var iloscKierunkow = []
                var iloscPrzystankow = []
                var kierunki = []
                for (var i = 0; i < glownyLicznik; i++) {
                    iloscKierunkow[i] = Object.keys(
                                jsonObject.success.bollards[i].directions).length
                    iloscPrzystankow[i] = Object.keys(
                                jsonObject.success.bollards[i].bollard).length
                }
                console.log("ilosc kierunkow: " + iloscKierunkow)
                var listaPrzystankow
                var symbol
                var numerLinii = []
                for (var i = 0; i < glownyLicznik; i++) {
                    console.log("Numer: " + i)
                    kierunki[i] = []
                    numerLinii[i] = []
                    for (var j = 0; j < iloscKierunkow[i]; j++) {
                        console.log("Numer: " + j)
                        console.log(jsonObject.success.bollards[i].directions[j].direction)
                        kierunki[i][j] = jsonObject.success.bollards[i].directions[j].direction
                        numerLinii[i][j] = jsonObject.success.bollards[i].directions[j].lineName
                        przystanki.append({
                                              "kierunkiJazdy": jsonObject.success.bollards[i].directions[j].direction,
                                              "liniePojazdu": jsonObject.success.bollards[i].directions[j].lineName,
                                              "symbolPrzystanku": jsonObject.success.bollards[i].bollard.tag
                                          })
                    }
                }
                console.log(kierunki)
                console.log(numerLinii)
            }
        }
        var data = "method=getBollardsByStopPoint&p0=%7B%22name%22%3A%22" + przystanek + "%22%7D"
        xhr.send(data)
    }
    ListModel {
        id: przystanki
    }
    ListView {
        id: listView
        y: 176
        height: 384
        anchors.left: parent.right
        anchors.right: parent.left
        anchors.rightMargin: -350
        anchors.leftMargin: -350
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
                        text: "[" + symbolPrzystanku + "] " + kierunkiJazdy
                              + " linia: " + liniePojazdu
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        stack.push("Odjazd.qml", {
                                       "przekazanyPrzystanek": symbolPrzystanku,
                                       "przekazanaLinia": liniePojazdu,
                                       "przekazanyKierunek": kierunkiJazdy
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

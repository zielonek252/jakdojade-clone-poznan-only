QT += quick

SOURCES += \
        main.cpp

resources.files = main.qml zdj/bus_n.png zdj/przystanek.png Przystanki.qml Menu.qml Odjazd.qml Kierunki.qml
resources.prefix = /$${TARGET}
RESOURCES += resources

TRANSLATIONS += \
    rozklad-peka_pl_PL.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Kierunki.qml \
    Menu.qml \
    Odjazd.qml \
    Przystanki.qml \
    zdj/bus_n.png \
    zdj/przystanek.png

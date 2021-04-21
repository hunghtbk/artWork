#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Class/ControllMainAPP.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    ControllMainAPP::getInstance()->initControlMainApp();
//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

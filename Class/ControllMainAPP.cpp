#include "ControllMainAPP.h"
#include <QDebug>

ControllMainAPP* ControllMainAPP::m_instance = nullptr;
void ControllMainAPP::initControlMainApp()
{
    m_uiBridge = new UIBridge(this);
    m_qmlEngine.rootContext()->setContextProperty("UIBridge", m_uiBridge);

    m_qmlEngine.load(QUrl(QStringLiteral("qrc:/main.qml")));
}

ControllMainAPP *ControllMainAPP::getInstance()
{
    if (m_instance == nullptr) {
        m_instance = new ControllMainAPP();
    }
    return m_instance;
}

ControllMainAPP::ControllMainAPP()
{

}

void ControllMainAPP::handleHMIEvent(QString str1, QString str2)
{
    qDebug() << str1;
    qDebug() << str2;
}

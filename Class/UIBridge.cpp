#include "UIBridge.h"
#include <QDebug>

UIBridge::UIBridge(QObject* appWindown) : QObject(appWindown) {
    connect(this, SIGNAL(hmiEvent(QString,QString)), appWindown, SLOT(handleHMIEvent(QString,QString)));
    connect(this, SIGNAL(changePositionEvent(int, int, QString)), appWindown, SLOT(handleChangePositionEvent(int, int, QString)));
    connect(this, SIGNAL(sendListToControllApp(QStringList)), appWindown, SLOT(handleList(QStringList)));
}
void UIBridge::log(QString message) {
    emit hmiEvent(message, "vlvlvlvlvlvlvlv");
}
void UIBridge::setCurrentObjectName(QString message)
{
    currentImageObjName = message;
    qDebug() << "Current OBJ Name " << currentImageObjName;
}

void UIBridge::mainQMLCallChangePosition(int x, int y)
{
    qDebug() << "Change position x = " << x << " - y = " << y;
    emit changePositionEvent(x, y, currentImageObjName);
}

void UIBridge::importObjectNametToList(QString obj)
{
    objNameList.append(obj);
}

void UIBridge::genInfo()
{
    emit sendListToControllApp(objNameList);
}

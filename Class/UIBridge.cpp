#include "UIBridge.h"
#include <QDebug>

UIBridge::UIBridge(QObject* appWindown) : QObject(appWindown) {
    connect(this, SIGNAL(hmiEvent(QString,QString)), appWindown, SLOT(handleHMIEvent(QString,QString)));
}
void UIBridge::log(QString message) {
    emit hmiEvent(message, "vlvlvlvlvlvlvlv");
}

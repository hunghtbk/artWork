#ifndef UIBRIDGE_H
#define UIBRIDGE_H

#include <QObject>

class UIBridge: public QObject
{
    Q_OBJECT
public:
    explicit UIBridge(QObject *appWindown = nullptr);
    Q_INVOKABLE void log(QString message);

signals:
    void hmiEvent(QString, QString);
};

#endif // UIBRIDGE_H

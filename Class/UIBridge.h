#ifndef UIBRIDGE_H
#define UIBRIDGE_H

#include <QObject>

class UIBridge: public QObject
{
    Q_OBJECT
public:
    explicit UIBridge(QObject *appWindown = nullptr);
    Q_INVOKABLE void log(QString message);
    Q_INVOKABLE void setCurrentObjectName(QString message);
    Q_INVOKABLE void mainQMLCallChangePosition(int x, int y);
    Q_INVOKABLE void importObjectNametToList(QString obj);
    Q_INVOKABLE void genInfo();

signals:
    void hmiEvent(QString, QString);
    void changePositionEvent(int x, int y, QString currentIMGObjName);
    void sendListToControllApp(QStringList);
private:
    QString currentImageObjName;
    QStringList objNameList;
};

#endif // UIBRIDGE_H

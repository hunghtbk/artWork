import QtQuick 2.5
import QtQml.Models 2.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.1
import "componentCreation.js" as MyScript
Window {
    id: appWindow
    visible: true
    width: 960
    height: 480
    title: qsTr("Hello World")

    property int editAreaWidth: 480
    property int editAreaHeigh: 320

    property int objectCounter: 0

    Rectangle {
        id: customize_your_art_work
        x: 0
        y: 0
        width: parent.width /4
        height: parent.height
        color: "#4f504f"

        Text {
            id: name
            text: qsTr("Name")
            color: "white"
            x: 10
            y: 10
        }

        Rectangle {
            id: art_work_name_rect
            x: 80
            y: 10
            color: "white"
            width: 150
            height: 20
            radius: 3
            TextEdit {
                id: art_work_name
                anchors.fill: parent
                text: "hunght"
                color: "black"
            }
        }

        Text {
            id: category
            text: qsTr("Category")
            color: "white"
            x: 10
            y: 40
        }

        Rectangle {
            id: category_name_rect
            x: 80
            y: 40
            color: "white"
            width: 150
            height: 20
            radius: 3
            TextEdit {
                id: category_name
                anchors.fill: parent
                text: "hunght"
                color: "black"
            }
        }

        Text {
            id: size_of_edit_area
            text: qsTr("Size: ") + editAreaWidth + "x" + editAreaHeigh
            color: "white"
            x: 10
            y: 80
        }

        Rectangle {
            id: upload_art
            x: 10
            y: 120
            width: 60
            height: 20
            color: "white"
            radius: 3

            Text {
                id: upload
                text: qsTr("Upload Art")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("upload Art")
                    fileDialog.visible = true
                }
            }
        }

        Rectangle {
            id: upload_text
            x: 80
            y: 120
            width: 60
            height: 20
            color: "white"
            radius: 3

            Text {
                id: txt
                text: qsTr("Add Text")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Add text")
                }
            }
        }

        ListView {
            id: root
            x: 0
            y: 150
            width: 320
            height: 480
            displaced: Transition {

                NumberAnimation {
                    properties: "x,y"
                    easing.type: Easing.OutQuad
                }
            }
            model: DelegateModel {
                id: visualModel
                model: ListModel {
                    id: colorModel
                    ListElement {
                        color: "blue"
                        itemNumber: "0"
                    }
                    ListElement {
                        color: "green"
                        itemNumber: "1"
                    }
                    ListElement {
                        color: "red"
                        itemNumber: "2"
                    }
                }

                delegate: MouseArea {
                    id: delegateRoot
                    property bool held: false
                    property int visualIndex: DelegateModel.itemsIndex
                    width: 80
                    height: 80
                    drag.target: held ? icon : undefined
                    onPressAndHold: {
                        held = true
                        icon.opacity = 0.5
                    }
                    onReleased: {
                        if (held === true) {
                            held = false
                            icon.opacity = 1
                            icon.Drag.drop()
                        } else {
                            //action on release
                        }
                    }
                    Rectangle {
                        id: icon
                        width: 50
                        height: 50
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }
                        color: model.color
                        radius: 3
                        Text {
                            anchors.centerIn: parent
                            text: model.itemNumber
                        }
                        Drag.active: delegateRoot.drag.active
                        Drag.source: delegateRoot
                        Drag.hotSpot.x: 36
                        Drag.hotSpot.y: 36
                        states: [
                            State {
                                when: icon.Drag.active
                                ParentChange {
                                    target: icon
                                    parent: root
                                }
                                AnchorChanges {
                                    target: icon
                                    anchors.horizontalCenter: undefined
                                    anchors.verticalCenter: undefined
                                }
                            }
                        ]
                    }

                    DropArea {
                        id: dropArea
                        anchors {
                            fill: parent
                            margins: 15
                        }
                        onDropped: {
                            var sourceColor = colorModel.get(drag.source.visualIndex).color;
                            var sourceNumber = colorModel.get(drag.source.visualIndex).itemNumber;
                            var targetColor = colorModel.get(delegateRoot.visualIndex).color;
                            var targetNumber = colorModel.get(delegateRoot.visualIndex).itemNumber;
                            colorModel.setProperty(drag.source.visualIndex, "color", targetColor);
                            colorModel.setProperty(drag.source.visualIndex, "itemNumber", targetNumber);
                            colorModel.setProperty(delegateRoot.visualIndex, "color", sourceColor);
                            colorModel.setProperty(delegateRoot.visualIndex, "itemNumber", sourceNumber);
                        }

                    }

                }

            }

        }
    }

//-------------------------------File Dialog----------------------------//
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            var str = ""
            for(var i in fileDialog.fileUrls){
                var url = fileDialog.fileUrls[i]
                str += Qt.resolvedUrl(url)
            }
            objectCounter = objectCounter + 1;
            var objName = "hunght" + objectCounter
            MyScript.createSpriteObjects(str, objName);
            UIBridge.importObjectNametToList(objName)
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: visible = false
    }
//----------------------------------------------------------------------//
    Rectangle {
        id: edit_art_area
        x: parent.width /4
        y: 0
        width: 3 * parent.width /4
        height: parent.height
        color: "black"

        Rectangle {
            id: edit_area
            width: editAreaWidth
            height: editAreaHeigh
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Component.onCompleted: {
                UIBridge.notifyWidthheighOfEditArea(editAreaWidth, editAreaHeigh)
            }
        }
    }

}

import QtQuick 2.5
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
            width: editAreaWidth
            height: editAreaHeigh
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

}

import QtQuick 2.5
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: main_item
    objectName: image_object
    width: 200
    height: 200
    property bool isSelected: false
    property string image_source: "qrc:/image/house.png"
    property string image_object: ""

    Rectangle {
        id: main_image
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "transparent"

        Image {
            id: content_image
            anchors.fill: parent
            source: image_source
        }

        MouseArea {
            id: image_mouse
            anchors.fill: parent
            propagateComposedEvents: true
            property int xposition: 0
            property int yposition: 0

            onClicked: {
                if (isSelected) {
                    arrow_image.visible = false
                    isSelected = false
                    rotattion_image.visible = false
                    rotattion_image1.visible = false
                    UIBridge.setCurrentObjectName("");
                } else {
                    arrow_image.visible = true
                    isSelected = true
                    rotattion_image.visible = true
                    rotattion_image1.visible = true
                }

            }
            onPositionChanged: {
                UIBridge.setCurrentObjectName(main_item.objectName);
                UIBridge.mainQMLCallChangePosition(mouseX, mouseY);
            }

        }
    }
    Rectangle {
        id: mask
        width: 20
        height: 20
        radius: 250
        visible: false
    }
    Image {
        id: rotattion_image
        y: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width: 20
        height: 20
        visible: false
        source: "qrc:/Image/rotation.png"
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                content_image.rotation = content_image.rotation + 1
            }
            onPressAndHold: {
                elapsedTimer.start();
            }
            onReleased: {
                elapsedTimer.stop();
            }
        }
        Timer  {
            id: elapsedTimer
            interval: 10
            running: false
            repeat: true
            onTriggered: {
                content_image.rotation = content_image.rotation + 1
            }
        }
    }

    Rectangle {
        id: mask1
        width: 20
        height: 20
        radius: 250
        visible: false
    }
    Image {
        id: rotattion_image1
        y: parent.height - mask1.height
        anchors.horizontalCenter: parent.horizontalCenter
        width: 20
        height: 20
        visible: false
        source: "qrc:/Image/rotation.png"
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                content_image.rotation = content_image.rotation - 1
            }
            onPressAndHold: {
                elapsedTimer1.start();
            }
            onReleased: {
                elapsedTimer1.stop();
            }
        }
        Timer  {
            id: elapsedTimer1
            interval: 10
            running: false
            repeat: true
            onTriggered: {
                content_image.rotation = content_image.rotation - 1
            }
        }
    }

    Image {
        id: arrow_image
        y: parent.height - 21
        x: parent.width - 21
        width: 20
        height: 20
        source: "qrc:/Image/arrow.png"
        visible: false

        MouseArea {
            anchors.fill: parent
            property int mountYofArrow : arrow_image.y + arrow_image.height/2

            onClicked: {
                main_item.width = main_item.width + 1
                main_item.height = main_item.height + 1
            }

            onPressAndHold: {
                main_item.width = main_item.width + 1
                main_item.height = main_item.height + 1

                console.log(mouseX)
            }

            onMouseXChanged: {
                var arrow_current_X = arrow_image.x
                var arrow_mouse_x = mouseX + arrow_image.x
                if (arrow_mouse_x > arrow_current_X) {
                    main_item.width = main_item.width + 1
                } else {
                    main_item.width = main_item.width - 1
                }
            }

            onMouseYChanged: {
                var arrow_current_Y = arrow_image.y
                var arrow_mouse_y = mouseY + arrow_image.y
                if (arrow_mouse_y > arrow_current_Y) {
                    main_item.height = main_item.height + 1
                } else {
                    main_item.height = main_item.height - 1
                }
            }


            onReleased: {
                console.log("current x: " + main_item.x + "current y" + main_item.y +
                            "current width" + main_item.width +
                            "current height" + main_item.height)
            }
        }
    }

}

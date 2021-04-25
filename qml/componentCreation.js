var component;
var sprite;

function createSpriteObjects(source, obj) {
    component = Qt.createComponent("ImageElement.qml");
    sprite = component.createObject(edit_area, {x: 100, y: 100, image_source: source, image_object: obj});

    if (sprite == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

//function finishCreation() {
//    if (component.status == Component.Ready) {
//        sprite = component.createObject(appWindow, {x: 100, y: 100});
//        if (sprite == null) {
//            // Error Handling
//            console.log("Error creating object");
//        }
//    } else if (component.status == Component.Error) {
//        // Error Handling
//        console.log("Error loading component:", component.errorString());
//    }
//}

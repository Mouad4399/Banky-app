import QtQuick
import QtQuick.Window
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Fonts 1.0

ColorImage {
    id: image
    property real radius :8
    layer.enabled:true
    layer.effect:OpacityMask {
        maskSource: Rectangle {
            id:mask
            width: image.width
            height: image.height
            radius: image.radius
            // visible: false // this also needs to be invisible or it will cover up the image
        }
    }
}
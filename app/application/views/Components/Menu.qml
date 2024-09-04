
import QtQuick
// import QtQuick.Templates as T
// import QtQuick.Controls.Material
// import QtQuick.Controls.Material.impl
import QtQuick.Controls
import QtQuick.Window
import Qt5Compat.GraphicalEffects


Menu {
    id: control
    // parent:parent

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    
    margins: 0
    verticalPadding: 2
    modal: true
    dim:false

    transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)

    delegate: MenuItem { }

    enter: Transition {
        // grow_fade_in
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        // shrink_fade_out
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    contentItem: ListView {
        implicitHeight: contentHeight

        model: control.contentModel
        interactive: Window.window
                        ? contentHeight + control.topPadding + control.bottomPadding > Window.window.height
                        : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: Rectangle {
        implicitWidth: 150
        implicitHeight: 20
        // FullScale doesn't make sense for Menu.
        radius: 5
        color: '#F6F6F6'
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 16
            color: "#100B2714"
            z: -1
        }

    }

    // Overlay.modal: Rectangle {
    //     color:Qt.rgba(0,0,0,0)
    // }

    // T.Overlay.modeless: Rectangle {
    //     color: control.Material.backgroundDimColor
    //     Behavior on opacity { NumberAnimation { duration: 150 } }
    // }
    
}

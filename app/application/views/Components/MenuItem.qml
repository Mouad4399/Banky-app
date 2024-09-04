
import QtQuick
// import QtQuick.Templates as T
// import QtQuick.Controls.Material
// import QtQuick.Controls.Material.impl
import QtQuick.Controls
import QtQuick.Window

MenuItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 32
    verticalPadding: 7
    spacing: 16

    // icon.width: 24
    // icon.height: 24

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 20
        radius:7
        color: control.highlighted ? Qt.rgba(1,1,1,0.3) : "transparent"
    }
}

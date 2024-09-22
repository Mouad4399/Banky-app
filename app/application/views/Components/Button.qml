import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Fonts 1.0
AbstractButton {
    id: button
    width: innerText.width
    height: innerText.height
    property alias innerText:innerText
    property string buttonText: "test"
    // buttonText: "test"
    property color color: "#121B28"
    property color textColor: "white"
    property real factorOfTint:1.2
    property color hoverColor: button.color == Qt.rgba(1, 1, 1, 1) ? "#f0f0f0" : Qt.lighter(button.color, factorOfTint)
    property color pressColor: Qt.darker(button.color, factorOfTint)
    property int fontSize: 12
    // property int fontFamily: Fonts.inter
    property int borderWidth: 0
    property int borderRadius: 5
    property color borderColor: "#d7d7d7"
    property int fontWeight: 700
    property bool fontUnderline: false
    property string imageSource: ""
    property string imageColor: ''
    property real imageRadius
    property alias imageSize: innerImage.sourceSize
    property alias image: innerImage
    property bool enabledEffect:button.buttonText===''
    property color disabledBgColor: "transparent"
    property color disabledImageColor: "transparent"
    property var scaleTo: 0.96
    scale: state === "Pressed" ? scaleTo : 1.0
    onEnabledChanged: state = ""

    //define a scale animation
    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutBack
        }
    }

    background: Rectangle {
        id: rectangleButton
        anchors.fill: parent
        radius: button.borderRadius
        color: button.enabled ? button.color : button.enabledEffect?button.disabledBgColor:'white'
        border.width: button.borderWidth
        border.color: button.borderColor

        Text {
            id: innerText
            text:qsTranslate('',button.buttonText)
            font.pointSize: button.fontSize
            color: button.textColor
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            font.family:Fonts.inter
            font.weight: button.fontWeight
            font.underline:button.fontUnderline
        }
        ColorImage {
            id: innerImage
            // property real radius
            anchors.centerIn: parent
            source: imageSource
            color:button.enabled ? button.imageColor==='' ?color:button.imageColor : button.disabledImageColor
            // sourceSize.height: 32
            // sourceSize.width:16
            antialiasing: true
            // visible: false // this is needed or the corners of the image will be visible underneath the opacity mask
            layer.enabled:button.imageRadius>0.0
            layer.effect:OpacityMask {
                maskSource: Rectangle {
                    width: innerImage.width
                    height: innerImage.height
                    radius: button.imageRadius
                    // visible: false // this also needs to be invisible or it will cover up the image
                }
            }
        }
    }
    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: rectangleButton
                color: button.hoverColor
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: rectangleButton
                color: button.pressColor
            }
        }
    ]

    //define transmission for the states
    transitions: [
        Transition {
            from: ""
            to: "Hovering"
            ColorAnimation {
                duration: 150
            }
        },
        Transition {
            from: "*"
            to: "Pressed"
            ColorAnimation {
                duration: 10
            }
        }
    ]
    signal clicked
    signal hoveredIn
    signal entered
    signal exited
    MouseArea {
        id: mouseArea
        enabled:button.enabled
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: button.enabled 
        acceptedButtons: Qt.LeftButton
        onClicked: {
            button.clicked();
        }
        onPositionChanged: {
            
            if (containsMouse)
                button.state = pressed ? button.state:"Hovering";
            else
                button.state = "";
        }

        onEntered: {
            button.hoveredIn()
            button.entered()
            button.state = 'Hovering';
        }
        onExited: {
            button.exited()
            button.state = '';
        }
        onPressed: {
            button.state = "Pressed";
        }
        onReleased: {
            if (containsMouse)
                button.state = "Hovering";
            else
                button.state = "";
        }
        onPressAndHold:{
            button.state="Pressed"
        }
    }
}

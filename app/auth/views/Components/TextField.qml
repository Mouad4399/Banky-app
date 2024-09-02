import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "white"
    property color colorOnFocus: Qt.rgba(0,0,0,0)
    property color colorMouseOver: Qt.rgba(0.8,0.8,0.8,0.3)
    property int bgRadius : 8
    property bool showPassIcon :false
    property bool bg_enabled:true
    property string imageSource : ""
    property string placeholder: qsTr("Type something")

    echoMode: changeInputEchoMode ?TextInput.Password:TextInput.Normal


    QtObject{
        id: internal

        property var dynamicColor: if(textField.focus){
                                        textField.hovered ? colorOnFocus : colorDefault
                                   }else{
                                       textField.hovered ? colorMouseOver : colorDefault
                                   }
    }
    property bool changeInputEchoMode : false

    implicitWidth: 120
    implicitHeight: 40
    rightPadding:showPassIcon ? 38:0
    placeholderText: textField.placeholder
    font.pointSize: 9
    color: "#121B28"
    background: Rectangle {
        id:innerRect
        // anchors.fill:parent
        color: textField.bg_enabled ? internal.dynamicColor : Qt.rgba(100/255,100/255,100/255,0.4)
        radius: textField.bgRadius
        border.color:textField.focus ? "#121B28":text!=="" ? "#121B28":"#AEAFB3"
        border.width:1

    }
    // onHoveredChanged: {
    //     innerRect.color = textField.hovered ? colorOnFocus : colorDefault
    // }

    Rectangle{
        id:showPassRect
        visible:showPassIcon
        width:18
        height: 18
        color:Qt.rgba(0,0,0,0)
        anchors.right:textField.right
        anchors.rightMargin:8
        anchors.verticalCenter: textField.verticalCenter
        Image{
            id:showPass
            anchors.centerIn:parent
            source: !changeInputEchoMode ? "image://img/eye.svg": "image://img/eye-off.svg"
            sourceSize.height: 18
            sourceSize.width: 18
            opacity:1

        }
    }

    MouseArea{
        anchors.fill:showPassRect
        visible: showPassRect.visible
        cursorShape:Qt.PointingHandCursor
        hoverEnabled:true
        onEntered: {
            showPass.opacity = 0.75

        }
        onExited :{
            showPass.opacity = 1
        }
        onClicked:  {
            changeInputEchoMode=!changeInputEchoMode
        }
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#AEAFB3"
    placeholderTextColor: "#81848c"
    verticalAlignment: Text.AlignVCenter
}

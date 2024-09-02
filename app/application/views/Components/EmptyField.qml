import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Fonts

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "white"
    property color colorOnFocus: Qt.rgba(0,0,0,0)
    property color colorMouseOver: Qt.rgba(0.8,0.8,0.8,0.3)
    property int bgRadius : 0
    property color borderColor:"#065AD8"
    property int borderWidth:1


    QtObject{
        id: internal

        property var dynamicColor: if(textField.focus){
                                        textField.hovered ? colorOnFocus : colorDefault
                                   }else{
                                       textField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    // implicitWidth: 80
    implicitHeight: 20
    leftPadding: 5
    // rightPadding:38
    placeholderText: qsTr("Search something")
    font.pointSize: 9
    font.family:Fonts.inter
    color: enabled ? 'black':"#AEAFB3"
    background: Rectangle {
        id:innerRect
        // anchors.fill:parent
        color: textField.colorDefault
        radius: textField.bgRadius
        border.color:enabled ? textField.focus ? textField.borderColor:text!=="" ? textField.borderColor:"#AEAFB3":"#AEAFB3"
        border.width:textField.borderWidth

    }
    // onHoveredChanged: {
    //     innerRect.color = textField.hovered ? colorOnFocus : colorDefault
    // }

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#AEAFB3"
    placeholderTextColor: "#81848c"
    verticalAlignment: Text.AlignVCenter
}

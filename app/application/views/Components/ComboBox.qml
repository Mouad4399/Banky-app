// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Fonts 1.0
// import QtQuick.Controls.Material.impl

T.ComboBox {
    id: control

    implicitWidth: 40+textMetrics.width
    implicitHeight: 30
    property int borderWidth:0
    property int bgRadius:0
    property string placeholderText:''
    property alias emptyField:emptyField
    property alias indicatorimage:indicatorimage


    TextMetrics {
        id: textMetrics
        font.family: Fonts.inter
        text: control.displayText
    }
    // editable:true
    // Material.accent: "#065AD8"
    // Material.background: "#065AD8"
    // Material.foreground: "#065AD8"

    // property string selectechoice : currentIndex>0

    delegate: MenuItem {
        id:menuItem
        required property var model
        required property int index

        width: ListView.view.width
        text: qsTranslate('',model[control.textRole])
        font.family:Fonts.inter
        // Material.foreground: control.currentIndex === index ? ListView.view.contentItem.Material.accent : ListView.view.contentItem.Material.foreground
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: ColorImage {
        id:indicatorimage
        visible:enabled
        x: control.mirrored ? control.padding : control.width - sourceSize.width - control.padding -5
        y: control.topPadding + (control.availableHeight - height) / 2
        color: 'black'
        antialiasing: true
        sourceSize.height: 24
        sourceSize.width: 24
        source:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 10L12 15L17 10H7Z" fill="#699BF7"/></svg>'
    }

    contentItem: EmptyField_ {
        id:emptyField
        leftPadding: 10
        // topPadding: Material.textFieldVerticalPadding
        // bottomPadding: Material.textFieldVerticalPadding
        // implicitWidth: 60
        implicitHeight: 30
        placeholderText:control.placeholderText

        text: control.editable ? qsTranslate('',control.editText) : qsTranslate('',control.displayText)
        

        enabled: control.enabled
        // autoScroll: control.editable
        // readOnly: control.down
        // inputMethodHints: control.inputMethodHints
        // validator: control.validator
        // selectByMouse: control.selectTextByMouse
        // focus:control.focus

        // bg_enabled: control.enabled
        // colorDefault:Qt.rgba(0,0,0,0)
        bgRadius:control.bgRadius
        borderWidth:control.borderWidth
        colorDefault:'white'
        z:-1

        selectionColor:"#065AD8"
        selectedTextColor: "#065AD8"
        verticalAlignment: Text.AlignVCenter
        font.family:Fonts.inter
        font.weight:500

        // cursorDelegate: CursorDelegate { }
    }


    // background:Rectangle{
    //     anchors.centerIn:parent
    //     width: control.width +4
    //     height:control.height + 4
    //     // color:control.focus ? "#065AD8":text!=="" ? "#065AD8":"#AEAFB3"
    //     radius:8
    //     border.width:1
    //     border.color:control.focus ? "#065AD8":"red"
            
    // }

    popup: T.Popup {
        y: control.editable ? control.height - 5 : 0
        width: control.width
        height: Math.min(contentItem.implicitHeight + verticalPadding * 2, control.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
        topMargin: 12
        bottomMargin: 12
        verticalPadding: 8
        modal:true

        // Material.theme: control.Material.theme
        // Material.accent: control.Material.accent
        // Material.primary: control.Material.primary

        enter: Transition {
            // grow_fade_in
            NumberAnimation { property: "scale"; from: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            // shrink_fade_out
            NumberAnimation { property: "scale"; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: 2
            color: "white"
            border.color:'#e9e9e9'
            border.width:1

            layer.enabled: control.enabled
            layer.effect:     DropShadow{
                // anchors.fill:bg
                horizontalOffset: 0
                verticalOffset: 4
                radius: 10
                samples: 16
                color: "#100B2714"
                // source:bg
                z:-1
            }
        }
    }



}

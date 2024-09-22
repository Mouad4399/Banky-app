import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0


Rectangle{
    id:root
    width:parent===null ? width:parent.width
    height:parent===null ? height:parent.height
    objectName:"Payment"
    color:"#eff1fc"

    function isReadyToLeave(){
        return (stepsStack.depth<=1 || stepsStack.currentItem.objectName==="PaymentSucceeded")
    
    }

    property Dialog notReadyToLeavePopup:dialog

    Dialog {
        id: dialog
        // standardButtons: DialogButtonBox.Ok
        // anchors.centerIn:parentId
        // anchors.centerIn:parent
        // property var parentId
        width: contentDialog.implicitWidth
        height: contentDialog.implicitHeight
        padding: 0
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2

        // property string imageToSend:''
        // property string audioToSend:''

        onAccepted:
        {
        }

        onClosed: {
        }

        // topPadding: 0

        enter: Transition {
            // grow_fade_in
            NumberAnimation {
                property: "scale"
                from: 0.9
                to: 1.0
                easing.type: Easing.OutQuint
                duration: 220
            }
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                easing.type: Easing.OutCubic
                duration: 150
            }
        }

        exit: Transition {
            // shrink_fade_out
            NumberAnimation {
                property: "scale"
                from: 1.0
                to: 0.9
                easing.type: Easing.OutQuint
                duration: 220
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                easing.type: Easing.OutCubic
                duration: 150
            }
        }

        modal: true

        background: Rectangle {
            anchors.fill: parent
            // color:"red"
            radius: 12
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
        contentItem:Rectangle {
            // anchors.fill: parent
            id: contentDialog
            default property alias data: col.data
            implicitWidth: col.width + 40
            implicitHeight: col.height+40
            radius: 12
            // color: "white"
            color: Qt.rgba(0,0,0,0)

            ColumnLayout {
                id: col
                // width: 420
                width:460
                anchors.centerIn: parent
                // anchors.horizontalCenter:parent.horizontalCenter

                spacing: 15

                ColorImage {
                    id: closebtn
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    source: "image://img/close_icon.svg"
                    sourceSize.width:18
                    color: 'black'
                    Rectangle {
                        // id:closebtn_rect
                        anchors.centerIn: parent
                        width: parent.width + 4
                        height: width
                        color: Qt.rgba(0, 0, 0, 0)
                        radius: width / 2
                        z: -1

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.border.color = "#065AD8";
                            }
                            onExited: {
                                parent.border.color = Qt.rgba(0, 0, 0, 0);
                            }
                            onClicked: {
                                dialog.close();
                            }
                        }
                    }
                }
                // Item {
                //     Layout.fillWidth: true
                //     Layout.fillHeight: true
                // }

                ColumnLayout {
                    // Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    spacing: 25
                    Text {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        text: qsTranslate('',"Discard Process ?")
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 17
                        font.weight: 900
                        color: "black"
                    }
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        Layout.maximumWidth:parent.parent.width -40
                        text: qsTranslate('',"You are about to leave without completing the payment process , do you want to Discard it ? ")
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 11
                        font.weight: 600
                        color: "#787878"
                    }
                    
                }
                RowLayout{
                    // Layout.fillWidth:true
                    Layout.alignment: Qt.AlignRight
                    Layout.topMargin:15
                    spacing: 15
                    Item{
                        Layout.fillWidth:true
                    }
                    Button_ {
                        // Layout.alignment: Qt.AlignCenter
                        // Layout.fillWidth:true
                        // implicitWidth: 140
                        width:innerText.width + 16*2
                        height:35
                        // width:Layout.preferredWidth
                        // height: 45
                        buttonText: qsTranslate('',"Stay In")
                        textColor:'#121B28'
                        fontWeight: 700
                        fontSize:11
                        color:'white'
                        borderWidth:1
                        borderColor:'#121B28'
                        onClicked: {
                            dialog.reject();
                        }
                    }
                    Button_ {
                        // Layout.alignment: Qt.AlignCenter
                        // Layout.fillWidth:true
                        // width:Layout.preferredWidth
                        // height: 45
                        width:innerText.width + 16*2
                        height:35
                        buttonText: qsTranslate('',"Discard and Leave")
                        fontSize:11
                        fontWeight: 700
                        color:"#d32f2f"
                        onClicked: {
                            dialog.accept();
                        }
                    }
                }
            }
        }

    }

    property variant user_kyc_form:{'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
    property variant user_acc_form:{'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}

    property variant updated_kyc:{'dummyKey':''}



    Component.onCompleted:{
        // busypopup.open()
        window.getAttr('get_acc').finished.connect(function get_acc_slot(code , json){
            window.getAttr('get_acc').finished.disconnect(get_acc_slot)
        });
        window.getAttr('get_acc').sendRequest()



        
        
    }

    Rectangle{
        width:parent.width
        height:190
        color:Qt.darker("#121b28",1.3)
    }

    Flickable {
        id: scrollView

        clip: true
                                                    
        boundsBehavior: Flickable.StopAtBounds
        // Layout.fillWidth: true
        // Layout.fillHeight: true
        // contentWidth: textArea.width; contentHeight: textArea.height +10
        flickableDirection: Flickable.VerticalFlick
        // ALScrollBar.vertical: ALScrollBar {
        // }

        anchors.fill:parent
        anchors.margins:15
        anchors.topMargin:55
        contentHeight: content.height +2
        contentWidth: parent.width
        // contentItem:Flickable{
        //     boundsBehvior: Flickable.StopAtBounds
        // }
        

        ScrollBar_.vertical: ScrollBar_ {
            // parent: scrollView
            // x: scrollView.width
            // y: scrollView.topPadding
            // height: scrollView.availableHeight
        }

        Rectangle{
            id: content
            default property alias data:content_col.data
            width: scrollView.width-10
            height: content_col.implicitHeight+15*2
            color:"white"
            radius:10
            ColumnLayout{
                id:content_col
                // anchors.fill:parent
                // anchors.margins:15
                anchors.verticalCenter:parent.verticalCenter
                anchors.left:parent.left
                anchors.leftMargin:15
                anchors.right:parent.right
                anchors.rightMargin:15
                spacing:15
                RowLayout{
                    Layout.fillWidth:true
                    Layout.topMargin:20
                    // Layout.bottomMargin:20
                    Text {
                        // Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        text: "Make a Payment :"
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 20
                        font.weight: 900
                        color: "#121B28"
                        
                    }
                    Text {
                        id:payment_type
                        // Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        text: ""
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 18
                        font.weight: 300
                        color: Qt.lighter("#121b28",1.62)
                        
                    }
                    Item{
                        Layout.fillWidth:true
                    }
                    ColorImage{
                        id:payment_icon
                        source:'data:image/svg+xml;utf8,<svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5 4C4.20435 4 3.44129 4.31607 2.87868 4.87868C2.31607 5.44129 2 6.20435 2 7V8H22V7C22 6.20435 21.6839 5.44129 21.1213 4.87868C20.5587 4.31607 19.7956 4 19 4H5ZM22 10H2V17C2 17.7956 2.31607 18.5587 2.87868 19.1213C3.44129 19.6839 4.20435 20 5 20H19C19.7956 20 20.5587 19.6839 21.1213 19.1213C21.6839 18.5587 22 17.7956 22 17V10ZM8 15C8 14.7348 8.10536 14.4804 8.29289 14.2929C8.48043 14.1054 8.73478 14 9 14H13.414L13.293 13.879C13.1054 13.6915 12.9999 13.4371 12.9998 13.1719C12.9997 12.9066 13.105 12.6521 13.2925 12.4645C13.48 12.2769 13.7344 12.1714 13.9996 12.1713C14.2649 12.1712 14.5194 12.2765 14.707 12.464L16.535 14.293C16.7225 14.4805 16.8278 14.7348 16.8278 15C16.8278 15.2652 16.7225 15.5195 16.535 15.707L14.707 17.535C14.6148 17.6305 14.5044 17.7067 14.3824 17.7591C14.2604 17.8115 14.1292 17.8391 13.9964 17.8403C13.8636 17.8414 13.7319 17.8161 13.609 17.7658C13.4861 17.7155 13.3745 17.6413 13.2806 17.5474C13.1867 17.4535 13.1125 17.3419 13.0622 17.219C13.0119 17.0961 12.9866 16.9644 12.9877 16.8316C12.9889 16.6988 13.0165 16.5676 13.0689 16.4456C13.1213 16.3236 13.1975 16.2132 13.293 16.121L13.414 16H9C8.73478 16 8.48043 15.8946 8.29289 15.7071C8.10536 15.5196 8 15.2652 8 15Z" fill="#B0B4B8"/></svg>'
                        color: Qt.lighter("#121b28",1.62)
                        sourceSize.width:50
                    }
                }
                
                StackView {
                    id:stepsStack
                    Layout.fillWidth:true
                    // Layout.fillHeight: true
                    implicitHeight: currentItem.implicitHeight
                    // Layout.leftMargin:20
                    // Layout.rightMargin:20
                    // Layout.bottomMargin:5

                    // initialItem:"./PaymentFirstStep.qml"
                    initialItem:"./ChoosePlan.qml"

                    popEnter: Transition {
                        // slide_in_left
                        LineAnimation {
                            property: "x"
                            from: (stepsStack.mirrored ? -0.5 : 0.5) * -stepsStack.width
                            to: 0
                        }
                        FadeIn {
                        }
                    }

                    popExit: Transition {
                        // slide_out_right
                        LineAnimation {
                            property: "x"
                            from: 0
                            to: (stepsStack.mirrored ? -0.5 : 0.5) * stepsStack.width
                        }
                        FadeOut {
                        }
                    }

                    pushEnter: Transition {
                        // slide_in_right
                        LineAnimation {
                            property: "x"
                            from: (stepsStack.mirrored ? -0.5 : 0.5) * stepsStack.width
                            to: 0
                        }
                        FadeIn {
                        }
                    }

                    pushExit: Transition {
                        // slide_out_left
                        LineAnimation {
                            property: "x"
                            from: 0
                            to: (stepsStack.mirrored ? -0.5 : 0.5) * -stepsStack.width
                        }
                        FadeOut {
                        }
                    }

                    replaceEnter: Transition {
                        // slide_in_right
                        LineAnimation {
                            property: "x"
                            from: (stepsStack.mirrored ? -0.5 : 0.5) * stepsStack.width
                            to: 0
                        }
                        FadeIn {
                        }
                    }

                    replaceExit: Transition {
                        // slide_out_left
                        LineAnimation {
                            property: "x"
                            from: 0
                            to: (stepsStack.mirrored ? -0.5 : 0.5) * -stepsStack.width
                        }
                        FadeOut {
                        }
                    }
                }

                // Rectangle{
                //     // Layout.fillWidth:true
                //     Layout.preferredWidth:240
                //     Layout.alignment:Qt.AlignLeft
                //     Layout.preferredHeight:3
                //     radius:height
                //     color:'#AEAFB3'
                // }
                
            }

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
    }

        
 component LineAnimation: NumberAnimation {
        duration: 200
        easing.type: Easing.OutCubic
    }

    component FadeIn: LineAnimation {
        property: "opacity"
        from: 0.0
        to: 1.0
    }

    component FadeOut: LineAnimation {
        property: "opacity"
        from: 1.0
        to: 0.0
    }

}
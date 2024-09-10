import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0

ColumnLayout{
    spacing:10
    required property var search_acc_info 
    required property real amountToPay 
    required property string description 
    ColorImage {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        source: 'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 11V13H7.99997L13.5 18.5L12.08 19.92L4.15997 12L12.08 4.08L13.5 5.5L7.99997 11H20Z" fill="#699BF7"/></svg>'
        sourceSize.width:18
        color: 'black'
        Rectangle {
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
                    stepsStack.pop();
                }
            }
        }
    }
    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft
        text: qsTranslate('',"Step 3 of 3")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.family: Fonts.inter
        font.pointSize: 8
        font.weight: 600
        color: "#AEAFB3"
        
    }
    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft
        text: qsTranslate('',"Step 3 : Confirm Your Transfer")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.family: Fonts.inter
        font.pointSize: 11
        font.weight: 900
        color: "#121b28"
        
    }
    Rectangle{
        height:100
        Layout.fillWidth:true
        // color:"#eff1fc"
        radius:9
        RowLayout{
            anchors.fill:parent
            anchors.leftMargin:15
            anchors.rightMargin:15

            RowLayout{
                spacing:20
                ColorImage {
                    id: recipient_image
                    source: 'data:image/svg+xml;utf8,<svg width="70" height="70" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.477 2 12C2 17.523 6.477 22 12 22C17.523 22 22 17.523 22 12C22 6.477 17.523 2 12 2ZM8.5 9.5C8.5 9.04037 8.59053 8.58525 8.76642 8.16061C8.94231 7.73597 9.20012 7.35013 9.52513 7.02513C9.85013 6.70012 10.236 6.44231 10.6606 6.26642C11.0852 6.09053 11.5404 6 12 6C12.4596 6 12.9148 6.09053 13.3394 6.26642C13.764 6.44231 14.1499 6.70012 14.4749 7.02513C14.7999 7.35013 15.0577 7.73597 15.2336 8.16061C15.4095 8.58525 15.5 9.04037 15.5 9.5C15.5 10.4283 15.1313 11.3185 14.4749 11.9749C13.8185 12.6313 12.9283 13 12 13C11.0717 13 10.1815 12.6313 9.52513 11.9749C8.86875 11.3185 8.5 10.4283 8.5 9.5ZM18.258 16.984C17.5092 17.9253 16.5575 18.6855 15.4739 19.2077C14.3904 19.7299 13.2029 20.0008 12 20C10.7971 20.0008 9.60965 19.7299 8.52607 19.2077C7.44249 18.6855 6.49081 17.9253 5.742 16.984C7.363 15.821 9.575 15 12 15C14.425 15 16.637 15.821 18.258 16.984Z" fill="#B0B4B8"/></svg>'
                    color:"#AEAFB3"
                }
                ColumnLayout{
                    Text {
                        Layout.alignment:Qt.AlignLeft
                        text: search_acc_info !== undefined ? search_acc_info.full_name : ''
                        // text: user_kyc_form.full_name
                        horizontalAlignment: Text.AlignLeft
                        font.family: Fonts.inter
                        wrapMode: Text.WordWrap
                        font.weight: 900
                        font.pointSize: 11
                        color: "#121b28"
                    }
                    Text {
                        Layout.alignment:Qt.AlignLeft
                        // text: user_info.email
                        text: search_acc_info !== undefined ? search_acc_info.email : ''
                        horizontalAlignment: Text.AlignLeft
                        font.family: Fonts.inter
                        wrapMode: Text.WordWrap
                        font.weight: 600
                        font.pointSize: 10
                        color: "#AEAFB3"
                    }
                    Text {
                        Layout.alignment:Qt.AlignLeft
                        text: search_acc_info !== undefined ? search_acc_info.account_id : ''
                        horizontalAlignment: Text.AlignLeft
                        font.family: Fonts.inter
                        wrapMode: Text.WordWrap
                        font.weight: 600
                        font.pointSize: 10
                        color: "#AEAFB3"
                    }
                    Text {
                        Layout.alignment:Qt.AlignLeft
                        text: search_acc_info !== undefined ? search_acc_info.account_number : ''
                        horizontalAlignment: Text.AlignLeft
                        font.family: Fonts.inter
                        wrapMode: Text.WordWrap
                        font.weight: 600
                        font.pointSize: 10
                        color: "#AEAFB3"
                    }
                    
                }
            }
            Item{
                Layout.fillWidth:true
            }
            // Button_{
            //     width:innerText.width + 20*2
            //     height:40
            //     buttonText:qsTranslate("","Choose")
            //     color: "#065AD8"
            //     borderColor: "#065AD8" 
            //     textColor: "white"
            //     fontWeight:600
            //     fontSize:10
            //     borderWidth:1
            //     onClicked:{
            //     }
            // }
        }

    }

    Rectangle{
        height:250
        Layout.fillWidth:true
        color:"#eff1fc"
        radius:9
        // border.width:1
        // border.color:"#121b28"
        ColumnLayout{
            anchors.fill:parent
            anchors.margins:15
            spacing:10
            Item{
                Layout.fillHeight:true
            }
            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                text: qsTranslate('',"Payment Details")
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                font.family: Fonts.inter
                font.pointSize: 11
                font.weight: 900
                color: "#121b28"
                
            }
            Rectangle{
                Layout.fillWidth:true
                height:1
                color: "#AEAFB3"
            }
            RowLayout{
                Layout.fillWidth:true
                Layout.fillHeight:true
                GridLayout{
                    // Layout.fillWidth:true
                    Layout.fillHeight:true
                    columns:2
                    rowSpacing:10
                    columnSpacing:40

                    Repeater{
                        model:[
                            'You Send',
                            'Recipient gets',
                            'E-mail of receiver',
                            'Fee',
                            'Purpose',
                            'Transfer will be receive on',
                            ]
                        delegate:Text {
                            Layout.column:0
                            Layout.row:index
                            // Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            text: modelData + " : "
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 10
                            font.weight: 600
                            color: "#444"
                        }
                    }
                    Repeater{
                        model:[
                            "USD "+amountToPay.toLocaleString(Qt.locale())+"$",
                            "USD "+amountToPay.toLocaleString(Qt.locale())+"$",
                            search_acc_info.email,
                            'Free',
                            description,
                            Qt.formatDate(new Date(), "dd MMM yyyy"),
                            ]
                        delegate:Text {
                            Layout.column:1
                            Layout.row:index
                            // Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            text: modelData
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 10
                            font.weight: 900
                            color:"#121b28"
                        }
                    }
                }
                Item{
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                }
            }
            Item{
                Layout.fillHeight:true
            }
        }
    }
    CheckBox_ {
        id:confirm_checkbox
        Layout.topMargin:20
        Layout.bottomMargin:20
        Layout.alignment:Qt.AlignCenter
        color:'#2381DF'
        text:" I confirm the payment details above "
        font.family: Fonts.inter
        font.weight: 600
        font.pointSize: 10
        // contentItem.leftPadding :20
        spacing:20
        // checked:model.checked
        onClicked:{
        }
    }
    Button_{
        enabled:confirm_checkbox.checked
        disabledBgColor:"#ccc"
        Layout.alignment:Qt.AlignRight
        Layout.preferredWidth:innerText.width + 48*2
        height:35
        buttonText:confirm_checkbox.checked ? "Next":"confirm the Payment to proceed"
        color: "#065AD8"
        textColor: confirm_checkbox.checked ?"white":"#666"
        fontWeight:600
        fontSize:10
        onClicked:{
            dialog.open()
        }
    }
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
                        text: qsTranslate('',"Confirm The Payment ")
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
                        text: qsTranslate('',"Enter yout pin number bellow :")
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 10
                        font.weight: 600
                        color: "#787878"
                    }
                    Row {
                        // Layout.fillHeight:true
                        // height: parent.height * 0.7
                        Layout.alignment:Qt.AlignHCenter | Qt.AlignVCenter
                        spacing: 10
                        // anchors.centerIn: parent

                        Repeater {
                            id:rep
                            model: 4 // Number of OTP digits

                            EmptyField_ {
                                id: otpField

                                width: 64
                                height: 64
                                // innerRec.radius:2
                                bgRadius:2
                                placeholderText:""
                                // focus: index ===3 ? true : false
                                maximumLength:1
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                font.pointSize: 27
                                font.weight:700
                                validator: IntValidator{}


                                onTextChanged: {
                                    errorMessage.visible=false
                                    // window.disp(index)
                                    if(text.length !==0){
                                        if (index < 4-1){
                                            otpField.parent.children[index + 1].forceActiveFocus()
                                        }
                                    }
                                }
                                // Focus the previous field on backspace
                                property string stri :""
                                Keys.onPressed: function(event){
                                    if (event.key === Qt.Key_Backspace && text.length === 0 && index > 0) {
                                        // window.disp()
                                        previousItem.forceActiveFocus();
                                        return;
                                    }
                                    if(event.matches(StandardKey.Paste)){
                                        // window.disp(pastedText)
                                        // stri= paste()
                                        // stri = StandardKey.Paste.valueOf()
                                        stri =window.getPaste()
                                        for (let i=1 ;i<4 ; i++){
                                            otpField.parent.children[i].text=stri[i]

                                        }

                                    }
                                }

                                // Reference to the next and previous items for navigation
                                // property TextField nextItem: index < 4 - 1 ? otpField.parent.children[index + 1] :
                                property var previousItem: index > 0 ? otpField.parent.children[index - 1] : null
                            }
                        }
                    }

                    
                }
                Text {
                    id:errorMessage
                    visible:false
                    Layout.alignment:Qt.AlignCenter
                    font.family: Fonts.inter
                    text: 'ERROR : Pin Number is Incorrect !!'
                    color: 'red'
                    font.pointSize: 9
                }
                RowLayout{
                    // Layout.fillWidth:true
                    Layout.alignment: Qt.AlignRight
                    Layout.topMargin:15
                    spacing: 15
                    // Item{
                    //     Layout.fillWidth:true
                    // }
                    Button_ {
                        id:confirm_btn
                        // Layout.alignment: Qt.AlignCenter
                        // Layout.fillWidth:true
                        // width:Layout.preferredWidth
                        // height: 45
                        width:innerText.width + 16*2
                        height:35
                        buttonText: qsTranslate('',"Confirm")
                        fontSize:11
                        fontWeight: 700
                        color:"#50DC6C"
                        property string pin_number
                        onClicked: {
                            for (let i=0 ;i<rep.count; i++){
                                pin_number+=rep.itemAt(i).text
                            }
                            // console.log(pin_number)
                            

                            window.getAttr('transfer_amount').finished.connect(function transfer_amount_slot(code , json){
                                busypopup.close()
                                if(code !== 200){
                                    errorMessage.visible=true
                                }else{
                                    toastmanager.show(true,"Payment Process :" ,"your Payment of USD <b>"+amountToPay+"</b>$ sent to <b>"+search_acc_info.full_name+"</b> was successfully completed")
                                    dialog.accept();
                                    stepsStack.push('./PaymentSucceeded.qml',{'search_acc_info':search_acc_info,
                                                    'amountToPay':Number(amountToPay),
                                                    'description':description,
                                                    'transaction_id':json.transaction_id
                                                    })
                                }
                                window.getAttr('transfer_amount').finished.disconnect(transfer_amount_slot)
                            });
                            busypopup.open()
                            window.getAttr('transfer_amount').sendRequest( {
                                'account_number':search_acc_info.account_number,
                                'amount':amountToPay ,
                                'pin_number':pin_number,
                                'description':description
                                })  

                            pin_number=""
                        }
                    }
                }
            }

        }

    }

}
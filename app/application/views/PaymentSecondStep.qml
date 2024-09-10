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
    ColorImage {
        id: closebtn
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        source: 'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 11V13H7.99997L13.5 18.5L12.08 19.92L4.15997 12L12.08 4.08L13.5 5.5L7.99997 11H20Z" fill="#699BF7"/></svg>'
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
                    stepsStack.pop();
                }
            }
        }
    }
    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft
        text: qsTranslate('',"Step 2 of 3")
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
        text: qsTranslate('',"Step 2 :Set Amount of Transfer")
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
                text: qsTranslate('',"You Send")
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                font.family: Fonts.inter
                font.pointSize: 10
                font.weight: 900
                color: "#444"
                
            }
            Rectangle {
                id: search
                // Layout.alignment: Qt.AlignLeft
                // default property alias data: row.data
                // height: row.height + border.width * 2
                height:40
                // implicitWidth: row.width + 2 + border.width * 2
                Layout.fillWidth:true
                border.color: '#D7D7D7'
                border.width: 1
                radius: 5
                RowLayout {
                    id: row
                    // anchors.centerIn: parent
                    // anchors.left:parent.left
                    // anchors.right:parent.right
                    // height: 40
                    anchors.fill:parent
                    anchors.margins:1
                    ColorImage {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin:10
                        // anchors.right: parent.right
                        // anchors.verticalCenter: parent.verticalCenter
                        source:'data:image/svg+xml;utf8,<svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5 4C4.20435 4 3.44129 4.31607 2.87868 4.87868C2.31607 5.44129 2 6.20435 2 7V8H22V7C22 6.20435 21.6839 5.44129 21.1213 4.87868C20.5587 4.31607 19.7956 4 19 4H5ZM22 10H2V17C2 17.7956 2.31607 18.5587 2.87868 19.1213C3.44129 19.6839 4.20435 20 5 20H19C19.7956 20 20.5587 19.6839 21.1213 19.1213C21.6839 18.5587 22 17.7956 22 17V10ZM8 15C8 14.7348 8.10536 14.4804 8.29289 14.2929C8.48043 14.1054 8.73478 14 9 14H13.414L13.293 13.879C13.1054 13.6915 12.9999 13.4371 12.9998 13.1719C12.9997 12.9066 13.105 12.6521 13.2925 12.4645C13.48 12.2769 13.7344 12.1714 13.9996 12.1713C14.2649 12.1712 14.5194 12.2765 14.707 12.464L16.535 14.293C16.7225 14.4805 16.8278 14.7348 16.8278 15C16.8278 15.2652 16.7225 15.5195 16.535 15.707L14.707 17.535C14.6148 17.6305 14.5044 17.7067 14.3824 17.7591C14.2604 17.8115 14.1292 17.8391 13.9964 17.8403C13.8636 17.8414 13.7319 17.8161 13.609 17.7658C13.4861 17.7155 13.3745 17.6413 13.2806 17.5474C13.1867 17.4535 13.1125 17.3419 13.0622 17.219C13.0119 17.0961 12.9866 16.9644 12.9877 16.8316C12.9889 16.6988 13.0165 16.5676 13.0689 16.4456C13.1213 16.3236 13.1975 16.2132 13.293 16.121L13.414 16H9C8.73478 16 8.48043 15.8946 8.29289 15.7071C8.10536 15.5196 8 15.2652 8 15Z" fill="#B0B4B8"/></svg>'
                        color:"#121b28"
                    }

                    EmptyField_ {
                        id:amount_to_pay_field
                        Layout.fillWidth: true
                        // Layout.fillHeight: true
                        Layout.preferredHeight:parent.height
                        Layout.alignment: Qt.AlignCenter
                        // implicitWidth: 230
                        // Layout.maximumWidth:300
                        // Layout.minimumWidth:200
                        validator: DoubleValidator{
                            notation:DoubleValidator.StandardNotation
                        }
                        
                        borderWidth: 0
                        placeholderText: qsTranslate('', 'Insert amount to send ...')
                        onTextEdited: {
                            newBalance.new_balance_int = Number(user_acc_info.account_balance)-Number(text)
                        }
                    }
                    // Rectangle {
                    //     Layout.alignment: Qt.AlignVCenter
                    //     color: '#D7D7D7'
                    //     default property alias data: combo.data
                    //     Layout.fillHeight: true
                    //     implicitWidth: combo.width -1
                    // }
                    ComboBox_ {
                        id: combo
                        Layout.fillHeight:true
                        model: ['USD', 'MAD', 'YEN', 'SRL',]
                        bgRadius:4

                    }
                }
            }
            ColumnLayout{
                spacing:5
                Layout.bottomMargin:15
                Text {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    textFormat: Text.RichText
                    text: "Available Balance : "+ "<b>"+ Number(user_acc_info.account_balance).toLocaleString(Qt.locale())+"$</b>"
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 9
                    font.weight: 600
                    color: "#444"
                    
                }
                Text {
                    id:newBalance
                    property real new_balance_int: parseInt(user_acc_info.account_balance)
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    textFormat: Text.RichText
                    text: "New Balance : "+ "<b>"+Number(new_balance_int).toLocaleString(Qt.locale())+" $</b>"
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 9
                    font.weight: 600
                    color: new_balance_int < 0 ? "red":"#444"
                    
                }
            }
            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                text: qsTranslate('',"Description")
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                font.family: Fonts.inter
                font.pointSize: 10
                font.weight: 900
                color: "#444"
                
            }
            TextField_ {
                id:description
                Layout.fillWidth: true
                placeholderText: "Insert the payment description ... "
                onTextEdited:{

                }
            }
            Item{
                Layout.fillHeight:true
            }
        }
    }
    RowLayout{
        Layout.topMargin:15
        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft
            text: qsTranslate('',"Total Fees")
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            font.family: Fonts.inter
            font.pointSize: 10
            font.weight: 600
            color: "#121b28"
            
        }
        Item{
            Layout.fillWidth:true
        }
        Text {
            Layout.alignment: Qt.AlignRight
            text: qsTranslate('',"Free")
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            font.family: Fonts.inter
            font.pointSize: 10
            font.weight: 600
            color:"#121b28"
            
        }
    }
    Rectangle{
        Layout.fillWidth:true
        height:1
        color: "#AEAFB3"
    }
    RowLayout{
        Layout.bottomMargin:15
        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft
            text: qsTranslate('',"Total To Pay")
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            font.family: Fonts.inter
            font.pointSize: 12
            font.weight: 900
            color: "#121b28"
            
        }
        Item{
            Layout.fillWidth:true
        }
        Text {
            Layout.alignment: Qt.AlignRight
            text: "USD "+Number(amount_to_pay_field.text).toLocaleString(Qt.locale())+"$"
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            font.family: Fonts.inter
            font.pointSize: 12
            font.weight: 900
            color: "#121b28"
            
        }
    }
    Button_{
        enabled:(newBalance.new_balance_int >0) && (Number(amount_to_pay_field.text)>0)
        Layout.alignment:Qt.AlignRight
        Layout.preferredWidth:innerText.width + 48*2
        height:35
        buttonText:newBalance.new_balance_int <0 ? "Can't Send This Amount":"Next"
        disabledBgColor:"#ccc"
        color: "#065AD8"
        textColor: newBalance.new_balance_int <0 ? "#666":"white"
        fontWeight:600
        fontSize:10
        onClicked:{
            stepsStack.push('./PaymentThirdStep.qml',{'search_acc_info':search_acc_info,
                                                        'amountToPay':Number(amount_to_pay_field.text),
                                                        'description':description.text
                                                        })
        }
    }

}
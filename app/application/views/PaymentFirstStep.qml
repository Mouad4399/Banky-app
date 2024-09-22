import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0


// Component.onCompleted:{


    
    
// }
ColumnLayout{
    // Layout.fillHeight:true
    required property string payment_type
    property var search_data :{
        'account_id_or_number':''
    }
    property var search_acc_info 
    function search_acc_slot(code , json){
        busypopup.close()
        if(code !== 200){
            notFound_alert.visible=true
            notFound_alert.notFound=true
            return
        }
        notFound_alert.visible=false
        notFound_alert.notFound=false
        search_acc_info=json
        
        window.getAttr('search_acc').finished.disconnect(search_acc_slot)
    }
    spacing:15
    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft
        text: qsTranslate('',"Step 1 : Choose Recipient ")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.family: Fonts.inter
        font.pointSize: 11
        font.weight: 900
        color: "#121b28"
        
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
                source:'data:image/svg+xml;utf8,<svg width="20" height="20" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.4851 17.154L10.2231 10.892C9.7231 11.318 9.14811 11.6477 8.49811 11.881C7.84811 12.1144 7.19477 12.231 6.53811 12.231C4.93677 12.231 3.58144 11.6767 2.47211 10.568C1.36277 9.45871 0.808105 8.10371 0.808105 6.50304C0.808105 4.90238 1.36211 3.54671 2.47011 2.43604C3.57877 1.32471 4.93344 0.769043 6.53411 0.769043C8.13544 0.769043 9.49144 1.32371 10.6021 2.43304C11.7128 3.54238 12.2681 4.89804 12.2681 6.50004C12.2681 7.19471 12.1451 7.86704 11.8991 8.51704C11.6524 9.16704 11.3291 9.72304 10.9291 10.185L17.1911 16.446L16.4851 17.154ZM6.53811 11.23C7.86477 11.23 8.98511 10.7734 9.89911 9.86004C10.8124 8.94671 11.2691 7.82638 11.2691 6.49904C11.2691 5.17238 10.8124 4.05238 9.89911 3.13904C8.98577 2.22571 7.86577 1.76904 6.5391 1.76904C5.21244 1.76904 4.09211 2.22571 3.17811 3.13904C2.26477 4.05238 1.80811 5.17238 1.80811 6.49904C1.80811 7.82571 2.26477 8.94571 3.17811 9.85904C4.09144 10.7724 5.21144 11.23 6.53811 11.23Z" fill="#7D8F92"/></svg>'
            }

            EmptyField_ {
                id:recipient_search_field
                Layout.fillWidth: true
                // Layout.fillHeight: true
                Layout.preferredHeight:parent.height
                Layout.alignment: Qt.AlignCenter
                // implicitWidth: 230
                // Layout.maximumWidth:300
                // Layout.minimumWidth:200
                borderWidth: 0
                placeholderText: qsTranslate('', 'Search for an Recipient by Account Number or Account ID')
                onTextChanged: {
                    search_data.account_id_or_number=text
                }
                onAccepted: {
                    busypopup.open()
                    window.getAttr('search_acc').finished.connect(search_acc_slot);
                    window.getAttr('search_acc').sendRequest(search_data)
                    search_output.visible=true
                }
            }
            // Rectangle {
            //     Layout.alignment: Qt.AlignVCenter
            //     color: '#D7D7D7'
            //     default property alias data: combo.data
            //     Layout.fillHeight: true
            //     implicitWidth: combo.width -1
            // }
            Button_ {
                id: combo
                width:innerText.width + 20*2
                // anchors.right: parent.right
                // height: parent.height
                Layout.fillHeight:true
                buttonText:qsTranslate("","Search")
                color: "#121b28"
                // borderColor: "#065AD8" 
                textColor: "white"
                fontWeight:600
                fontSize:10
                // borderWidth:1
                onClicked:{
                    busypopup.open()
                    window.getAttr('search_acc').finished.connect(search_acc_slot);
                    window.getAttr('search_acc').sendRequest(search_data)
                    search_output.visible=true
                }

            }
        }
    }
    Rectangle{
        id:search_output
        visible:false
        height:150
        Layout.fillWidth:true
        color:"#eff1fc"
        radius:9
        RowLayout{
            visible:!notFound_alert.visible
            anchors.fill:parent
            anchors.leftMargin:15
            anchors.rightMargin:15

            RowLayout{
                spacing:20
                Loader {
                    
                    sourceComponent: search_acc_info!== undefined ? search_acc_info.account_id ===user_acc_info.account_id ? user_image : other_user_image :undefined
                }
                Component{
                    id:user_image
                    ColorImage {
                        id: recipient_image
                        // Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                        source:'http://localhost:8000/user/kyc/file/image?token='+user_info.token 
                        // Layout.preferredWidth:10
                        // Layout.preferredHeight:width
                        Layout.preferredWidth:width
                        Layout.preferredHeight:height
                        width:100
                        height:100
                        layer.enabled:true
                        layer.effect:OpacityMask {
                            maskSource: Rectangle {
                                width: recipient_image.width
                                height: recipient_image.height
                                radius: width/2
                                // visible: false // this also needs to be invisible or it will cover up the image
                            }
                        }
                    }
                }
                Component{
                    id:other_user_image
                    ColorImage {
                        id: recipient_image
                        source:'data:image/svg+xml;utf8,<svg width="100" height="100" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.477 2 12C2 17.523 6.477 22 12 22C17.523 22 22 17.523 22 12C22 6.477 17.523 2 12 2ZM8.5 9.5C8.5 9.04037 8.59053 8.58525 8.76642 8.16061C8.94231 7.73597 9.20012 7.35013 9.52513 7.02513C9.85013 6.70012 10.236 6.44231 10.6606 6.26642C11.0852 6.09053 11.5404 6 12 6C12.4596 6 12.9148 6.09053 13.3394 6.26642C13.764 6.44231 14.1499 6.70012 14.4749 7.02513C14.7999 7.35013 15.0577 7.73597 15.2336 8.16061C15.4095 8.58525 15.5 9.04037 15.5 9.5C15.5 10.4283 15.1313 11.3185 14.4749 11.9749C13.8185 12.6313 12.9283 13 12 13C11.0717 13 10.1815 12.6313 9.52513 11.9749C8.86875 11.3185 8.5 10.4283 8.5 9.5ZM18.258 16.984C17.5092 17.9253 16.5575 18.6855 15.4739 19.2077C14.3904 19.7299 13.2029 20.0008 12 20C10.7971 20.0008 9.60965 19.7299 8.52607 19.2077C7.44249 18.6855 6.49081 17.9253 5.742 16.984C7.363 15.821 9.575 15 12 15C14.425 15 16.637 15.821 18.258 16.984Z" fill="#B0B4B8"/></svg>'
                    }
                }
                ColumnLayout{
                    Text {
                        Layout.alignment:Qt.AlignLeft
                        text: search_acc_info !== undefined ? search_acc_info.full_name + (search_acc_info.account_id ===user_acc_info.account_id ? " (You)" : "") : ''
                        // text: user_kyc_form.full_name
                        horizontalAlignment: Text.AlignLeft
                        font.family: Fonts.inter
                        wrapMode: Text.WordWrap
                        font.weight: 600
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
                        color: '#2381DF'
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
            Button_{
                enabled:search_acc_info!== undefined ?search_acc_info.account_id !==user_acc_info.account_id : null
                enabledEffect:true
                disabledBgColor:"#ccc"
                width:innerText.width + 20*2
                height:40
                buttonText:qsTranslate("","Choose")
                color: "#065AD8"
                textColor: enabled ? "white" : "#666"
                fontWeight:600
                fontSize:10
                onClicked:{
                    stepsStack.push('./PaymentSecondStep.qml',{'search_acc_info':search_acc_info,
                                                                'payment_type':payment_type
                                                                })
                }
            }
        }
        ColumnLayout{
            id:notFound_alert
            anchors.fill:parent
            spacing:10
            property bool notFound
            // anchors.centerIn:parent
            Item{
                Layout.fillHeight:true
            }

            ColorImage{
                visible:notFound_alert.notFound
                Layout.alignment:Qt.AlignCenter
                source:'data:image/svg+xml;utf8,<svg width="55" height="55" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 8V12M12 16.01L12.01 15.999M9 3H4V6M4 11V13M20 11V13M15 3H20V6M9 21H4V18M15 21H20V18" stroke="#699BF7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>'
                color: "#AEAFB3"
            }
            Text {
                visible:notFound_alert.notFound
                Layout.alignment:Qt.AlignCenter
                text: "This User Doesn't Exist"
                horizontalAlignment: Text.AlignLeft
                font.family: Fonts.inter
                wrapMode: Text.WordWrap
                font.weight: 600
                font.pointSize: 12
                color: "#AEAFB3"
            }
            Item{
                Layout.fillHeight:true
            }
        }
        Popup {
            id: busypopup
            // anchors.centerIn: Overlay.overlay
            anchors.centerIn:parent
            closePolicy: Popup.NoAutoClose
            modal: true
            background: Rectangle {
                anchors.fill: parent
                // color:"red"
                radius: 12
            }

            BusyIndicator {
                running: true
            }
        }
    }
}
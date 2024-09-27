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
    objectName:"Cards"
    color:"#eff1fc"

    function isReadyToLeave(){
        return true
    
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


    Component.onCompleted:{
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
        
        contentHeight: content.height +120
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
            anchors.top:parent.top
            anchors.topMargin:50
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
                spacing:10
                RowLayout{
                    Layout.fillWidth:true
                    Layout.topMargin:20
                    // Layout.bottomMargin:20
                    ColumnLayout{

                        Text {
                            
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            text: qsTranslate('',"Cards : ")
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 20
                            font.weight: 900
                            color: "#121B28"
                            
                        }
                        Text {
                            
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            text: "Here you will see your all your credit cards . "
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 12
                            font.weight: 300
                            color: "#999"
                            
                        }
                    }
                    Item{
                        Layout.fillWidth:true
                    }
                    ColorImage{
                        source:'data:image/svg+xml;utf8,<svg width="52" height="40" viewBox="0 0 26 20" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_21_65)"><path d="M21.7344 1.6016C21.3525 1.23441 21.3525 0.640657 21.7344 0.277376C22.1162 -0.085905 22.7338 -0.0898113 23.1116 0.277376L25.7116 2.77738C25.8944 2.95316 25.9959 3.19144 25.9959 3.44144C25.9959 3.69144 25.8944 3.92972 25.7116 4.1055L23.1116 6.6055C22.7297 6.97269 22.1122 6.97269 21.7344 6.6055C21.3566 6.23831 21.3525 5.64456 21.7344 5.28128L22.6687 4.38284L15.6 4.37503C15.0597 4.37503 14.625 3.95706 14.625 3.43753C14.625 2.918 15.0597 2.50003 15.6 2.50003H22.6728L21.7344 1.6016ZM4.26562 14.7266L3.33125 15.625H10.4C10.9403 15.625 11.375 16.043 11.375 16.5625C11.375 17.0821 10.9403 17.5 10.4 17.5H3.32719L4.26156 18.3985C4.64344 18.7657 4.64344 19.3594 4.26156 19.7227C3.87969 20.086 3.26219 20.0899 2.88437 19.7227L0.284375 17.2266C0.101562 17.0508 0 16.8125 0 16.5625C0 16.3125 0.101562 16.0743 0.284375 15.8985L2.88437 13.3985C3.26625 13.0313 3.88375 13.0313 4.26156 13.3985C4.63937 13.7657 4.64344 14.3594 4.26156 14.7227L4.26562 14.7266ZM3.9 2.50003H13.7272C13.5769 2.78128 13.4875 3.09769 13.4875 3.43753C13.4875 4.55863 14.4341 5.46878 15.6 5.46878H20.3694C20.2069 6.13285 20.3937 6.8555 20.93 7.37503C21.7547 8.168 23.0912 8.168 23.9159 7.37503L24.7 6.62113V15C24.7 16.3789 23.5341 17.5 22.1 17.5H12.2728C12.4231 17.2188 12.5125 16.9024 12.5125 16.5625C12.5125 15.4414 11.5659 14.5313 10.4 14.5313H5.63063C5.79313 13.8672 5.60625 13.1446 5.07 12.625C4.24531 11.8321 2.90875 11.8321 2.08406 12.625L1.3 13.3789V5.00003C1.3 3.62113 2.46594 2.50003 3.9 2.50003ZM6.5 5.00003H3.9V7.50003C5.33406 7.50003 6.5 6.37894 6.5 5.00003ZM22.1 12.5C20.6659 12.5 19.5 13.6211 19.5 15H22.1V12.5ZM13 13.75C14.0343 13.75 15.0263 13.3549 15.7577 12.6517C16.4891 11.9484 16.9 10.9946 16.9 10C16.9 9.00547 16.4891 8.05164 15.7577 7.34838C15.0263 6.64512 14.0343 6.25003 13 6.25003C11.9657 6.25003 10.9737 6.64512 10.2423 7.34838C9.51089 8.05164 9.1 9.00547 9.1 10C9.1 10.9946 9.51089 11.9484 10.2423 12.6517C10.9737 13.3549 11.9657 13.75 13 13.75Z" fill="#B0B4B8"/></g><defs><clipPath id="clip0_21_65"><rect width="26" height="20" fill="white"/></clipPath></defs></svg>'
                        color:"#121b28"
                    }
                }
                Rectangle{
                    Layout.topMargin:15
                    // Layout.bottomMargin:15
                    Layout.fillWidth:true
                    height:2
                    radius:1
                    color:"#eff1fc"
                }
                RowLayout{
                    Layout.topMargin:10
                    Layout.bottomMargin:10
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    spacing:10
                    Rectangle {
                        id: search
                        Layout.alignment: Qt.AlignVCenter
                        // default property alias data: row.data
                        // height: row.height + border.width * 2
                        height:40
                        // implicitWidth: row.width + 2 + border.width * 2
                        // Layout.fillWidth:true
                        implicitWidth: 300
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
                            anchors.margins:2
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
                                placeholderText: qsTranslate('', 'Search for by card number ... ')
                                onTextChanged: {
                                    search_data.account_id_or_number=text
                                }
                                onAccepted: {
                                    // busypopup.open()
                                    // window.getAttr('search_acc').finished.connect(search_acc_slot);
                                    // window.getAttr('search_acc').sendRequest(search_data)
                                    // search_output.visible=true
                                }
                            }
                            // Rectangle {
                            //     Layout.alignment: Qt.AlignVCenter
                            //     color: '#D7D7D7'
                            //     default property alias data: combo.data
                            //     Layout.fillHeight: true
                            //     implicitWidth: combo.width -1
                            // }
                            // Button_ {
                            //     id: combo
                            //     width:innerText.width + 20*2
                            //     // anchors.right: parent.right
                            //     // height: parent.height
                            //     Layout.fillHeight:true
                            //     buttonText:qsTranslate("","Search")
                            //     color: "#121b28"
                            //     // borderColor: "#065AD8" 
                            //     textColor: "white"
                            //     fontWeight:600
                            //     fontSize:10
                            //     // borderWidth:1
                            //     onClicked:{
                            //     }

                            // }
                        }
                    }
                    Text {
                        Layout.alignment:Qt.AlignVCenter
                        text: "type :"
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 9
                        font.weight: 500
                        color: "#666"
                    }
                    // Flickable {
                    //     id: tagScroll

                    //     clip: true
                                                                    
                    //     boundsBehavior: Flickable.StopAtBounds
                    //     // Layout.fillWidth: true
                    //     // Layout.fillHeight: true
                    //     // contentWidth: textArea.width; contentHeight: textArea.height +10
                    //     flickableDirection: Flickable.HorizontalFlick
                    //     // ALScrollBar.vertical: ALScrollBar {
                    //     // }
                    //     // Layout.preferredWidth:300
                    //     width:300
                    //     height:40
                    //     // Layout.preferredHeight:parent.height
                    //     Layout.alignment:Qt.AlignVCenter
                    //     contentHeight: height
                    //     contentWidth: tagRow.implicitWidth +10
                    //     // contentItem:Flickable{
                    //     //     boundsBehvior: Flickable.StopAtBounds
                    //     // }
                        

                    //     // ScrollBar_.horizontal: ScrollBar_ {
                    //     //     // parent: scrollView
                    //     //     // x: scrollView.width
                    //     //     // y: scrollView.topPadding
                    //     //     // height: scrollView.availableHeight
                    //     // }

                    //     Row{
                    //         id:tagRow
                    //         // height: tagScroll.height-10
                    //         // width: tagScroll.width-10
                    //         // anchors.fill:parent
                    //         // anchors.margins:1

                    //         // anchors.verticalCenter:parent.verticalCenter
                    //         // height:40
                    //         // anchors.top:parent.top
                    //         // anchors.bottom:parent.bottom
                    //         // anchors.left:parent.
                    //         anchors.fill:parent
                    //         spacing:5

                    //         Repeater{
                    //             Layout.alignment:Qt.AlignCenter
                    //             model:['kitchen','bedroom','livingroom','bathroom','garage','sleepingroom']
                    //             delegate:Button_ {
                    //                 Layout.topMargin:20
                    //                 // Layout.alignment:Qt.AlignCenter
                    //                 // Layout.alignment:Qt.AlignCenter
                    //                 width:innerText.width + 10*2
                    //                 // Layout.fillHeight:true
                    //                 height:27
                    //                 borderRadius:height/2
                    //                 buttonText: modelData
                    //                 color: checked ?Qt.lighter("#121b28",1.5):"#eee"
                    //                 // borderColor: "#065AD8" 
                    //                 textColor: checked ?"white" :"black"
                    //                 fontWeight:300
                    //                 fontSize:9
                    //                 checkable:true
                    //                 autoExclusive: true
                    //                 // borderWidth:1
                    //                 onClicked:{
                    //                     checked=true
                    //                 }

                    //             }
                    //         }
                    //     }
                    //     // Rectangle{
                    //     //     anchors.fill:parent
                    //     //     color:'red'
                    //     // }
                    // }
                    Row{
                        id:typeRow
                        spacing:5
                        property var transaction_request :{
                            'type':'all'
                        }

                        Repeater{
                            Layout.alignment:Qt.AlignCenter
                            model:['Visa','Master Card','Others','All']
                            delegate:Button_ {
                                checked:modelData === "All"
                                width:innerText.width + 10*2
                                // Layout.fillHeight:true
                                height:27
                                borderRadius:height/2
                                buttonText: modelData
                                hoverColor:Qt.darker(color,1.1)
                                color: checked ?Qt.lighter("#121b28",1.8):"#eee"
                                // borderColor: "#065AD8" 
                                textColor: checked ?"white" :"black"
                                fontWeight:300
                                fontSize:9
                                checkable:true
                                autoExclusive: true
                                // borderWidth:1
                                onClicked:{
                                    checked=true
                                }
                                onCheckedChanged:{
                                    if(checked){
                                        transaction_table.transaction_request={
                                            'type':['visa','mastercard','others','all'][index]
                                        }
                                        // console.log(transaction_table.transaction_request.type)
                                        
                                    }
                                }

                            }
                        }
                    }
                    Item{
                        Layout.fillWidth:true
                    }
                
                    
                }
                CardsTable{
                    id:transaction_table
                    // transaction_request:typeRow.transaction_request
                    tableView.model:TableModel {
                        id: employeeModel
                        TableModelColumn {
                            display: "card_type"
                        }
                        TableModelColumn {
                            display: "card_number"
                        }
                        TableModelColumn {
                            display: "amount"
                        }
                        TableModelColumn {
                            display: "expiry_date"
                        }
                        TableModelColumn {
                            display: "status"
                        }

                        rows:[
                            {
                                'amount': 134897.34,
                                'full_name':'Mouad Ait Ougrram',
                                'card_type': 'Visa',
                                'card_number': '32498235903',
                                'expiry_date': '2024-09-02T10:12:43.942187Z',
                                'cvv':'543',
                                'status':'Active'
                            },
                            {
                                'amount': 13346.34,
                                'full_name':'Mouad Ait Ougrram',
                                'card_type': 'Master',
                                'card_number': '32498235903',
                                'expiry_date': '2024-09-02T10:12:43.942187Z',
                                'cvv':'543',
                                'status':'Active'
                            },
                            {
                                'amount': 1363457.34,
                                'full_name':'Mouad Ait Ougrram',
                                'card_type': 'Visa',
                                'card_number': '32498235903',
                                'expiry_date': '2024-09-02T10:12:43.942187Z',
                                'cvv':'543',
                                'status':'Active'
                            },
                        ]
                    }
                }
            }
        }
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
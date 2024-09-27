import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Fonts 1.0
import Components 1.0

Dialog {
    id: dialog
    property var credit_card :{'dummy':''}

    width: contentDialog.implicitWidth
    height: contentDialog.implicitHeight
    padding: 0
    parent:stack
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
            width:580
            anchors.centerIn: parent
            // anchors.horizontalCenter:parent.horizontalCenter

            spacing: 10

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
                spacing: 0
                Text {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    text: qsTranslate('',"Credit Card")
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
                    text: qsTranslate('',"See all information about your credit cards .")
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 10
                    font.weight: 600
                    color: "#787878"
                }
                
            }
            RowLayout{
                Layout.topMargin:15
                Layout.fillWidth:true
                spacing:15
                ColorImage{
                    // Layout.fillWidth:true
                    Layout.alignment:Qt.AlignTop
                    Layout.preferredWidth:71
                    Layout.preferredHeight:45
                    Layout.rightMargin:Layout.preferredWidth+20
                    // width: 240; height: 160
                    // Layout.fillWidth:true
                    // Layout.fillHeight:true
                    transformOrigin: Item.TopLeft
                    // // color:"red"
                    scale:3
                    // scale:(parent.width/240)
                    // Component.onCompleted:{
                    //     console.log(height)
                    // }
                    source:'image://img/credit_card_'+credit_card.card_type.toLowerCase()+"_"+((index % 2)+1)+".png"


                    Text{
                        // id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text:'Card Holder Name'
                        font.pointSize:4
                        color:'white'
                        x: -5.5  ; y:  32
                        
                        
                    }
                    Text{
                        // id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text:credit_card.full_name
                        font.pointSize:4.5
                        color:'white'
                        font.weight:700
                        // color:'white'
                        x: -8.5  ; y: 35
                        
                        
                    }
                    Text{
                        // id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text:'Expiry Date'
                        font.pointSize:4
                        color:'white'
                        x: 45.25  ; y: 31.5
                        
                    }
                    Text{
                        // id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text:credit_card.expiry_date
                        font.pointSize:5
                        color:'white'
                        font.weight:600
                        // color:'white'
                        x: 48  ; y: 34.25
                        
                        
                    }
                    Text{
                        // id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text: "$"+credit_card.amount.toLocaleString(Qt.locale())
                        font.pointSize:8
                        color:'white'
                        font.weight:600
                        // color:'white'
                        x: -12.25  ; y: 12.75
                        
                        
                    }
                    Text{
                        id:test
                        scale:0.5
                        font.family:Fonts.inter
                        text:'* * * *  * * * *  * * * *  '+credit_card.card_number.slice(-4)
                        // textFormat:Text.RichText
                        font.pointSize:6
                        color:'white'
                        font.weight:600
                        // color:'white'
                        x: -5.5  ; y: 21.75
                        
                        
                    }

                    // scale: PathView.scale
                    // opacity: 1
                    // Rectangle{
                    //     // anchors.fill:parent
                    //     anchors.left:parent.left
                    //     anchors.right:parent.right
                    //     anchors.bottom:parent.bottom
                    //     height:10
                    //     // scale: parent.scale
                    //     // visible:(parent.currentIndex===4 ) || (parent.currentIndex===0) ? ( Math.abs(index-parent.currentIndex)<parent.model.count/2):true
                    //     z:-Infinity
                    //     radius:20
                    //     // color:"transparent"
                    //     layer.enabled: true
                    //     layer.effect: DropShadow {
                    //         horizontalOffset: 0
                    //         verticalOffset: 4
                    //         radius: 12
                    //         samples: 16
                    //         color: "#27272727"
                    //         z: -1
                    //     }
                    // }

                    // Layout.alignment:Qt.AlignCenter
                    
                }
                Item{
                    Layout.fillWidth:true
                }
                Rectangle{
                    height:250
                    Layout.preferredWidth:343
                    color:"#eff1fc"
                    radius:9
                    // Component.onCompleted:{
                    //     console.log(width)
                    // }
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
                            text: qsTranslate('',"Credit Card Details")
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
                                        'Amount',
                                        'Card Holder',
                                        'Card Type',
                                        'Card Number',
                                        'Expiry Month & Year',
                                        'CVV',
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
                                        "USD "+credit_card.amount.toLocaleString(Qt.locale())+"$",
                                        credit_card.full_name,
                                        credit_card.card_type,
                                        credit_card.card_number,
                                        Qt.formatDate(new Date(credit_card.expiry_date) , "MM/yy"),
                                        credit_card.cvv,
                                        ]
                                    delegate:Text {
                                        Layout.column:1
                                        Layout.row:index
                                        // Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignRight
                                        text: modelData
                                        horizontalAlignment: Text.AlignRight
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
            }
            RowLayout{
                // Layout.fillWidth:true
                Layout.alignment: Qt.AlignRight
                Layout.topMargin:15
                spacing: 15
                Button_ {
                    // Layout.alignment: Qt.AlignCenter
                    // Layout.fillWidth:true
                    // width:Layout.preferredWidth
                    // height: 45
                    width:innerText.width + 16*2
                    height:35
                    buttonText: qsTranslate('',"Delete")
                    fontSize:11
                    fontWeight: 700
                    color:"#d32f2f"
                    onClicked: {
                        window.getAttr('delete_request').finished.connect(function delete_request_slot(code , json){
                            // busypopup.close()
                            if(code !== 200){
                                // console.log('something wrong ! , ' + transaction_request.type === 'all'?tableView.model.getRow(row).receiver_account_id:tableView.model.getRow(row).account_id)
                                toastmanager.show(false,"Delete Payment Request Process :" ,"Your Request of <b>"+json.transaction_id+"</b> was not Deleted ! ")
                                return
                            }
                            toastmanager.show(true,"Delete Payment Request Process :" ,"Your Request of <b>"+json.transaction_id+"</b> was successfully Deleted ! ")
                            
                            window.getAttr('delete_request').finished.disconnect(delete_request_slot)
                            dialog.accept();
                        });
                        window.getAttr('delete_request').sendRequest({
                            'transaction_id':dialog.transaction_id
                        })
                    }
                }
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
                    buttonText: qsTranslate('',"Withdraw")
                    fontSize:11
                    fontWeight: 700
                    color:"#50DC6C"
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
                    buttonText: qsTranslate('',"Fund Card")
                    fontSize:11
                    fontWeight: 700
                    color:"#065AD8"
                    onClicked: {
                    }
                }
            }
        }
    }

}
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
    objectName:"Account"
    color:"#eff1fc"

    Rectangle{
        width:parent.width
        height:190
        color:Qt.darker("#121b28",1.3)
    }


    RowLayout{
        anchors.fill: parent
        anchors.margins:15
        spacing:15

        Rectangle{
            // id:user_profile_card
            // Layout.preferredWidth:250
            // Layout.preferredHeight:400
            // Layout.alignment:Qt.AlignVCenter
            Layout.alignment:Qt.AlignTop
            Layout.topMargin:40
            width:250
            height:360
            // color:'red'
            radius:10

            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 16
                color: "#100B2714"
                z: -1
            }
            ColumnLayout{
                anchors.fill:parent
                anchors.margins:15
                spacing:10

                ColorImage {
                    id: user_image
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    source: 'http://localhost:8000/user/kyc/file/identity_image?token=b8c04399b638cad5a07ba5fd4d05e58f4609aa77'
                    Layout.preferredWidth:parent.width * 45/100
                    Layout.preferredHeight:width
                    layer.enabled:true
                    layer.effect:OpacityMask {
                        maskSource: Rectangle {
                            width: user_image.width
                            height: user_image.height
                            radius: width/2
                            // visible: false // this also needs to be invisible or it will cover up the image
                        }
                    }
                }
                Text {
                    text: "Mouad Ait Ougrram"
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 11
                    font.weight: 900
                    color: "#121b28"
                }
                Text {
                    text: "Active"
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 10
                    font.weight: 400
                    color: "#50DC6C"
                }
                Rectangle{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredHeight:1
                    color:'#AEAFB3'
                }
                GridLayout {
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                    columns: 1
                    columnSpacing: 0
                    rowSpacing: 10
                    Item{
                        Layout.fillHeight:true
                    }

                    RowLayout{
                        Layout.fillWidth:true
                        Layout.alignment:Qt.AlignTop
                        spacing:0
                        Text {
                            text: "Account ID:"
                            Layout.alignment:Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#121b28"
                        }
                        Text {
                            text: "Account ID"
                            Layout.fillWidth:true
                            Layout.alignment:Qt.AlignRight
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#AEAFB3"
                        }
                    }
                    Item{
                        Layout.fillHeight:true
                    }

                }

                Button_{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    height:40
                    buttonText:"Logout"
                    fontSize:10
                    textColor:state!==''?"white":hoverColor
                    color:"#eff1fc"
                    hoverColor:"#121b28"
                    pressColor:hoverColor
                    borderColor:"#999"
                    borderWidth:state!==''?0:1
                    borderRadius:15
                }
                Button_{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    height:40
                    buttonText:"Delete Account"
                    fontSize:10
                    textColor:state!==''?"white":hoverColor
                    color:"white"
                    hoverColor:"#FC5758"
                    pressColor:hoverColor
                    borderColor:hoverColor
                    borderWidth:1
                    borderRadius:15
                }

                // Item{
                //     Layout.fillHeight:true
                // }
            }

        }
        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: membersContent.height + 20

            ScrollBar_.vertical: ScrollBar_ {
                parent: scrollView
                x: scrollView.width
                y: scrollView.topPadding
                height: scrollView.availableHeight
            }

            Rectangle{
                id: membersContent
                default property alias data:kyc_detail
                width: scrollView.width-10
                height: kyc_detail.height+15*2
                color:"white"
                radius:10
                ColumnLayout{
                    id:kyc_detail
                    // anchors.fill:parent
                    // anchors.margins:15
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.left:parent.left
                    anchors.leftMargin:15
                    anchors.right:parent.right
                    anchors.rightMargin:15
                    spacing:15
                    Rectangle{
                        height:100
                        Layout.fillWidth:true
                        color:"#eff1fc"
                        radius:9
                        RowLayout{
                            anchors.fill:parent
                            anchors.leftMargin:15
                            anchors.rightMargin:15

                            RowLayout{
                                spacing:20
                                ColorImage {
                                    id: user_image_edit
                                    // Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                                    source: 'http://localhost:8000/user/kyc/file/identity_image?token=b8c04399b638cad5a07ba5fd4d05e58f4609aa77'
                                    Layout.preferredWidth:70
                                    Layout.preferredHeight:width
                                    layer.enabled:true
                                    layer.effect:OpacityMask {
                                        maskSource: Rectangle {
                                            width: user_image_edit.width
                                            height: user_image_edit.height
                                            radius: width/2
                                            // visible: false // this also needs to be invisible or it will cover up the image
                                        }
                                    }
                                }
                                ColumnLayout{
                                    Layout.alignment:Qt.AlignCenter
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: "Mouad Ait Ougrram"
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "black"
                                    }
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: "mouad@user.com"
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "#2381DF"
                                    }
                                    
                                }
                            }
                            Item{
                                Layout.fillWidth:true
                            }
                            Button_{
                                width:innerText.width + 48*2
                                height:35
                                buttonText:qsTranslate("","Upload new profile picture")
                                color: "#065AD8"
                                borderColor: "#065AD8" 
                                textColor: "white"
                                fontWeight:600
                                fontSize:10
                                borderWidth:1
                                onClicked:{
                                }
                            }
                        }
                    }
                    GridLayout {
                        // Layout.preferredWidth: parent.width
                        // Layout.maximumWidth: parent.width 
                        Layout.fillWidth:true
                        Layout.fillHeight:true
                        // Layout.alignment: Qt.AlignHCenter
                        // anchors.fill:parent
                        // anchors.margins:15
                        rowSpacing: 15
                        columnSpacing: 10
                        columns: 2

                        Repeater{
                            model:3
                            delegate:TextField_ {
                                Layout.column:0
                                Layout.row:2*index +1
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                // implicitHeight: 45
                                placeholder: ""
                                bgRadius: 8
                                onTextChanged:{
                                }
                            }
                        }
                        Repeater{
                            model:3
                            delegate:TextField_ {
                                Layout.column:1
                                Layout.row:2*index +1
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                // implicitHeight: 45
                                placeholder: ""
                                bgRadius: 8
                                onTextChanged:{
                                }
                            }
                        }
                        Repeater{
                            model:['Full Name','Country','City']
                            delegate:Text {
                                Layout.column:0
                                Layout.row:2*index
                                text: modelData
                                horizontalAlignment: Text.AlignLeft
                                font.family: Fonts.inter
                                wrapMode: Text.WordWrap
                                font.weight: 600
                                font.pointSize: 10
                                color: "#444444"
                            }
                        }
                        Repeater{
                            model:['Mobile Number','State','Fax']
                            delegate:Text {
                                Layout.column:1
                                Layout.row:2*index
                                text: modelData
                                horizontalAlignment: Text.AlignLeft
                                font.family: Fonts.inter
                                wrapMode: Text.WordWrap
                                font.weight: 600
                                font.pointSize: 10
                                color: "#444444"
                            }
                        }
                        Text {
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*3
                            text: 'Date Of Birth'
                            horizontalAlignment: Text.AlignLeft
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            font.weight: 600
                            font.pointSize: 10
                            color: "#444444"
                        }
                        TextField_ {
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*3 +1
                            Layout.fillWidth: true
                            // Layout.fillHeight: true
                            // implicitHeight: 45
                            placeholder: "1999-1-1"
                            bgRadius: 8
                            onTextChanged:{
                            }
                        }
                        // Text {
                        //     Layout.columnSpan:2
                        //     Layout.column:0
                        //     Layout.row:2*4
                        //     text: qsTr("Gender")
                        //     horizontalAlignment: Text.AlignLeft
                        //     wrapMode: Text.WordWrap
                        //     font.family: Fonts.inter
                        //     font.pointSize: 10
                        //     font.weight: 600
                        //     color: "#444"
                        // }
                        GridLayout{
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*4 
                            Layout.fillWidth: true
                            columns:3
                            Text {
                                text: qsTr("Gender")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }
                            Text {
                                text: qsTr("Marrtuale Status")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }
                            Text {
                                text: qsTr("Identity Type")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }

                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','Male', 'Female','Not expose']
                            }
                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','Single', 'Married','Not expose']
                            }
                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','National ID Card', 'Drives Licence','International Passport']
                            }
                        }


                            // Text {
                            //     Layout.column:0
                            //     Layout.row:0
                            //     text: "Adresse*<font color='red'>*</font> "
                            //     horizontalAlignment: Text.AlignLeft
                            //     font.family: Fonts.inter
                            //     wrapMode: Text.WordWrap
                            //     font.weight: 600
                            //     font.pointSize: 10
                            //     color: "#444444"
                            // }
                            // TextField_ {
                            //     Layout.column:0
                            //     Layout.row:1
                            //     Layout.fillWidth: true
                            //     // Layout.fillHeight: true
                            //     // implicitHeight: 45
                            //     placeholder: ""
                            //     bgRadius: 8
                            //     onTextChanged:{
                            //     }
                            // }
                            // Text {
                            //     Layout.column:1
                            //     Layout.row:0
                            //     text: "RC 1<font color='red'>*</font> "
                            //     horizontalAlignment: Text.AlignLeft
                            //     font.family: Fonts.inter
                            //     wrapMode: Text.WordWrap
                            //     font.weight: 600
                            //     font.pointSize: 10
                            //     color: "#444444"
                            // }
                            // TextField_ {
                            //     Layout.column:1
                            //     Layout.row:1
                            //     Layout.fillWidth: true
                            //     // Layout.fillHeight: true
                            //     // implicitHeight: 45
                            //     placeholder: ""
                            //     bgRadius: 8
                            //     onTextChanged:{
                            //     }
                            // }

                            // Text {
                            //     Layout.column:0
                            //     Layout.row:2
                            //     text: "Adresse*<font color='red'>*</font> "
                            //     horizontalAlignment: Text.AlignLeft
                            //     font.family: Fonts.inter
                            //     wrapMode: Text.WordWrap
                            //     font.weight: 600
                            //     font.pointSize: 10
                            //     color: "#444444"
                            // }
                            // TextField_ {
                            //     Layout.column:0
                            //     Layout.row:3
                            //     Layout.fillWidth: true
                            //     // Layout.fillHeight: true
                            //     // implicitHeight: 45
                            //     placeholder: ""
                            //     bgRadius: 8
                            //     onTextChanged:{
                            //     }
                            // }
                            // Text {
                            //     Layout.column:1
                            //     Layout.row:2
                            //     text: "RC 1<font color='red'>*</font> "
                            //     horizontalAlignment: Text.AlignLeft
                            //     font.family: Fonts.inter
                            //     wrapMode: Text.WordWrap
                            //     font.weight: 600
                            //     font.pointSize: 10
                            //     color: "#444444"
                            // }
                            // TextField_ {
                            //     Layout.column:1
                            //     Layout.row:3
                            //     Layout.fillWidth: true
                            //     // Layout.fillHeight: true
                            //     // implicitHeight: 45
                            //     placeholder: ""
                            //     bgRadius: 8
                            //     onTextChanged:{
                            //     }
                            // }
                    


                        // Button_{
                        //     Layout.alignment:Qt.AlignBottom
                        //     width:innerText.width + 50*2
                        //     height:35
                        //     buttonText:qsTranslate("","Enregister")
                        //     color: "#065AD8"
                        //     borderColor: "#065AD8" 
                        //     textColor: "white"
                        //     fontWeight:600
                        //     fontSize:10
                        //     borderWidth:1
                        //     onClicked:{
                        //     }
                        // }
                        Item{
                            Layout.columnSpan:2
                            Layout.fillHeight:true
                        }

                    }
                    RowLayout{
                        Layout.fillWidth:true
                        Layout.preferredHeight:250
                        spacing:15

                        Rectangle{
                            Layout.fillWidth:true
                            Layout.fillHeight:true
                            color:"#eff1fc"
                            radius:9
                            anchors.margins:10
                            Button_{
                                Layout.alignment:Qt.AlignLeft
                                width:innerText.width + 48*2
                                height:35
                                buttonText:qsTranslate("","Submit")
                                color: "#065AD8"
                                borderColor: "#065AD8" 
                                textColor: "white"
                                fontWeight:600
                                fontSize:10
                                borderWidth:1
                                onClicked:{
                                }
                            }
                            
                        }

                    }
                    Button_{
                        Layout.alignment:Qt.AlignLeft
                        width:innerText.width + 48*2
                        height:35
                        buttonText:qsTranslate("","Submit")
                        color: "#065AD8"
                        borderColor: "#065AD8" 
                        textColor: "white"
                        fontWeight:600
                        fontSize:10
                        borderWidth:1
                        onClicked:{
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
        }
    }

    Popup {
        id: busypopup
        anchors.centerIn: Overlay.overlay
        closePolicy: Popup.NoAutoClose
        modal: true

        BusyIndicator {
            running: true
        }
    }

}
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0


Rectangle{
    id:root
    width:parent===null ? width:parent.width
    height:parent===null ? height:parent.height
    objectName:"Dashboard"
    color:"#F5F5F5"
    function isReadyToLeave(){
        
        return true
    
    }
    property variant user_kyc_form:{'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
    property variant user_acc_form:{'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}


    Component.onCompleted:{
        window.getAttr('get_acc').finished.connect(function get_acc_slot(code , json){
            busypopup.close();
            user_acc_form=user_acc_info
            window.getAttr('get_acc').finished.disconnect(get_acc_slot)
        });
        busypopup.open();
        window.getAttr('get_acc').sendRequest()

        window.getAttr('get_kyc').finished.connect(function get_kyc_slot(code,json) {
            busypopup.close()

            if (code === 200) {
                user_kyc_form=user_kyc_info
            }

            window.getAttr('get_kyc').finished.disconnect(get_kyc_slot)
        });
        busypopup.open();
        window.getAttr('get_kyc').sendRequest()
        
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 10
        spacing: 20


        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: membersContent.height + 20

            ScrollBar_.vertical: ScrollBar_ {
                parent: scrollView
                x: -10
                y: scrollView.topPadding
                height: scrollView.availableHeight
            }
            ColumnLayout {
                id: membersContent
                anchors.left: parent.left
                anchors.leftMargin: 20
                width: scrollView.width - 40
                height: 1000
                spacing: 20
                ColumnLayout {
                    Layout.preferredWidth: parent.width 
                    Layout.maximumWidth: parent.width 
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 5
                    RowLayout {
                        Layout.topMargin: 20
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        spacing:15
                        Text {
                            id: title
                            // anchors.horizontalCenter: parent.horizontalCenter
                            // Layout.fillWidth: true
                            text: qsTr("Dashboard")
                            horizontalAlignment: Text.AlignLeft
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            font.weight: 700
                            font.pointSize: 20
                            color: "#121b28"
                        }
                        Item{
                            Layout.fillWidth:true
                        }

                        Button_ {
                            // Layout.alignment: Qt.AlignTop
                            // anchors.top: parent.top
                            // anchors.right: parent.right
                            Layout.topMargin:-10
                            imageSource: "image://img/bell.svg"
                            width: 30
                            height: 30
                            borderRadius: width/2
                            imageColor: "#121b28"
                            color:"white"

                            buttonText: ""
                            onClicked: {
                                toastmanager.show();
                            }
                        }
                        Button_ {
                            // Layout.alignment: Qt.AlignTop
                            // anchors.top: parent.top
                            // anchors.right: parent.right
                            Layout.topMargin:-10
                            imageSource: "http://localhost:8000/user/kyc/file/image?token="+user_info.token
                            image.height:height
                            image.width:width
                            image.cache:false
                            imageRadius:width/2
                            width: 45
                            height: 45
                            borderRadius: width/2
                            // imageColor: "#121b28"
                            color:"green"

                            buttonText: ""
                            onClicked: {
                                toastmanager.show();
                            }
                        }
                    }
                }
                GridLayout {
                    id: grid
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                    Layout.preferredWidth :parent.width
                    Layout.preferredHeight :parent.height
                    property double colMulti: grid.Layout.preferredWidth / grid.columns
                    property double rowMulti: grid.Layout.preferredHeight / grid.rows
                    function prefWidth(item){
                        return colMulti * item.Layout.columnSpan
                    }
                    function prefHeight(item){
                        return rowMulti * item.Layout.rowSpan
                    }
                    // height: 800+40
                    // columnSpacing: 10
                    columns:3
                    rows:12
                    rowSpacing: 15
                    columnSpacing:15

                    Rectangle{
                        Layout.columnSpan:2
                        Layout.rowSpan:3
                        color:"#121b28"
                        radius:10
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        // Layout.fillHeight: true
                        // Layout.fillWidth: true
                        ColumnLayout{
                            anchors.left:parent.left
                            anchors.right:parent.right
                            anchors.top:parent.top
                            anchors.bottom:bottomPanel.top
                            anchors.margins:20
                           
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth:parent.parent.width
                                textFormat: Text.RichText
                                text: "Hi , "+user_kyc_form.full_name+" !"
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 12
                                font.weight: 300
                                color: "white"
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.topMargin:20
                                Layout.alignment: Qt.AlignLeft
                                textFormat: Text.RichText
                                text: "$ "+ Number(user_acc_form.account_balance).toLocaleString(Qt.locale())+""
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 30
                                font.weight: 300
                                color: "white"
                            }
                            Item{
                                Layout.fillHeight:true
                            }
                        }
                        Rectangle{
                            id:bottomPanel
                            anchors.bottom:parent.bottom
                            anchors.left:parent.left
                            anchors.right:parent.right
                            height:60
                            radius: 10
                            color:Qt.lighter(parent.color,1.5)
                        }
                    }
                    Rectangle{
                        Layout.columnSpan:1
                        Layout.rowSpan:4
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                    }
                    Rectangle{
                        Layout.columnSpan:2
                        Layout.rowSpan:9
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                    }
                    Rectangle{
                        Layout.columnSpan:1
                        Layout.rowSpan:8
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                    }

                }



            }
        }
    }


}
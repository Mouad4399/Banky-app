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

    Component.onCompleted:{
        window.getAttr('get_acc').finished.connect(function get_acc_slot(code , json){
            window.getAttr('get_acc').finished.disconnect(get_acc_slot)
        });
        window.getAttr('get_acc').sendRequest()
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 10
        spacing: 20

        ColumnLayout {
            Layout.preferredWidth: parent.width - 60
            Layout.maximumWidth: parent.width - 60
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
                // height: 800+40
                spacing: 20



            }
        }
    }


}
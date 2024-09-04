
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
// import QtQuick.Controls.Material
import Fonts 1.0
import Components 1.0
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
            width:420
            anchors.centerIn: parent
            // anchors.horizontalCenter:parent.horizontalCenter

            spacing: 25

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
                Layout.alignment: Qt.AlignHCenter
                spacing: 25
                ColorImage{
                    Layout.alignment: Qt.AlignHCenter
                    source:'data:image/svg+xml;utf8,<svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9.15865 51.5786C6.29334 48.8112 4.00787 45.5009 2.4356 41.8408C0.863334 38.1807 0.0357472 34.2441 0.0011327 30.2607C-0.0334818 26.2773 0.725569 22.3269 2.234 18.64C3.74242 14.9531 5.97002 11.6036 8.7868 8.7868C11.6036 5.97002 14.9531 3.74242 18.64 2.234C22.3269 0.725569 26.2773 -0.0334818 30.2607 0.0011327C34.2441 0.0357472 38.1807 0.863334 41.8408 2.4356C45.5009 4.00787 48.8112 6.29334 51.5786 9.15865C57.0434 14.8167 60.0672 22.3948 59.9989 30.2607C59.9305 38.1266 56.7754 45.651 51.2132 51.2132C45.651 56.7754 38.1266 59.9305 30.2607 59.9989C22.3948 60.0672 14.8167 57.0434 9.15865 51.5786ZM47.3486 47.3486C51.852 42.8453 54.382 36.7374 54.382 30.3686C54.382 23.9999 51.852 17.892 47.3486 13.3886C42.8453 8.88527 36.7374 6.3553 30.3686 6.3553C23.9999 6.3553 17.892 8.88527 13.3886 13.3886C8.88527 17.892 6.3553 23.9999 6.3553 30.3686C6.3553 36.7374 8.88527 42.8453 13.3886 47.3486C17.892 51.852 23.9999 54.382 30.3686 54.382C36.7374 54.382 42.8453 51.852 47.3486 47.3486ZM27.3686 15.3686H33.3686V33.3686H27.3686V15.3686ZM27.3686 39.3686H33.3686V45.3686H27.3686V39.3686Z" fill="#065AD8"/></svg>'
                }
                Text {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTranslate('',"You have made Un")
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 17
                    font.weight: 600
                    color: "black"
                }
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth:parent.parent.width -40
                    text: qsTranslate('',"Veux-tu vraiment supprimer ce domaine ? Cette action supprimera toutes les informations associées, y compris les catégories, sous-catégories, produits et toutes autres données liées à ce domaine.")
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 10
                    font.weight: 600
                    color: "#787878"
                }
                
            }
            RowLayout{
                // Layout.fillWidth:true
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin:35
                spacing: 15
                Button_ {
                    // Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth:true
                    // implicitWidth: 140
                    width:Layout.preferredWidth
                    height: 45
                    buttonText: qsTranslate('',"Annuler")
                    textColor:'#065AD8'
                    fontWeight: 500
                    color:'white'
                    borderWidth:1
                    borderColor:'#065AD8'
                    onClicked: {
                        dialog.reject();
                    }
                }
                Button_ {
                    // Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth:true
                    width:Layout.preferredWidth
                    height: 45
                    buttonText: qsTranslate('',"Supprimer")
                    fontWeight: 500
                    onClicked: {
                        dialog.accept();
                    }
                }
            }
        }
    }

}
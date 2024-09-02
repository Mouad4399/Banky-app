import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import Components 1.0
import Fonts 1.0
import "./views"
Window {
    id: authmain_app
    width: 400
    height: 500
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    Rectangle {
        id: content
        anchors.fill: parent
        anchors.centerIn: parent
        color: "#F5F5F5"

        Button_ {
            id: closeWinBtn
            anchors.top: parent.top
            anchors.right: parent.right
            imageSource: "image://img/close_icon.svg"
            width: 32
            height: 32
            borderRadius: 0
            buttonText: ""
            z: Infinity
            pressColor: "red"
            color: "#121B28"

            imageSize.height: 16

            onClicked: {
                Qt.quit();
            }
        }
        Rectangle {
            anchors.top: closeWinBtn.top
            anchors.right: closeWinBtn.left
            anchors.left: parent.left
            anchors.bottom: closeWinBtn.bottom
            color: "#121B28"
            z: Infinity
            DragHandler {
                onActiveChanged: if (active) {
                    authmain_app.startSystemMove();
                }
            }
        }
        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: closeWinBtn.bottom
            anchors.bottom: parent.bottom
            spacing: 0

            ColorImage {
                // Layout.fillWidth:true
                // Layout.fillHeight:true
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 40
                Layout.bottomMargin: 40
                source: "image://img/banky_LB.svg"
                // Layout.maximumWidth:40

            }
            LoginForm{
                
            }
        }
    }
}

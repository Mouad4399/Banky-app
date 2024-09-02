import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Fonts 1.0
import Components 1.0

Rectangle {
    id: toast

    property string messageTitle: 'Error'
    property string messageBody : 'Error Body'
    default property alias data: row.data
    required property int index
    width: row.width + 15 * 2
    height: row.height + 15 * 2
    color: "#FFF6F6"
    radius: 12
    border.width: 1
    border.color: "#C14848"
    clip: true
    RowLayout {
        id: row
        spacing: 16
        anchors.centerIn: parent
        clip: true

        Rectangle{
            width:35
            height:35
            radius:width/2
            color:"#FC5758"
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            ColorImage {
                anchors.centerIn:parent
                sourceSize.width:22
                source: 'data:image/svg+xml;utf8,<svg width="8" height="8" viewBox="0 0 8 8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.84984 1.16708C5.28987 -0.389027 2.72993 -0.389027 1.16997 1.16708C-0.389991 2.72319 -0.389991 5.27681 1.16997 6.83292C2.72993 8.38903 5.24987 8.38903 6.80984 6.83292C8.3698 5.27681 8.4098 2.72319 6.84984 1.16708ZM5.12988 5.67581L4.0099 4.5586L2.88993 5.67581L2.32994 5.11721L3.44992 4L2.32994 2.88279L2.88993 2.32419L4.0099 3.4414L5.12988 2.32419L5.68986 2.88279L4.56989 4L5.68986 5.11721L5.12988 5.67581Z" fill="#699BF7"/></svg>'
                color:'white'

            }
        }
        ColumnLayout {
            // implicitWidth:100
            Text {
                id: message
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                Layout.maximumWidth: 320
                Layout.minimumWidth: 150
                font.family: Fonts.inter
                font.pointSize: 10
                text: qsTr(toast.messageTitle)
                font.weight: 700
                wrapMode: Text.WordWrap
                color: "#27303A"
            }
            Text {
                font.family: Fonts.inter
                font.pointSize: 9
                Layout.maximumWidth: 320
                Layout.minimumWidth: 150
                Layout.fillHeight: true
                wrapMode: Text.WordWrap
                font.weight: 200
                text: toast.messageBody
            }
        }
        Button_ {
            width: 24
            height: 24
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            imageSource: "image://img/close_icon.svg"
            imageSize.width:16
            imageColor:"black"
            color: Qt.rgba(0, 0, 0, 0)
            onClicked: {
                // console.log(index)
                animation.stop()
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

    opacity: 0
    SequentialAnimation on opacity {
        id: animation
        running: false

        NumberAnimation {
            to: .9
            duration: 300
        }

        PauseAnimation {
            duration: 5000
        }

        NumberAnimation {
            to: 0
            duration: 300
        }

        onRunningChanged: {
            if (!running) {
                anchors.right = undefined;
                root.model.remove(index);
            }
        }
    }

    Component.onCompleted: {
        animation.start();
    }
}

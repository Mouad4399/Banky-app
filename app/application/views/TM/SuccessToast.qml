import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Fonts 1.0
import Components 1.0

Rectangle {
    id: toast
    property string messageTitle: 'Sucess'
    property string messageBody : 'sucess Body'
    default property alias data: row.data
    required property int index
    width: row.width + 15 * 2
    height: row.height + 15 * 2
    color: "#F6FFF9"
    radius: 12
    border.width: 1
    border.color: "#48C1B5"
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
            color:"#50DC6C"
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            ColorImage {
                anchors.centerIn:parent
                sourceSize.width:20
                source: 'data:image/svg+xml;utf8,<svg width="7" height="8" viewBox="0 0 7 8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.72222 5.81818L1.16667 4.36364L1.715 3.85091L2.72222 4.78909L5.285 2.39273L5.83333 2.90909M3.5 0L0 1.45455V3.63636C0 5.65455 1.49333 7.54182 3.5 8C5.50667 7.54182 7 5.65455 7 3.63636V1.45455L3.5 0Z" fill="#699BF7"/></svg>'
                color:"white"

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
                textFormat: Text.RichText
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
                textFormat: Text.RichText
            }
        }
        Button_ {
            width: 24
            height: 24
            buttonText:''
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

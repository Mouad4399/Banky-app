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
    height: stack.depth >1 ? 530:500
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
            RowLayout{
                anchors.top:parent.top
                anchors.left:parent.left
                anchors.bottom:parent.bottom
                anchors.leftMargin:8
                spacing:10

                ColorImage{
                    Layout.alignment:Qt.AlignVCenter
                    source: "image://img/banky_logo.svg"
                    sourceSize.height:16
                }
                Text {
                    Layout.alignment:Qt.AlignVCenter
                    font.family: Fonts.inter
                    text: 'Banky'
                    color: 'white'
                    font.pointSize: 10
                    font.weight:300
                }
            }
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
            
            StackView {
                id:stack
                Layout.fillWidth:true
                Layout.fillHeight: true
                implicitHeight: currentItem.implicitHeight
                // Layout.leftMargin:20
                // Layout.rightMargin:20
                // Layout.bottomMargin:5

                initialItem:LoginForm{
                    
                }

                popEnter: Transition {
                    // slide_in_left
                    LineAnimation {
                        property: "x"
                        from: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                        to: 0
                    }
                    FadeIn {
                    }
                }

                popExit: Transition {
                    // slide_out_right
                    LineAnimation {
                        property: "x"
                        from: 0
                        to: (stack.mirrored ? -0.5 : 0.5) * stack.width
                    }
                    FadeOut {
                    }
                }

                pushEnter: Transition {
                    // slide_in_right
                    LineAnimation {
                        property: "x"
                        from: (stack.mirrored ? -0.5 : 0.5) * stack.width
                        to: 0
                    }
                    FadeIn {
                    }
                }

                pushExit: Transition {
                    // slide_out_left
                    LineAnimation {
                        property: "x"
                        from: 0
                        to: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                    }
                    FadeOut {
                    }
                }

                replaceEnter: Transition {
                    // slide_in_right
                    LineAnimation {
                        property: "x"
                        from: (stack.mirrored ? -0.5 : 0.5) * stack.width
                        to: 0
                    }
                    FadeIn {
                    }
                }

                replaceExit: Transition {
                    // slide_out_left
                    LineAnimation {
                        property: "x"
                        from: 0
                        to: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                    }
                    FadeOut {
                    }
                }
                
                component LineAnimation: NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }

                component FadeIn: LineAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                }

                component FadeOut: LineAnimation {
                    property: "opacity"
                    from: 1.0
                    to: 0.0
                }
            }
            
        }
    }
}

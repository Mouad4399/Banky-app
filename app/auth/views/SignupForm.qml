import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
// import "./../../assets/components"
import Components 1.0
import Fonts 1.0


Rectangle {
                // anchors.fill:parent
                // border.color:"red"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Component.onCompleted:{
                    window.getAttr('register').finished.connect(function (code,json) {
                                        busypopup.close();
                                        if (code === 201) {
                                            main_app.goToApp();
                                            console.log('signup successful')
                                        }else{
                                            // console.log(code)
                                            auth_error_message = json.detail;
                                            console.log(auth_error_message)
                                        }
                                        
                                    });
                }

                property var signupFormData: {
                    "username": '',
                    "email": '',
                    "password": ''
                }
                property var auth_error_message:""
                ColorImage {
                    anchors.left:parent.left
                    anchors.top:parent.top
                    anchors.leftMargin:5
                    anchors.topMargin:5
                    source: 'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 11V13H7.99997L13.5 18.5L12.08 19.92L4.15997 12L12.08 4.08L13.5 5.5L7.99997 11H20Z" fill="#699BF7"/></svg>'
                    sourceSize.width:18
                    color: 'black'
                    Rectangle {
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
                                stack.pop();
                            }
                        }
                    }
                }
                GridLayout {
                    id: grid
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    width: parent.width * 0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.left:parent.left
                    // anchors.right:parent.right
                    columns: 1
                    rows: 4
                    columnSpacing: 15
                    rowSpacing: 20

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {

                            text: qsTr("Username")
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 500
                            color: "#444444"
                        }
                        TextField_ {
                            Layout.fillWidth: true
                            placeholderText: "Enter your username"
                            onTextChanged: {
                                signupFormData.username = text;
                                auth_error_message = "";
                            }
                            Text {
                                visible: auth_error_message !==""
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.leftMargin: 3
                                anchors.topMargin: 3
                                font.family: Fonts.inter
                                text: 'ERROR : ' + auth_error_message
                                color: 'red'
                                font.pointSize: 6
                            }
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {

                            text: qsTr("E-mail Address")
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 500
                            color: "#444444"
                        }
                        TextField_ {
                            Layout.fillWidth: true
                            placeholderText: "Enter your E-mail"
                            onTextChanged: {
                                signupFormData.email = text;
                                auth_error_message = "";
                            }
                            Text {
                                visible: auth_error_message !==""
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.leftMargin: 3
                                anchors.topMargin: 3
                                font.family: Fonts.inter
                                text: 'ERROR : ' + auth_error_message
                                color: 'red'
                                font.pointSize: 6
                            }
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {

                            text: qsTr("Password")
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 500
                            color: "#444444"
                        }
                        TextField_ {
                            Layout.fillWidth: true
                            showPassIcon: true
                            onTextChanged: {
                                signupFormData.password = text;
                                auth_error_message = "";
                            }
                            onAccepted: {
                                // main_app.authentificate()
                                // console.log(window)
                                window.getAttr('register').sendRequest(signupFormData);
                                busypopup.open();

                            }
                            Text {
                                visible: auth_error_message !== ""
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.leftMargin: 3
                                anchors.topMargin: 3
                                font.family: Fonts.inter
                                text: 'ERROR : ' + auth_error_message
                                color: 'red'
                                font.pointSize: 6
                            }
                        }
                    }
                }
                
                Button_ {
                    id: connexionBtn
                    anchors.top: grid.bottom
                    anchors.topMargin: 40
                    width: grid.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonText: qsTr("Sign-up")
                    fontWeight: 300
                    color: "#121B28"
                    height: 35
                    onClicked: {
                        // main_app.authentificate()
                        // console.log(window)
                        window.getAttr('register').sendRequest(signupFormData);
                        busypopup.open();
                        window.getAttr('register').finished.connect(function (code,json) {
                                busypopup.close();
                                if (code === 201) {
                                    main_app.goToApp();
                                    console.log('signup successful')
                                }else{
                                    auth_error_message = json.detail;
                                    console.log(auth_error_message)
                                }
                                
                            });

                    }
                }

                Popup {
                    id: busypopup
                    // anchors.centerIn: Overlay.overlay
                    anchors.centerIn:parent
                    closePolicy: Popup.NoAutoClose
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

                    BusyIndicator {
                        running: true
                    }
                }
            }

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
                    window.getAttr('authenticate').finished.connect(function (code,json) {
                                        busypopup.close();
                                        if (code === 200) {
                                            main_app.goToApp();
                                            console.log('login successful')
                                        }else{
                                            // console.log(code)
                                            auth_error_message = json.detail;
                                            console.log(auth_error_message)
                                        }
                                        
                                    });
                }

                property var loginFormData: {
                    "username": '',
                    "password": ''
                }
                property var auth_error_message:""
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
                                loginFormData.username = text;
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
                                loginFormData.password = text;
                                auth_error_message = "";
                            }
                            onAccepted: {
                                // main_app.authentificate()
                                // console.log(window)
                                window.getAttr('authenticate').sendRequest(loginFormData);
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
                Text {
                    id: noAccount
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: grid.bottom
                    anchors.topMargin: 10
                    // anchors.bottomMargin:20
                    width: parent.width * 0.8
                    textFormat: Text.RichText

                    text: qsTr("
        <!DOCTYPE html>
        <html>
        <head>
        <style>
        b {
        color: #3554D1;
        text-decoration: none;
        cursor: pointer;
        }

        </style>
        </head>
        <body>
        <a href=''><b>Forgot your Passoword ?</b></a>

        </body>
        </html>


        ")
                    onLinkActivated: {
                        // stack.push("ForgotPassword.qml");
                    }

                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 8
                    font.weight: 100
                    color: "#000000"
                    MouseArea {
                        id: tesxtmouseArea
                        visible: parent.hoveredLink
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton // Don't eat the mouse clicks
                        cursorShape: Qt.PointingHandCursor
                    }
                }
                
                Button_ {
                    id: connexionBtn
                    anchors.top: grid.bottom
                    anchors.topMargin: 60
                    width: grid.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonText: qsTr("Login")
                    fontWeight: 300
                    color: "#121B28"
                    height: 35
                    onClicked: {
                        // main_app.authentificate()
                        // console.log(window)
                        window.getAttr('authenticate').sendRequest(loginFormData);
                        busypopup.open();
                        window.getAttr('authenticate').finished.connect(function (code,json) {
                                busypopup.close();
                                if (code === 200) {
                                    main_app.goToApp();
                                    console.log('login successful')
                                }else{
                                    auth_error_message = json.detail;
                                    console.log(auth_error_message)
                                }
                                
                            });

                    }
                }
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: connexionBtn.bottom
                    anchors.topMargin: 10
                    width: parent.width * 0.8
                    textFormat: Text.RichText


                    text:qsTr("
                    <!DOCTYPE html>
                    <html>
                    <head>
                    <style>
                    a:link {
                    color: #3554D1;
                    text-decoration: none;
                    cursor: pointer;
                    }

                    </style>
                    </head>
                    <body style='color:#666'>
                    Don't have an account yet ?<a href='http://#'><b> Sign up</b></a>

                    </body>
                    </html>


                    ")
                    onLinkActivated:{
                        // console.log('helo')
                        stack.push('./SignupForm.qml')
                    }
                    horizontalAlignment:Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 8
                    font.weight: 100
                    color:"white"
                    HoverHandler {
                        enabled: parent.hoveredLink
                        cursorShape: Qt.PointingHandCursor
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

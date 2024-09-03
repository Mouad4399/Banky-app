import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebSockets
import Fonts 1.0
import Components 1.0

import './views/TM'

ApplicationWindow {
    id: mainWindow
    minimumWidth: 1200
    minimumHeight:600
    maximumWidth: 1200
    maximumHeight:600
    visible: true
    onClosing:{
        Qt.quit()
    }

    color: "#121B28"
    title: "Banky"



    Component.onCompleted:{
        // if your repeate this it will do the multiple connect function at the same time
        window.getAttr('logout').finished.connect(function (code,json) {
                                busypopup.close();
                                if (code === 200) {
                                    main_app.goToAuth();
                                    console.log('logout successful')
                                }else{
                                    toastmanager.show(false , "Authentication Error",json.detail+" : \nOr You are not Authorized to do this Action !")
                                    var auth_error_message = json.detail;
                                    console.log(auth_error_message)
                                }
                                
                            });
    }
    Rectangle {
        id: leftnavBar
        anchors.left: parent.left
        anchors.top: parent.top
        width: 900/4.5
        // width:58
        height: parent.height
        color: "#121B28"
        z:Infinity

        ColumnLayout {
            anchors {
                right: parent.right
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                rightMargin: 15
                leftMargin: 15
                topMargin: 25
                bottomMargin: 25
            }
            clip:true
            spacing: 8
            // Rectangle {
            //     width: logo.width
            //     height: logo.height + 25
                Image {
                    id: logo
                    // Layout.leftMargin:-9
                    sourceSize.width: 100+ (parent.width/180)*20
                    source: "image://img/banky_DB.svg"
                    Layout.alignment:Qt.AlignHCenter
                    Layout.bottomMargin:30
                    
                }

                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M2.52 7.823C2 8.77 2 9.915 2 12.203V13.725C2 17.625 2 19.576 3.172 20.788C4.344 22 6.229 22 10 22H14C17.771 22 19.657 22 20.828 20.788C21.999 19.576 22 17.626 22 13.725V12.204C22 9.915 22 8.771 21.48 7.823C20.962 6.874 20.013 6.286 18.116 5.108L16.116 3.867C14.111 2.622 13.108 2 12 2C10.892 2 9.89 2.622 7.884 3.867L5.884 5.108C3.987 6.286 3.039 6.874 2.52 7.823ZM11.25 18C11.25 18.1989 11.329 18.3897 11.4697 18.5303C11.6103 18.671 11.8011 18.75 12 18.75C12.1989 18.75 12.3897 18.671 12.5303 18.5303C12.671 18.3897 12.75 18.1989 12.75 18V15C12.75 14.8011 12.671 14.6103 12.5303 14.4697C12.3897 14.329 12.1989 14.25 12 14.25C11.8011 14.25 11.6103 14.329 11.4697 14.4697C11.329 14.6103 11.25 14.8011 11.25 15V18Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Dashboard'
                    checked:true
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }

                }




                
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="26" height="20" viewBox="0 0 26 20" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_21_65)"><path d="M21.7344 1.6016C21.3525 1.23441 21.3525 0.640657 21.7344 0.277376C22.1162 -0.085905 22.7338 -0.0898113 23.1116 0.277376L25.7116 2.77738C25.8944 2.95316 25.9959 3.19144 25.9959 3.44144C25.9959 3.69144 25.8944 3.92972 25.7116 4.1055L23.1116 6.6055C22.7297 6.97269 22.1122 6.97269 21.7344 6.6055C21.3566 6.23831 21.3525 5.64456 21.7344 5.28128L22.6687 4.38284L15.6 4.37503C15.0597 4.37503 14.625 3.95706 14.625 3.43753C14.625 2.918 15.0597 2.50003 15.6 2.50003H22.6728L21.7344 1.6016ZM4.26562 14.7266L3.33125 15.625H10.4C10.9403 15.625 11.375 16.043 11.375 16.5625C11.375 17.0821 10.9403 17.5 10.4 17.5H3.32719L4.26156 18.3985C4.64344 18.7657 4.64344 19.3594 4.26156 19.7227C3.87969 20.086 3.26219 20.0899 2.88437 19.7227L0.284375 17.2266C0.101562 17.0508 0 16.8125 0 16.5625C0 16.3125 0.101562 16.0743 0.284375 15.8985L2.88437 13.3985C3.26625 13.0313 3.88375 13.0313 4.26156 13.3985C4.63937 13.7657 4.64344 14.3594 4.26156 14.7227L4.26562 14.7266ZM3.9 2.50003H13.7272C13.5769 2.78128 13.4875 3.09769 13.4875 3.43753C13.4875 4.55863 14.4341 5.46878 15.6 5.46878H20.3694C20.2069 6.13285 20.3937 6.8555 20.93 7.37503C21.7547 8.168 23.0912 8.168 23.9159 7.37503L24.7 6.62113V15C24.7 16.3789 23.5341 17.5 22.1 17.5H12.2728C12.4231 17.2188 12.5125 16.9024 12.5125 16.5625C12.5125 15.4414 11.5659 14.5313 10.4 14.5313H5.63063C5.79313 13.8672 5.60625 13.1446 5.07 12.625C4.24531 11.8321 2.90875 11.8321 2.08406 12.625L1.3 13.3789V5.00003C1.3 3.62113 2.46594 2.50003 3.9 2.50003ZM6.5 5.00003H3.9V7.50003C5.33406 7.50003 6.5 6.37894 6.5 5.00003ZM22.1 12.5C20.6659 12.5 19.5 13.6211 19.5 15H22.1V12.5ZM13 13.75C14.0343 13.75 15.0263 13.3549 15.7577 12.6517C16.4891 11.9484 16.9 10.9946 16.9 10C16.9 9.00547 16.4891 8.05164 15.7577 7.34838C15.0263 6.64512 14.0343 6.25003 13 6.25003C11.9657 6.25003 10.9737 6.64512 10.2423 7.34838C9.51089 8.05164 9.1 9.00547 9.1 10C9.1 10.9946 9.51089 11.9484 10.2423 12.6517C10.9737 13.3549 11.9657 13.75 13 13.75Z" fill="#B0B4B8"/></g><defs><clipPath id="clip0_21_65"><rect width="26" height="20" fill="white"/></clipPath></defs></svg>'
                    imageSize.height:height/2
                    buttonText:'Transaction'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }

                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5 4C4.20435 4 3.44129 4.31607 2.87868 4.87868C2.31607 5.44129 2 6.20435 2 7V8H22V7C22 6.20435 21.6839 5.44129 21.1213 4.87868C20.5587 4.31607 19.7956 4 19 4H5ZM22 10H2V17C2 17.7956 2.31607 18.5587 2.87868 19.1213C3.44129 19.6839 4.20435 20 5 20H19C19.7956 20 20.5587 19.6839 21.1213 19.1213C21.6839 18.5587 22 17.7956 22 17V10ZM8 15C8 14.7348 8.10536 14.4804 8.29289 14.2929C8.48043 14.1054 8.73478 14 9 14H13.414L13.293 13.879C13.1054 13.6915 12.9999 13.4371 12.9998 13.1719C12.9997 12.9066 13.105 12.6521 13.2925 12.4645C13.48 12.2769 13.7344 12.1714 13.9996 12.1713C14.2649 12.1712 14.5194 12.2765 14.707 12.464L16.535 14.293C16.7225 14.4805 16.8278 14.7348 16.8278 15C16.8278 15.2652 16.7225 15.5195 16.535 15.707L14.707 17.535C14.6148 17.6305 14.5044 17.7067 14.3824 17.7591C14.2604 17.8115 14.1292 17.8391 13.9964 17.8403C13.8636 17.8414 13.7319 17.8161 13.609 17.7658C13.4861 17.7155 13.3745 17.6413 13.2806 17.5474C13.1867 17.4535 13.1125 17.3419 13.0622 17.219C13.0119 17.0961 12.9866 16.9644 12.9877 16.8316C12.9889 16.6988 13.0165 16.5676 13.0689 16.4456C13.1213 16.3236 13.1975 16.2132 13.293 16.121L13.414 16H9C8.73478 16 8.48043 15.8946 8.29289 15.7071C8.10536 15.5196 8 15.2652 8 15Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Payment'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }

                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_23_85)"><path d="M14.7625 -0.000161572C14.5855 0.00691535 14.4148 0.0387615 14.237 0.0829923L2.21154 3.01284C0.789076 3.36138 -0.100847 4.79622 0.248577 6.21957L1.93465 13.1036C2.03683 13.5137 2.23576 13.8933 2.5148 14.2107C2.79384 14.528 3.14486 14.7739 3.53846 14.9277V13.2691C3.53846 10.8302 5.52265 8.84599 7.96154 8.84599H19.1024L17.4437 2.01765C17.297 1.42409 16.9501 0.899271 16.4615 0.531697C15.9729 0.164124 15.3734 -0.023721 14.7625 -0.000161572ZM15.8399 3.81518L16.5591 6.82818L13.5735 7.54649L12.8269 4.56092L15.8399 3.81518ZM7.96154 10.6152C6.49662 10.6152 5.30769 11.8041 5.30769 13.2691V20.346C5.30769 21.8109 6.49662 22.9998 7.96154 22.9998H20.3462C21.8111 22.9998 23 21.8109 23 20.346V13.2691C23 11.8041 21.8111 10.6152 20.3462 10.6152H7.96154ZM7.96154 12.0253H20.3462C21.0282 12.0253 21.5899 12.587 21.5899 13.2691V14.1537H6.71777V13.2691C6.71777 12.587 7.2795 12.0253 7.96154 12.0253ZM6.71777 16.8075H21.5899V20.346C21.5899 21.028 21.0282 21.5898 20.3462 21.5898H7.96154C7.63224 21.5879 7.31696 21.4563 7.08411 21.2234C6.85126 20.9906 6.71963 20.6753 6.71777 20.346V16.8075Z" fill="#B0B4B8"/></g><defs><clipPath id="clip0_23_85"><rect width="23" height="23" fill="white"/></clipPath></defs></svg>'
                    imageSize.height:height/2
                    buttonText:'Card'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }

                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 13.75C20 13.5511 19.921 13.3603 19.7803 13.2197C19.6397 13.079 19.4489 13 19.25 13H16.25C16.0511 13 15.8603 13.079 15.7197 13.2197C15.579 13.3603 15.5 13.5511 15.5 13.75V20.5H14V4.25C14 3.522 13.998 3.05 13.952 2.704C13.908 2.379 13.837 2.277 13.78 2.22C13.723 2.163 13.621 2.092 13.296 2.048C12.949 2.002 12.478 2 11.75 2C11.022 2 10.55 2.002 10.204 2.048C9.879 2.092 9.777 2.163 9.72 2.22C9.663 2.277 9.592 2.379 9.548 2.704C9.502 3.051 9.5 3.522 9.5 4.25V20.5H8V8.75C8 8.55109 7.92098 8.36032 7.78033 8.21967C7.63968 8.07902 7.44891 8 7.25 8H4.25C4.05109 8 3.86032 8.07902 3.71967 8.21967C3.57902 8.36032 3.5 8.55109 3.5 8.75V20.5H1.75C1.55109 20.5 1.36032 20.579 1.21967 20.7197C1.07902 20.8603 1 21.0511 1 21.25C1 21.4489 1.07902 21.6397 1.21967 21.7803C1.36032 21.921 1.55109 22 1.75 22H21.75C21.9489 22 22.1397 21.921 22.2803 21.7803C22.421 21.6397 22.5 21.4489 22.5 21.25C22.5 21.0511 22.421 20.8603 22.2803 20.7197C22.1397 20.579 21.9489 20.5 21.75 20.5H20V13.75Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Insights'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }

                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M9.024 2.783C9.07336 2.56094 9.19696 2.36234 9.3744 2.21999C9.55184 2.07764 9.77252 2.00004 10 2H14C14.2275 2.00004 14.4482 2.07764 14.6256 2.21999C14.803 2.36234 14.9266 2.56094 14.976 2.783L15.416 4.764C15.816 4.954 16.196 5.174 16.556 5.424L18.494 4.814C18.711 4.74577 18.9448 4.75356 19.1568 4.8361C19.3688 4.91864 19.5463 5.07099 19.66 5.268L21.66 8.732C21.7738 8.92904 21.817 9.159 21.7824 9.3839C21.7479 9.6088 21.6377 9.81519 21.47 9.969L19.973 11.342C20.0091 11.7799 20.0091 12.2201 19.973 12.658L21.47 14.031C21.6377 14.1848 21.7479 14.3912 21.7824 14.6161C21.817 14.841 21.7738 15.071 21.66 15.268L19.66 18.732C19.5463 18.929 19.3688 19.0814 19.1568 19.1639C18.9448 19.2464 18.711 19.2542 18.494 19.186L16.557 18.576C16.197 18.826 15.817 19.046 15.417 19.236L14.977 21.216C14.9278 21.4384 14.8041 21.6374 14.6265 21.7799C14.4488 21.9225 14.2278 22.0001 14 22H10C9.77252 22 9.55184 21.9224 9.3744 21.78C9.19696 21.6377 9.07336 21.4391 9.024 21.217L8.584 19.236C8.184 19.046 7.804 18.826 7.444 18.576L5.506 19.186C5.28899 19.2542 5.0552 19.2464 4.84322 19.1639C4.63124 19.0814 4.45373 18.929 4.34 18.732L2.34 15.268C2.22621 15.071 2.18303 14.841 2.21757 14.6161C2.25211 14.3912 2.36232 14.1848 2.53 14.031L4.027 12.658C3.99086 12.2201 3.99086 11.7799 4.027 11.342L2.53 9.97C2.36232 9.81619 2.25211 9.6098 2.21757 9.3849C2.18303 9.16 2.22621 8.93004 2.34 8.733L4.34 5.269C4.45373 5.07199 4.63124 4.91964 4.84322 4.8371C5.0552 4.75456 5.28899 4.74677 5.506 4.815L7.443 5.425C7.803 5.175 8.183 4.955 8.583 4.765L9.023 2.785L9.024 2.783ZM12 15C12.7956 15 13.5587 14.6839 14.1213 14.1213C14.6839 13.5587 15 12.7956 15 12C15 11.2044 14.6839 10.4413 14.1213 9.87868C13.5587 9.31607 12.7956 9 12 9C11.2044 9 10.4413 9.31607 9.87868 9.87868C9.31607 10.4413 9 11.2044 9 12C9 12.7956 9.31607 13.5587 9.87868 14.1213C10.4413 14.6839 11.2044 15 12 15Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Settings'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                    }
                }
                Item{
                    Layout.fillHeight:true
                    Layout.fillWidth:true
                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.477 2 12C2 17.523 6.477 22 12 22C17.523 22 22 17.523 22 12C22 6.477 17.523 2 12 2ZM8.5 9.5C8.5 9.04037 8.59053 8.58525 8.76642 8.16061C8.94231 7.73597 9.20012 7.35013 9.52513 7.02513C9.85013 6.70012 10.236 6.44231 10.6606 6.26642C11.0852 6.09053 11.5404 6 12 6C12.4596 6 12.9148 6.09053 13.3394 6.26642C13.764 6.44231 14.1499 6.70012 14.4749 7.02513C14.7999 7.35013 15.0577 7.73597 15.2336 8.16061C15.4095 8.58525 15.5 9.04037 15.5 9.5C15.5 10.4283 15.1313 11.3185 14.4749 11.9749C13.8185 12.6313 12.9283 13 12 13C11.0717 13 10.1815 12.6313 9.52513 11.9749C8.86875 11.3185 8.5 10.4283 8.5 9.5ZM18.258 16.984C17.5092 17.9253 16.5575 18.6855 15.4739 19.2077C14.3904 19.7299 13.2029 20.0008 12 20C10.7971 20.0008 9.60965 19.7299 8.52607 19.2077C7.44249 18.6855 6.49081 17.9253 5.742 16.984C7.363 15.821 9.575 15 12 15C14.425 15 16.637 15.821 18.258 16.984Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Account'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true
                        if (stack.currentItem.objectName!=buttonText){
                            stack.replace('./views/'+buttonText+'.qml')
                        }
                        
                    }

                }
                RowButton_{
                    hoverColor:Qt.lighter("#121B28", 1.5)
                    pressColor:"#121b28"
                    Layout.alignment:Qt.AlignCenter
                    Layout.fillWidth:true
                    Layout.preferredHeight:40
                    imageSource:'data:image/svg+xml;utf8,<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M6 2C5.20435 2 4.44129 2.31607 3.87868 2.87868C3.31607 3.44129 3 4.20435 3 5V19C3 19.7956 3.31607 20.5587 3.87868 21.1213C4.44129 21.6839 5.20435 22 6 22H12C12.7956 22 13.5587 21.6839 14.1213 21.1213C14.6839 20.5587 15 19.7956 15 19V5C15 4.20435 14.6839 3.44129 14.1213 2.87868C13.5587 2.31607 12.7956 2 12 2H6ZM16.293 7.293C16.4805 7.10553 16.7348 7.00021 17 7.00021C17.2652 7.00021 17.5195 7.10553 17.707 7.293L21.707 11.293C21.8945 11.4805 21.9998 11.7348 21.9998 12C21.9998 12.2652 21.8945 12.5195 21.707 12.707L17.707 16.707C17.5184 16.8892 17.2658 16.99 17.0036 16.9877C16.7414 16.9854 16.4906 16.8802 16.3052 16.6948C16.1198 16.5094 16.0146 16.2586 16.0123 15.9964C16.01 15.7342 16.1108 15.4816 16.293 15.293L18.586 13H10C9.73478 13 9.48043 12.8946 9.29289 12.7071C9.10536 12.5196 9 12.2652 9 12C9 11.7348 9.10536 11.4804 9.29289 11.2929C9.48043 11.1054 9.73478 11 10 11H18.586L16.293 8.707C16.1055 8.51947 16.0002 8.26516 16.0002 8C16.0002 7.73484 16.1055 7.48053 16.293 7.293Z" fill="#B0B4B8"/></svg>'
                    imageSize.height:height/2
                    buttonText:'Logout'
                    fontSize:11
                    checkable:true
                    autoExclusive: true
                    imageColor:checked? "#121b28":"#a4a8ad"
                    textColor:checked? "#121b28":"#a4a8ad"
                    color:checked?"white":"#121b28"
                    content.anchors.centerIn:undefined
                    content.anchors.left:content.parent.left
                    content.anchors.leftMargin:10
                    content.anchors.verticalCenter:content.parent.verticalCenter
                    content.spacing: 15
                    onClicked:{
                        checked=true

                        window.getAttr('logout').sendRequest();
                        busypopup.open();
                        
                    }

                }


        }
    }
    Rectangle {
        anchors.left: leftnavBar.right
        anchors.right: parent.right
        height: parent.height
        color: "white"
        clip: true

        StackView {
            id: stack
            anchors.fill: parent
            clip: true
            initialItem: "./views/Dashboard.qml"
            ToastManager {
                id: toastmanager
            }
            popEnter: Transition {
                // slide_in_left
                // LineAnimation {
                //     property: "x"
                //     from: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                //     to: 0
                // }
                FadeIn {
                }
            }

            popExit: Transition {
                // slide_out_right
                // LineAnimation {
                //     property: "x"
                //     from: 0
                //     to: (stack.mirrored ? -0.5 : 0.5) * stack.width
                // }
                FadeOut {
                }
            }

            pushEnter: Transition {
                // slide_in_right
                // LineAnimation {
                //     property: "x"
                //     from: (stack.mirrored ? -0.5 : 0.5) * stack.width
                //     to: 0
                // }
                FadeIn {
                }
            }

            pushExit: Transition {
                // slide_out_left
                // LineAnimation {
                //     property: "x"
                //     from: 0
                //     to: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                // }
                FadeOut {
                }
            }

            replaceEnter: Transition {
                // slide_in_right
                // LineAnimation {
                //     property: "x"
                //     from: (stack.mirrored ? -0.5 : 0.5) * stack.width
                //     to: 0
                // }
                FadeIn {
                }
            }

            replaceExit: Transition {
                // slide_out_left
                // LineAnimation {
                //     property: "x"
                //     from: 0
                //     to: (stack.mirrored ? -0.5 : 0.5) * -stack.width
                // }
                FadeOut {
                }
            }
        }
        // ToastManager {
        //     id: toastmanager
        // }
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

    Popup {
        id: busypopup
        // anchors.centerIn: Overlay.overlay
        anchors.centerIn:parent
        closePolicy: Popup.NoAutoClose
        modal: true

        BusyIndicator {
            running: true
        }
    }
}

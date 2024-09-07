import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0


Rectangle{
    id:root
    width:parent===null ? width:parent.width
    height:parent===null ? height:parent.height
    objectName:"Account"
    color:"#eff1fc"

    function isReadyToLeave(){
        
        return Object.keys(updated_kyc).length ===1
    
    }

    property Dialog notReadyToLeavePopup:dialog

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
                width:460
                anchors.centerIn: parent
                // anchors.horizontalCenter:parent.horizontalCenter

                spacing: 15

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
                    Layout.alignment: Qt.AlignLeft
                    spacing: 25
                    Text {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        text: qsTranslate('',"Discard Changes ?")
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 17
                        font.weight: 900
                        color: "black"
                    }
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        Layout.maximumWidth:parent.parent.width -40
                        text: qsTranslate('',"You are about to leave without saving changes to your KYC information , do you want to Discard them ? ")
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: Fonts.inter
                        font.pointSize: 11
                        font.weight: 600
                        color: "#787878"
                    }
                    
                }
                RowLayout{
                    // Layout.fillWidth:true
                    Layout.alignment: Qt.AlignRight
                    Layout.topMargin:15
                    spacing: 15
                    Item{
                        Layout.fillWidth:true
                    }
                    Button_ {
                        // Layout.alignment: Qt.AlignCenter
                        // Layout.fillWidth:true
                        // implicitWidth: 140
                        width:innerText.width + 16*2
                        height:35
                        // width:Layout.preferredWidth
                        // height: 45
                        buttonText: qsTranslate('',"Stay In")
                        textColor:'#121B28'
                        fontWeight: 700
                        fontSize:11
                        color:'white'
                        borderWidth:1
                        borderColor:'#121B28'
                        onClicked: {
                            dialog.reject();
                        }
                    }
                    Button_ {
                        // Layout.alignment: Qt.AlignCenter
                        // Layout.fillWidth:true
                        // width:Layout.preferredWidth
                        // height: 45
                        width:innerText.width + 16*2
                        height:35
                        buttonText: qsTranslate('',"Discard and Leave")
                        fontSize:11
                        fontWeight: 700
                        color:"#d32f2f"
                        onClicked: {
                            dialog.accept();
                        }
                    }
                }
            }
        }

    }

    property variant user_kyc_form:{'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
    property variant user_acc_form:{'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}

    property variant updated_kyc:{'dummyKey':''}

    function get_kyc_slot(code,json) {
        busypopup.close()
        if (code === 200) {
            // main_app.goToApp();
            // console.log('login successful')
            // toastmanager.show(true,"Receive KYC Data :" , "Your Data have been received successfuly !")
        }else if (code=== 404 && json.detail !==undefined){
            // user_kyc_form ={'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
            toastmanager.show(false,"Receive KYC Data :" , "Your havn't set up your KYC information !")
        }else{
            // console.log(code)
            var auth_error_message = json.detail;
            console.log(auth_error_message)
            toastmanager.show(false,"Receive KYC Data :" , "There was an Error While getting your KYC data !")
        }

        user_kyc_form=user_kyc_info
        window.getAttr('get_kyc').finished.disconnect(get_kyc_slot)
        
    }
    function update_kyc_slot(code,json) {
        busypopup.close()
        if (code === 201) {
            // main_app.goToApp();
            // console.log('login successful')
            toastmanager.show(true,"Update KYC Data :" , "Your Data have been updated successfuly !")
        }else{
            // console.log(code)
            var auth_error_message = json.detail;
            console.log(auth_error_message)
            toastmanager.show(false,"Update KYC Data :" , "There was an Error While updating your KYC data !")
        }

        
        // reset updated_kyc
        updated_kyc={'dummyKey':''};
        window.getAttr('update_kyc').finished.disconnect(update_kyc_slot)
        stack.replace("./Account.qml");
        
    }
    function get_acc_slot(code , json){
        user_acc_form=user_acc_info
        window.getAttr('get_acc').finished.disconnect(get_acc_slot)
    }
    Component.onCompleted:{
        busypopup.open()
        window.getAttr('get_acc').finished.connect(get_acc_slot);
        window.getAttr('get_acc').sendRequest()

        window.getAttr('get_kyc').finished.connect(get_kyc_slot);
        window.getAttr('get_kyc').sendRequest()

        // one you write the Update_KYC and set up everything
        window.getAttr('update_kyc').finished.connect(update_kyc_slot);


        
        
    }

    Rectangle{
        width:parent.width
        height:190
        color:Qt.darker("#121b28",1.3)
    }


    RowLayout{
        anchors.fill: parent
        anchors.margins:15
        spacing:15

        Rectangle{
            // id:user_profile_card
            // Layout.preferredWidth:250
            // Layout.preferredHeight:400
            // Layout.alignment:Qt.AlignVCenter
            Layout.alignment:Qt.AlignTop
            Layout.topMargin:40
            width:250
            height:400
            // color:'red'
            radius:10

            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 16
                color: "#100B2714"
                z: -1
            }
            ColumnLayout{
                anchors.fill:parent
                anchors.margins:15
                spacing:10

                RImage_ {
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    source: 'http://localhost:8000/user/kyc/file/image?token='+user_info.token
                    Layout.preferredWidth:parent.width * 45/100
                    Layout.preferredHeight:width
                    radius:width/2
                }
                Text {
                    text: user_kyc_form.full_name
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 11
                    font.weight: 900
                    color: "#121b28"
                }
                Text {
                    text: user_acc_form.account_status
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.family: Fonts.inter
                    font.pointSize: 10
                    font.weight: 400
                    color: "#6EC531"
                }
                Rectangle{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredHeight:1
                    color:'#AEAFB3'
                }
                GridLayout {
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                    columns: 1
                    columnSpacing: 0
                    rowSpacing: 10
                    Item{
                        Layout.fillHeight:true
                    }

                    RowLayout{
                        Layout.fillWidth:true
                        Layout.alignment:Qt.AlignTop
                        spacing:0
                        Text {
                            text: "Account ID:"
                            Layout.alignment:Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#121b28"
                        }
                        Text {
                            text: user_acc_form.account_id
                            Layout.fillWidth:true
                            Layout.alignment:Qt.AlignRight
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#AEAFB3"
                        }
                    }
                    RowLayout{
                        Layout.fillWidth:true
                        Layout.alignment:Qt.AlignTop
                        spacing:0
                        Text {
                            text: "PIN :"
                            Layout.alignment:Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#121b28"
                        }
                        Text {
                            text: user_acc_form.pin_number
                            Layout.fillWidth:true
                            Layout.alignment:Qt.AlignRight
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#AEAFB3"
                        }
                    }
                    RowLayout{
                        Layout.fillWidth:true
                        Layout.alignment:Qt.AlignTop
                        spacing:0
                        Text {
                            text: "Date joined :"
                            Layout.alignment:Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#121b28"
                        }
                        Text {
                            text: Qt.formatDateTime(new Date(user_acc_form.date),"yyyy-MM-dd")
                            Layout.fillWidth:true
                            Layout.alignment:Qt.AlignRight
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 9
                            font.weight: 400
                            color: "#AEAFB3"
                        }
                    }
                    Item{
                        Layout.fillHeight:true
                    }

                }

                Button_{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    height:40
                    buttonText:"Logout"
                    fontSize:10
                    textColor:state!==''?"white":hoverColor
                    color:"#eff1fc"
                    hoverColor:"#121b28"
                    pressColor:hoverColor
                    borderColor:"#999"
                    borderWidth:state!==''?0:1
                    borderRadius:15
                }
                Button_{
                    Layout.fillWidth:true
                    Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                    height:40
                    buttonText:"Delete Account"
                    fontSize:10
                    textColor:state!==''?"white":hoverColor
                    color:"white"
                    hoverColor:"#FC5758"
                    pressColor:hoverColor
                    borderColor:hoverColor
                    borderWidth:1
                    borderRadius:15
                }

                // Item{
                //     Layout.fillHeight:true
                // }
            }

        }
        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: membersContent.height + 20

            ScrollBar_.vertical: ScrollBar_ {
                parent: scrollView
                x: scrollView.width
                y: scrollView.topPadding
                height: scrollView.availableHeight
            }

            Rectangle{
                id: membersContent
                default property alias data:kyc_detail
                width: scrollView.width-10
                height: kyc_detail.height+15*2
                color:"white"
                radius:10
                ColumnLayout{
                    id:kyc_detail
                    // anchors.fill:parent
                    // anchors.margins:15
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.left:parent.left
                    anchors.leftMargin:15
                    anchors.right:parent.right
                    anchors.rightMargin:15
                    spacing:15
                    Rectangle{
                        height:100
                        Layout.fillWidth:true
                        color:"#eff1fc"
                        radius:9
                        RowLayout{
                            anchors.fill:parent
                            anchors.leftMargin:15
                            anchors.rightMargin:15

                            RowLayout{
                                spacing:20
                                ColorImage {
                                    id: user_image_edit
                                    Layout.alignment:Qt.AlignTop
                                    source: 'http://localhost:8000/user/kyc/file/image?token='+user_info.token
                                    Layout.preferredWidth:70
                                    Layout.preferredHeight:width
                                    layer.enabled:true
                                    layer.effect:OpacityMask {
                                        maskSource: Rectangle {
                                            width: user_image_edit.width
                                            height: user_image_edit.height
                                            radius: width/2
                                            // visible: false // this also needs to be invisible or it will cover up the image
                                        }
                                    }
                                }
                                ColumnLayout{
                                    Layout.alignment:Qt.AlignCenter
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: user_kyc_form.full_name
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "black"
                                    }
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: user_info.email
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "#2381DF"
                                    }
                                    
                                }
                            }
                            Item{
                                Layout.fillWidth:true
                            }
                            Button_{
                                width:innerText.width + 48*2
                                height:35
                                buttonText:qsTranslate("","Upload new profile picture")
                                color: "#065AD8"
                                borderColor: "#065AD8" 
                                textColor: "white"
                                fontWeight:600
                                fontSize:10
                                borderWidth:1
                                onClicked:{
                                    fileOpen.field_name='image'
                                    fileOpen.open()
                                }
                            }
                        }
                    }
                    GridLayout {
                        // Layout.preferredWidth: parent.width
                        // Layout.maximumWidth: parent.width 
                        Layout.fillWidth:true
                        Layout.fillHeight:true
                        // Layout.alignment: Qt.AlignHCenter
                        // anchors.fill:parent
                        // anchors.margins:15
                        rowSpacing: 15
                        columnSpacing: 10
                        columns: 2

                        Repeater{
                            model:['full_name','country','city']
                            delegate:TextField_ {
                                Layout.column:0
                                Layout.row:2*index +1
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                // implicitHeight: 45
                                text:user_kyc_form[modelData]
                                placeholder: ""
                                bgRadius: 8
                                onTextEdited:{
                                    if(text=== user_kyc_form[modelData]){
                                        delete updated_kyc[modelData];
                                        return
                                    }else{
                                        updated_kyc[modelData]=text
                                    }
                                }
                            }
                        }
                        Repeater{
                            model:['mobile','state','fax']
                            delegate:TextField_ {
                                Layout.column:1
                                Layout.row:2*index +1
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                // implicitHeight: 45
                                text:user_kyc_form[modelData]
                                placeholder: ""
                                bgRadius: 8
                                onTextEdited:{
                                    if(text=== user_kyc_form[modelData]){
                                        delete updated_kyc[modelData];
                                        return
                                    }else{
                                        updated_kyc[modelData]=text
                                    }
                                }
                            }
                        }
                        Repeater{
                            model:['Full Name','Country','City']
                            delegate:Text {
                                Layout.column:0
                                Layout.row:2*index
                                text: modelData
                                horizontalAlignment: Text.AlignLeft
                                font.family: Fonts.inter
                                wrapMode: Text.WordWrap
                                font.weight: 600
                                font.pointSize: 10
                                color: "#444444"
                            }
                        }
                        Repeater{
                            model:['Mobile Number','State','Fax']
                            delegate:Text {
                                Layout.column:1
                                Layout.row:2*index
                                text: modelData
                                horizontalAlignment: Text.AlignLeft
                                font.family: Fonts.inter
                                wrapMode: Text.WordWrap
                                font.weight: 600
                                font.pointSize: 10
                                color: "#444444"
                            }
                        }
                        Text {
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*3
                            text: 'Date Of Birth'
                            horizontalAlignment: Text.AlignLeft
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            font.weight: 600
                            font.pointSize: 10
                            color: "#444444"
                        }
                        TextField_ {
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*3 +1
                            Layout.fillWidth: true
                            // Layout.fillHeight: true
                            // implicitHeight: 45
                            text: Qt.formatDateTime(new Date(user_kyc_form.date_of_birth),"yyyy-MM-dd")
                            placeholder:"yyyy-MM-dd"
                            bgRadius: 8
                            onTextEdited:{
                                if(text=== Qt.formatDateTime(new Date(user_kyc_form.date_of_birth),"yyyy-MM-dd")){
                                        delete updated_kyc.date_of_birth;
                                        return
                                    }else{
                                        updated_kyc.date_of_birth=text
                                    }
                            }
                        }
                        GridLayout{
                            Layout.columnSpan:2
                            Layout.column:0
                            Layout.row:2*4 
                            Layout.fillWidth: true
                            columns:3
                            Text {
                                text: qsTr("Gender")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }
                            Text {
                                text: qsTr("Marrtuale Status")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }
                            Text {
                                text: qsTr("Identity Type")
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                font.family: Fonts.inter
                                font.pointSize: 10
                                font.weight: 600
                                color: "#444"
                            }

                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','Male', 'Female','Not expose']
                                property var choices:{'':0 , 'male':1,'female':2,'other':3}
                                property var indexchoices:['' , 'male','female','other']
                                currentIndex:choices[user_kyc_form.gender]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    var text=indexchoices[index]

                                    if(text=== user_kyc_form.gender){
                                        delete updated_kyc['gender'];
                                        return
                                    }else{
                                        updated_kyc['gender']=text
                                    }
                                }
                            }
                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','Single', 'Married','Not expose']
                                property var choices:{'':0 , 'single':1,'married':2,'other':3}
                                property var indexchoices:['' , 'single','married','other']
                                currentIndex:choices[user_kyc_form.marrital_status]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    var text=indexchoices[index]

                                    if(text=== user_kyc_form.marrital_status){
                                        delete updated_kyc['marrital_status'];
                                        return
                                    }else{
                                        updated_kyc['marrital_status']=text
                                    }
                                }
                            }
                            ComboBox_ {
                                Layout.fillWidth: true
                                implicitHeight: 45
                                borderWidth:1
                                bgRadius:8
                                placeholderText:""
                                model: ['----','National ID Card', 'Drives Licence','International Passport']
                                property var choices:{'':0 , 'national_id_card':1,'drivers_licnece':2,'international_passport':3}
                                property var indexchoices:['' , 'national_id_card','drivers_licnece','international_passport']
                                currentIndex:choices[user_kyc_form.identity_type]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    var text=indexchoices[index]
                                    console.log(text)

                                    if(text=== user_kyc_form.identity_type){
                                        delete updated_kyc['identity_type'];
                                        return
                                    }else{
                                        updated_kyc['identity_type']=text
                                    }
                                }
                            }
                        }

                        Item{
                            Layout.columnSpan:2
                            Layout.fillHeight:true
                        }

                    }
                    RowLayout{
                        Layout.fillWidth:true
                        Layout.preferredHeight:250
                        spacing:15

                        Rectangle{
                            Layout.fillWidth:true
                            Layout.fillHeight:true
                            color:"#eff1fc"
                            radius:9
                            ColumnLayout{
                                anchors.fill:parent
                                anchors.margins:10
                                spacing:10
                                ColorImage {
                                    id: identity_image
                                    // Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                                    source: 'http://localhost:8000/user/kyc/file/identity_image?token='+user_info.token
                                    Layout.fillWidth:true
                                    Layout.fillHeight:true
                                    // Layout.preferredWidth:parent.width * 45/100
                                    // Layout.preferredHeight:width
                                    layer.enabled:true
                                    layer.effect:OpacityMask {
                                        maskSource: Rectangle {
                                            width: identity_image.width
                                            height: identity_image.height
                                            radius: 8
                                            // visible: false // this also needs to be invisible or it will cover up the image
                                        }
                                    }
                                }
                                RowLayout{
                                    Layout.fillWidth:true
                                    height:35
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: "Your Identity : "
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "black"
                                    }
                                    Item{
                                        Layout.fillWidth:true
                                    }
                                    Button_{
                                        Layout.alignment:Qt.AlignRight
                                        width:innerText.width + 48*2
                                        height:35
                                        buttonText:qsTranslate("","Change")
                                        color: "#065AD8"
                                        borderColor: "#065AD8" 
                                        textColor: "white"
                                        fontWeight:600
                                        fontSize:10
                                        borderWidth:1
                                        onClicked:{
                                            fileOpen.field_name='identity_image'
                                            fileOpen.open()
                                        }
                                    }
                                }
                            }
                            
                        }
                        Rectangle{
                            Layout.fillWidth:true
                            Layout.fillHeight:true
                            color:"#eff1fc"
                            radius:9
                            ColumnLayout{
                                anchors.fill:parent
                                anchors.margins:10
                                spacing:10
                                ColorImage {
                                    id: signature_image
                                    // Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                                    source: 'http://localhost:8000/user/kyc/file/signature?token='+user_info.token
                                    Layout.fillWidth:true
                                    Layout.fillHeight:true
                                    // Layout.preferredWidth:parent.width * 45/100
                                    // Layout.preferredHeight:width
                                    layer.enabled:true
                                    layer.effect:OpacityMask {
                                        maskSource: Rectangle {
                                            width: signature_image.width
                                            height: signature_image.height
                                            radius: 8
                                            // visible: false // this also needs to be invisible or it will cover up the image
                                        }
                                    }
                                }
                                RowLayout{
                                    Layout.fillWidth:true
                                    height:35
                                    Text {
                                        Layout.alignment:Qt.AlignLeft
                                        text: "Your Signature : "
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: Fonts.inter
                                        wrapMode: Text.WordWrap
                                        font.weight: 600
                                        font.pointSize: 10
                                        color: "black"
                                    }
                                    Item{
                                        Layout.fillWidth:true
                                    }
                                    Button_{
                                        Layout.alignment:Qt.AlignRight
                                        width:innerText.width + 48*2
                                        height:35
                                        buttonText:qsTranslate("","Change")
                                        color: "#065AD8"
                                        borderColor: "#065AD8" 
                                        textColor: "white"
                                        fontWeight:600
                                        fontSize:10
                                        borderWidth:1
                                        onClicked:{
                                            fileOpen.field_name='signature'
                                            fileOpen.open()
                                        }
                                    }
                                }
                            }
                            
                        }

                    }
                    Button_{
                        Layout.alignment:Qt.AlignRight
                        width:innerText.width + 48*2
                        height:35
                        buttonText:qsTranslate("","Submit KYC")
                        color: "#065AD8"
                        borderColor: "#065AD8" 
                        textColor: "white"
                        fontWeight:600
                        fontSize:10
                        borderWidth:1
                        onClicked:{
                            // remove unccessarely dymmyKey
                            updated_kyc.dummyKey !== undefined ? delete updated_kyc.dummyKey:null
                            busypopup.open()
                            console.log(JSON.stringify(updated_kyc))
                            window.getAttr('update_kyc').sendRequest(updated_kyc)

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
            }
        }
    }
    FileDialog {
        id: fileOpen
        title: qsTr("Upload (JPGE,PNG,etc....)")
        nameFilters: ["Image File (*.JPGE , *.png , *.jpg)"]
        property string field_name
        onAccepted: {
            console.log( String(fileOpen.currentFile).substr(8))
            updated_kyc[field_name]=String(fileOpen.currentFile).substr(8);
            if (field_name === 'identity_image'){
                identity_image.source='file:'+String(fileOpen.currentFile).substr(8)
            }else if(field_name === 'signature'){
                signature_image.source='file:'+String(fileOpen.currentFile).substr(8)
            }else if(field_name === 'image'){
                user_image_edit.source='file:'+String(fileOpen.currentFile).substr(8)
            }
        }
    }
}
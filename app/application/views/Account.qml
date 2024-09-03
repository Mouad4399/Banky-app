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

    

    property variant user_kyc_form:{'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
    property variant user_acc_form:{'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}

    property variant updated_kyc:{'dummyKey':''}

    function get_kyc_slot(code,json) {
        busypopup.close()
        if (code === 200) {
            // main_app.goToApp();
            // console.log('login successful')
            toastmanager.show(true,"Receive KYC Data :" , "Your Data have been received successfuly !")
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
        if (code === 200) {
            // main_app.goToApp();
            // console.log('login successful')
            toastmanager.show(true,"Update KYC Data :" , "Your Data have been updated successfuly !")
        }else{
            // console.log(code)
            var auth_error_message = json.detail;
            console.log(auth_error_message)
            toastmanager.show(false,"Receive KYC Data :" , "There was an Error While updating your KYC data !")
        }

        // user_kyc_form=user_kyc_info
        window.getAttr('update_kyc').finished.disconnect(update_kyc_slot)
        
    }
    function get_acc_slot(code , json){
        user_acc_form=user_acc_info
        window.getAttr('get_acc').finished.disconnect(get_acc_slot)
    }
    Component.onCompleted:{
        // busypopup.open()
        window.getAttr('get_acc').finished.connect(get_acc_slot);
        window.getAttr('get_acc').sendRequest()

        window.getAttr('get_kyc').finished.connect(get_kyc_slot);
        window.getAttr('get_kyc').sendRequest()

        // one you write the Update_KYC and set up everything
        // window.getAttr('update_kyc').finished.connect(update_kyc_slot);
        
        
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
                                    // Layout.alignment:Qt.AlignHCenter|Qt.AlignTop
                                    source: 'http://localhost:8000/user/kyc/file/identity_image?token='+user_info.token
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
                            placeholder: "1999-1-1"
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
                        // Text {
                        //     Layout.columnSpan:2
                        //     Layout.column:0
                        //     Layout.row:2*4
                        //     text: qsTr("Gender")
                        //     horizontalAlignment: Text.AlignLeft
                        //     wrapMode: Text.WordWrap
                        //     font.family: Fonts.inter
                        //     font.pointSize: 10
                        //     font.weight: 600
                        //     color: "#444"
                        // }
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
                                currentIndex:choices[user_kyc_form.gender]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    user_kyc_form.gender=choices[index]
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
                                currentIndex:choices[user_kyc_form.marrital_status]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    user_kyc_form.marrital_status=choices[index]
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
                                currentIndex:choices[user_kyc_form.identity_type]
                                onActivated:index=>{
                                    if(index===0){
                                        return
                                    }
                                    user_kyc_form.identity_type=choices[index]
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
                            // busypopup.open()
                            console.log(JSON.stringify(updated_kyc))
                            // window.getAttr('update_kyc').sendRequest(updated_kyc)

                            // reset updated_kyc
                            updated_kyc={'dummyKey':''};

                            stack.replace(root);
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
            user_kyc_form[field_name]=String(fileOpen.currentFile).substr(8)
        }
    }
}
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Qt.labs.qmlmodels
import Fonts 1.0
import Components 1.0

Rectangle {
    id: table
    Layout.fillWidth: true
    property alias tableView : tableView
    property alias horizontalHeader : horizontalHeader
    // Layout.fillHeight: true
    default property alias data: tableCol.data
    // implicitWidth:tableCol.width
    implicitHeight: tableCol.implicitHeight + 1 * 2
    // color:'red'
    color: Qt.rgba(0, 0, 0, 0)
    border.width: 1
    radius: 7
    border.color: '#E9E9E9'


    required property var transaction_request
    property var type_icon:{"sent":"image://img/sent_money.svg","received":"image://img/received_money.svg","sent_requests":"image://img/sent_request.svg","received_requests":"image://img/received_request.svg"}

    onTransaction_requestChanged:{
        sendRequest()
    }
    function sendRequest(){
        window.getAttr('get_transaction').finished.connect(function get_transaction_slot(code , json) {
            busypopup.close()
            if(code=== 200){
                tableView.model.rows=json
            }
            window.getAttr('get_transaction').finished.disconnect(get_transaction_slot)
        });
        busypopup.open()
        window.getAttr('get_transaction').sendRequest(transaction_request)
    }
    Component.onCompleted:{
        sendRequest()
    }

    ColumnLayout {
        id: tableCol
        spacing: 0
        anchors.centerIn: parent

        implicitWidth: parent.width - 4 * 2
        // Layout.fillHeight:true
        // anchors.bottom: pagination.top
        // anchors.bottomMargin: 15
        // anchors.horizontalCenter: parent.horizontalCenter
        // implicitWidth: parent.width - 8
        // Layout.preferredHeight: tableView.height + horizontalHeader.contentItem.height
        HorizontalHeaderView {
            id: horizontalHeader
            clip:true
            Layout.fillWidth: true
            // anchors.left: tableView.left
            // anchors.top: parent.top
            syncView: tableView
            columnSpacing: 5
            Layout.topMargin:1
            implicitHeight: 40
            implicitWidth: parent.implicitWidth
            model: ["Transaction","Name/Business","Amount","Date","Status","Action"]
            boundsBehavior: Flickable.StopAtBounds

            Rectangle {
                // width: horizontalHeader.implicitWidth + 8
                anchors.left:parent.left
                anchors.right:parent.right
                height: 1
                x: -4
                color: '#E9E9E9'
                z: horizontalHeader.model.length
                anchors.bottom: parent.bottom
            }
            // property var sort_data:{
            //     "column": "nom",
            //     "sort": false,
            //     "role":["tous","ger","emp"][filter_btn.currentIndex]
            // }
            property int activatedColumn :0
            delegate: DelegateChooser {
                // role:index

                DelegateChoice {
                    index: 0
                    delegate: HeaderBtn{

                    }
                }
                DelegateChoice {
                    index: 3
                    delegate: HeaderBtn{

                    }
                }
                DelegateChoice {
                    delegate: Rectangle {
                        color: '#f9fbfc'
                        implicitHeight: 40
                        implicitWidth: tableCol.implicitWidth / horizontalHeader.model.length
                        Text {
                            text:  modelData
                            font.pointSize: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            color: '#4a5266'
                            horizontalAlignment: Text.AlignHCenter
                            font.family: Fonts.inter
                            font.weight: 700
                        }
                    }
                }
            }
        }

        TableView {
            id: tableView
            clip: true
            // interactive: false
            onLayoutChanged:{
                // console.log('hellothsere')
            }
            // topRow :
            editTriggers: TableView.DoubleTapped | TableView.EditKeyPressed
            // anchors.top: horizontalHeader.bottom
            Layout.fillWidth: true
            // anchors.right: parent.right
            // anchors.left: parent.left
            height: 65 * 5
            model: TableModel {
                        id: employeeModel
                        TableModelColumn {
                            display: "transaction_id"
                        }
                        TableModelColumn {
                            display: "full_name"
                        }
                        TableModelColumn {
                            display: "amount"
                        }
                        TableModelColumn {
                            display: "date"
                        }
                        TableModelColumn {
                            display: "status"
                        }

                        // rows:[
                        //     {
                        //         'transaction_id': 'TRA2j3342uh23i4o',
                        //         'full_name': 'Mouad Ait Ougrram',
                        //         'amount': '$1,778.24',
                        //         'date': '06/12/2023',
                        //         'status': 'complated',
                        //     }
                        // ]
                    }
            selectionModel: ItemSelectionModel {
            }
            rowSpacing: 0
            columnSpacing: 0
            alternatingRows: true
            keyNavigationEnabled: true
            pointerNavigationEnabled: true
            selectionBehavior: TableView.SelectRows
            animate: true
            boundsBehavior: Flickable.StopAtBounds
            

            // flickableDirection: Flickable.HorizontalFlick
            ScrollBar_.horizontal: ScrollBar_ {
                // parent: tableView
                // anchors.top:parent.top
                // x: scrollView.width
                // y: scrollView.topPadding
                // height: scrollView.availableHeight
            }
            Rectangle{
                // anchors.fill:tableView.view
                id:busypopup_bg
                visible:false
                width: tableView.width
                height: tableView.height
                color:Qt.rgba(0.1,0.1,0.1,0.1)
                z:Infinity
                Popup {
                    id: busypopup
                    // anchors.centerIn: Overlay.overlay
                    anchors.centerIn:parent
                    closePolicy: Popup.NoAutoClose
                    // modal: true
                    onOpened:{
                        parent.visible=true
                    }
                    onClosed:{
                        parent.visible=false
                    }
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
            ColumnLayout{
                id:notFound_alert
                x:((tableView.width)/2) - width/2
                y:((tableView.height)/2) - height/2
                spacing:10
                property bool notFound:tableView.rows.length ===0
                z:Infinity
                // anchors.centerIn:parent
                Item{
                    Layout.fillHeight:true
                }

                ColorImage{
                    visible:notFound_alert.notFound
                    Layout.alignment:Qt.AlignCenter
                    source:'data:image/svg+xml;utf8,<svg width="55" height="55" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 8V12M12 16.01L12.01 15.999M9 3H4V6M4 11V13M20 11V13M15 3H20V6M9 21H4V18M15 21H20V18" stroke="#699BF7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>'
                    color: "#AEAFB3"
                }
                Text {
                    visible:notFound_alert.notFound
                    Layout.alignment:Qt.AlignCenter
                    text: "No Record Found"
                    horizontalAlignment: Text.AlignLeft
                    font.family: Fonts.inter
                    wrapMode: Text.WordWrap
                    font.weight: 600
                    font.pointSize: 12
                    color: "#AEAFB3"
                }
                Item{
                    Layout.fillHeight:true
                }
            }
                

            property var hoveredRow: undefined
            property var hoveredCol: undefined
            property var pressedRow: undefined
            delegate: DelegateChooser {
                id: chooserId

                DelegateChoice {
                    column: 0
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 30/100

                        RowLayout{
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            scale: row === tableView.pressedRow ? 1.05 : 1.0
                            spacing:10
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            ColorImage{
                                Layout.alignment:Qt.AlignTop
                                source:type_icon[tableView.model.getRow(row).type]
                            }
                            ColumnLayout{

                                Text {
                                    text:  display
                                    font.weight: 400
                                    font.family: Fonts.inter
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pointSize: 10
                                    // anchors.horizontalCenter:parent.horizontalCenter
                                    color: '#121b28'
                                    font.capitalization: Font.AllUppercase
                                }
                                Text {
                                    text: tableView.model.getRow(row).transaction_type
                                    font.weight: 600
                                    font.family: Fonts.inter
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pointSize: 8
                                    // anchors.horizontalCenter:parent.horizontalCenter
                                    color: '#4a5266'
                                }
                            }
                        }

                    }
                }
                DelegateChoice {
                    column: 1
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 15/100
                        Text {
                            text:  display
                            scale: row === tableView.pressedRow ? 1.05 : 1.0
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            font.weight: 500
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            // anchors.horizontalCenter:parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: '#46555d'
                        }

                    }
                }
                DelegateChoice {
                    column: 2
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 10/100
                        Text {
                            text:  Number(display).toLocaleString(Qt.locale()) + " $"
                            scale: row === tableView.pressedRow ? 1.05 : 1.0
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            font.weight: 500
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            // anchors.horizontalCenter:parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: '#46555d'
                        }

                    }
                }
                DelegateChoice {
                    column: 3
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 15/100
                        Text {
                            text:   Qt.formatDate(new Date(display) , "ddd \nyyyy-MM-dd")
                            scale: row === tableView.pressedRow ? 1.05 : 1.0
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            font.weight: 500
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            // anchors.horizontalCenter:parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: '#46555d'
                        }

                    }
                }
                DelegateChoice {
                    column: 4
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 15/100
                        Text {
                            text:  display
                            scale: row === tableView.pressedRow ? 1.05 : 1.0
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            font.weight: 700
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            font.family: Fonts.inter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            // anchors.horizontalCenter:parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: '#32c068'
                            Rectangle{
                                anchors.centerIn:parent
                                width:parent.width + 10*2
                                height:parent.height + 5*2
                                // anchors.fill:parent
                                // anchors.leftMargin:-8
                                // anchors.rightMargin:-8
                                // anchors.topMargin:-4
                                // anchors.bottomMargin:-4
                                // // anchors.margins:-4
                                z:-1
                                radius:height/2
                                color:"#f0fff3"

                            }
                        }

                    }
                }
                DelegateChoice {
                    column: 5
                    delegate: TableRow{
                        implicitWidth:TableView.view.width * 15/100
                        RowLayout{
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            // anchors.left:parent.left
                            // anchors.right:parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            spacing:5
                            Item{
                                Layout.fillWidth:true
                            }
                            Button_{
                                // Layout.alignment:Qt.AlignCenter
                                visible:(tableView.model.getRow(row).status!== 'request_settled')&&(tableView.model.getRow(row).type==='received_requests')
                                buttonText:'Settle'
                                enabledEffect:true
                                disabledBgColor:"#ccc"
                                Layout.preferredWidth:innerText.width + 10*2
                                // Layout.preferredHeight:innerText.hight + 15*2
                                height:25
                                color: "#065AD8"
                                textColor: "white" 
                                fontWeight:600
                                fontSize:10
                                onClicked:{
                                    var search_acc_info;
                                    // console.log(transaction_request.type === 'all'?tableView.model.getRow(row).sender_account:tableView.model.getRow(row).account_id)
                                    // console.log(transaction_request.type)
                                    window.getAttr('search_acc').finished.connect(function search_acc_slot(code , json){
                                                                                    // busypopup.close()
                                                                                    if(code !== 200){
                                                                                        console.log('something wrong ! , ' + transaction_request.type === 'all'?tableView.model.getRow(row).sender_account_id:tableView.model.getRow(row).account_id)
                                                                                        return
                                                                                    }
                                                                                    search_acc_info=json
                                                                                    
                                                                                    stack.replaceIfReady('./views/Payment.qml',{'helperFunction':function (){
                                                                                                                                this.stepsStack.push('./PaymentThirdStep.qml',{'search_acc_info':search_acc_info,
                                                                                                                                                                            'amount':Number(tableView.model.getRow(row).amount),
                                                                                                                                                                            'description':tableView.model.getRow(row).description,
                                                                                                                                                                            'payment_type':'Settlement',
                                                                                                                                                                            'transaction_id':tableView.model.getRow(row).transaction_id,
                                                                                                                                                                            })}})
                                                                                    window.getAttr('search_acc').finished.disconnect(search_acc_slot)
                                                                                });
                                    window.getAttr('search_acc').sendRequest({
                                        'account_id_or_number':transaction_request.type === 'all'?tableView.model.getRow(row).sender_account_id:tableView.model.getRow(row).account_id})


                                }                                
                            }
                            Button_{
                                // Layout.alignment:Qt.AlignCenter
                                visible:(tableView.model.getRow(row).status!== 'request_settled')&&(tableView.model.getRow(row).type ==='sent_requests' || tableView.model.getRow(row).type ==='received_requests')
                                buttonText:'Cancle'
                                enabledEffect:true
                                disabledBgColor:"#ccc"
                                Layout.preferredWidth:innerText.width + 10*2
                                // Layout.preferredHeight:innerText.hight + 15*2
                                height:25
                                color: "#e04a47"
                                textColor: "white" 
                                fontWeight:600
                                fontSize:10  
                            }
                            Item{
                                Layout.fillWidth:true
                            }
                        }

                    }
                }
            }
        }
    }

    component TableRow :Rectangle {
        implicitWidth: TableView.view.width * 20/100
        implicitHeight: 65
        color: (row === tableView.hoveredRow) ? '#F5F5F5' : ((row === tableView.pressedRow) ? '#EEEEEE' : 'white')
        Behavior on color {
            ColorAnimation {
                duration: 300
                easing.type: Easing.OutQuart
            }
        }

        signal clicked
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onPositionChanged: {
                if (containsPress === false) {
                    tableView.pressedRow = undefined;
                    tableView.hoveredRow = row;
                }
            }

            onEntered: {
                tableView.pressedRow = undefined;
                tableView.hoveredRow = row;
                tableView.hoveredCol = column;
            }
            onReleased: {
                if (containsMouse) {
                    tableView.hoveredRow = row;
                } else {
                    tableView.hoveredRow = undefined;
                }
                tableView.pressedRow = undefined;
            }
            onExited: {
                tableView.pressedRow = undefined;
                if (tableView.hoveredRow === row && tableView.hoveredCol === column) {
                    tableView.hoveredRow = undefined;
                    tableView.hoveredCol = undefined;
                }
            }
            onPressed: {
                tableView.hoveredRow = undefined;
                tableView.pressedRow = row;
            }
            onClicked: {
                parent.clicked();
                // var dialogComponent = Qt.createComponent("RowClickedDialog.qml");
                // if (dialogComponent.status === Component.Ready) {
                //     var dialog = dialogComponent.createObject(mainWindow);
                //     dialog.open();
                // } else
                //     console.error(dialogComponent.errorString());
                // console.log(chooserId.choices[0].delegate.)

            }
        }

       
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width + 8
            height: 1
            color: '#E9E9E9'
            anchors.bottom: parent.bottom
        }
    }

    component HeaderBtn:Rectangle {
        color: state === "Pressed" ? "#f0f0f0" : '#f9fbfc'
        implicitHeight: 40
        implicitWidth: tableCol.implicitWidth / horizontalHeader.model.length
        scale: state === "Pressed" ? 0.98 : 1.0
        onEnabledChanged: state = ""

        //define a scale animation
        Behavior on scale {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutBack
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 100
                easing.type: Easing.OutBack
            }
        }
        RotationAnimation {
            id: rotationAnimation
            target: sortImage
            duration: 150
            // to: sortImage.rotation
            // running: true
            easing.type: Easing.OutBack
        }

        Text {
            id: headerTitle
            text: modelData
            font.pointSize: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            color: '#4a5266'
            horizontalAlignment: Text.AlignHCenter
            font.family: Fonts.inter
            font.weight: 700
        }
        ColorImage {
            id: sortImage
            visible:horizontalHeader.activatedColumn===index
            // rotation:horizontalHeader.sort_data.sort ? 0:180
            anchors.left: headerTitle.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            // source: 'image://img/sort.svg'
            // Behavior on rotation {

            // RotationAnimation {
            //     id:rotationAnimation
            //     // loops: 1
            //     // from: sortImage.rotation===180?0:180
            //     to: sortImage.rotation===180?0:180
            //     duration:2000
            //     easing.type: Easing.OutBack
            // }
            // }
            // Component.onCompleted:{
            //     rotation=horizontalHeader.sort_data.sort ? 0:180
            //     console.log('hello')
            // }
        }
        
        // property bool btn_state:horizontalHeader.sort_data.sort
        signal clicked(sort : bool)
        MouseArea {
            id:mouse_area
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton 
            // property bool btn_state:horizontalHeader.sort_data.sort
            onPositionChanged: {
                if (containsPress === false) {
                    parent.state = '';
                }
            }
            onExited: {
                parent.state = '';
            }
            onPressed: {
                parent.state = "Pressed";
            }
            onClicked: {
                // console.log(index)
                
                if (sortImage.visible===false){
                    // console.log(sortImage.rotation)
                    parent.clicked(btn_state);
                    return
                }
                btn_state=!btn_state
                // console.log('a1')
                // console.log(sortImage.rotation)
                // sortImage.rotation = sortImage.rotation === 180 ? 0 : 180
                
                // console.log(sortImage.rotation)
                // console.log('i clicked')
                rotationAnimation.finished.connect(function (){
                    parent.clicked(btn_state)
                    })
                // console.log('a3')

                rotationAnimation.to = sortImage.rotation === 180 ? 0 : 180;
                rotationAnimation.start();
            }
            onReleased: {
                parent.state = "";
                // console.log(parent.state)
            }
        }
        
        onClicked:sort=>{
            // // console.log('b1')
            // horizontalHeader.activatedColumn=index
            // horizontalHeader.sort_data.column= "nom"
            // // console.log(sort)
            // horizontalHeader.sort_data.sort= sort
            // root.requestPage(pagination.currentPage)
            // // console.log('b2')
        }
    }
}

 

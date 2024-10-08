import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Qt.labs.qmlmodels
import QtCharts
import Fonts 1.0
import Components 1.0


Rectangle{
    id:root
    width:parent===null ? width:parent.width
    height:parent===null ? height:parent.height
    objectName:"Dashboard"
    color:"#F5F5F5"
    function isReadyToLeave(){
        
        return true
    
    }
    property variant user_kyc_form:{'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
    property variant user_acc_form:{'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}


    Component.onCompleted:{
        window.getAttr('get_acc').finished.connect(function get_acc_slot(code , json){
            busypopup.close();
            user_acc_form=user_acc_info
            window.getAttr('get_acc').finished.disconnect(get_acc_slot)
        });
        busypopup.open();
        window.getAttr('get_acc').sendRequest()

        window.getAttr('get_kyc').finished.connect(function get_kyc_slot(code,json) {
            busypopup.close()

            if (code === 200) {
                user_kyc_form=user_kyc_info
            }

            window.getAttr('get_kyc').finished.disconnect(get_kyc_slot)
        });
        busypopup.open();
        window.getAttr('get_kyc').sendRequest()
        
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 10
        spacing: 20


        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: membersContent.height + 140

            ScrollBar_.vertical: ScrollBar_ {
                parent: scrollView
                x: scrollView.width - 10
                y: scrollView.topPadding
                height: scrollView.availableHeight
            }
            ColumnLayout {
                id: membersContent
                anchors.left: parent.left
                anchors.leftMargin: 20
                width: scrollView.width - 50
                height: 1000
                spacing: 20
                ColumnLayout {
                    Layout.preferredWidth: parent.width 
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 5
                    RowLayout {
                        Layout.topMargin: 20
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        spacing:15
                        Text {
                            
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            text: qsTranslate('',"Dashboard : ")
                            horizontalAlignment: Text.AlignLeft
                            wrapMode: Text.WordWrap
                            font.family: Fonts.inter
                            font.pointSize: 20
                            font.weight: 900
                            color: "#121B28"
                            
                        }
                        Item{
                            Layout.fillWidth:true
                        }

                        Button_ {
                            // Layout.alignment: Qt.AlignTop
                            // anchors.top: parent.top
                            // anchors.right: parent.right
                            Layout.topMargin:-10
                            imageSource: "image://img/bell.svg"
                            width: 30
                            height: 30
                            borderRadius: width/2
                            imageColor: "#121b28"
                            color:"white"

                            buttonText: ""
                            onClicked: {
                                toastmanager.show();
                            }
                        }
                        Button_ {
                            // Layout.alignment: Qt.AlignTop
                            // anchors.top: parent.top
                            // anchors.right: parent.right
                            Layout.topMargin:-10
                            imageSource: "http://localhost:8000/user/kyc/file/image?token="+user_info.token
                            image.height:height
                            image.width:width
                            image.cache:false
                            imageRadius:width/2
                            width: 45
                            height: 45
                            borderRadius: width/2
                            // imageColor: "#121b28"
                            color:"green"

                            buttonText: ""
                            onClicked: {
                                toastmanager.show();
                            }
                        }
                    }
                }
                GridLayout {
                    id: grid
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                    Layout.preferredWidth :parent.width
                    Layout.preferredHeight :parent.height
                    property double colMulti: grid.Layout.preferredWidth / grid.columns
                    property double rowMulti: grid.Layout.preferredHeight / grid.rows
                    function prefWidth(item){
                        return colMulti * item.Layout.columnSpan
                    }
                    function prefHeight(item){
                        return rowMulti * item.Layout.rowSpan
                    }
                    // height: 800+40
                    // columnSpacing: 10
                    columns:3
                    rows:12
                    rowSpacing: 15
                    columnSpacing:15

                    Rectangle{
                        Layout.columnSpan:2
                        Layout.rowSpan:3
                        color:"#121b28"
                        radius:10
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        z:Infinity
                        // Layout.fillHeight: true
                        // Layout.fillWidth: true
                        RowLayout{
                            anchors.left:parent.left
                            anchors.right:parent.right
                            anchors.top:parent.top
                            anchors.bottom:bottomPanel.top
                            anchors.margins:20
                            spacing:10
                           
                            ColumnLayout{
                                
                                Text {
                                    Layout.alignment: Qt.AlignLeft
                                    // Layout.preferredWidth:parent.parent.width
                                    // textFormat: Text.RichText
                                    text: "Hi , "+user_kyc_form.full_name+" !"
                                    horizontalAlignment: Text.AlignLeft
                                    wrapMode: Text.WordWrap
                                    font.family: Fonts.inter
                                    font.pointSize: 12
                                    font.weight: 300
                                    color: "white"
                                }

                                Text {
                                    // Layout.fillWidth: true
                                    Layout.topMargin:20
                                    Layout.alignment: Qt.AlignLeft
                                    // textFormat: Text.RichText
                                    text: "$ "+ Number(user_acc_form.account_balance).toLocaleString(Qt.locale())+""
                                    horizontalAlignment: Text.AlignLeft
                                    wrapMode: Text.WordWrap
                                    font.family: Fonts.inter
                                    font.pointSize: 30
                                    font.weight: 300
                                    color: "white"
                                }
                                Text {
                                    Layout.alignment: Qt.AlignLeft
                                    // Layout.preferredWidth:parent.parent.width
                                    width:implicitWidth
                                    textFormat: Text.RichText
                                    text: "Last Received $" + "<font color=green>  100,000</font>"
                                    horizontalAlignment: Text.AlignLeft
                                    // wrapMode: Text.WordWrap
                                    font.family: Fonts.inter
                                    font.pointSize: 11
                                    font.weight: 300
                                    color: "white"
                                }
                                Item{
                                    Layout.fillHeight:true
                                }
                            }
                            ColumnLayout{
                                Layout.fillWidth:true
                                Layout.fillHeight:true
                                ComboBox_ {
                                    id: interval_combo
                                    Layout.alignment:Qt.AlignRight
                                    emptyField.colorDefault:Qt.lighter("#121b28",1.5)
                                    emptyField.color:"white"
                                    indicatorimage.color:"white"
                                    model: ['Days','Weeks']
                                    bgRadius:4
                                    currentIndex:0
                                    onActivated:{
                                        // currentIndex=index
                                        chart_loader.active =false
                                        chart_loader.active =true
                                    }

                                }

                                Loader{
                                    id:chart_loader
                                    Layout.fillWidth:true
                                    Layout.fillHeight:true
                                    sourceComponent:ChartView {
                                        id: chartView
                                        antialiasing: true
                                        animationOptions: ChartView.SeriesAnimations
                                        // Layout.alignment:Qt.AlignTop
                                        Layout.fillWidth:true
                                        Layout.fillHeight:true
                                        backgroundColor :"transparent"
                                        margins { right: 0; bottom: 0; left: 0; top: 0 }

                                        legend.visible: false

                                        property  list<var> seriesData
                                        Timer {
                                            id:timer
                                            interval: 20*(timeStep+1)/2
                                            property int timeStep: 0
                                            repeat:true
                                            // running:!(timeStep >=7)
                                            // property var test:[0,5,23,5,150,80,100]
                                            onTriggered: {
                                                
                                                // here change to the data from api
                                                // console.log(chartView.seriesData[timeStep].outcome)
                                                // console.log(timeStep)
                                                if (axisY.maximumValue<Math.max(Number(chartView.seriesData[timeStep].outcome),Number(chartView.seriesData[timeStep].income))){
                                                    axisY.maximumValue=Math.max(Number(chartView.seriesData[timeStep].outcome),Number(chartView.seriesData[timeStep].income))
                                                }
                                                series2.append(timeStep,chartView.seriesData[timeStep].outcome)
                                                series1.append(timeStep,chartView.seriesData[timeStep].income)
                                                timeStep++
                                                if (timeStep >= 7){
                                                    timeStep=0
                                                    running=false

                                                }
                                            }
                                        }

                                        Component.onCompleted:{
                                            window.getAttr('get_transactions_summary').finished.connect(function get_transactions_summary_slot(code , json) {
                                                // busypopup.close()
                                                if(code=== 200){
                                                    chartView.seriesData=json.interval_transactions
                                                }
                                                timer.start()
                                                window.getAttr('get_transactions_summary').finished.disconnect(get_transactions_summary_slot)
                                            });
                                            // busypopup.open()
                                            window.getAttr('get_transactions_summary').sendRequest({
                                                'interval':['days','weeks'][interval_combo.currentIndex]
                                            })
                                        }

                                        ValueAxis {
                                            id: axisX
                                            min: -0.1
                                            max:6+ 0.1
                                            gridVisible:false
                                            lineVisible :false
                                            labelsVisible :false
                                        }
                                        ValueAxis {
                                            id: axisY
                                            property real maximumValue:0
                                            max:maximumValue+maximumValue*0.1
                                            min: -maximumValue*0.1
                                            // max: {return Math.max(series1.maxPoint.y,series2.maxPoint.y)+ 10}
                                            // gridLineColor:"transparent"
                                            // labelsColor:"transparent"
                                            gridVisible:false
                                            lineVisible :false
                                            labelsVisible :false
                                        }
                                        AreaSeries {
                                            id:areaseries1
                                            borderColor: Qt.rgba(0, 0, 0, 0)
                                            borderWidth: 0
                                            color:"blue"
                                            brush:{
                                                if(window)
                                                    return window.GetBrush(chartView.height + 25,"blue")
                                            }
                                            axisX: axisX
                                            axisY: axisY
                                            upperSeries: series1
                                            // function setbrush(){
                                            //     // console.log(chartView.mapToPosition(Qt.point(series2.maxPoint.x,series2.maxPoint.y),series2))
                                            //     brush=window.GetBrush(chartView.mapToPosition(Qt.point(series1.maxPoint.x,series1.maxPoint.y),series1),"blue")
                                            // }
                                        }

                                        LineSeries {
                                            id: series1
                                            axisX: axisX
                                            axisY: axisY
                                            property var maxPoint:Qt.point(0,0)

                                            // onMaxPointChanged:{
                                            //     console.log(series1.maxPoint)
                                            //     console.log(chartView.mapToPosition(series1.maxPoint,series1))
                                            //     areaseries1.brush=window.GetBrush(chartView.mapToPosition(Qt.point(series1.maxPoint.x,series1.maxPoint.y),series1),"blue")
                                            // }
                                            color: "blue"
                                            useOpenGL: true
                                            width: 3
                                            capStyle: Qt.RoundCap
                                            pointsVisible:true
                                            onHovered: (point,state)=>{
                                                // areaseries1.setbrush()
                                            }
                                        }
                                        // VXYModelMapper {
                                        //     model: TableModel {
                                        //         TableModelColumn {
                                        //             display: "index"
                                        //         }
                                        //         TableModelColumn {
                                        //             display: "income"
                                        //         }
                                        //         rows:[{'index':0,'week': '2024-09-08', 'income': 0, 'outcome': 0}, {'index':1,'week': '2024-09-09', 'income': 0, 'outcome': 0}, {'index':2,'week': '2024-09-10', 'income': 0, 'outcome': 70.80}, {'index':3,'week': '2024-09-11', 'income': 0, 'outcome': 240.75}, {'index':4,'week': '2024-09-12', 'income': 0, 'outcome': 0}, {'index':5,'week': '2024-09-13', 'income': 0, 'outcome': 0}]
                                        //     }
                                        //     series: series2
                                        //     firstRow: 1
                                        //     xColumn: 0
                                        //     yColumn: 1
                                        // }
                                        // VXYModelMapper {
                                        //     model: TableModel {
                                        //         TableModelColumn {
                                        //             display: "index"
                                        //         }
                                        //         TableModelColumn {
                                        //             display: "outcome"
                                        //         }
                                        //         rows:[{'index':0,'week': '2024-09-08', 'income': 0, 'outcome': 0}, {'index':1,'week': '2024-09-09', 'income': 0, 'outcome': 0}, {'index':2,'week': '2024-09-10', 'income': 0, 'outcome': '70.8000000000000'}, {'index':3,'week': '2024-09-11', 'income': 0, 'outcome': '240.75'}, {'index':4,'week': '2024-09-12', 'income': 0, 'outcome': 0}, {'index':5,'week': '2024-09-13', 'income': 0, 'outcome': 0}]
                                        //     }
                                        //     series: series1
                                        //     firstRow: 1
                                        //     xColumn: 0
                                        //     yColumn: 1
                                        //     // Component.onCompleted:{
                                        //     //     console.log(model.data())
                                        //     // }
                                        // }
                                        AreaSeries {
                                            id:areaseries2
                                            borderColor: Qt.rgba(0, 0, 0, 0)
                                            borderWidth: 0
                                            color:"red"
                                            brush:{
                                                if(window)
                                                    return window.GetBrush(chartView.height + 25,"red")
                                            }
                                            axisX: axisX
                                            axisY: axisY
                                            upperSeries: series2
                                            // function setbrush(){
                                            //     // console.log(chartView.mapToPosition(Qt.point(series2.maxPoint.x,series2.maxPoint.y),series2))
                                            //     brush=window.GetBrush(chartView.mapToPosition(Qt.point(series2.maxPoint.x,series2.maxPoint.y),series2),"red")
                                            // }
                                        }

                                        LineSeries {
                                            id: series2
                                            axisX: axisX
                                            axisY: axisY
                                            property var maxPoint:Qt.point(0,0)
                                            color: "red"
                                            useOpenGL: true
                                            width: 3
                                            capStyle: Qt.RoundCap
                                            pointsVisible:true
                                            onHovered: (point,state)=>{
                                                // console.log(chartView.mapToPosition(Qt.point(series2.maxPoint.x,series2.maxPoint.y),series2))
                                                // areaseries2.setbrush()
                                            }
                                        }

                                        Rectangle{
                                            id:ticket
                                            width:115
                                            height:65
                                            color: Qt.rgba(0,0,0,0.8)
                                            radius:4
                                            opacity:0
                                            z:Infinity
                                            
                                            Text {
                                                id: ticket_text
                                                anchors.top:parent.top
                                                anchors.left:parent.left
                                                anchors.margins:5

                                                text:"num"
                                                font.pointSize: 10
                                                color: "white"
                                                horizontalAlignment: Text.AlignLeft
                                                font.family: Fonts.inter
                                                font.weight: 700
                                            }
                                            ColumnLayout{
                                                anchors.bottom:parent.bottom
                                                anchors.left:parent.left
                                                anchors.right:parent.right
                                                anchors.margins:5
                                                spacing:-1
                                                Repeater{
                                                    id:ticket_rep
                                                    model:ListModel{
                                                        id:ticket_model
                                                        ListElement{text:"Incomes";val:12;color:'blue'}
                                                        ListElement{text:"Outcomes";val:12;color:'red'}

                                                    }
                                                    delegate:RowLayout{
                                                        Layout.alignment:Qt.AlignLeft
                                                        spacing:4
                                                        Rectangle{
                                                            width:14
                                                            height:14
                                                            color:model.color
                                                        }
                                                        Text{
                                                            text:model.text+":"
                                                            font.pointSize: 9
                                                            color: "white"
                                                            horizontalAlignment: Text.AlignLeft
                                                            font.family: Fonts.inter
                                                            font.weight: 400
                                                        }
                                                        Text{
                                                            text:model.val
                                                            font.pointSize: 9
                                                            color: "white"
                                                            horizontalAlignment: Text.AlignLeft
                                                            font.family: Fonts.inter
                                                            font.weight: 400
                                                        }
                                                    }
                                                }
                                            }
                                            Behavior on x {
                                                NumberAnimation{
                                                    duration:500
                                                    easing.type:Easing.OutExpo
                                                }
                                            }
                                            Behavior on y {
                                                NumberAnimation{
                                                    duration:500
                                                    easing.type:Easing.OutExpo
                                                }
                                            }
                                            Behavior on opacity{
                                                NumberAnimation {
                                                    // duration: 300
                                                    easing.type: Easing.InOutQuad
                                                }
                                            }
                                            PropertyChanges{ visible:opacity===1}

                                            // x:
                                        }
                                        MouseArea{
                                            anchors.fill:parent
                                            propagateComposedEvents:true
                                            hoverEnabled: true
                                            onPositionChanged:mouse=>{
                                                // console.log(chartView.mapToPosition(Qt.point(series2.maxPoint.x,series2.maxPoint.y),series2))
                                                //                                             console.log(series1.maxPoint)
                                                // console.log(chartView.mapToPosition(series1.maxPoint,series1))
                                                // areaseries1.brush=window.GetBrush(chartView.mapToPosition(Qt.point(series1.maxPoint.x,series1.maxPoint.y),series1),"blue")

                                                // console.log(mouse.x)
                                                // console.log(chartView.mapToValue(Qt.point(mouse.x,mouse.y)))
                                                var point=chartView.mapToValue(Qt.point(mouse.x,mouse.y))
                                                // console.log(Math.round(point.x))
                                                if ((Math.abs(point.x-Math.round(point.x))<0.5 )) {
                                                    var seriesPoint = chartView.mapToPosition(Qt.point(Math.round(point.x),series1.at(Math.round(point.x)).y));
                                                    var seriesPoint2 = chartView.mapToPosition(Qt.point(Math.round(point.x),series2.at(Math.round(point.x)).y));
                                                    // console.log(Math.round(point.x)+ "  "+ series1.at(Math.round(point.x)).y)
                                                    ticket.x = seriesPoint.x - ticket.width / 2; // Center the text horizontally
                                                    // console.log(seriesPoint.x)
                                                    ticket.y = (seriesPoint.y+seriesPoint2.y)/2 - ticket.height/2; // Position the text above the point
                                                    ticket.opacity=1


                                                    // console.log(point.y)    
                                                    // areaseries1.brush=window.GetBrush(point.y,"blue")

                                                    ticket_text.text= (6-Math.round(point.x))=== 0 ? "Current "+interval_combo.currentValue.slice(0,-1) : ((6-Math.round(point.x))> 1?("Last " +(6-Math.round(point.x))+" "+interval_combo.currentValue) : "Last "+interval_combo.currentValue.slice(0,-1))
                                                    ticket_rep.model.get(0).val=series1.at(Math.round(point.x)).y
                                                    ticket_rep.model.get(1).val=series2.at(Math.round(point.x)).y 
                                                    // ticket_rep.model.get(2).val=series2.at(Math.round(point.x)-1).y
                                                }
                                            }
                                            onExited:{
                                                ticket.opacity=0
                                            }
                                            onClicked:{
                                            }
                                        }


                                    }
                                }
                                // Item{
                                //     Layout.fillHeight:true
                                // }
                                
                            }
                        }
                        Rectangle{
                            id:bottomPanel
                            anchors.bottom:parent.bottom
                            anchors.left:parent.left
                            anchors.right:parent.right
                            height:60
                            radius: 10
                            color:Qt.lighter("#121b28",1.5)
                            RowLayout{
                                anchors.fill:parent
                                anchors.margins:10
                                spacing:10
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 20*2
                                    height:35
                                    buttonText:"Transfer Money"
                                    color: Qt.lighter("#121b28",1.5)
                                    borderColor: "white"
                                    textColor: "white"
                                    fontWeight:700
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Payment.qml')
                                    }
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 20*2
                                    height:35
                                    buttonText:"Receive Money"
                                    color: Qt.lighter("#121b28",1.5)
                                    borderColor: "white"
                                    textColor: "white"
                                    fontWeight:700
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Payment.qml')
                                    }
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 20*2
                                    height:35
                                    buttonText:"All Cards"
                                    color: Qt.lighter("#121b28",1.5)
                                    borderColor: "white"
                                    textColor: "white"
                                    fontWeight:700
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Payment.qml')
                                    }
                                }
                                Item{
                                    Layout.fillWidth:true
                                }
                            }
                        }
                    }
                    Rectangle{
                        Layout.columnSpan:1
                        Layout.rowSpan:4
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                        ColumnLayout{
                            anchors.fill:parent
                            anchors.margins:10
                            spacing:10
                            RowLayout{
                                Layout.fillWidth:true
                                Layout.topMargin:20
                                // Layout.bottomMargin:20
                                ColumnLayout{

                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: qsTranslate('',"Cards : ")
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 17
                                        font.weight: 900
                                        color: "#121B28"
                                        
                                    }
                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: "Here you will see your Linked Cards . "
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 10
                                        font.weight: 300
                                        color: "#999"
                                        
                                    }
                                }
                                Item{
                                    Layout.fillWidth:true
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignTop | Qt.AlignRight
                                    width:innerText.width + 10*2
                                    height:35
                                    buttonText:"+ Add"
                                    color: "#065AD8"
                                    borderColor: "#065AD8" 
                                    textColor: "white"
                                    fontWeight:600
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Transactions.qml')
                                    }
                                }
                            }
                            Rectangle {
                                id:show
                                width: 240; height: 160
                                // Layout.fillWidth:true
                                // Layout.fillHeight:true
                                transformOrigin: Item.TopLeft
                                // color:"red"
                                scale:(parent.width/width)

                                // Component.onCompleted:{
                                //     console.log("my scale " + scale)
                                // }
                                Button_ {
                                    id:leftArrow
                                    z:Infinity
                                    enabled:pathview.currentIndex !==0
                                    disabledBgColor: '#ccc'
                                    disabledImageColor: '#666'
                                    imageColor:"#C4CDD5"
                                    anchors.left:parent.left
                                    anchors.top:parent.top
                                    anchors.topMargin:parent.height/2 -height/2
                                    buttonText: ''
                                    height: 18
                                    width: 18
                                    borderRadius: width/2
                                    color: "white"
                                    hoverColor: "#e3e3e3"
                                    pressColor: "#e3e3e3"
                                    borderWidth: 1
                                    imageSource: 'data:image/svg+xml;utf8,<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15.1599 7.41L10.5799 12L15.1599 16.59L13.7499 18L7.74991 12L13.7499 6L15.1599 7.41Z" fill="#C4CDD5"/></svg>'
                                    onClicked: {
                                        pathview.decrementCurrentIndex()
                                    }
                                }
                                Button_ {
                                    id:rightArrow
                                    z:Infinity
                                    enabled:pathview.currentIndex !==(pathview.count -1)
                                    disabledBgColor: '#ccc'
                                    disabledImageColor: '#666'
                                    imageColor:"#C4CDD5"
                                    anchors.right:parent.right
                                    anchors.top:parent.top
                                    anchors.topMargin:parent.height/2 -height/2
                                    buttonText: ''
                                    height: 18
                                    width: 18
                                    borderRadius: width/2
                                    color: "white"
                                    hoverColor: "#e3e3e3"
                                    pressColor: "#e3e3e3"
                                    borderWidth: 1
                                    imageSource: 'data:image/svg+xml;utf8,<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.84009 7.41L13.4201 12L8.84009 16.59L10.2501 18L16.2501 12L10.2501 6L8.84009 7.41Z" fill="#C4CDD5"/></svg>'
                                    onClicked: {
                                        pathview.incrementCurrentIndex()
                                    }
                                }

                                

                                Component {
                                    id: delegate
                                    
                                    ColorImage{
                                        width:71
                                        height:45
                                        source:"image://img/credit_card_visa_"+((index%5))+".png"
                                        visible:(pathview.currentIndex===(pathview.count-1))  || (pathview.currentIndex===0) ? ( Math.abs(index-pathview.currentIndex)<(pathview.count)/2):( Math.abs(index-pathview.currentIndex)<(pathview.count)/4)

                                        id: wrapper
                                        required property int index
                                        opacity: PathView.opacity
                                        scale: PathView.scale


                                        Text{
                                            // id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'Card Holder Name'
                                            font.pointSize:4
                                            color:'white'
                                            x: -5.5  ; y:  32
                                            
                                            
                                        }
                                        Text{
                                            // id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'Mouad Ait Ougrram'
                                            font.pointSize:4.5
                                            color:'white'
                                            font.weight:700
                                            // color:'white'
                                            x: -8.5  ; y: 35
                                            // DragHandler {
                                            //     onGrabChanged:(transition, eventPoint) => {


                                            //         switch (eventPoint.state) {
                                            //             case EventPoint.Pressed:
                                            //                 console.log("on press @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Updated:
                                            //                 console.log("on update @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Released:
                                            //                 console.log("on release @", test.x," ; " ,test.y);
                                            //                 break
                                            //             default:
                                            //                 console.log(eventPoint.position, "state", eventPoint.state)
                                            //                 break
                                            //         }
                                            //     }
                                            // }
                                            
                                            
                                        }
                                        Text{
                                            // id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'Expiry Date'
                                            font.pointSize:4
                                            color:'white'
                                            x: 45.25  ; y: 31.5
                                            // DragHandler {
                                            //     onGrabChanged:(transition, eventPoint) => {


                                            //         switch (eventPoint.state) {
                                            //             case EventPoint.Pressed:
                                            //                 console.log("on press @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Updated:
                                            //                 console.log("on update @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Released:
                                            //                 console.log("on release @", test.x," ; " ,test.y);
                                            //                 break
                                            //             default:
                                            //                 console.log(eventPoint.position, "state", eventPoint.state)
                                            //                 break
                                            //         }
                                            //     }
                                            // }
                                            
                                        }
                                        Text{
                                            // id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'07/12'
                                            font.pointSize:5
                                            color:'white'
                                            font.weight:600
                                            // color:'white'
                                            x: 48  ; y: 34.25
                                            // DragHandler {
                                            //     onGrabChanged:(transition, eventPoint) => {


                                            //         switch (eventPoint.state) {
                                            //             case EventPoint.Pressed:
                                            //                 console.log("on press @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Updated:
                                            //                 console.log("on update @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Released:
                                            //                 console.log("on release @", test.x," ; " ,test.y);
                                            //                 break
                                            //             default:
                                            //                 console.log(eventPoint.position, "state", eventPoint.state)
                                            //                 break
                                            //         }
                                            //     }
                                            // }
                                            
                                            
                                        }
                                        Text{
                                            // id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'$120.00'
                                            font.pointSize:8
                                            color:'white'
                                            font.weight:600
                                            // color:'white'
                                            x: -5.25  ; y: 12.75
                                            // DragHandler {
                                            //     onGrabChanged:(transition, eventPoint) => {


                                            //         switch (eventPoint.state) {
                                            //             case EventPoint.Pressed:
                                            //                 console.log("on press @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Updated:
                                            //                 console.log("on update @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Released:
                                            //                 console.log("on release @", test.x," ; " ,test.y);
                                            //                 break
                                            //             default:
                                            //                 console.log(eventPoint.position, "state", eventPoint.state)
                                            //                 break
                                            //         }
                                            //     }
                                            // }
                                            
                                            
                                        }
                                        Text{
                                            id:test
                                            scale:0.5
                                            font.family:Fonts.inter
                                            text:'* * * *  * * * *  * * * *  6057'
                                            // textFormat:Text.RichText
                                            font.pointSize:6
                                            color:'white'
                                            font.weight:600
                                            // color:'white'
                                            x: -5.5  ; y: 21.75
                                            // DragHandler {
                                            //     onGrabChanged:(transition, eventPoint) => {


                                            //         switch (eventPoint.state) {
                                            //             case EventPoint.Pressed:
                                            //                 console.log("on press @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Updated:
                                            //                 console.log("on update @", eventPoint.position);
                                            //                 break
                                            //             case EventPoint.Released:
                                            //                 console.log("on release @", test.x," ; " ,test.y);
                                            //                 break
                                            //             default:
                                            //                 console.log(eventPoint.position, "state", eventPoint.state)
                                            //                 break
                                            //         }
                                            //     }
                                            // }
                                            
                                            
                                        }

                                        // scale: PathView.scale
                                        // opacity: 1
                                        z:PathView.z
                                        Rectangle{
                                            // anchors.fill:parent
                                            anchors.left:parent.left
                                            anchors.right:parent.right
                                            anchors.bottom:parent.bottom
                                            height:10
                                            // scale: parent.scale
                                            // visible:(parent.currentIndex===4 ) || (parent.currentIndex===0) ? ( Math.abs(index-parent.currentIndex)<parent.model.count/2):true
                                            z:-Infinity
                                            radius:20
                                            // color:"transparent"
                                            layer.enabled: true
                                            layer.effect: DropShadow {
                                                horizontalOffset: 0
                                                verticalOffset: 4
                                                radius: 12
                                                samples: 16
                                                color: "#27272727"
                                                z: -1
                                            }
                                        }
                                    }
                                }

                                PathView {
                                    id:pathview
                                    anchors.fill: parent
                                    model: TableModel {
                                        id:credit_card
                                        TableModelColumn {
                                            display: "icon"
                                        }
                                        TableModelColumn {
                                            display: "name"
                                        }
                                        rows:[
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                            {"icon":1 , "name":'john'},
                                        ]
                                    }
                                    delegate: delegate
                                    // pathItemCount :3
                                    // offset :1
                                    // dragMargin: 0
                                    // maximumFlickVelocity :150
                                    path: Path {
                                        // startX: show.width /2
                                        // startY: show.height * 0.35 -20
                                        startX: 120; startY: 100

                                        PathAttribute { name: "scale"; value: 2 }
                                        PathAttribute { name: "opacity"; value: 1.0 }
                                        PathAttribute { name: "z"; value:(pathview.count)-1 }

                                        // PathLine {
                                        //     x: show.width/2
                                        //     y: show.height / 2
                                        // }
                                        PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }


                                        PathAttribute { name: "scale"; value:0.1}
                                        PathAttribute { name: "opacity"; value:0.55 }
                                        PathAttribute { name: "z"; value:0 }

                                        PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }


                                        // PathLine {
                                        //     x: show.width * 0.3
                                        //     y: show.height*0.4
                                        // }
                                        // PathAttribute { name: "z"; value:(pathview.count)-2 }
                                        // PathAttribute { name: "scale"; value: 0.1 }
                                        // PathAttribute { name: "opacity"; value: 0.2 }

                                    }
                                    // property real pasti:3
                                    // property real curri:4
                                    // onCurrentIndexChanged:{
                                    //     pasti=curri
                                    //     curri=currentIndex
                                    // }
                                            property int prevIndex: 0
                                    // property int num: model.count
                                    currentIndex:0
                                    onCurrentIndexChanged: {
                                        // console.log(count-1)
                                        if(currentIndex === (count-1) && prevIndex === 0){
                                            if(dragging) interactive = false;
                                            currentIndex = 0;
                                        }
                                        else if(currentIndex === 0 && prevIndex === (count-1)){
                                            if(dragging) interactive = false;
                                            currentIndex = (count-1);
                                        }

                                        prevIndex = currentIndex

                                    }

                                    onDraggingChanged: {
                                        if (dragging === false){
                                            interactive = true
                                        }
                                    }

                                    // snapMode: PathView.SnapToItem
                                    // preferredHighlightBegin: 0.3
                                    // preferredHighlightEnd: 0.7
                                    // highlightRangeMode: PathView.StrictlyEnforceRang
                                }
                            }
                            Item{
                                Layout.fillHeight:true
                            }
                        }
                    }
                    Rectangle{
                        Layout.columnSpan:2
                        Layout.rowSpan:9
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                        ColumnLayout{
                            anchors.fill:parent
                            anchors.margins:10
                            spacing:10
                            RowLayout{
                                Layout.fillWidth:true
                                Layout.topMargin:20
                                // Layout.bottomMargin:20
                                ColumnLayout{

                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: qsTranslate('',"Transactions : ")
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 17
                                        font.weight: 900
                                        color: "#121B28"
                                        
                                    }
                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: "Here you will see your transactions history . "
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 10
                                        font.weight: 300
                                        color: "#999"
                                        
                                    }
                                }
                                Item{
                                    Layout.fillWidth:true
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 10*2
                                    height:35
                                    buttonText:"View All >>"
                                    color: "#065AD8"
                                    borderColor: "#065AD8" 
                                    textColor: "white"
                                    fontWeight:600
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Transactions.qml')
                                    }
                                }
                            }
                            Rectangle{
                                Layout.topMargin:15
                                Layout.bottomMargin:15
                                Layout.fillWidth:true
                                height:2
                                radius:1
                                color:"#eff1fc"
                            }
                            TransactionTable{
                                // Layout.fillWidth:undefined
                                id:transaction_table
                                transaction_request:{'type':"all"}
                                horizontalHeader.model:["Transaction","Name/Business","Amount","Date","Status"]
                                tableView.model:TableModel {
                                    
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

                                    // rows:[{'transaction_id': 'TRNa5wb95Hc8MFS2Yj', 'sender_account': 'b97c2142-dd36-40e1-8951-491aa4ea2143', 'receiver_account': '0c5e46c0-1661-4e1b-8091-e1831d4a3b00', 'full_name': 'Mouad Ait Ougrram', 'amount': '10.55', 'date': '2024-09-09T21:55:02.584985Z', 'status': 'completed', 'transaction_type': 'transfer', 'type': 'sent'}, {'transaction_id': 'TRNZ3uKx7MGbfoDEye', 'sender_account': '0c5e46c0-1661-4e1b-8091-e1831d4a3b00', 'receiver_account': 'b97c2142-dd36-40e1-8951-491aa4ea2143', 'full_name': 'Mouad Ait Ougrram', 'amount': '54.34', 'date': '2024-09-09T21:53:20.300615Z', 'status': 'completed', 'transaction_type': 'transfer', 'type': 'received'}]
                                }
                            }
                            Item{
                                Layout.fillHeight:true
                            }
                        }

                    }
                    Rectangle{
                        Layout.columnSpan:1
                        Layout.rowSpan:4
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                        ColumnLayout{
                            anchors.fill:parent
                            anchors.margins:10
                            spacing:10
                            RowLayout{
                                Layout.fillWidth:true
                                Layout.topMargin:20
                                // Layout.bottomMargin:20
                                ColumnLayout{

                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: qsTranslate('',"Analytics : ")
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 17
                                        font.weight: 900
                                        color: "#121B28"
                                        
                                    }
                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: "Here you will see your Analytics . "
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 10
                                        font.weight: 300
                                        color: "#999"
                                        
                                    }
                                }
                                Item{
                                    Layout.fillWidth:true
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 10*2
                                    height:35
                                    buttonText:"View All >>"
                                    color: "#065AD8"
                                    borderColor: "#065AD8" 
                                    textColor: "white"
                                    fontWeight:600
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Transactions.qml')
                                    }
                                }
                            }
                            Item{
                                Layout.fillHeight:true
                            }
                        }
                    }
                    Rectangle{
                        Layout.columnSpan:1
                        Layout.rowSpan:4
                        Layout.preferredWidth: grid.prefWidth(this)
                        Layout.preferredHeight: grid.prefHeight(this)
                        radius:10
                        ColumnLayout{
                            anchors.fill:parent
                            anchors.margins:10
                            spacing:10
                            RowLayout{
                                Layout.fillWidth:true
                                Layout.topMargin:20
                                // Layout.bottomMargin:20
                                ColumnLayout{

                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: qsTranslate('',"Notifications : ")
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 17
                                        font.weight: 900
                                        color: "#121B28"
                                        
                                    }
                                    Text {
                                        
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignLeft
                                        text: "Here you will see your notification history . "
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WordWrap
                                        font.family: Fonts.inter
                                        font.pointSize: 10
                                        font.weight: 300
                                        color: "#999"
                                        
                                    }
                                }
                                Item{
                                    Layout.fillWidth:true
                                }
                                Button_{
                                    Layout.alignment:Qt.AlignRight
                                    width:innerText.width + 10*2
                                    height:35
                                    buttonText:"View All >>"
                                    color: "#065AD8"
                                    borderColor: "#065AD8" 
                                    textColor: "white"
                                    fontWeight:600
                                    fontSize:10
                                    borderWidth:1
                                    onClicked:{
                                        stack.replaceIfReady('./views/Transactions.qml')
                                    }
                                }
                            }
                            Item{
                                Layout.fillHeight:true
                            }
                        }
                    }

                }



            }
        }
    }


}
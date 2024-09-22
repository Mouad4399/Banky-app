import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0

ColumnLayout{
    spacing:15
    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft
        text: qsTranslate('',"Choose what to do :")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.family: Fonts.inter
        font.pointSize: 10
        font.weight: 600
        color: "#444"
        
    }
    // Rectangle{
    //     height:140 + 10*2
    //     Layout.fillWidth:true
    //     color:"#eff1fc"
    //     // color:Qt.lighter("#121b28",1.5)
    //     radius:9
        RowLayout{
            // anchors.margins:10
            // // anchors.centerIn:parent
            // anchors.fill:parent
            spacing:20
            Button_{
                ButtonGroup.group: btn_Group
                width:140 + innerText.width
                // Layout.fillWidth:true
                height:140
                buttonText:"Send Money"
                fontSize: 17
                fontWeight: 900
                innerText.anchors.centerIn:undefined
                innerText.anchors.bottom:innerText.parent.bottom
                innerText.anchors.bottomMargin:20
                innerText.anchors.left:innerText.parent.left
                innerText.anchors.leftMargin:20

                textColor:checked ?"white" :"#121b28"
                property string source : 'data:image/svg+xml;utf8,<svg viewBox="-0.5 -0.5 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="Send-Dollars--Streamline-Iconoir" height="24" width="24"><desc>Send Dollars Streamline Icon: https://streamlinehq.com</desc><path d="M9.1882125 7.143129166666667c-0.9237375 -0.8526291666666668 -2.5505083333333336 -1.4457416666666667 -4.045604166666666 -1.4829250000000003m-4.0457 9.574229166666667c0.8691125000000001 1.0696916666666667 2.485054166666667 1.6797666666666666 4.0457 1.7316125m0 -11.305841666666666c-1.7789541666666668 -0.04417916666666667 -3.3714166666666667 0.6987208333333333 -3.3714166666666667 2.7278000000000002 0 3.7344333333333335 7.417020833333333 1.8672166666666667 7.417020833333333 5.601554166666667 0 2.1299916666666667 -1.9740708333333332 3.045104166666667 -4.045604166666666 2.9764875m0 -11.305841666666666V3.4086958333333337m0 13.557350000000001v2.6252583333333335" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"></path><path d="M12.655941666666667 11.5h9.247150000000001m0 0 -4.438616666666666 -4.623575000000001M21.90309166666667 11.5l-4.438616666666666 4.623575000000001" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"></path></svg>'
                ColorImage{
                    anchors.right:parent.right
                    anchors.top:parent.top
                    anchors.margins:10
                    source:parent.source
                    sourceSize.width:48
                    color:parent.checked ?"white" :"#121b28"
                }
                color: checked ?Qt.lighter("#121b28",1.8):"#eee"
                borderColor:Qt.lighter("#121b28",1.8)
                hoverColor:Qt.darker(color,1.1)
                // borderWidth:1
                checkable:true
                autoExclusive: true
                onClicked:{
                    // btn_Group.clicked(this)
                    checked=true
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
            Button_{
                ButtonGroup.group: btn_Group
                width:140 + innerText.width
                // Layout.fillWidth:true
                height:140
                buttonText:"Request Money"
                fontSize: 17
                fontWeight: 900
                innerText.anchors.centerIn:undefined
                innerText.anchors.bottom:innerText.parent.bottom
                innerText.anchors.bottomMargin:20
                innerText.anchors.left:innerText.parent.left
                innerText.anchors.leftMargin:20

                textColor:checked ?"white" :"#121b28"
                property string source : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" fill="#000000" class="bi bi-send-plus" viewBox="0 0 16 16" id="Send-Plus--Streamline-Bootstrap" height="16" width="16"><desc>Send Plus Streamline Icon: https://streamlinehq.com</desc><path d="M15.964 0.686a0.5 0.5 0 0 0 -0.65 -0.65L0.767 5.855a0.75 0.75 0 0 0 -0.124 1.329l4.995 3.178 1.531 2.406a0.5 0.5 0 0 0 0.844 -0.536L6.637 10.07l7.494 -7.494 -1.895 4.738a0.5 0.5 0 1 0 0.928 0.372zm-2.54 1.183L5.93 9.363 1.591 6.602z" stroke-width="1"></path><path d="M16 12.5a3.5 3.5 0 1 1 -7 0 3.5 3.5 0 0 1 7 0m-3.5 -2a0.5 0.5 0 0 0 -0.5 0.5v1h-1a0.5 0.5 0 0 0 0 1h1v1a0.5 0.5 0 0 0 1 0v-1h1a0.5 0.5 0 0 0 0 -1h-1v-1a0.5 0.5 0 0 0 -0.5 -0.5" stroke-width="1"></path></svg>'
                ColorImage{
                    anchors.right:parent.right
                    anchors.top:parent.top
                    anchors.margins:10
                    source:parent.source
                    sourceSize.width:48
                    color:parent.checked ?"white" :"#121b28"
                }
                // ColumnLayout{
                //     anchors.fill:parent
                //     Text {
                //         Layout.fillWidth:true
                //         Layout.alignment:Qt.AlignCenter
                //         text: qsTranslate('',"Make Payment Request")
                //         horizontalAlignment: Text.AlignHCenter
                //         wrapMode: Text.WordWrap
                //         font.family: Fonts.inter
                //         font.pointSize: 11
                //         font.weight: 700
                //         color: parent.parent.checked ?"white" :"#121b28"
                //     }
                // }
                color: checked ?Qt.lighter("#121b28",1.8):"#eee"
                borderColor:Qt.lighter("#121b28",1.8)
                hoverColor:Qt.darker(color,1.1)
                // borderWidth:1
                checkable:true
                autoExclusive: true
                onClicked:{
                    // btn_Group.clicked(this)
                    checked=true
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
            ButtonGroup {
                id:btn_Group
                // Component.onCompleted:{
                //     console.log(buttons )
                // }
                // onClicked:{
                //     console.log(checkState )
                // }
            }
        }       
    // }

    Item{
        Layout.fillHeight:true
    }
    Button_{
        enabled:btn_Group.checkedButton!==null
        enabledEffect:true
        Layout.alignment:Qt.AlignRight
        Layout.preferredWidth:innerText.width + 48*2
        height:35
        buttonText:enabled ? "Next":"Choose First !"
        disabledBgColor:"#ccc"
        color: "#065AD8"
        textColor: enabled ?"white" :"#666"
        fontWeight:600
        fontSize:10
        onClicked:{
            if(btn_Group.checkedButton.buttonText==="Send Money"){
                stepsStack.push('./PaymentFirstStep.qml',{
                    'payment_type':'Transfer'
                })
                payment_type.text=btn_Group.checkedButton.buttonText 
                payment_icon.source=btn_Group.checkedButton.source
            }
            else{
                stepsStack.push('./PaymentFirstStep.qml',{
                    'payment_type':'Request'
                })
                payment_type.text=btn_Group.checkedButton.buttonText 
                payment_icon.source=btn_Group.checkedButton.source
            }
            // console.log(btn_Group.checkedButton) 
        }
    }

}
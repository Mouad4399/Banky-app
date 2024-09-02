import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Qt.labs.qmlmodels

import Fonts 1.0
import Components 1.0

ListView {
    id: root
    function show(type=false , messageTitle="default title" ,messageBody="default body") {
        toastlistmodel.insert(0, {'type':type ?'SuccessToast':'ErrorToast' , 'messageTitle':messageTitle , 'messageBody':messageBody});
    }

    z: Infinity
    spacing: 5
    anchors.fill: parent
    anchors.bottomMargin: 10
    anchors.topMargin: 30
    verticalLayoutDirection: ListView.TopToBottom

    interactive: false

    displaced: Transition {
        NumberAnimation { properties: "x,y"; duration: 300; easing.type:Easing.InOutQuad}
    }

    focus: true


    delegate: DelegateChooser {
        role:'type'
        DelegateChoice{
            roleValue:'ErrorToast'
            delegate:Component{
                ErrorToast{
                    messageTitle:toastlistmodel.get(index) !== undefined ? toastlistmodel.get(index).messageTitle : messageTitle
                    messageBody:toastlistmodel.get(index) !== undefined ? toastlistmodel.get(index).messageBody : messageBody
                    anchors.right:parent.right
                    anchors.rightMargin:30
                }
            }
        }
        DelegateChoice{
            roleValue:'SuccessToast'
            delegate:Component{
                SuccessToast{
                    messageTitle:toastlistmodel.get(index) !== undefined ? toastlistmodel.get(index).messageTitle : messageTitle
                    messageBody:toastlistmodel.get(index) !== undefined ? toastlistmodel.get(index).messageBody : messageBody
                    anchors.right:parent.right
                    anchors.rightMargin:30
                }
            }
        }
        
    }
    ListModel {
        id: toastlistmodel
    }
    
    model: toastlistmodel
}

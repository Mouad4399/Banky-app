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
    spacing:10
    required property var search_acc_info 
    required property real amountToPay 
    required property string description 
    required property string transaction_id 
    objectName:'PaymentSucceeded'

    Rectangle{
        height:250
        Layout.fillWidth:true
        color:"#eff1fc"
        radius:9
        // border.width:1
        // border.color:"#121b28"
        ColumnLayout{
            anchors.fill:parent
            anchors.margins:15
            spacing:10
            Item{
                Layout.fillHeight:true
            }
            ColorImage{
                source:'data:image/svg+xml;uft8,<svg class="svg-icon" style="width: 1.0009765625em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M510.580623 0C228.585279 0 0 228.591529 0 510.575623c0 281.966594 228.585279 510.550623 510.580623 510.550623 281.975344 0 510.561873-228.585279 510.561873-510.550623C1021.139997 228.591529 792.555967 0 510.580623 0M510.580623 996.232466c-268.234077 0-485.674343-217.440265-485.674343-485.656843 0-268.214077 217.440265-485.665593 485.674343-485.665593 268.230327 0 485.665593 217.446515 485.665593 485.665593C996.249966 778.789701 778.810951 996.232466 510.580623 996.232466"  /><path d="M807.964736 335.90416c-5.716257-5.712507-15.657519-5.712507-21.373776 0L425.004269 697.505851 263.617822 536.119404c-5.628757-5.633757-15.455019-5.623757-21.073776 0-2.818753 2.818753-4.368755 6.562508-4.377505 10.540013 0 3.987505 1.553752 7.726259 4.368755 10.547513L414.750506 729.42339c2.810003 2.815003 6.560008 4.368755 10.547513 4.368755 3.642504 0 7.085009-1.295002 10.110012-4.036255l372.556705-372.462955C813.857243 351.384179 813.857243 341.801667 807.964736 335.90416"  /></svg>'
                sourceSize.width:100
                color:'#1fbf79'
                Layout.alignment:Qt.AlignCenter
            }
            Text {
                Layout.alignment:Qt.AlignCenter
                text: qsTranslate('',"Money Sent")
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                font.family: Fonts.inter
                font.pointSize: 22
                font.weight: 900
                color: "#121b28"
            }
            Text {
                // Layout.fillWidth: 
                Layout.preferredWidth:parent.width
                Layout.alignment:Qt.AlignCenter
                textFormat: Text.RichText
                text: "Payment <b>"+transaction_id+"</b> of <b>USD "+Number(amountToPay).toLocaleString(Qt.locale())+" $</b> was sent to <b>"+search_acc_info.full_name+"</b>"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                font.family: Fonts.inter
                font.pointSize: 10
                font.weight: 600
                color: "#444"
            }

            Item{
                Layout.fillHeight:true
            }
        }
    }

}
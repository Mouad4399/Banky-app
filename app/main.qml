import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtCharts 
import QtQuick.Templates as T
ApplicationWindow{
    id:root_app
    width:942
    height:525
    visible:false
    title:"Banky"
    Loader {
        id: mainLoader
        source:current_view
    }

}
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
    // property variant l : {'dummyKey':''}
    // Component.onCompleted:{
    //     // var l = root_app.l;
    //     // var l ={};
    //     // delete l.h;
    //     l['d']='dd'
    //     console.log(l['d'])
    //     // console.log(JSON.stringify(l))
    // }
    Loader {
        id: mainLoader
        source:current_view
    }

}
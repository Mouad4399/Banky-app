import QtQuick 2.15
pragma Singleton
Item {

    property var inter: interVarFont.name
    
    FontLoader{id:interVarFont ;source: "Inter.ttf" }

}

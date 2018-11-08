import QtQuick 2.0
Item{

    Rectangle{
       id: menuRectangle
       width: window.width
       height: window.height/16
       anchors.top: window.top
       color: "#6f6d6d"

       Rectangle{
           id: quotesRectangle
           width: menuRectangle.width/3
           height: menuRectangle.height
           anchors.top: menuRectangle.top
           anchors.left: menuRectangle.left
           color: menuRectangle.color
           Text{
               id: quotesText
               text: "Quotes"
               color: "white"
               font.family: "Sylfaen"
               font.pixelSize: 18
               anchors.horizontalCenter: quotesRectangle.horizontalCenter
           }
           MouseArea {
               anchors.fill: quotesRectangle
               onClicked: {
                     mediator.sendRequest();
                     stack.push(quote)
               }
               onPressed: quotesRectangle.color = "#8f8b8b"
               onReleased: quotesRectangle.color = "6f6d6d"
           }
      }

       Rectangle{
           id: picturesRectangle
           width: menuRectangle.width/3
           height: menuRectangle.height
           anchors.top: menuRectangle.top
           anchors.left: quotesRectangle.right
           color: menuRectangle.color
           Text{
               id: picturesText
               text: "Pictures"
               color: "white"
               font.family: "Sylfaen"
               font.pixelSize: 18
               anchors.horizontalCenter: picturesRectangle.horizontalCenter
           }
           MouseArea {
               anchors.fill: picturesRectangle
               onClicked: {
                   //stack.pop()
                   //stack.push(reactiveImage)
               }
               onPressed: picturesRectangle.color = "#8f8b8b"
               onReleased: picturesRectangle.color = "#6f6d6d"
           }
           Rectangle {
               id: borderBottom2
               width: parent.width
               height: 2
               anchors.bottom: parent.bottom
               color: "white"
           }
       }

       Rectangle{
           id: favouritesRectangle
           width: menuRectangle.width/3
           height: menuRectangle.height
           anchors.top: menuRectangle.top
           anchors.left: picturesRectangle.right
           color: menuRectangle.color
           Text{
               id: favouritesText
               text: "Favourites Quotes"
               color: "white"
               font.family: "Sylfaen"
               font.pixelSize: 18
               anchors.horizontalCenter: favouritesRectangle.horizontalCenter
           }
           MouseArea {
               anchors.fill: favouritesRectangle
               onClicked: {
                   //stack.pop()
                   stack.push(favorites)
               }
               onPressed: favouritesRectangle.color = "#8f8b8b"
               onReleased: favouritesRectangle.color = "#6f6d6d"
           }
       }
    }

////////////////////////////2nd menu/////////////////////////////////////////////////////
    Rectangle{
           id: heartMenu
           width: window.width
           height: window.height/16
           anchors.top: menuRectangle.bottom
           color: "#757373"

           Image{
               id: heartImage
               anchors.top: heartMenu.top
               anchors.bottom: heartMenu.bottom
               anchors.right: heartMenu.right
               anchors.rightMargin: window.width/50
               fillMode: Image.PreserveAspectFit
           }
        }

/////////////////////////////end of menu/////////////////////////////////////////////////


    Rectangle{
        id: imageShow
        width: window.width
        height: window.height/1.14
        anchors.top: heartMenu.bottom
        anchors.left: heartMenu.left
        anchors.right: heartMenu.right
        anchors.bottom: window.bottom

        Image{
             id: backGroundImage
             source: "background1.jpg"
             anchors.fill: imageShow
        }

        Image {
             id: thisImage
             source: "image://images"
             anchors.fill: parent
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.topMargin: 20
             anchors.leftMargin: 20
             anchors.bottomMargin: 20
             anchors.rightMargin: 20
             Rectangle {
                 anchors.fill: parent
                 color: "transparent"
                 border.width: 1
                 border.color: "#6f6d6d"
             }
         }
         MouseArea {
             anchors.fill: parent
             onClicked: {
                 thisImage.source= "image://images/" + Math.random(1000);
             }
         }
     }
}

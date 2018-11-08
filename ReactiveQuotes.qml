import QtQuick 2.0

Item {
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
                   //mediator.sendRequest();
                   //contentText.text=mediator.mContent();
                   //titleText.text=mediator.mTitle();
                   //stack.push(quote)
               }
               onPressed: quotesRectangle.color = "#8f8b8b"
               onReleased: quotesRectangle.color = "#6f6d6d"
           }
           Rectangle {
                id: borderBottom
                width: parent.width
                height: 2
                anchors.bottom: parent.bottom
                color: "white"
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
                   stack.push(reactiveImage)
               }
               onPressed: picturesRectangle.color = "#8f8b8b"
               onReleased: picturesRectangle.color = "#6f6d6d"
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
//    Rectangle {
//             id: borderBottom
//             width: quotesRectangle.width
//             height: 2
//             anchors.bottom: quotesRectangle.bottom
//             color: "white"
//    }
    Rectangle{
       id: heartMenu
       width: parent.width
       height: window.height/16
       anchors.top: menuRectangle.bottom
       color: "#757373"

       Image{
           id: heartImage
           source: "hearts/heart1.png"
           property int heart: 1
           anchors.top: heartMenu.top
           anchors.bottom: heartMenu.bottom
           anchors.right: heartMenu.right
           anchors.rightMargin: window.width/50
           fillMode: Image.PreserveAspectFit
           MouseArea {
               anchors.fill: heartImage
               onClicked: {
                   if(heartImage.heart==1){
                       heartImage.source = "hearts/heart2.png"
                       mediator.insertQuote(mediator.mContent(),mediator.mTitle())
                       heartImage.heart=2;
                   }
                   else{
                       heartImage.source = "hearts/heart1.png"
                       mediator.removeLastQuote()
                       heartImage.heart=1;
                   }
               }
           }
       }
    }
//////////////////////////////////end of menu////////////////////////////////////////////
    Rectangle{
        width: window.width
        height: window.height/1.14
        id: quoteShow
        anchors.top: heartMenu.bottom
        anchors.left: heartMenu.left
        anchors.right: heartMenu.right
        Image{
             id: backGroundImage
             source: "background1.jpg"
             anchors.fill: quoteShow
        }
        Text{
             id: contentText
             text:  mediator.mContent()
             font.family: "Maiandra GD"
             verticalAlignment: Text.AlignVCenter
             horizontalAlignment: Text.AlignHCenter
             styleColor: "#5c5a5a"
             anchors.top: quoteShow.top
             anchors.right: quoteShow.right
             anchors.left: quoteShow.left

             anchors.topMargin: window.height/5
             anchors.leftMargin: window.width/8
             anchors.rightMargin: window.width/8

             width: window.width
             color: "#494646"
             wrapMode: Text.WordWrap
             font.pointSize: 16
        }

        Text {
            id: titleText
            color: "#555252"
            text: mediator.mTitle()
            font.family: "Maiandra GD"
            font.bold: true
            font.italic: true
            font.pointSize: 13
            anchors.top: contentText.bottom
            anchors.right: quoteShow.right
            anchors.bottom: quoteShow.bottom

            anchors.topMargin: window.height/12
            anchors.rightMargin: window.width/7
            wrapMode: Text.WordWrap
        }

        MouseArea {
             anchors.fill: quoteShow
             onClicked: {
                   mediator.sendRequest();
                   contentText.text=mediator.mContent();
                   titleText.text=mediator.mTitle();
                   heartImage.source = "hearts/heart1.png"
              }
          }
        }

}

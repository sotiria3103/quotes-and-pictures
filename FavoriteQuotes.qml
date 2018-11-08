import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.1

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
                   mediator.sendRequest();
                   //stack.pop()
                   stack.push(quote)
               }
               onPressed: quotesRectangle.color = "#8f8b8b"
               onReleased: quotesRectangle.color = "#6f6d6d"
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
                    // stack.push(favorites)
               }
               onPressed: favouritesRectangle.color = "#8f8b8b"
               onReleased: favouritesRectangle.color = "#6f6d6d"
           }
           Rectangle {
               id: borderBottom
               width: parent.width
               height: 2
               anchors.bottom: parent.bottom
               color: "white"
               }
       }

    }

    ////////////////////////////end of menu/////////////////////////////////////////////

    Rectangle{
       id: deleteMenu
       width: window.width
       height: window.height/16
       anchors.top: menuRectangle.bottom
       color: "#757373"
       Image{
           id: binImage
           source: "bin.png"
           anchors.top: deleteMenu.top
           anchors.bottom: deleteMenu.bottom
           anchors.right: deleteMenu.right
           anchors.rightMargin: window.width/50
           fillMode: Image.PreserveAspectFit
           MouseArea {
               anchors.fill: binImage
                onClicked: mediator.removeQuote(myview.currentIndex);
            }
        }
    }
    Rectangle{
            width: window.width
            height: window.height/1.14
            id: favourteQuotesRectangle
            anchors.top: deleteMenu.bottom
            anchors.bottom: window.bottom
            anchors.left: window.left
            anchors.right: window.right

    RowLayout{
        anchors.fill: favourteQuotesRectangle
        anchors.margins: 10
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color:"#e0e0e0"

            ListView{
                id:myview
                anchors.fill:parent
                anchors.margins:5
                model:mediator.myModel
                highlight: Rectangle{
                    color:"#bbcacc"
                }
                delegate: myDelegate
                focus:true
                clip:true
            }
        }
        Component{
            id:myDelegate
            Item{
                width:myview.width
                height:myview.height/6
                RowLayout{
                    id: rowLayout
                    anchors.fill: parent

                    Text{
                            id: qtitleText
                            text: qtitle //the name of the person who said/wrote the quote
                            Layout.preferredWidth: parent.width/75

                            anchors.left: window.left
                            anchors.leftMargin: window/20
                            verticalAlignment: Text.AlignVCenter

                            font.family: "Bookman Old Style"
                            font.bold: true

                            color: "#494646"
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            Layout.fillWidth: true
                    }

                    Text{
                            id: contentText
                            text: content //this is the quote
                            Layout.preferredWidth: parent.width/25

                            anchors.left: qtitleText.right
                            anchors.right: window.right
                            verticalAlignment: "AlignVCenter"

                            color: "#555252"
                            font.family: "Bookman Old Style"
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        myview.currentIndex = index

                    }

                }
            }
        }
    }
}
}

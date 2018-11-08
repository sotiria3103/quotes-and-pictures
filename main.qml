import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Window {
    visible: true
    width: 640
    height: 480
    id:window
    title: qsTr("Make my day!")

        Component
        {
            id:reactiveImage;
            ReactiveImages {}
        }
        Component
        {
            id:favorites;
            FavoriteQuotes {}
        }
        Component
        {
            id:quote;
            ReactiveQuotes {}
        }
        StackView
        {
            anchors.fill: parent
            initialItem: quote
            id: stack
        }

}

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: window
    width: 800
    height: 600
    visible: true
    color: "#434040"
    title: qsTr("Text Tools")

    Rectangle{
        id: welcomePage
        width: window.width
        height: window.height
        color: "#333333"

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true

            onClicked: mouse.accepted = false
            onPressed:{
                console.log("click")
                welcomePageFadeOut.start()
                mouse.accepted = false
            }
            onReleased: mouse.accepted = false
            onDoubleClicked: mouse.accepted = false
            onPositionChanged: mouse.accepted = false
            onPressAndHold: mouse.accepted = false
        }

        OpacityAnimator {
            id: welcomePageFadeIn
            target: welcomePage
            from: 0
            to: 1
            duration: 1000
            running: true
        }

        OpacityAnimator {
            id: welcomePageFadeOut
            target: welcomePage
            from: welcomePage.opacity
            to: 0
            duration: 700
            onStarted: {
                swipeView.visible = true
                swipeViewFadeOut.start()
            }

            onFinished: {
                welcomePage.visible = false
            }
        }

        Text {
            id: text1
            color: "#f0e2e2"
            text: qsTr("Hello World!")
            font.pixelSize: 34
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            transformOrigin: Item.Center
            font.italic: true
            font.weight: Font.ExtraBold
            anchors.fill: parent
        }
    }

    SwipeView {
        id: swipeView
        width: window.width
        height: window.height
        visible: false
        opacity: 0

        OpacityAnimator {
            id: swipeViewFadeOut
            target: swipeView
            from: 0
            to: 1
            duration: 700
        }

        Item{
            id: mainPage
            width: swipeView.width
            height: swipeView.height

            Rectangle{
                width: mainPage.width
                height: mainPage.height
                color: "#333333"

                Text {
                    id: text2
                    color: "#f0e2e2"
                    text: qsTr("Text Tools")
                    font.pixelSize: 34
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    transformOrigin: Item.Center
                    font.italic: true
                    font.weight: Font.ExtraBold
                    anchors.fill: parent
                }
            }
        }
    }
}

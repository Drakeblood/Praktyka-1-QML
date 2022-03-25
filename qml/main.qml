import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import Praktyka.TextTools 1.0;

Window {
    id: window
    width: 700
    height: 400
    visible: true
    color: "#434040"
    title: qsTr("Text Tools")

    TextTools{
        id: textTools
    }

    Connections{
        target: textTools
        function onResultTextAreaTextChanged() {
            busyIndicator.running = false
            swipeView.setCurrentIndex(1);
        }
    }

    Rectangle {
        id: welcomePage
        width: window.width
        height: window.height
        color: "#333322"

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true

            onPressed: {
                welcomePageFadeOut.start()
                mouse.accepted = false
            }
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
            duration: 1000
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
            duration: 1000
        }

        Item {
            id: mainPage
            width: swipeView.width
            height: swipeView.height

            Rectangle {
                width: mainPage.width
                height: mainPage.height
                color: "#333333"

                Rectangle {
                    id: textAreaHolder;
                    width: 400
                    height: 100
                    color: "#FFFFFF"
                    radius: 20
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 50

                    ScrollView {
                        anchors.fill: parent

                        TextArea {
                            id: textArea
                            width: textAreaHolder.width
                            height: textAreaHolder.height
                            placeholderTextColor: "#333333"
                            wrapMode: TextEdit.Wrap
                            textMargin: 10.10
                        }
                    }
                }

                GroupBox{
                    id: radioButtonsGroup
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    background: Rectangle{
                        color: "white"
                        radius: 20
                    }

                    RowLayout{

                        RadioButton {
                            checked: true
                            text: "Reverse"
                            onClicked: {
                                textTools.textProcessMethod = TextTools.Reverse
                            }
                        }

                        RadioButton {
                            text: "Lower Case"
                            onClicked: {
                                textTools.textProcessMethod = TextTools.LowerCase
                            }
                        }

                        RadioButton {
                            text: "Upper Case"
                            onClicked: {
                                textTools.textProcessMethod = TextTools.UpperCase
                            }
                        }
                    }
                }

                BusyIndicator {
                    id: busyIndicator
                    width: 50
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 100
                    running: false
                    palette.dark: "white"
                }

                Button {
                    id: processButton
                    width: 100
                    text: qsTr("Process")
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 50
                    background: Rectangle{
                        radius: 20
                    }
                    onClicked: {
                        textTools.inputTextAreaText = textArea.text
                        textTools.processText();
                        busyIndicator.running = true
                    }
                }
            }
        }

        Item {
            id: resultPage
            width: swipeView.width
            height: swipeView.height

            Rectangle {
                width: mainPage.width
                height: mainPage.height
                color: "#333333"

                Rectangle {
                    id: resultTextAreaHolder;
                    width: 400
                    height: 100
                    color: "#FFFFFF"
                    radius: 20
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 50

                    ScrollView {
                        anchors.fill: parent

                        TextArea {
                            id: resultTextArea
                            width: textAreaHolder.width
                            height: textAreaHolder.height
                            placeholderTextColor: "#333333"
                            wrapMode: TextEdit.Wrap
                            textMargin: 10.10
                            readOnly: true
                            text: textTools.resultTextAreaText
                        }
                    }
                }
            }
        }
    }
}

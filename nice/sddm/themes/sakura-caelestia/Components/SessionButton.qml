// Config created by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
// Copyright (C) 2022-2025 Keyitdev
// Based on https://github.com/MarianArlt/sddm-sugar-dark
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: sessionButton

    height: root.font.pointSize
    width: parent.width / 2
    
    property var selectedSession: selectSession.currentIndex
    property string textConstantSession
    property int loginButtonWidth
    property ComboBox exposeSession: selectSession

    ComboBox {
        id: selectSession

        // important
        // change also in errorMessage
        height: root.font.pointSize * 2.8
        width: Math.max(displayedItem.implicitWidth + 96, 280)
        anchors.horizontalCenter: parent.horizontalCenter

        hoverEnabled: true
        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"
        
        Keys.onPressed: function(event) {
            if ((event.key == Qt.Key_Left || event.key == Qt.Key_Right) && !popup.opened) {
                popup.open();
            }
        }

        delegate: ItemDelegate {
            // minus padding
            width: popupHandler.width - 20
            anchors.horizontalCenter: popupHandler.horizontalCenter
            
            contentItem: Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: model.name
                font.pointSize: root.font.pointSize * 0.8
                font.family: root.font.family
                color: config.DropdownTextColor
            }
            
            background: Rectangle {
                color: selectSession.highlightedIndex === index ? config.DropdownSelectedBackgroundColor : "transparent"
            }
        }

        indicator {
            visible: false
        }

        contentItem: Item {
            anchors.fill: parent

            Row {
                id: displayedItem

                anchors.centerIn: parent
                spacing: root.font.pointSize * 0.45

                Text {
                    id: sessionIcon

                    text: "desktop_windows"
                    font.family: root.iconFontFamily
                    font.pixelSize: root.font.pointSize * 1.35
                    font.variableAxes: ({ "FILL": 0, "GRAD": 0, "opsz": 24, "wght": 400 })
                    color: config.SessionButtonTextColor
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    id: sessionText

                    text: (config.TranslateSessionSelection || "Session") + " (" + selectSession.currentText + ")"
                    color: config.SessionButtonTextColor
                    font.pointSize: root.font.pointSize * 0.9
                    font.family: root.font.family
                    verticalAlignment: Text.AlignVCenter
                }

                Keys.onReleased: selectSession.popup.open()
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: config.FormBackgroundColor
            border.color: parent.visualFocus ? config.HighlightBorderColor : config.FormBorderColor
            border.width: 1
            radius: config.FormBorderRadius / 2
        }

        popup: Popup {
            id: popupHandler

            implicitHeight: contentItem.implicitHeight
            width: sessionButton.width
            y: parent.height - 1
            x: -popupHandler.width / 2 + selectSession.width / 2
            padding: 10

            contentItem: ListView {
                implicitHeight: contentHeight + 20

                clip: true
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                radius: config.RoundCorners / 2
                color: config.DropdownBackgroundColor
                layer.enabled: true
            }

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1 }
            }
        }

        states: [
            State {
                name: "pressed"
                when: selectSession.down
                PropertyChanges {
                    target: sessionText
                    color: Qt.darker(config.HoverSessionButtonTextColor, 1.1)
                }
                PropertyChanges {
                    target: sessionIcon
                    color: Qt.darker(config.HoverSessionButtonTextColor, 1.1)
                }
            },
            State {
                name: "hovered"
                when: selectSession.hovered
                PropertyChanges {
                    target: sessionText
                    color: Qt.lighter(config.HoverSessionButtonTextColor, 1.1)
                }
                PropertyChanges {
                    target: sessionIcon
                    color: Qt.lighter(config.HoverSessionButtonTextColor, 1.1)
                }
            },
            State {
                name: "focused"
                when: selectSession.visualFocus
                PropertyChanges {
                    target: sessionText
                    color: config.HoverSessionButtonTextColor
                }
                PropertyChanges {
                    target: sessionIcon
                    color: config.HoverSessionButtonTextColor
                }
            }
        ]
        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color"
                    duration: 150
                }
            }
        ]

    }

}

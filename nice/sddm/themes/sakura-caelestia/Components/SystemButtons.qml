// Config created by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
// Copyright (C) 2022-2025 Keyitdev
// Based on https://github.com/MarianArlt/sddm-sugar-dark
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {

    spacing: root.font.pointSize

    property var shutdown: ["Shutdown", config.TranslateShutdown || textConstants.shutdown, sddm.canPowerOff]
    property var reboot: ["Reboot", config.TranslateReboot || textConstants.reboot, sddm.canReboot]
    property var suspend: ["Suspend", config.TranslateSuspend || textConstants.suspend, sddm.canSuspend]
    property var hibernate: ["Hibernate", config.TranslateHibernate || textConstants.hibernate, sddm.canHibernate]
    property var iconNames: ["power_settings_new", "restart_alt", "bedtime", "dark_mode"]

    property ComboBox exposedSession

    Repeater {
        id: systemButtons
        
        model: [shutdown, reboot, suspend, hibernate]

        RoundButton {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: root.font.pointSize * 6.5

            contentItem: Column {
                spacing: 4

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: systemButtons.iconNames[index]
                    font.family: root.iconFontFamily
                    font.pixelSize: root.font.pointSize * 2.2
                    font.variableAxes: ({ "FILL": 0, "GRAD": 0, "opsz": 24, "wght": 400 })
                    color: parent.parent.activeFocus || parent.parent.hovered ? config.HoverSystemButtonsIconsColor : config.SystemButtonsIconsColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData[1]
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.72
                    color: parent.parent.activeFocus || parent.parent.hovered ? config.HoverSystemButtonsIconsColor : config.SystemButtonsIconsColor
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            visible: config.HideSystemButtons != "true" && (config.BypassSystemButtonsChecks == "true" ? 1 : modelData[2])
            hoverEnabled: true
            palette.buttonText: config.SystemButtonsIconsColor
            
            background: Rectangle {
                height: 2
                width: parent.width

                color: "transparent"
            }

            Keys.onReturnPressed: clicked()
            onClicked: {
                parent.forceActiveFocus()
                index == 0 ? sddm.powerOff() : index == 1 ? sddm.reboot() : index == 2 ? sddm.suspend() : sddm.hibernate()
            }
            KeyNavigation.left: index > 0 ? parent.children[index-1] : null
            
            states: [
                State {
                    name: "pressed"
                    when: parent.children[index].down
                    PropertyChanges {
                        target: parent.children[index].contentItem.children[0]
                        color: root.palette.buttonText
                        palette.buttonText: Qt.darker(root.palette.buttonText, 1.1)
                    }
                },
                State {
                    name: "hovered"
                    when: parent.children[index].hovered
                    PropertyChanges {
                        target: parent.children[index].contentItem.children[0]
                        color: root.palette.buttonText
                        palette.buttonText: Qt.lighter(root.palette.buttonText, 1.1)
                    }
                },
                State {
                    name: "focused"
                    when: parent.children[index].activeFocus
                    PropertyChanges {
                        target: parent.children[index].contentItem.children[0]
                        color: root.palette.buttonText
                        palette.buttonText: root.palette.buttonText
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, palette.buttonText, border.color"
                        duration: 150
                    }
                }
            ]

        }

    }

}

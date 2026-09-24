// Config created by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
// Copyright (C) 2022-2025 Keyitdev
// Based on https://github.com/MarianArlt/sddm-sugar-dark
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    spacing: root.font.pointSize * 0.9
    property var sessionSelect
    SDDM.TextConstants { id: textConstants }

    property int p: config.ScreenPadding == "" ? 0 : config.ScreenPadding
    property string a: config.FormPosition

    Input {
        id: input

        Layout.alignment: Qt.AlignVCenter
        Layout.preferredHeight: root.font.pointSize * 18
        Layout.leftMargin: p != "0" ? a == "left" ? -p : a == "right" ? p : 0 : 0
        Layout.topMargin: root.font.pointSize * 1.5
    }

    SystemButtons {
        id: systemButtons

        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.preferredHeight: root.font.pointSize * 5
        Layout.maximumHeight: root.font.pointSize * 5
        Layout.leftMargin: p != "0" ? a == "left" ? -p : a == "right" ? p : 0 : 0
        
        exposedSession: input.exposeSession
    }
    
    VirtualKeyboardButton {
        id: virtualKeyboardButton

        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.preferredHeight: root.height / 27
        Layout.maximumHeight: root.height / 27
        Layout.leftMargin: p != "0" ? a == "left" ? -p : a == "right" ? p : 0 : 0
    }
}

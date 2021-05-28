import "components"

import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

SessionManagementScreen {
    property bool showUsernamePrompt: !showUserList
    property int usernameFontSize
    property int fontSize: parseInt(config.fontSize)
    property string usernameFontColor
    property string lastUserName
    property bool passwordFieldOutlined: config.PasswordFieldOutlined == "true"
    property bool hidePasswordRevealIcon: config.HidePasswordRevealIcon == "false"
    property int visibleBoundary: mapFromItem(loginButton, 0, 0).y
    onHeightChanged: visibleBoundary = mapFromItem(loginButton, 0, 0).y + loginButton.height + units.smallSpacing

    signal loginRequest(string username, string password)

    onShowUsernamePromptChanged: {
        if (!showUsernamePrompt) {
            lastUserName = ""
        }
    }

    function startLogin() {
        var username = showUsernamePrompt ? userNameInput.text : userList.selectedUser
        var password = passwordBox.text

        loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    PlasmaComponents.TextField {
        id: userNameInput
        Layout.fillWidth: true
        font.pointSize: fontSize + 1
        opacity: 1.0
        text: lastUserName
        visible: showUsernamePrompt
        focus: showUsernamePrompt && !lastUserName //if there's a username prompt it gets focus first, otherwise password does
        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Username")

        style: TextFieldStyle {
            textColor: "white"
            placeholderTextColor: "white"
            background: Rectangle {
                radius: 3
                border.color: "#0078D4"
                border.width: 2
                color: "#3d3d3d"
            }
        }
    }

    PlasmaComponents.TextField {
        id: passwordBox
        Layout.fillWidth: true
        font.pointSize: fontSize + 1
        opacity: passwordFieldOutlined ? 1.0 : 1.0
        placeholderText: config.PasswordFieldPlaceholderText == "Password" ? i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Password") : config.PasswordFieldPlaceholderText
        focus: !showUsernamePrompt || lastUserName
        echoMode: TextInput.Password
        revealPasswordButtonShown: hidePasswordRevealIcon
        onAccepted: startLogin()

        style: TextFieldStyle {
            textColor: passwordFieldOutlined ? "white" : "white"
            placeholderTextColor: passwordFieldOutlined ? "white" : "white"
            passwordCharacter: config.PasswordFieldCharacter == "" ? "●" : config.PasswordFieldCharacter
            background: Rectangle {
                radius: 3
                border.color: "#0078D4"
                border.width: 2
                color: "#3d3d3d"
            }
        }

        Keys.onEscapePressed: {
            mainStack.currentItem.forceActiveFocus();
        }

        Keys.onPressed: {
            if (event.key == Qt.Key_Left && !text) {
                userList.decrementCurrentIndex();
                event.accepted = true
            }
            if (event.key == Qt.Key_Right && !text) {
                userList.incrementCurrentIndex();
                event.accepted = true
            }
        }

        Keys.onReleased: {
            if (loginButton.opacity == 0 && length > 0) {
                showLoginButton.start()
            }
            if (loginButton.opacity > 0 && length == 0) {
                hideLoginButton.start()
            }
        }

        Connections {
            target: sddm
            onLoginFailed: {
                passwordBox.selectAll()
                passwordBox.forceActiveFocus()
            }
        }
    }

    Image {
        id: loginButton
        source: "assets/login.svgz"
        smooth: true
        sourceSize: Qt.size(passwordBox.height, passwordBox.height)
        anchors {
            left: passwordBox.right
            verticalCenter: passwordBox.verticalCenter
        }
        anchors.leftMargin: 8
        visible: opacity > 0
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: startLogin();
        }
        PropertyAnimation {
            id: showLoginButton
            target: loginButton
            properties: "opacity"
            to: 0.75
            duration: 100
        }
        PropertyAnimation {
            id: hideLoginButton
            target: loginButton
            properties: "opacity"
            to: 0
            duration: 80
        }
    }
}

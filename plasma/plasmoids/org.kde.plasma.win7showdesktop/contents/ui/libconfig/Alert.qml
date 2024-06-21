// Version 2

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

// Based on Bootstrap's alerts
// https://getbootstrap.com/docs/4.6/components/alerts/
Rectangle {
	id: alertItem
	Layout.fillWidth: true
	property int horPadding: 4 * Screen.devicePixelRatio
	property int vertPadding: 4 * Screen.devicePixelRatio
	implicitHeight: vertPadding + alertLabel.implicitHeight + vertPadding
	clip: true
	border.width: 2
	radius: 5 * Screen.devicePixelRatio

	enum AlertType {
		Positive,
		Information,
		Warning,
		Error
	}
	property int messageType: Alert.AlertType.Warning

	color: {
		if (messageType == Alert.AlertType.Information) { return "#d9edf7"
		} else if (messageType == Alert.AlertType.Warning) { return "#fcf8e3"
		} else if (messageType == Alert.AlertType.Error) { return "#f2dede"
		} else { /* Positive */ return "#dff0d8" }
	}
	border.color: {
		if (messageType == Alert.AlertType.Information) { return "#bcdff1"
		} else if (messageType == Alert.AlertType.Warning) { return "#faf2cc"
		} else if (messageType == Alert.AlertType.Error) { return "#ebcccc"
		} else { /* Positive */ return "#d0e9c6" }
	}
	property color labelColor: {
		if (messageType == Alert.AlertType.Information) { return "#31708f"
		} else if (messageType == Alert.AlertType.Warning) { return "#8a6d3b"
		} else if (messageType == Alert.AlertType.Error) { return "#a94442"
		} else { /* Positive */ return "#3c763d" }
	}

	property alias icon: alertIcon
	Kirigami.Icon {
		id: alertIcon
		visible: false

		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: alertItem.horPadding
		width: alertLabel.fontInfo.pixelSize
		height: alertLabel.fontInfo.pixelSize

		source: {
			if (messageType == Alert.AlertType.Information) { return "dialog-information-symbolic"
			} else if (messageType == Alert.AlertType.Warning) { return "dialog-warning-symboli"
			} else if (messageType == Alert.AlertType.Error) { return "dialog-error-symbolic"
			} else { /* Positive */ return "dialog-ok-symbolic" }
		}
	}

	property alias label: alertLabel
	property alias text: alertLabel.text
	property alias wrapMode: alertLabel.wrapMode
	property alias maximumLineCount: alertLabel.maximumLineCount
	QQC2.Label {
		id: alertLabel
		wrapMode: Text.Wrap
		color: alertItem.labelColor
		linkColor: Kirigami.Theme.highlightColor

		elide: Text.ElideRight
		QQC2.ToolTip.visible: alertLabel.truncated
		QQC2.ToolTip.text: alertLabel.text

		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: alertItem.horPadding + (alertIcon.visible ? (alertIcon.width + alertItem.horPadding) : 0)
		anchors.right: parent.right
		anchors.rightMargin: alertItem.horPadding

		function onLinkActivated(link) {
			Qt.openUrlExternally(link)
		}

		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
			cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
		}
	}
}
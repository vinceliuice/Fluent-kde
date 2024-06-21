import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

import ".." as Widget
import "../libconfig" as LibConfig


LibConfig.FormKCM {
	id: page

	property string cfg_click_action: 'showdesktop'
	property alias cfg_click_command: click_command.text

	property string cfg_mousewheel_action: 'run_commands'
	property alias cfg_mousewheel_up: mousewheel_up.text
	property alias cfg_mousewheel_down: mousewheel_down.text

	property int indentWidth: 24 * Screen.devicePixelRatio

	Widget.AppletConfig {
		id: config
	}

	Widget.PanelMargins {
		id: panelMargins
	}

	function setClickCommand(command) {
		cfg_click_action = 'run_command'
		clickGroup_runcommand.checked = true
		cfg_click_command = command
	}

	function setMouseWheelCommands(up, down) {
		cfg_mousewheel_action = 'run_commands'
		mousewheelGroup_runcommands.checked = true
		cfg_mousewheel_up = up
		cfg_mousewheel_down = down
	}

	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Look")
		useThickTopMargin: false
		label.Layout.topMargin: 0
	}

	RowLayout {
		Kirigami.FormData.label: i18n("Size:")
		LibConfig.SpinBox {
			id: sizeSpinBox
			configKey: 'size'
			suffix: i18n("px")
			from: 4 // Mouse Events are ignored with sizes smaller than 4px (Issue #26)
		}
		QQC2.Label {
			readonly property int buttonTotalSize: sizeSpinBox.value + panelMargins.panelEdgeMargin
			text: i18n(" + %1px (Panel Margin) = %2px", panelMargins.panelEdgeMargin, buttonTotalSize)
		}
	}

	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("Edge Color:")
		configKey: 'edgeColor'
	}

	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("Hovered Color:")
		configKey: 'hoveredColor'
	}

	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("Pressed Color:")
		configKey: 'pressedColor'
	}



	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Click")
	}

	LibConfig.RadioButtonGroup {
		id: clickGroup
		spacing: 2 * Screen.devicePixelRatio
		Kirigami.FormData.isSection: true

		QQC2.RadioButton {
			text: i18nd("plasma_applet_org.kde.plasma.showdesktop", "Show Desktop")
			QQC2.ButtonGroup.group: clickGroup.group
			checked: cfg_click_action == 'showdesktop'
			onClicked: cfg_click_action = 'showdesktop'
		}
		QQC2.RadioButton {
			text: i18ndc("plasma_applet_org.kde.plasma.showdesktop", "@action", "Minimize All Windows")
			QQC2.ButtonGroup.group: clickGroup.group
			checked: cfg_click_action == 'minimizeall'
			onClicked: cfg_click_action = 'minimizeall'
		}
		QQC2.RadioButton {
			id: clickGroup_runcommand
			text: i18n("Run Command")
			QQC2.ButtonGroup.group: clickGroup.group
			checked: cfg_click_action == 'run_command'
			onClicked: cfg_click_action = 'run_command'
		}
		RowLayout {
			Layout.fillWidth: true
			Text { width: indentWidth } // indent
			QQC2.TextField {
				Layout.fillWidth: true
				id: click_command
				wrapMode: QQC2.TextField.Wrap
			}
		}
		Rectangle {

		}
		RowLayout {
			Layout.fillWidth: true
			Text { width: indentWidth } // indent
			LibConfig.Alert {
				text: i18n("Note that in openSUSE, <b>qdbus</b> is automatically replaced with <b>qdbus6</b>.")
			}
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: clickGroup.group
			checked: false
			text: i18nd("kwin", "Toggle Present Windows (All desktops)")
			property string command: 'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "ExposeAll"'
			onClicked: setClickCommand(command)
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: clickGroup.group
			checked: false
			text: i18nd("kwin", "Toggle Present Windows (Current desktop)")
			property string command: 'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Expose"'
			onClicked: setClickCommand(command)
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: clickGroup.group
			checked: false
			text: i18nd("kwin", "Toggle Present Windows (Window class)")
			property string command: 'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "ExposeClass"'
			onClicked: setClickCommand(command)
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: clickGroup.group
			checked: false
			text: i18ndc("kwin", "@action Overview is the name of a Kwin effect", "Toggle Overview")
			property string command: 'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Overview"'
			onClicked: setClickCommand(command)
		}
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Mouse Wheel")
	}

	LibConfig.RadioButtonGroup {
		id: mousewheelGroup
		spacing: 0
		Kirigami.FormData.isSection: true

		QQC2.RadioButton {
			id: mousewheelGroup_runcommands
			text: i18n("Run Commands")
			QQC2.ButtonGroup.group: mousewheelGroup.group
			checked: cfg_mousewheel_action == 'run_commands'
			onClicked: cfg_mousewheel_action = 'run_commands'
		}
		GridLayout {
			columns: 3
			Layout.fillWidth: true
			Text { width: indentWidth } // indent
			QQC2.Label {
				text: i18n("Scroll Up:")
				Layout.alignment: Qt.AlignRight
			}
			QQC2.TextField {
				Layout.fillWidth: true
				id: mousewheel_up
				wrapMode: QQC2.TextField.Wrap
			}

			Text { width: indentWidth } // indent
			QQC2.Label {
				text: i18n("Scroll Down:")
				Layout.alignment: Qt.AlignRight
			}
			QQC2.TextField {
				Layout.fillWidth: true
				id: mousewheel_down
				wrapMode: QQC2.TextField.Wrap
			}

			Text { width: indentWidth } // indent
			LibConfig.Alert {
				Layout.columnSpan: 2
				text: i18n("Note that in openSUSE, <b>qdbus</b> is automatically replaced with <b>qdbus6</b>.")
			}
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: mousewheelGroup.group
			checked: false
			text: i18n("Volume (No UI) (amixer)")
			property string upCommand:   'amixer -q sset Master 10%+'
			property string downCommand: 'amixer -q sset Master 10%-'
			// text: i18n("Volume (No UI) (pactl)")
			// property string upCommand:   'pactl set-sink-volume "@DEFAULT_SINK@" "+10%"'
			// property string downCommand: 'pactl set-sink-volume "@DEFAULT_SINK@" "-10%"'
			onClicked: setMouseWheelCommands(upCommand, downCommand)
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: mousewheelGroup.group
			checked: false
			text: i18n("Volume (UI) (qdbus)")
			property string upCommand:   'qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "increase_volume"'
			property string downCommand: 'qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "decrease_volume"'
			onClicked: setMouseWheelCommands(upCommand, downCommand)
		}
		QQC2.RadioButton {
			QQC2.ButtonGroup.group: mousewheelGroup.group
			checked: false
			text: i18n("Switch Desktop (qdbus)")
			property string upCommand:   'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Switch One Desktop to the Left"'
			property string downCommand: 'qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Switch One Desktop to the Right"'
			onClicked: setMouseWheelCommands(upCommand, downCommand)
		}
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Peek")
	}

	LibConfig.CheckBox {
		Kirigami.FormData.label: i18n("Show desktop on hover:")
		text: i18n("Enable")
		configKey: 'peekingEnabled'
	}
	LibConfig.SpinBox {
		Kirigami.FormData.label: i18n("Peek threshold:")
		configKey: 'peekingThreshold'
		suffix: i18n("ms")
		stepSize: 50
		from: 0
	}
}

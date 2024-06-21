// Version 6

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

/*
** Example:
**
import './libconfig' as LibConfig
LibConfig.Heading {
	text: i18n("SpinBox (Double)")
}
*/

// While the following Kirigami is very simple:
// Kirigami.Separator {
//     Kirigami.FormData.label: "Heading"
//     Kirigami.FormData.isSection: true
// }
//
// I want to be able to adjust the label size and make it bold.
// Kirigami's buddy Heading is level=3, which does not stand out
// very well. I also want to center the heading.
// Since we can't access the Heading in the buddy component, we
// need to make sure the Heading has no text, and draw our own.
ColumnLayout {
	id: heading
	spacing: 0

	property string text: ""
	property alias separator: separator
	property alias label: label
	property bool useThickTopMargin: true

	property Item __formLayout: {
		if (parent && typeof parent.wideMode === 'boolean') {
			return parent
		} else if (typeof formLayout !== 'undefined' && typeof formLayout.wideMode === 'boolean') {
			return formLayout
		} else if (typeof page !== 'undefined' && typeof page.wideMode === 'boolean') {
			return page
		} else {
			return null
		}
	}

	Layout.fillWidth: true
	// Kirigami.FormData.isSection: true
	Kirigami.MnemonicData.controlType: Kirigami.MnemonicData.FormLabel

	Kirigami.Separator {
		id: separator
		visible: false
		Layout.fillWidth: true
		Layout.topMargin: Kirigami.Units.largeSpacing
		Layout.bottomMargin: Kirigami.Units.largeSpacing
	}

	Kirigami.Heading {
		id: label
		Layout.topMargin: useThickTopMargin ? Kirigami.Units.largeSpacing * 3 : Kirigami.Units.largeSpacing
		Layout.bottomMargin: Kirigami.Units.smallSpacing
		Layout.fillWidth: true
		text: heading.text
		level: 1
		font.weight: Font.Bold
		// horizontalAlignment: (!__formLayout || __formLayout.wideMode) ? Text.AlignHCenter : Text.AlignLeft
		verticalAlignment: (!__formLayout || __formLayout.wideMode) ? Text.AlignVCenter : Text.AlignBottom
	}
}

//--- Test Default Kirigami Heading
// Kirigami.Separator {
// 	property string text: ""
// 	Kirigami.FormData.label: text
// 	Kirigami.FormData.isSection: true
// 	property alias separator: separator
// 	Item {
// 		id: separator
// 	}
// }

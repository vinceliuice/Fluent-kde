// Version 7

import QtQuick
import QtQuick.Controls as QQC2

/*
** Example:
**
import './libconfig' as LibConfig
// Integer
LibConfig.SpinBox {
	configKey: "leftPadding"
	suffix: "px"
	from: 0
	to: 1000
	stepSize: 5
}
// Double
LibConfig.SpinBox {
	configKey: "distance"
	decimals: 3
	suffix: "m"
	minimumValue: 0.0
	maximumValue: 1000.0
	stepSize: Math.round(0.5 * factor)
}
*/
// QQC1.SpinBox: https://github.com/qt/qtquickcontrols/blob/dev/src/controls/SpinBox.qml
// QQC2.SpinBox: https://github.com/qt/qtquickcontrols2/blob/5.15/src/imports/controls/SpinBox.qml
// KDE Config Theme: https://invent.kde.org/frameworks/qqc2-desktop-style/-/blob/master/org.kde.desktop/SpinBox.qml
// Qt6 QQC2.SpinBox: https://github.com/qt/qtquickcontrols2/blob/dev/src/imports/controls/basic/SpinBox.qml
QQC2.SpinBox {
	id: spinBox

	property string configKey: ''
	readonly property var configValue: configKey ? plasmoid.configuration[configKey] : 0

	readonly property real factor: Math.pow(10, decimals)
	readonly property real valueReal: value / factor
	value: Math.round(configValue * factor)
	onValueRealChanged: serializeTimer.start()

	readonly property int spinBox_MININT: Math.ceil(-2147483648 / factor)
	readonly property int spinBox_MAXINT: Math.floor(2147483647 / factor)
	from: Math.round(minimumValue * factor)
	to: Math.round(maximumValue * factor)

	// Reimplement QQC1 properties
	// https://github.com/qt/qtquickcontrols/blob/dev/src/controls/SpinBox.qml
	property int decimals: 0
	property alias prefix: prefixLabel.text
	property alias suffix: suffixLabel.text
	property real minimumValue: 0
	property real maximumValue: spinBox_MAXINT

	// Avoid selecting prefix/suffix by drawing them overlayed on top.
	// As a bonus, we can draw with in a different color (textColor at 60% opacity).
	QQC2.Label {
		id: prefixLabel
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.leftMargin: spinBox.leftPadding
		anchors.topMargin: spinBox.topPadding
		anchors.bottomMargin: spinBox.bottomPadding
		font: spinBox.font
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		color: spinBox.palette.text
		opacity: 0.6
	}
	QQC2.Label {
		id: suffixLabel
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.rightMargin: spinBox.rightPadding
		anchors.topMargin: spinBox.topPadding
		anchors.bottomMargin: spinBox.bottomPadding
		font: spinBox.font
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		color: spinBox.palette.text
		opacity: 0.6
	}

	Timer { // throttle
		id: serializeTimer
		interval: 300
		onTriggered: {
			if (configKey) {
				if (decimals == 0) {
					plasmoid.configuration[configKey] = spinBox.value
				} else {
					plasmoid.configuration[configKey] = spinBox.valueReal
				}
			}
		}
	}

	// Note: Qt5 used RegExpValidator { regExp: /[\-\.\d]+/ }
	// validator: RegularExpressionValidator {
	// 	regularExpression: /[\-\.\d]+/
	// }
	validator: DoubleValidator {
		bottom: Math.min(spinBox.from, spinBox.to)
		top:  Math.max(spinBox.from, spinBox.to)
		decimals: spinBox.decimals
		notation: DoubleValidator.StandardNotation
	}

	textFromValue: function(value, locale) {
		return Number(value / factor).toFixed(decimals)
	}

	valueFromText: function(text, locale) {
		var text2 = text
			.replace(/[^\-\.\d]/g, '') // Remove non digit characters
			.replace(/\.+/g, '.') // Allow user to type '.' instead of RightArrow to enter to decimals
		var val = Number(text2)
		if (isNaN(val)) {
			val = -0
		}
		// console.log('valueFromText', text, val)
		return Math.round(val * factor)
	}

	// Select value on foucs
	onActiveFocusChanged: {
		if (activeFocus) {
			selectValue()
		}
	}
	function selectValue() {
		// Check if SpinBox.contentItem == TextInput
		// https://invent.kde.org/frameworks/qqc2-desktop-style/-/blob/master/org.kde.desktop/SpinBox.qml
		// https://doc.qt.io/qt-5/qml-qtquick-textinput.html#select-method
		if (contentItem && contentItem instanceof TextInput) {
			contentItem.selectAll()
		}
	}

	function fixMinus(str) {
		var minusIndex = str.indexOf('-')
		if (minusIndex >= 0) {
			var a = str.substr(0, minusIndex)
			var b = str.substr(minusIndex+1)
			console.log('a', a, 'b', b)

			return '-' + a + b
		} else {
			return str
		}
	}
	function fixDecimals(str) {
		var periodIndex = str.indexOf('.')
		var a = str.substr(0, periodIndex+1)
		var b = str.substr(periodIndex+1)
		return a + b.replace(/\.+/g, '') // Remove extra periods
	}

	function fixText(str) {
		return fixMinus(fixDecimals(str))
	}

	function onTextEdited() {
		var oldText = spinBox.contentItem.text
		// console.log('onTextEdited', 'oldText1', oldText)
		oldText = fixText(oldText)
		// console.log('onTextEdited', 'oldText2', oldText)
		var oldPeriodIndex = oldText.indexOf('.')
		if (oldPeriodIndex == -1) {
			oldPeriodIndex = oldText.length
		}
		var oldCursorPosition = spinBox.contentItem.cursorPosition
		var oldCursorDelta = oldPeriodIndex - oldCursorPosition

		spinBox.value = spinBox.valueFromText(oldText, spinBox.locale)
		spinBox.valueModified()

		var newText = spinBox.contentItem.text
		// console.log('onTextEdited', 'newText1', newText)
		newText = fixText(newText)
		// console.log('onTextEdited', 'newText2', newText)
		var newPeriodIndex = newText.indexOf('.')
		if (newPeriodIndex == -1) {
			newPeriodIndex = newText.length
		}
		if (newText != spinBox.contentItem.text) {
			spinBox.contentItem.text = Qt.binding(function(){
				return spinBox.textFromValue(spinBox.value, spinBox.locale)
			})
		}
		spinBox.contentItem.cursorPosition = newPeriodIndex - oldCursorDelta
	}

	function bindContentItem() {
		if (contentItem && contentItem instanceof TextInput) {
			// We bind the left/right padding in the TextInput so that
			// clicking the prefix/suffix will focus the TextInput. If we set
			// the SpinBox left/right padding, then they do not focus the TextInput.
			contentItem.leftPadding = Qt.binding(function(){ return prefixLabel.implicitWidth })
			contentItem.rightPadding = Qt.binding(function(){ return suffixLabel.implicitWidth })

			// Bind value update on keypress, while retaining cursor position
			spinBox.contentItem.textEdited.connect(spinBox.onTextEdited)
		}
	}

	onContentItemChanged: {
		bindContentItem()
	}

	Component.onCompleted: {
		for (var i = 0; i < data.length; i++) {
			if (data[i] instanceof Connections) {
				// Remove the Connections where it changes the text/cursor when typing.
				// onTextEdited { value = valueFromText() }
				data[i].destroy()
				break
			}
		}
		bindContentItem()
	}
}

// Version 3

import QtQuick
import QtQuick.Window
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
	id: simpleKCM
	default property alias _formChildren: formLayout.data

	Kirigami.FormLayout {
		id: formLayout
	}

	// https://invent.kde.org/plasma/plasma-desktop/-/blame/master/desktoppackage/contents/configuration/AppletConfiguration.qml
	// AppletConfiguration.implicitWidth: Kirigami.Units.gridUnit * 40 = 720
	// AppletConfiguration.Layout.minimumWidth: Kirigami.Units.gridUnit * 30 = 540
	// In practice, Window.width = 744px is a typical FormLayout.wideMode switchWidth
	// A rough guess is 128+24+180+10+360+24+20 = 746px
	// TabSidebar=128x, Padding=24px, Labels=180px, Spacing=10px, Controls=360px, Padding=24px, Scrollbar=20px
	// However the default is only 720px. So we'll set it to a 800px minimum to avoid wideMode=false
	property int wideModeMinWidth: 800 * Screen.devicePixelRatio
	Window.onWindowChanged: {
		if (Window.window) {
			Window.window.visibleChanged.connect(function(){
				if (Window.window && Window.window.visible && Window.window.width < wideModeMinWidth) {
					Window.window.width = wideModeMinWidth
				}
			})
		}
	}
}

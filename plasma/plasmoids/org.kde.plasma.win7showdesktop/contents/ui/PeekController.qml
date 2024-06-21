/*
	SPDX-FileCopyrightText: 2022 ivan (@ratijas) tkachenko <me@ratijas.tk>

	SPDX-License-Identifier: GPL-2.0-or-later
*/

import org.kde.plasma.private.showdesktop 0.1
import org.kde.plasma.plasmoid 2.0


Controller {
	id: controller

	titleInactive: i18ndc("plasma_applet_org.kde.plasma.showdesktop", "@action:button", "Peek at Desktop")
	titleActive: Plasmoid.containment.corona.editMode ? titleInactive : i18ndc("plasma_applet_org.kde.plasma.showdesktop", "@action:button", "Stop Peeking at Desktop")

	descriptionActive: i18ndc("plasma_applet_org.kde.plasma.showdesktop", "@info:tooltip", "Moves windows back to their original positions")
	descriptionInactive: i18ndc("plasma_applet_org.kde.plasma.showdesktop", "@info:tooltip", "Temporarily shows the desktop by moving windows away")

	active: showdesktop.showingDesktop

	// override
	function toggle() {
		showdesktop.toggleDesktop();
	}

	readonly property ShowDesktop showdesktop: ShowDesktop {
		id: showdesktop
	}
}

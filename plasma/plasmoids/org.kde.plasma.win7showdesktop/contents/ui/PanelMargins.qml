import QtQuick
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg

// Logic from org.kde.panel/.../main.qml
KSvg.FrameSvgItem {
	id: panelSvg
	visible: false
	imagePath: "widgets/panel-background"
	prefix: [plasmoidLocationString(), ""]

	function plasmoidLocationString(): string {
		switch (Plasmoid.location) {
		case PlasmaCore.Types.LeftEdge:
			return "west"
		case PlasmaCore.Types.TopEdge:
			return "north"
		case PlasmaCore.Types.RightEdge:
			return "east"
		case PlasmaCore.Types.BottomEdge:
			return "south"
		}
		return ""
	}
	readonly property int rowSpacing: Kirigami.Units.smallSpacing
	readonly property int panelEdgeMargin: {
		if (Plasmoid.location === PlasmaCore.Types.LeftEdge) {
			return rowSpacing + panelSvg.fixedMargins.bottom
		} else if (Plasmoid.location === PlasmaCore.Types.RightEdge) {
			return rowSpacing + panelSvg.fixedMargins.bottom
		} else if (Plasmoid.location === PlasmaCore.Types.TopEdge) {
			return rowSpacing + panelSvg.fixedMargins.right
		} else if (Plasmoid.location === PlasmaCore.Types.BottomEdge) {
			return rowSpacing + panelSvg.fixedMargins.right
		} else {
			return 0
		}
	}

	// fixedMargins.onLeftChanged: console.log('panelSvg.fixedMargins.left', panelSvg.fixedMargins.left)
	// fixedMargins.onRightChanged: console.log('panelSvg.fixedMargins.right', panelSvg.fixedMargins.right)
	// fixedMargins.onTopChanged: console.log('panelSvg.fixedMargins.top', panelSvg.fixedMargins.top)
	// fixedMargins.onBottomChanged: console.log('panelSvg.fixedMargins.bottom', panelSvg.fixedMargins.bottom)
	// onRowSpacingChanged: console.log('rowSpacing', rowSpacing)
	// onPanelEdgeMarginChanged: console.log('panelEdgeMargin', panelEdgeMargin)
}

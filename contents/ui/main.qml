import QtQuick
import org.kde.kwin.decoration

// Note: I'm not considering maximized here because original game doesn't either.

Decoration {
  id: root

  property real pixelWidth: 1
  property color colorRed: "#000000"
  property color colorCyan: "#000000"
  property color colorPink: "#000000"
  property color colorMagenta: "#474747"
  property color colorWhite: "#000000"
  property color colorGray: "#343434"
  readonly property real buttonSize: pixelWidth * 14

  DecorationOptions {
    id: options
    deco: decoration
  }

  Rectangle {
    id: shadow
    visible: !decoration.client.maximized && decoration.client.active
    width: background.width
    height: background.height
    anchors.left: background.left
    anchors.top: background.top
    anchors.leftMargin: root.padding.right
    anchors.topMargin: root.padding.bottom
    color: root.colorRed
    opacity: 0.3
    z: -1
  }

  Rectangle {
    id: background
    color: decoration.client.active ? "#404040" : root.colorGray
    border.width: 0
    anchors.fill: parent
    anchors.leftMargin: root.padding.left
    anchors.rightMargin: root.padding.right
    anchors.topMargin: root.padding.top
    anchors.bottomMargin: root.padding.bottom

    // Custom borders: top and left (black), bottom and right (#808080)
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      width: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#808080"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      width: root.pixelWidth
      color: "#808080"
    }

    // 2x2 pixel checkerboard grid pattern (only visible on active window)
    Image {
      id: gridPattern
      anchors.fill: parent
      visible: decoration.client.active
      source: "../images/grid.svgz"
      fillMode: Image.Tile
      asynchronous: false
    }
  }

  Rectangle {
    id: titleRow
    color: decoration.client.active ? "#404040" : root.colorGray
    border.width: 0

    height: root.pixelWidth * 15

    anchors {
      left: background.left
      right: background.right
      top: background.top
    }

    // 2x2 pixel checkerboard grid pattern (only visible on active window)
    Image {
      id: titleGridPattern
      anchors.fill: parent
      visible: decoration.client.active
      source: "../images/grid.svgz"
      fillMode: Image.Tile
      asynchronous: false
    }

    // Custom borders: top and left (black), bottom and right (#808080)
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      width: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#808080"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      width: root.pixelWidth
      color: "#808080"
    }

    ButtonGroup {
      id: leftButtonGroup
      spacing: root.pixelWidth * 2
      explicitSpacer: root.buttonSize
      menuButton: menuButtonComponent
      appMenuButton: appMenuButtonComponent
      minimizeButton: minimizeButtonComponent
      maximizeButton: maximizeButtonComponent
      keepBelowButton: keepBelowButtonComponent
      keepAboveButton: keepAboveButtonComponent
      helpButton: helpButtonComponent
      shadeButton: shadeButtonComponent
      allDesktopsButton: stickyButtonComponent
      closeButton: closeButtonComponent
      buttons: options.titleButtonsLeft
      anchors {
        top: parent.top
        topMargin: 1
        left: parent.left
        leftMargin: root.pixelWidth * 3
      }
    }

    Text {
      id: caption
      textFormat: Text.PlainText
      anchors {
        left: leftButtonGroup.right
        right: rightButtonGroup.left
        leftMargin: root.pixelWidth * 3
        rightMargin: root.pixelWidth * 3
        verticalCenter: parent.verticalCenter
      }
      color: "#FFFFFF"
      text: decoration.client.caption
      font: options.titleFont
      elide: Text.ElideMiddle
      renderType: Text.NativeRendering
    }

    ButtonGroup {
      id: rightButtonGroup
      spacing: root.pixelWidth * 0
      explicitSpacer: root.buttonSize
      menuButton: menuButtonComponent
      appMenuButton: appMenuButtonComponent
      minimizeButton: minimizeButtonComponent
      maximizeButton: maximizeButtonComponent
      keepBelowButton: keepBelowButtonComponent
      keepAboveButton: keepAboveButtonComponent
      helpButton: helpButtonComponent
      shadeButton: shadeButtonComponent
      allDesktopsButton: stickyButtonComponent
      closeButton: closeButtonComponent
      buttons: options.titleButtonsRight
      anchors {
        top: parent.top
        topMargin: 1
        right: parent.right
        rightMargin: root.pixelWidth * 3
      }
    }

    Component.onCompleted: {
      decoration.installTitleItem(this);
    }
  }

  Rectangle {
    id: contentBackground
    color: root.colorWhite
    border.width: 0
    anchors {
      fill: background
      leftMargin: 0
      rightMargin: 0
      topMargin: titleRow.height
      bottomMargin: 0
    }

    // Custom borders: top and left (black), bottom and right (#808080)
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      width: root.pixelWidth
      color: "#000000"
    }
    Rectangle {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.pixelWidth
      color: "#808080"
    }
    Rectangle {
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      width: root.pixelWidth
      color: "#808080"
    }
  }

  Component {
    id: maximizeButtonComponent
    PixelButton {
      objectName: "maximizeButton"
      buttonType: DecorationOptions.DecorationButtonMaximizeRestore
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: keepBelowButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonKeepBelow
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: keepAboveButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonKeepAbove
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  /*Component {
    id: helpButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonQuickHelp
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }*/
  Component {
    id: minimizeButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonMinimize
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: shadeButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonShade
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: stickyButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonOnAllDesktops
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: closeButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonClose
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }
  Component {
    id: menuButtonComponent
    MenuButton {
      width: root.buttonSize
      height: root.buttonSize
    }
  }
  Component {
    id: appMenuButtonComponent
    PixelButton {
      buttonType: DecorationOptions.DecorationButtonApplicationMenu
      size: root.buttonSize
      mainColor: root.colorRed
    }
  }

  function updatePadding() {
    if (!decoration.client.maximized) {
      padding.setBorders(2 * pixelWidth);
    } else {
      padding.setBorders(0);
    }
  }

  Connections {
    target: decoration.client
    function onMaximizedChanged() {
      root.updatePadding();
    }
  }

  Connections {
    target: decoration
    function onConfigChanged() {
      root.setupBorders();
      root.setupColors();
    }
  }

  function setupBorders() {
    let pw = decoration.readConfig("pixelWidth", 15);
    if (pw) root.pixelWidth = pw / 10;

    borders.setBorders(4 * pixelWidth);
    borders.bottom = 8 * pixelWidth;
    borders.setTitle(titleRow.height + 6 * pixelWidth);
    maximizedBorders.setBorders(4 * pixelWidth);
    maximizedBorders.bottom = 8 * pixelWidth;
    maximizedBorders.setTitle(titleRow.height + 6 * pixelWidth);
    extendedBorders.setBorders(4 * pixelWidth);
    extendedBorders.bottom = 8 * pixelWidth;
    extendedBorders.setTitle(titleRow.height + 6 * pixelWidth);

    updatePadding();
  }

  function setupColors() {
    root.colorRed = decoration.readConfig("colorRed", Qt.color("#000000"));
    root.colorCyan = decoration.readConfig("colorCyan", Qt.color("#000000"));
    root.colorPink = decoration.readConfig("colorPink", Qt.color("#000000"));
    root.colorMagenta = decoration.readConfig("colorMagenta", Qt.color("#000000"));
    root.colorGray = decoration.readConfig("colorGray", Qt.color("#000000"));
  }

  Component.onCompleted: {
    setupBorders();
    setupColors();
  }
}

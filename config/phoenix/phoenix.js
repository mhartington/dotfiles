Phoenix.set({
  daemon: false,
  openAtLogin: true,
});
const log = (val) => Phoenix.log(JSON.stringify(val));
const computeNewFrameFromGrid = (screen, grid) => {
  const screenRect = screen.flippedVisibleFrame();

  if (!screenRect) return;
  var unitX = screenRect.width / grid.cols;
  var unitY = screenRect.height / grid.rows;
  var newFrame = {
    x: screenRect.x + grid.x * unitX,
    y: screenRect.y + grid.y * unitY,
    width: grid.width * unitX,
    height: grid.height * unitY,
  };
  return newFrame;
};
const move = (grid) => {
  const win = Window.focused();
  const screen = win.screen();
  var newFrame = computeNewFrameFromGrid(screen, grid);
  win.setSize({ width: newFrame.width, height: newFrame.height });
  win.setTopLeft({ x: newFrame.x, y: newFrame.y });
  win.setSize({ width: newFrame.width, height: newFrame.height });
};
const moveToScreen = (window, newScreen) =>{
  const screen = window.screen();

  // const newScreen = direction === 'right' ? screen.next() : screen.previous();
  if (screen === newScreen) {
    return;
  }

  const screenFrame = screen.flippedVisibleFrame();
  const newScreenFrame = newScreen.flippedVisibleFrame();
  const windowFrame = window.frame();

  const widthRatio = newScreenFrame.width / screenFrame.width;
  const heightRatio = newScreenFrame.height / screenFrame.height;

  const width = Math.round(windowFrame.width * widthRatio);
  const height = Math.round(windowFrame.height * heightRatio);
  const x = Math.round( newScreenFrame.x + (windowFrame.x - screenFrame.x) * widthRatio);
  const y = Math.round( newScreenFrame.y + (windowFrame.y - screenFrame.y) * heightRatio);
  const newWindowFrame = { x, y, width, height };

  // Moving between screens in a single operation doesn't work reliably, so do
  // the operations one at a time
  if ( newWindowFrame.height > windowFrame.height || newWindowFrame.width > windowFrame.width) {
    // New window is bigger -- move first
    window.setTopLeft(newWindowFrame);
    window.setSize(newWindowFrame);
  }
  else {
    // New window is smaller -- shrink it first
    window.setSize(newWindowFrame);
    window.setTopLeft(newWindowFrame);
  }
}

Key.on('l', ['alt'], () => {
  move({ x: 1, y: 0, width: 1, height: 1, rows: 1, cols: 2 });
});
Key.on('h', ['alt'], () => {
  move({ x: 0, y: 0, width: 1, height: 1, rows: 1, cols: 2 });
});
Key.on('m', ['alt'], () => {
  move({ x: 0, y: 0, width: 1, height: 1, rows: 1, cols: 1 });
});

Key.on('u', ['alt', 'shift'], () => {
  move({ x: 0, y: 0, width: 6, height: 2, rows: 1, cols: 9 });
});
Key.on('o', ['alt', 'shift'], () => {
  move({ x: 6, y: 0, width: 3, height: 2, rows: 1, cols: 9 });
});

Key.on('l', ['alt', 'shift'], () => {
  const win = Window.focused();
  moveToScreen(win, win.screen().next());
});
Key.on('h', ['alt', 'shift'], function () {
  const win = Window.focused();
  moveToScreen(win, win.screen().previous());
});

//Launch Apps
const launch = (appName) => {
  App.launch(appName, { focus: true })
};
Key.on('f', ['alt'], () => launch('iTerm'));
// Key.on('f', ['alt'], () => launch('kitty'));
// Key.on('f', ['alt'], () => launch('Alacritty'));
Key.on('q', ['alt'], () => launch('QuickTime Player'));
Key.on('o', ['alt'], () => launch('OBS'));
Key.on('c', ['shift', 'alt'], () => launch('Brave Browser'));
Key.on('c', ['alt'], () => launch('Microsoft Edge'));
Key.on('s', ['alt'], () => launch('Safari'));
Key.on('e', ['alt'], () => launch('Simulator'));
Key.on('s', ['shift', 'alt'], () => launch('Safari Technology Preview'));
Key.on('z', ['alt'], () => launch('zoom.us'));
Key.on('d', ['alt'], () => launch('Slack'));
Key.on('t', ['alt'], () => launch('Messages'));

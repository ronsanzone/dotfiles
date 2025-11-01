var keys = []
var modifiers = ["ctrl", "shift"]

function alert(message) {
	var modal = new Modal()
	modal.message = message
	modal.duration = 2
	modal.show()
}

var windowToGrid = function (win, x, y, width, height) {
	var screen = win.screen().flippedVisibleFrame()
	win.setFrame({
		x: Math.round(x * screen.width) + screen.x,
		y: Math.round(y * screen.height) + screen.y,
		width: Math.round(width * screen.width),
		height: Math.round(height * screen.height)
	})
}

var toGrid = function (x, y, width, height) {
	windowToGrid(Window.focused(), x, y, width, height)
}

Window.fullScreen = function() {
	toGrid(0, 0, 1, 1)
}

Window.leftHalf = function() {
	toGrid(0, 0, 0.5, 1)
}

Window.rightHalf = function() {
	toGrid(0.5, 0, 0.5, 1)
}

Window.bottomHalf = function() {
	toGrid(0, 0.5, 1, 0.5)
}

Window.topHalf = function() {
	toGrid(0, 0, 1, 0.5)
}

// Ultrawide grids
Window.firstThird = function() {
	toGrid(0, 0, 0.333, 1)
}

Window.secondThird = function() {
	toGrid(0.333, 0, 0.333, 1)
}

Window.thirdThird = function() {
	toGrid(0.666, 0, 0.333, 1)
}

Window.firstQuarter = function() {
	toGrid(0, 0, 0.25, 1)
}

Window.secondQuarter = function() {
	toGrid(0.25, 0, 0.25, 1)
}

Window.thirdQuarter = function() {
	toGrid(0.50, 0, 0.25, 1)
}

Window.fourthQuarter = function() {
	toGrid(0.75, 0, 0.25, 1)
}

Window.throwWindow = function() {
	var win = Window.focused()
	var winFrame = win.frame()
	var current = win.screen().flippedVisibleFrame()
	var next = win.screen().next().flippedVisibleFrame()

	var opts = {
		x: next.x + (winFrame.x - current.x) / current.width * next.width,
		y: next.y + (winFrame.y - current.y) / current.height * next.height,
		width: (winFrame.x - current.x) / current.width * next.width,
		height: (winFrame.y - current.y) / current.height * next.height,
	}

	win.setFrame(opts)
}

Window.throwWindowBack = function() {
	var win = Window.focused()
	var winFrame = win.frame()
	var current = win.screen().flippedVisibleFrame()
	var next = win.screen().previous().flippedVisibleFrame()

	var opts = {
		x: next.x + (winFrame.x - current.x) / current.width * next.width,
		y: next.y + (winFrame.y - current.y) / current.height * next.height,
		width: (winFrame.x - current.x) / current.width * next.width,
		height: (winFrame.y - current.y) / current.height * next.height,
	}

	win.setFrame(opts)
}

Window.shrink = function(up) {
	var win = Window.focused()
	var winFrame = win.frame()
	var current = win.screen().flippedVisibleFrame()

	var opts = {
		x: winFrame.x,
		y: winFrame.y,
		width: winFrame.width,
		height: current.height / 2,

	}
	win.setFrame(opts)
}

Window.shrinkUp = function() {
	shrink(true)
}

Window.shrinkDown = function() {
	shrink(false)
}

// Rotate current window between monitors
keys.push(new Key('s', modifiers, Window.throwWindow))
keys.push(new Key('d', modifiers, Window.throwWindowBack))

// Basic monitor keybinds

keys.push(new Key('f', modifiers, Window.fullScreen))
keys.push(new Key('h', modifiers, Window.leftHalf))
keys.push(new Key('l', modifiers, Window.rightHalf))
keys.push(new Key('j', modifiers, Window.bottomHalf))
keys.push(new Key('k', modifiers, Window.topHalf))

// Ultrawide specific
keys.push(new Key('y', modifiers, Window.firstThird))
keys.push(new Key('u', modifiers, Window.secondThird))
keys.push(new Key('i', modifiers, Window.thirdThird))

keys.push(new Key('n', modifiers, Window.firstQuarter))
keys.push(new Key('m', modifiers, Window.secondQuarter))
keys.push(new Key(',', modifiers, Window.thirdQuarter))
keys.push(new Key('.', modifiers, Window.fourthQuarter))

keys.push(new Key('o', modifiers, Window.shrinkUp))
keys.push(new Key('p', modifiers, Window.shrinkDown))

-- Focus follows mouse for macOS using Hammerspoon

local focusFollowsMouse = {}

-- Configuration
local DELAY = 0.1 -- Delay in seconds before focusing (prevents accidental focus changes)
local EXCLUDE_APPS = { "Finder", "System Preferences", "System Settings", "Activity Monitor" }

-- Variables
local mouseTimer = nil
local lastMousePosition = nil

-- Function to check if an app should be excluded
local function shouldExcludeApp(appName)
	for _, excludedApp in ipairs(EXCLUDE_APPS) do
		if appName == excludedApp then
			return true
		end
	end
	return false
end

-- Function to focus window under mouse
local function focusWindowUnderMouse()
	local mousePoint = hs.mouse.absolutePosition()
	local windowUnderMouse = nil

	-- Get all windows and find the one under mouse
	-- We'll iterate through them in reverse order (topmost first)
	local allWindows = hs.window.orderedWindows()

	for _, win in ipairs(allWindows) do
		if win:isStandard() and win:isVisible() then
			local frame = win:frame()
			if
				frame
				and mousePoint.x >= frame.x
				and mousePoint.x <= (frame.x + frame.w)
				and mousePoint.y >= frame.y
				and mousePoint.y <= (frame.y + frame.h)
			then
				windowUnderMouse = win
				break -- First match is the topmost window
			end
		end
	end

	if windowUnderMouse then
		local currentFocused = hs.window.focusedWindow()
		local app = windowUnderMouse:application()

		if app then
			local appName = app:name()

			-- Debug output (uncomment to troubleshoot)
			-- print("Found window under mouse:", appName, "Current focused:", currentFocused and currentFocused:application():name() or "none")

			-- Only focus if it's a different window and not excluded
			if currentFocused ~= windowUnderMouse and not shouldExcludeApp(appName) then
				windowUnderMouse:focus()
				-- print("Focused:", appName)
			end
		end
	end
end

-- Mouse move callback with debouncing
local function onMouseMove()
	local currentMousePosition = hs.mouse.absolutePosition()

	-- Only proceed if mouse actually moved
	if
		lastMousePosition
		and math.abs(currentMousePosition.x - lastMousePosition.x) < 5
		and math.abs(currentMousePosition.y - lastMousePosition.y) < 5
	then
		return
	end

	lastMousePosition = currentMousePosition

	-- Cancel existing timer
	if mouseTimer then
		mouseTimer:stop()
	end

	-- Set new timer with delay
	mouseTimer = hs.timer.doAfter(DELAY, focusWindowUnderMouse)
end

-- Start/stop functions
function focusFollowsMouse.start()
	if focusFollowsMouse.eventtap then
		focusFollowsMouse.stop()
	end

	focusFollowsMouse.eventtap = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, onMouseMove)
	focusFollowsMouse.eventtap:start()
	hs.alert.show("Focus follows mouse: ON")
end

function focusFollowsMouse.stop()
	if focusFollowsMouse.eventtap then
		focusFollowsMouse.eventtap:stop()
		focusFollowsMouse.eventtap = nil
	end

	if mouseTimer then
		mouseTimer:stop()
		mouseTimer = nil
	end

	hs.alert.show("Focus follows mouse: OFF")
end

function focusFollowsMouse.toggle()
	if focusFollowsMouse.eventtap then
		focusFollowsMouse.stop()
	else
		focusFollowsMouse.start()
	end
end

-- Hotkeys (customize these to your preference)
hs.hotkey.bind({ "cmd", "alt" }, "f", focusFollowsMouse.toggle)

-- Auto-start (uncomment if you want it to start automatically)
-- focusFollowsMouse.start()

-- Reload configuration
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
	hs.reload()
end)

-- Show notification when config loads
hs.alert.show("Hammerspoon config loaded! Cmd+Alt+F to toggle focus follows mouse")

-- JK-Dev Start Screen System (Windows 11 Glass PRO + Implement Window + Copy)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

---------------------------------------------------------
-- CONFIG
---------------------------------------------------------
local RAW_LINK = "https://raw.githubusercontent.com/Kub4-dev/Start-Screen-For-Roblox-Games/refs/heads/main/main.lua"

---------------------------------------------------------
-- BLUR
---------------------------------------------------------
local blur = Instance.new("BlurEffect")
blur.Size = 18
blur.Parent = Lighting

---------------------------------------------------------
-- MAIN GUI
---------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "JK_StartScreen"
gui.IgnoreGuiInset = true
gui.Parent = playerGui

---------------------------------------------------------
-- MAIN PANEL
---------------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(1,0,1,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BackgroundTransparency = 0.35
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,24)
mainCorner.Parent = main

local mainShadow = Instance.new("ImageLabel")
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://5028857084"
mainShadow.ImageColor3 = Color3.fromRGB(0,0,0)
mainShadow.ImageTransparency = 0.4
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(24,24,276,276)
mainShadow.Size = UDim2.new(1.02,0,1.02,0)
mainShadow.Position = UDim2.new(-0.01,0,-0.01,0)
mainShadow.ZIndex = 0
mainShadow.Parent = main

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,180))
}
gradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 0.78),
	NumberSequenceKeypoint.new(1, 0.78)
}
gradient.Rotation = 90
gradient.Parent = main

---------------------------------------------------------
-- HEADER
---------------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.12,0)
title.BackgroundTransparency = 1
title.Text = "JK-Dev's Start Screen"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(240,240,240)
title.Parent = main

---------------------------------------------------------
-- BUTTON FACTORY
---------------------------------------------------------
local function createButton(text, color, posY)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.3,0,0.11,0)
	btn.Position = UDim2.new(0.35,0,posY,0)
	btn.Text = text
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamSemibold
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.AutoButtonColor = false
	btn.Parent = main

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,18)
	corner.Parent = btn

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5
	stroke.Color = Color3.fromRGB(255,255,255)
	stroke.Transparency = 0.4
	stroke.Parent = btn

	local normal = color
	local hover = Color3.fromRGB(
		math.clamp(color.R*255+20,0,255),
		math.clamp(color.G*255+20,0,255),
		math.clamp(color.B*255+20,0,255)
	)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hover}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.15}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normal}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
	end)

	return btn
end

---------------------------------------------------------
-- BUTTONS
---------------------------------------------------------
local playBtn = createButton("PLAY", Color3.fromRGB(0,200,0), 0.30)
local infoBtn = createButton("INFO", Color3.fromRGB(0,120,255), 0.45)
local implementBtn = createButton("IMPLEMENT THIS SCREEN TO YOUR GAME", Color3.fromRGB(255,170,0), 0.60)
local exitBtn = createButton("EXIT", Color3.fromRGB(255,80,80), 0.75)

---------------------------------------------------------
-- BLOCKER
---------------------------------------------------------
local blocker = Instance.new("TextButton")
blocker.Size = UDim2.new(1,0,1,0)
blocker.BackgroundTransparency = 1
blocker.Text = ""
blocker.Visible = false
blocker.ZIndex = 5
blocker.Parent = gui

---------------------------------------------------------
-- WINDOW FACTORY
---------------------------------------------------------
local function createWindow()
	local win = Instance.new("Frame")
	win.Size = UDim2.new(0.40,0,0.40,0)
	win.Position = UDim2.new(0.30,0,0.30,0)
	win.BackgroundColor3 = Color3.fromRGB(30,30,30)
	win.BackgroundTransparency = 0.18
	win.Visible = false
	win.ZIndex = 10
	win.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,22)
	corner.Parent = win

	local shadow = mainShadow:Clone()
	shadow.Size = UDim2.new(1.1,0,1.1,0)
	shadow.Position = UDim2.new(-0.05,0,-0.05,0)
	shadow.ImageTransparency = 0.45
	shadow.ZIndex = 9
	shadow.Parent = win

	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0.12,0,0.12,0)
	closeBtn.Position = UDim2.new(0.86,0,0.02,0)
	closeBtn.Text = "X"
	closeBtn.TextScaled = true
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
	closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
	closeBtn.ZIndex = 11
	closeBtn.Parent = win

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0,16)
	closeCorner.Parent = closeBtn

	closeBtn.MouseButton1Click:Connect(function()
		win.Visible = false
		blocker.Visible = false
	end)

	return win
end

---------------------------------------------------------
-- INFO WINDOW (tabs)
---------------------------------------------------------
local infoWindow = createWindow()

local creatorTab = Instance.new("TextButton")
creatorTab.Size = UDim2.new(0.5,0,0.12,0)
creatorTab.Position = UDim2.new(0,0,0.12,0)
creatorTab.Text = "Creator"
creatorTab.TextScaled = true
creatorTab.Font = Enum.Font.GothamBold
creatorTab.BackgroundColor3 = Color3.fromRGB(70,70,70)
creatorTab.TextColor3 = Color3.fromRGB(255,255,255)
creatorTab.ZIndex = 11
creatorTab.Parent = infoWindow

local devTab = Instance.new("TextButton")
devTab.Size = UDim2.new(0.5,0,0.12,0)
devTab.Position = UDim2.new(0.5,0,0.12,0)
devTab.Text = "Info for Devs"
devTab.TextScaled = true
devTab.Font = Enum.Font.GothamBold
devTab.BackgroundColor3 = Color3.fromRGB(50,50,50)
devTab.TextColor3 = Color3.fromRGB(255,255,255)
devTab.ZIndex = 11
devTab.Parent = infoWindow

local creatorText = Instance.new("TextLabel")
creatorText.Size = UDim2.new(1,0,0.6,0)
creatorText.Position = UDim2.new(0,0,0.32,0)
creatorText.BackgroundTransparency = 1
creatorText.Text = "Creator of the Start Screen is JK-Dev"
creatorText.TextScaled = true
creatorText.Font = Enum.Font.GothamBold
creatorText.TextColor3 = Color3.fromRGB(255,255,255)
creatorText.ZIndex = 11
creatorText.Parent = infoWindow

local devText = Instance.new("TextLabel")
devText.Size = UDim2.new(1,0,0.6,0)
devText.Position = UDim2.new(0,0,0.32,0)
devText.BackgroundTransparency = 1
devText.Text = "Just add this script to any game.\nIt does not conflict with anything.\nWorks perfectly in every game."
devText.TextScaled = true
devText.Font = Enum.Font.GothamBold
devText.TextColor3 = Color3.fromRGB(255,255,255)
devText.Visible = false
devText.ZIndex = 11
devText.Parent = infoWindow

creatorTab.MouseButton1Click:Connect(function()
	creatorText.Visible = true
	devText.Visible = false
	creatorTab.BackgroundColor3 = Color3.fromRGB(70,70,70)
	devTab.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

devTab.MouseButton1Click:Connect(function()
	creatorText.Visible = false
	devText.Visible = true
	devTab.BackgroundColor3 = Color3.fromRGB(70,70,70)
	creatorTab.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

infoBtn.MouseButton1Click:Connect(function()
	blocker.Visible = true
	infoWindow.Visible = true
end)

---------------------------------------------------------
-- IMPLEMENT WINDOW (with COPY)
---------------------------------------------------------
local implementWindow = createWindow()

local codeBox = Instance.new("TextLabel")
codeBox.Size = UDim2.new(1,0,0.55,0)
codeBox.Position = UDim2.new(0,0,0.20,0)
codeBox.BackgroundTransparency = 1
codeBox.Text = "Click COPY to copy start screen source in one link and paste it into an empty script in your game to get a beutyfool screen in your game."
codeBox.TextScaled = true
codeBox.Font = Enum.Font.GothamBold
codeBox.TextColor3 = Color3.fromRGB(255,255,255)
codeBox.ZIndex = 11
codeBox.Parent = implementWindow

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.45,0,0.15,0)
copyBtn.Position = UDim2.new(0.275,0,0.75,0)
copyBtn.Text = "COPY"
copyBtn.TextScaled = true
copyBtn.Font = Enum.Font.GothamBold
copyBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.ZIndex = 11
copyBtn.Parent = implementWindow

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0,16)
copyCorner.Parent = copyBtn

local codeToCopy = 'loadstring(game:HttpGet("'..RAW_LINK..'"))()'

copyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(codeToCopy)
		copyBtn.Text = "COPIED!"
		task.wait(1)
		copyBtn.Text = "COPY"
	else
		copyBtn.Text = "NO CLIPBOARD"
		task.wait(1)
		copyBtn.Text = "COPY"
	end
end)

implementBtn.MouseButton1Click:Connect(function()
	blocker.Visible = true
	implementWindow.Visible = true
end)

---------------------------------------------------------
-- EXIT + PLAY
---------------------------------------------------------
exitBtn.MouseButton1Click:Connect(function()
	player:Kick('You clicked "exit". Join again if you clicked by accident.')
end)

playBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	blur:Destroy()
end)

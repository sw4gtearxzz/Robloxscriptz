local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Emotes"
ScreenGui.Parent = CoreGui

-- Main Frame
local BackFrame = Instance.new("Frame")
BackFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
BackFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BackFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
BackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BackFrame.BackgroundTransparency = 0
BackFrame.Visible = false
BackFrame.BorderSizePixel = 0
BackFrame.Parent = ScreenGui

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 15)
UICornerFrame.Parent = BackFrame

-- Open Button
local OpenButton = Instance.new("TextButton")
OpenButton.Text = "Emotes"
OpenButton.Size = UDim2.new(0.2, 0, 0.08, 0)
OpenButton.Position = UDim2.new(0.4, 0, 0.85, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.TextScaled = true
OpenButton.AutoButtonColor = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenButton

-- Hover effect for open button
OpenButton.MouseEnter:Connect(function()
	OpenButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)
OpenButton.MouseLeave:Connect(function()
	OpenButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

OpenButton.MouseButton1Click:Connect(function()
	BackFrame.Visible = not BackFrame.Visible
end)

-- Scrolling Frame
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, 0, 1, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.Parent = BackFrame

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.22, 0, 0, 60)
Grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Scroll

-- Emotes list
local Emotes = {
	{name = "Around Town", id = 3576747102},
	{name = "Fashionable", id = 3576745472},
	{name = "Swish", id = 3821527813},
	{name = "Top Rock", id = 3570535774},
	{name = "Fancy Feet", id = 3934988903},
	{name = "Idol", id = 4102317848},
	{name = "Sneaky", id = 3576754235},
	{name = "Robot", id = 3576721660},
	{name = "Louder", id = 3576751796},
	{name = "Twirl", id = 3716633898},
	{name = "Bodybuilder", id = 3994130516},
	{name = "Jacks", id = 3570649048},
	{name = "Shuffle", id = 4391208058},
	{name = "Dorky Dance", id = 4212499637},
	{name = "Flex Walk", id = 15506506103},
	{name = "Dizzy", id = 3934986896},
	{name = "Rock Star", id = 6533100850},
	{name = "Panini Dance", id = 5915781665},
	{name = "Elton John - Piano Jump", id = 11453096488},
	{name = "Cartwheel - George Ezra", id = 10370929905},
	{name = "Extra Emote 1", id = 133596366979822},
	{name = "Extra Emote 2", id = 93511411593120},
	{name = "Extra Emote 3", id = 15698511500},
	{name = "Extra Emote 4", id = 16572756230},
	{name = "Extra Emote 5", id = 78074267827823},
	{name = "Extra Emote 6", id = 95317654766616},
	{name = "Extra Emote 7", id = 112354510576428},
	{name = "Extra Emote 8", id = 94428815809038},
	{name = "Extra Emote 9", id = 97123113822381},
	{name = "Extra Emote 10", id = 115300061334912},
	{name = "Extra Emote 11", id = 117564534161906},
	{name = "Extra Emote 12", id = 138572458313208},
}

local function playEmote(id)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if humanoid.RigType == Enum.HumanoidRigType.R15 then
		local success, track = pcall(function()
			return humanoid:PlayEmoteAndGetAnimTrackById(id)
		end)
		if not success then
			StarterGui:SetCore("SendNotification", {
				Title = "Emote Error",
				Text = "Failed to play emote "..id,
				Duration = 3
			})
		end
	else
		StarterGui:SetCore("SendNotification", {
			Title = "R6 Detected",
			Text = "You must use R15 to play these emotes",
			Duration = 3
		})
	end
end

for _, emote in ipairs(Emotes) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9, 0, 0, 50)
	button.Text = emote.name
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextScaled = true
	button.AutoButtonColor = false
	button.Parent = Scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button

	-- Hover effect
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end)

	button.MouseButton1Click:Connect(function()
		playEmote(emote.id)
		BackFrame.Visible = false
	end)
end

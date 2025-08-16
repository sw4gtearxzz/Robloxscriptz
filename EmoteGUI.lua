-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Emotes"
ScreenGui.Parent = CoreGui

local BackFrame = Instance.new("Frame")
BackFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
BackFrame.AnchorPoint = Vector2.new(0.5,0.5)
BackFrame.Position = UDim2.new(0.5,0,0.5,0)
BackFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
BackFrame.BackgroundTransparency = 0.1
BackFrame.Visible = false
BackFrame.Parent = ScreenGui

local OpenButton = Instance.new("TextButton")
OpenButton.Text = "Emotes"
OpenButton.Size = UDim2.new(0.2,0,0.08,0)
OpenButton.Position = UDim2.new(0.4,0,0.85,0)
OpenButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.TextScaled = true
OpenButton.Parent = ScreenGui

OpenButton.MouseButton1Click:Connect(function()
	BackFrame.Visible = not BackFrame.Visible
end)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,0,1,0)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.BackgroundTransparency = 1
Scroll.Parent = BackFrame

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.22,0,0,60)
Grid.CellPadding = UDim2.new(0.02,0,0.02,0)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Scroll

-- Emotes List
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
    {name = "Extra 1", id = 133596366979822},
    {name = "Extra 2", id = 93511411593120},
    {name = "Extra 3", id = 15698511500},
    {name = "Extra 4", id = 16572756230},
    {name = "Extra 5", id = 78074267827823},
    {name = "Extra 6", id = 95317654766616},
    {name = "Extra 7", id = 112354510576428},
    {name = "Extra 8", id = 94428815809038},
    {name = "Extra 9", id = 97123113822381},
    {name = "Extra 10", id = 115300061334912},
    {name = "Extra 11", id = 117564534161906},
    {name = "Extra 12", id = 138572458313208},
    {name = "Extra 13", id = 70635223083942},
    {name = "Extra 14", id = 100297498958164},
    {name = "Extra 15", id = 134584040095037},
    {name = "Extra 16", id = 112746062636394},
    {name = "Extra 17", id = 78755795767408},
    {name = "Extra 18", id = 88834614877886},
    {name = "Extra 19", id = 19746055344304},
    {name = "Extra 20", id = 138386881919239},
    {name = "Extra 21", id = 114899970878842},
    {name = "Extra 22", id = 92376846011129},
    {name = "Extra 23", id = 91380965860245},
    {name = "Extra 24", id = 101573394483995},
    {name = "Extra 25", id = 130998336536045},
    {name = "Extra 26", id = 134311528115559},
    {name = "Extra 27", id = 131763631172236},
    {name = "Extra 28", id = 90101899912160},
    {name = "Extra 29", id = 140252879267563},
}

-- Function to play emote
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

-- Create buttons for all emotes
for _, emote in ipairs(Emotes) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9,0,0,50)
	button.Text = emote.name
	button.BackgroundColor3 = Color3.fromRGB(60,60,60)
	button.TextColor3 = Color3.new(1,1,1)
	button.Parent = Scroll
	button.MouseButton1Click:Connect(function()
		playEmote(emote.id)
		BackFrame.Visible = false
	end)
end

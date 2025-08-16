-- WalkSpeed GUI (Mobile-Friendly)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local currentSpeed = 16
local speedEnabled = true

local function createGUI()
	if player.PlayerGui:FindFirstChild("MobileToolsGUI") then
		player.PlayerGui.MobileToolsGUI:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "MobileToolsGUI"
	gui.Parent = player:WaitForChild("PlayerGui")

	-- Floating button
	local floatButton = Instance.new("TextButton")
	floatButton.Size = UDim2.new(0,50,0,50)
	floatButton.Position = UDim2.new(0,50,0,50)
	floatButton.Text = "⚡"
	floatButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
	floatButton.BackgroundTransparency = 0.3
	floatButton.TextColor3 = Color3.fromRGB(255,255,255)
	floatButton.Font = Enum.Font.SourceSansBold
	floatButton.TextSize = 30
	floatButton.Parent = gui

	-- Main frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0,240,0,120)
	mainFrame.Position = UDim2.new(0,110,0,50)
	mainFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
	mainFrame.BackgroundTransparency = 0.2
	mainFrame.Visible = false
	mainFrame.Parent = gui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,0,25)
	title.Position = UDim2.new(0,0,0,0)
	title.BackgroundTransparency = 1
	title.Text = "WalkSpeed Tool"
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 18
	title.Parent = mainFrame

	-- WalkSpeed TextBox
	local speedBox = Instance.new("TextBox")
	speedBox.Size = UDim2.new(0,200,0,30)
	speedBox.Position = UDim2.new(0,20,0,40)
	speedBox.PlaceholderText = "Type WalkSpeed (0-10000)"
	speedBox.Text = tostring(currentSpeed)
	speedBox.ClearTextOnFocus = false
	speedBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
	speedBox.BackgroundTransparency = 0.2
	speedBox.TextColor3 = Color3.fromRGB(255,255,255)
	speedBox.Font = Enum.Font.SourceSans
	speedBox.TextSize = 18
	speedBox.Parent = mainFrame

	-- WalkSpeed toggle
	local speedToggle = Instance.new("TextButton")
	speedToggle.Size = UDim2.new(0,80,0,30)
	speedToggle.Position = UDim2.new(0,80,0,80)
	speedToggle.BackgroundColor3 = Color3.fromRGB(100,200,100)
	speedToggle.BackgroundTransparency = 0.2
	speedToggle.TextColor3 = Color3.fromRGB(0,0,0)
	speedToggle.Font = Enum.Font.SourceSansBold
	speedToggle.TextSize = 18
	speedToggle.Text = "ON"
	speedToggle.Parent = mainFrame

	-- Toggle GUI with float button
	floatButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = not mainFrame.Visible
	end)

	-- Toggle WalkSpeed
	speedToggle.MouseButton1Click:Connect(function()
		speedEnabled = not speedEnabled
		local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
		if speedEnabled and humanoid then
			humanoid.WalkSpeed = currentSpeed
			speedToggle.Text = "ON"
			speedToggle.BackgroundColor3 = Color3.fromRGB(100,200,100)
		elseif humanoid then
			humanoid.WalkSpeed = 16
			speedToggle.Text = "OFF"
			speedToggle.BackgroundColor3 = Color3.fromRGB(200,100,100)
		end
	end)

	-- Update WalkSpeed from TextBox
	speedBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local value = tonumber(speedBox.Text)
			if value and value >= 0 and value <= 10000 then
				currentSpeed = value
				local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
				if humanoid and speedEnabled then
					humanoid.WalkSpeed = currentSpeed
				end
				speedBox.Text = tostring(currentSpeed)
			else
				speedBox.Text = tostring(currentSpeed)
			end
		end
	end)
end

-- Initial GUI
createGUI()

-- Respawn handling
player.CharacterAdded:Connect(function(char)
	task.wait(1)
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		if speedEnabled then humanoid.WalkSpeed = currentSpeed else humanoid.WalkSpeed = 16 end
	end
	createGUI()
end)

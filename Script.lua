local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "TskPanel"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 220, 0, 360)
Main.Position = UDim2.new(0.5, -110, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "Tsk Fake Robux"
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold

local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 140, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(80, 40, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

CreateButton("Ragdoll", UDim2.new(0, 10, 0, 70), function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end)

CreateButton("Rocket", UDim2.new(0, 10, 0, 110), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 100, 0)
        bv.MaxForce = Vector3.new(0, 50000, 0)
        task.wait(0.5)
        bv:Destroy()
    end
end)

CreateButton("Balloon", UDim2.new(0, 10, 0, 150), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bf = Instance.new("BodyForce", hrp)
        bf.Force = Vector3.new(0, 2500, 0)
        task.wait(3)
        bf:Destroy()
    end
end)

CreateButton("Toggle GUI", UDim2.new(0, 10, 0, 270), function()
    Main.Visible = false
end)

local RobuxText = Instance.new("TextLabel", Main)
RobuxText.Text = "Robux:"
RobuxText.Size = UDim2.new(0, 50, 0, 30)
RobuxText.Position = UDim2.new(0, 10, 0, 325)
RobuxText.TextColor3 = Color3.fromRGB(200, 200, 0)
RobuxText.Font = Enum.Font.GothamBold
RobuxText.BackgroundTransparency = 1

local RobuxAmount = Instance.new("TextLabel", Main)
RobuxAmount.Text = tostring(VALOR_ROBUX)
RobuxAmount.Size = UDim2.new(0, 50, 0, 30)
RobuxAmount.Position = UDim2.new(0, 150, 0, 325)
RobuxAmount.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxAmount.Font = Enum.Font.GothamBold
RobuxAmount.BackgroundTransparency = 1

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

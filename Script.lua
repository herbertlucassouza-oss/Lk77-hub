local mt = getrawmetatable(game)
local old = mt.__namecall
if setreadonly then setreadonly(mt, false) else make_writeable(mt) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        return nil
    end
    return old(self, ...)
end)

if setreadonly then setreadonly(mt, true) else make_readonly(mt) end

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Lk7Hub"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 480)
Main.Position = UDim2.new(0.5, -125, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "Fake Robux lk7 - Anti-Kick"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local TargetBox = Instance.new("TextBox", Main)
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 40)
TargetBox.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBox)

local function SendVisualChat(msg)
    local targetText = TargetBox.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if targetText == "all" or p.Name:lower():find(targetText) then
            if p.Character and p.Character:FindFirstChild("Head") then
                game:GetService("Chat"):Chat(p.Character.Head, msg, Enum.ChatColor.White)
            end
        end
    end
end

local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(80, 40, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 80))
PhraseBtn("Chegouuu", UDim2.new(0, 130, 0, 80))
PhraseBtn("Tmjjj MN", UDim2.new(0, 10, 0, 120))
PhraseBtn("vouch", UDim2.new(0, 130, 0, 120))

local Line = Instance.new("Frame", Main)
Line.Size = UDim2.new(0, 230, 0, 2)
Line.Position = UDim2.new(0, 10, 0, 165)
Line.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Line.BorderSizePixel = 0

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

CmdBtn("Ragdoll", UDim2.new(0, 10, 0, 180), function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end)

CmdBtn("Rocket (Safe)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local f = Instance.new("Fire", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 40, 0)
        bv.MaxForce = Vector3.new(0, 9000, 0)
        task.wait(1)
        f:Destroy()
        bv:Destroy()
    end
end)

CmdBtn("Balloon (Safe)", UDim2.new(0, 10, 0, 270), function()
    local head = player.Character:FindFirstChild("Head")
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if head and hrp then
        local m = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        local old = m.Scale
        m.Scale = Vector3.new(3, 3, 3)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 10, 0)
        bv.MaxForce = Vector3.new(0, 8000, 0)
        task.wait(3)
        m.Scale = old
        bv:Destroy()
    end
end)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 440)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.Font = Enum.Font.GothamBold
RobuxLabel.BackgroundTransparency = 1

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

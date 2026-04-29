local mt = getrawmetatable(game)
local old = mt.__namecall
if setreadonly then setreadonly(mt, false) else make_writeable(mt) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        warn("Tentativa de Kick bloqueada!")
        return nil
    end
    return old(self, ...)
end)

if setreadonly then setreadonly(mt, true) else make_readonly(mt) end

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Lk7HubV5"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 560)
Main.Position = UDim2.new(0.5, -125, 0.5, -280)
Main.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "Lk7 Hub - V5"
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

local function GetTarget()
    local text = TargetBox.Text:lower()
    local targets = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if text == "all" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            table.insert(targets, p)
        end
    end
    return targets
end

local function SendVisualChat(msg)
    for _, p in pairs(GetTarget()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            game:GetService("Chat"):Chat(p.Character.Head, msg, Enum.ChatColor.White)
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

local function ApplyNoAnimStraight()
    local char = player.Character
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hum and hrp then
        -- Trava animações
        for _, track in pairs(hum:GetPlayingAnimationTracks()) do
            track:Stop()
        end
        -- Mantém reto
        local bg = Instance.new("BodyGyro", hrp)
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
        return bg
    end
end

CmdBtn("Ragdoll (Straight/NoAnim)", UDim2.new(0, 10, 0, 180), function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local gyro = ApplyNoAnimStraight()
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(2)
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        if gyro then gyro:Destroy() end
    end
end)

CmdBtn("Rocket (Safe)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local f = Instance.new("Fire", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        local gyro = ApplyNoAnimStraight()
        bv.Velocity = Vector3.new(0, 40, 0)
        bv.MaxForce = Vector3.new(0, 9000, 0)
        task.wait(1.2)
        f:Destroy()
        bv:Destroy()
        if gyro then gyro:Destroy() end
    end
end)

CmdBtn("Balloon (Straight/NoAnim)", UDim2.new(0, 10, 0, 270), function()
    local head = player.Character:FindFirstChild("Head")
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if head and hrp then
        local gyro = ApplyNoAnimStraight()
        local m = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        m.Scale = Vector3.new(4, 4, 4)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 12, 0)
        bv.MaxForce = Vector3.new(0, 10000, 0)
        task.wait(4)
        m.Scale = Vector3.new(1, 1, 1)
        bv:Destroy()
        if gyro then gyro:Destroy() end
    end
end)

CmdBtn("Force Jump 3x (Visual)", UDim2.new(0, 10, 0, 315), function()
    for _, p in pairs(GetTarget()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                for i = 1, 3 do
                    local bv = Instance.new("BodyVelocity", p.Character.HumanoidRootPart)
                    bv.Velocity = Vector3.new(0, 35, 0)
                    bv.MaxForce = Vector3.new(0, 50000, 0)
                    task.wait(0.15)
                    bv:Destroy()
                    task.wait(0.6)
                end
            end)
        end
    end
end)

CmdBtn("Jail (5 Segundos)", UDim2.new(0, 10, 0, 360), function()
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.CFrame
        local cage = Instance.new("Model", workspace)
        cage.Name = "VisualJail"
        
        local parts = {
            {s = Vector3.new(10, 1, 10), p = pos * CFrame.new(0, -3.5, 0)},
            {s = Vector3.new(10, 1, 10), p = pos * CFrame.new(0, 7, 0)},
            {s = Vector3.new(1, 10, 10), p = pos * CFrame.new(5, 2, 0)},
            {s = Vector3.new(1, 10, 10), p = pos * CFrame.new(-5, 2, 0)},
            {s = Vector3.new(10, 10, 1), p = pos * CFrame.new(0, 2, 5)},
            {s = Vector3.new(10, 10, 1), p = pos * CFrame.new(0, 2, -5)}
        }
        
        for _, v in pairs(parts) do
            local p = Instance.new("Part", cage)
            p.Size = v.s
            p.CFrame = v.p
            p.Anchored = true
            p.Transparency = 1
            p.CastShadow = false
        end
        
        task.wait(5)
        cage:Destroy()
    end
end)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 520)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.Font = Enum.Font.GothamBold
RobuxLabel.BackgroundTransparency = 1

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

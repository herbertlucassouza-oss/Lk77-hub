local function Bypass()
    local g = game
    local mt = getrawmetatable(g)
    local old = mt.__namecall
    if setreadonly then setreadonly(mt, false) else make_writeable(mt) end
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" or method == "BreakJoints" then return nil end
        return old(self, ...)
    end)
    if setreadonly then setreadonly(mt, true) else make_readonly(mt) end
end
pcall(Bypass)

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Lk7V10Final"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 580)
Main.Position = UDim2.new(0.5, -125, 0.5, -280)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 40)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
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
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 80))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 80))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 120))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 120))

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- FUNÇÃO PARA TRAVAR VIDA
local function GodMode(state)
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if state then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        else
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end
    end
end

CmdBtn("Ragdoll (Immortal)", UDim2.new(0, 10, 0, 180), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        GodMode(true)
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(1.5)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        GodMode(false)
    end
end)

CmdBtn("Rocket (Immortal)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        GodMode(true)
        local f = Instance.new("Fire", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, 99999, 0)
        bv.Velocity = Vector3.new(0, 50, 0)
        task.wait(1.5)
        bv:Destroy()
        f:Destroy()
        GodMode(false)
    end
end)

CmdBtn("Balloon (Immortal)", UDim2.new(0, 10, 0, 270), function()
    local head = player.Character:FindFirstChild("Head")
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if head and hrp then
        GodMode(true)
        local m = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        m.Scale = Vector3.new(3.5, 3.5, 3.5)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, 25000, 0)
        bv.Velocity = Vector3.new(0, 18, 0)
        task.wait(4)
        bv:Destroy()
        m.Scale = Vector3.new(1, 1, 1)
        GodMode(false)
    end
end)

CmdBtn("Force Jump 3x (Fix)", UDim2.new(0, 10, 0, 315), function()
    for _, p in pairs(GetTarget()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                for i = 1, 3 do
                    local bv = Instance.new("BodyVelocity", p.Character.HumanoidRootPart)
                    bv.MaxForce = Vector3.new(0, 9e9, 0)
                    bv.Velocity = Vector3.new(0, 50, 0)
                    task.wait(0.2)
                    bv:Destroy()
                    task.wait(0.6)
                end
            end)
        end
    end
end)

CmdBtn("Jail (Invisível)", UDim2.new(0, 10, 0, 360), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local cage = Instance.new("Part", workspace)
        cage.Size = Vector3.new(10, 12, 10)
        cage.CFrame = hrp.CFrame
        cage.Transparency = 1
        cage.Anchored = true
        cage.CanCollide = true
        task.wait(5)
        cage:Destroy()
    end
end)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 530)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

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
sg.Name = "PhysicsHub_Final"
sg.ResetOnSpawn = false

local COR_FUNDO = Color3.fromRGB(15, 15, 20)
local COR_INPUT = Color3.fromRGB(25, 25, 35)
local COR_BOTAO = Color3.fromRGB(45, 45, 55)
local COR_PHRASE = Color3.fromRGB(60, 30, 150)

local MainPhys = Instance.new("Frame", sg)
MainPhys.Name = "PhysicsPanel"
MainPhys.Size = UDim2.new(0, 250, 0, 550)
MainPhys.Position = UDim2.new(0.1, 0, 0.5, -275)
MainPhys.BackgroundColor3 = COR_FUNDO
MainPhys.Active = true
MainPhys.Draggable = true
Instance.new("UICorner", MainPhys).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainPhys)
Title.Text = "ikzz"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local TargetBox = Instance.new("TextBox", MainPhys)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Nick do Player..."
TargetBox.Size = UDim2.new(0, 230, 0, 35)
TargetBox.Position = UDim2.new(0, 10, 0, 45)
TargetBox.BackgroundColor3 = COR_INPUT
TargetBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetBox)

local function GetTarget()
    local text = TargetBox.Text:lower()
    if text == "" then return nil end
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            return p
        end
    end
    return nil
end

local function SendVisualChat(msg)
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("Head") then
        game:GetService("Chat"):Chat(t.Character.Head, msg, Enum.ChatColor.White)
    end
end

local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", MainPhys)
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = COR_PHRASE
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 90))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 90))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 135))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 135))

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", MainPhys)
    btn.Size = UDim2.new(0, 230, 0, 45)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = COR_BOTAO
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 200), function()
    if player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(1)
    end
end)

CmdBtn("Rocket (No-Kick)", UDim2.new(0, 10, 0, 255), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 30 do hrp.CFrame = hrp.CFrame * CFrame.new(0, 3, 0) task.wait() end
    end
end)

CmdBtn("Balloon (No-Kick)", UDim2.new(0, 10, 0, 310), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 25, 0)
        bv.MaxForce = Vector3.new(0, 8000, 0)
        task.wait(4) bv:Destroy()
    end
end)

CmdBtn("Force Jump 3x", UDim2.new(0, 10, 0, 365), function()
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("Humanoid") then
        for i = 1, 3 do t.Character.Humanoid.Jump = true task.wait(0.5) end
    end
end)

CmdBtn("Jail (5 Seg)", UDim2.new(0, 10, 0, 420), function()
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = t.Character.HumanoidRootPart
        local oldCF = hrp.CFrame
        local s = tick()
        while tick() - s < 5 do hrp.CFrame = oldCF task.wait() end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then
        MainPhys.Visible = not MainPhys.Visible
    end
end)

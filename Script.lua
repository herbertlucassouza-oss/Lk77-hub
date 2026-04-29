local function Bypass()
    local g = game
    local mt = getrawmetatable(g)
    local old = mt.__namecall
    if setreadonly then setreadonly(mt, false) else make_writeable(mt) end
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return nil end
        return old(self, ...)
    end)
    if setreadonly then setreadonly(mt, true) else make_readonly(mt) end
end
pcall(Bypass)

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "ikzz_V17_Safe"
sg.ResetOnSpawn = false

local COR_FUNDO = Color3.fromRGB(15, 15, 20)
local COR_INPUT = Color3.fromRGB(25, 25, 35)
local COR_BOTAO = Color3.fromRGB(45, 45, 55)
local COR_PHRASE = Color3.fromRGB(60, 30, 150)

local MainPhys = Instance.new("Frame", sg)
MainPhys.Name = "PhysicsPanel"
MainPhys.Size = UDim2.new(0, 250, 0, 500)
MainPhys.Position = UDim2.new(0.1, 0, 0.5, -250)
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
    btn.Size = UDim2.new(0, 230, 0, 40)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = COR_BOTAO
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 190), function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end)

CmdBtn("Rocket (V2 Safe)", UDim2.new(0, 10, 0, 240), function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local velocity = Instance.new("LinearVelocity", hrp)
        local attachment = Instance.new("Attachment", hrp)
        velocity.Attachment0 = attachment
        velocity.MaxForce = 99999
        velocity.VectorVelocity = Vector3.new(0, 80, 0)
        task.wait(1.5)
        velocity:Destroy()
        attachment:Destroy()
    end
end)

CmdBtn("Balloon (Slow Float)", UDim2.new(0, 10, 0, 290), function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local force = Instance.new("BodyVelocity", hrp)
        force.Velocity = Vector3.new(0, 15, 0)
        force.MaxForce = Vector3.new(0, 5000, 0)
        task.wait(4)
        force:Destroy()
    end
end)

CmdBtn("Force Jump 3x", UDim2.new(0, 10, 0, 340), function()
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("Humanoid") then
        for i = 1, 3 do 
            t.Character.Humanoid.Jump = true 
            task.wait(0.6) 
        end
    end
end)

CmdBtn("Jail (Freeze)", UDim2.new(0, 10, 0, 390), function()
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = t.Character.HumanoidRootPart
        local oldCF = hrp.CFrame
        local start = tick()
        while tick() - start < 5 do
            hrp.CFrame = oldCF
            task.wait(0.1)
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then
        MainPhys.Visible = not MainPhys.Visible
    end
end)

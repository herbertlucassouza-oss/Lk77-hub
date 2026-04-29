
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
sg.Name = "Lk7Tools_V15"
sg.ResetOnSpawn = false

local COR_FUNDO = Color3.fromRGB(15, 15, 20)
local COR_INPUT = Color3.fromRGB(25, 25, 35)
local COR_BOTAO = Color3.fromRGB(45, 45, 55)
local COR_BOTAO_ATIVO = Color3.fromRGB(180, 20, 50)
local COR_DISABLE = Color3.fromRGB(20, 160, 80)
local COR_PHRASE = Color3.fromRGB(60, 30, 150)

local MainTools = Instance.new("Frame", sg)
MainTools.Name = "Lk7ToolsPanel"
MainTools.Size = UDim2.new(0, 280, 0, 420)
MainTools.Position = UDim2.new(0.6, 0, 0.5, -210)
MainTools.BackgroundColor3 = COR_FUNDO
MainTools.Active = true
MainTools.Draggable = true
Instance.new("UICorner", MainTools)

local TargetBox = Instance.new("TextBox", MainTools)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Digite o Nick aqui..."
TargetBox.Size = UDim2.new(0, 250, 0, 40)
TargetBox.Position = UDim2.new(0, 15, 0, 75)
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

local MainPhys = Instance.new("Frame", sg)
MainPhys.Name = "PhysicsPanel"
MainPhys.Size = UDim2.new(0, 250, 0, 600)
MainPhys.Position = UDim2.new(0.1, 0, 0.5, -300)
MainPhys.BackgroundColor3 = COR_FUNDO
MainPhys.Active = true
MainPhys.Draggable = true
Instance.new("UICorner", MainPhys)

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

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 50))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 50))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 95))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 95))

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

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    if player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(1)
    end
end)

local EquipBtn = Instance.new("TextButton", MainTools)
EquipBtn.Text = "Equip"
EquipBtn.Size = UDim2.new(0, 250, 0, 45)
EquipBtn.Position = UDim2.new(0, 15, 0, 210)
EquipBtn.BackgroundColor3 = COR_BOTAO_ATIVO
EquipBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", EquipBtn)

EquipBtn.MouseButton1Click:Connect(function()
    local t = GetTarget()
    if t and t.Character and t.Character:FindFirstChild("RightHand") then
        local model = Instance.new("Model", t.Character)
        model.Name = "FakeTool"
        local p = Instance.new("Part", model)
        p.Size = Vector3.new(1,1,1)
        p.CFrame = t.Character.RightHand.CFrame
        local w = Instance.new("WeldConstraint", p)
        w.Part0 = p
        w.Part1 = t.Character.RightHand
    end
end)

local DisableBtn = Instance.new("TextButton", MainTools)
DisableBtn.Text = "Disable"
DisableBtn.Size = UDim2.new(0, 250, 0, 45)
DisableBtn.Position = UDim2.new(0, 15, 0, 295)
DisableBtn.BackgroundColor3 = COR_DISABLE
DisableBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", DisableBtn)

DisableBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character then
            for _, v in pairs(p.Character:GetChildren()) do
                if v.Name == "FakeTool" then v:Destroy() end
            end
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g then
        if i.KeyCode == Enum.KeyCode.P then MainPhys.Visible = not MainPhys.Visible
        elseif i.KeyCode == Enum.KeyCode.L then MainTools.Visible = not MainTools.Visible end
    end
end)

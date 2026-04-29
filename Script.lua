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
sg.Name = "Lk7Tools_V13"
sg.ResetOnSpawn = false

local COR_FUNDO = Color3.fromRGB(15, 15, 20)
local COR_INPUT = Color3.fromRGB(25, 25, 35)
local COR_BOTAO = Color3.fromRGB(45, 45, 55)
local COR_BOTAO_ATIVO = Color3.fromRGB(180, 20, 50)
local COR_DISABLE = Color3.fromRGB(20, 160, 80)
local COR_PHRASE = Color3.fromRGB(60, 30, 150)

local MainPhys = Instance.new("Frame", sg)
MainPhys.Name = "PhysicsPanel"
MainPhys.Size = UDim2.new(0, 250, 0, 600)
MainPhys.Position = UDim2.new(0.1, 0, 0.5, -300)
MainPhys.BackgroundColor3 = COR_FUNDO
MainPhys.Active = true
MainPhys.Draggable = true
Instance.new("UICorner", MainPhys).CornerRadius = UDim.new(0, 10)

local TitlePhys = Instance.new("TextLabel", MainPhys)
TitlePhys.Text = "ikzz"
TitlePhys.Size = UDim2.new(1, 0, 0, 40)
TitlePhys.TextColor3 = Color3.fromRGB(200, 200, 200)
TitlePhys.BackgroundTransparency = 1
TitlePhys.Font = Enum.Font.GothamBold

local function SendVisualChat(msg)
    local targetText = sg:FindFirstChild("Lk7ToolsPanel") and sg.Lk7ToolsPanel.TargetBox.Text:lower() or ""
    for _, p in pairs(game.Players:GetPlayers()) do
        if targetText == "all" or p.Name:lower():find(targetText) or p.DisplayName:lower():find(targetText) then
            if p.Character and p.Character:FindFirstChild("Head") then
                game:GetService("Chat"):Chat(p.Character.Head, msg, Enum.ChatColor.White)
            end
        end
    end
end

local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", MainPhys)
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = COR_PHRASE
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
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
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end)

CmdBtn("Rocket (No-Kick CFrame)", UDim2.new(0, 10, 0, 235), function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 50 do
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 2, 0)
            task.wait()
        end
    end
end)

CmdBtn("Balloon (No-Kick CFrame)", UDim2.new(0, 10, 0, 290), function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local float = Instance.new("BodyVelocity", hrp)
        float.Velocity = Vector3.new(0, 15, 0)
        float.MaxForce = Vector3.new(0, 4000, 0)
        task.wait(5)
        float:Destroy()
    end
end)

CmdBtn("Force Jump 3x (Fix)", UDim2.new(0, 10, 0, 345), function()
    local targetText = sg.Lk7ToolsPanel.TargetBox.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and (p.Name:lower():find(targetText) or p.DisplayName:lower():find(targetText)) then
            task.spawn(function()
                for i = 1, 3 do
                    if p.Character and p.Character:FindFirstChild("Humanoid") then
                        p.Character.Humanoid.Jump = true
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
end)

CmdBtn("Jail (5 Segundos)", UDim2.new(0, 10, 0, 400), function()
    local targetText = sg.Lk7ToolsPanel.TargetBox.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and (p.Name:lower():find(targetText) or p.DisplayName:lower():find(targetText)) then
            local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local oldCF = hrp.CFrame
                local start = tick()
                while tick() - start < 5 do
                    hrp.CFrame = oldCF
                    task.wait()
                end
            end
        end
    end
end)

local MainTools = Instance.new("Frame", sg)
MainTools.Name = "Lk7ToolsPanel"
MainTools.Size = UDim2.new(0, 280, 0, 420)
MainTools.Position = UDim2.new(0.6, 0, 0.5, -210)
MainTools.BackgroundColor3 = COR_FUNDO
MainTools.Active = true
MainTools.Draggable = true
Instance.new("UICorner", MainTools).CornerRadius = UDim.new(0, 12)

local TitleTools = Instance.new("TextLabel", MainTools)
TitleTools.Text = "Lk7 Tools"
TitleTools.Size = UDim2.new(1, 0, 0, 40)
TitleTools.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleTools.BackgroundTransparency = 1
TitleTools.Font = Enum.Font.GothamBold
TitleTools.TextSize = 16

local TargetBox = Instance.new("TextBox", MainTools)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "reabremntei"
TargetBox.Size = UDim2.new(0, 250, 0, 40)
TargetBox.Position = UDim2.new(0, 15, 0, 75)
TargetBox.BackgroundColor3 = COR_INPUT
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBox)

local SelectedTool = "Hammer"
local function CreateToolBtn(name, pos)
    local btn = Instance.new("TextButton", MainTools)
    btn.Name = name.."Btn"
    btn.Size = UDim2.new(0, 75, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = (name == SelectedTool and COR_BOTAO_ATIVO or COR_BOTAO)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        SelectedTool = name
        MainTools.CarpetBtn.BackgroundColor3 = COR_BOTAO
        MainTools.LaserBtn.BackgroundColor3 = COR_BOTAO
        MainTools.HammerBtn.BackgroundColor3 = COR_BOTAO
        btn.BackgroundColor3 = COR_BOTAO_ATIVO
    end)
end

CreateToolBtn("Carpet", UDim2.new(0, 15, 0, 155))
CreateToolBtn("Laser", UDim2.new(0, 100, 0, 155))
CreateToolBtn("Hammer", UDim2.new(0, 185, 0, 155))

local EquipBtn = Instance.new("TextButton", MainTools)
EquipBtn.Text = "Equip"
EquipBtn.Size = UDim2.new(0, 250, 0, 45)
EquipBtn.Position = UDim2.new(0, 15, 0, 210)
EquipBtn.BackgroundColor3 = COR_BOTAO_ATIVO
EquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EquipBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", EquipBtn)

local DisableBtn = Instance.new("TextButton", MainTools)
DisableBtn.Text = "Disable"
DisableBtn.Size = UDim2.new(0, 250, 0, 45)
DisableBtn.Position = UDim2.new(0, 15, 0, 295)
DisableBtn.BackgroundColor3 = COR_DISABLE
DisableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", DisableBtn)

local Assets = {
    Carpet = 497746190,
    Laser = 13511116,
    Hammer = 13192271
}

EquipBtn.MouseButton1Click:Connect(function()
    local text = TargetBox.Text:lower()
    for _, t in pairs(game.Players:GetPlayers()) do
        if t ~= player and (t.Name:lower():find(text) or t.DisplayName:lower():find(text)) then
            if t.Character and t.Character:FindFirstChild("RightHand") then
                for _, v in pairs(t.Character:GetChildren()) do
                    if v:IsA("Model") and v.Name:find("Fake") then v:Destroy() end
                end
                local model = Instance.new("Model", t.Character)
                model.Name = "FakeTool"
                local mesh = game:GetObjects("rbxassetid://"..Assets[SelectedTool])[1]
                if mesh then
                    mesh.Parent = model
                    local handle = mesh:FindFirstChild("Handle") or mesh
                    local weld = Instance.new("WeldConstraint", handle)
                    handle.CFrame = t.Character.RightHand.CFrame
                    weld.Part0 = handle weld.Part1 = t.Character.RightHand
                end
            end
        end
    end
end)

DisableBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character then 
            for _, v in pairs(p.Character:GetChildren()) do
                if v:IsA("Model") and v.Name:find("Fake") then v:Destroy() end
            end
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe then
        if input.KeyCode == Enum.KeyCode.P then MainPhys.Visible = not MainPhys.Visible
        elseif input.KeyCode == Enum.KeyCode.L then MainTools.Visible = not MainTools.Visible end
    end
end)

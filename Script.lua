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
sg.Name = "Lk7V11Hybrid"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE_PHYSICS = Enum.KeyCode.P
local TECLA_TOGGLE_TOOLS = Enum.KeyCode.L

local COR_FUNDO = Color3.fromRGB(15, 15, 20)
local COR_BOTAO = Color3.fromRGB(45, 45, 55)
local COR_BOTAO_ATIVO = Color3.fromRGB(180, 20, 50)
local COR_DISABLE = Color3.fromRGB(20, 160, 80)

local MainPhys = Instance.new("Frame", sg)
MainPhys.Name = "PhysicsPanel"
MainPhys.Size = UDim2.new(0, 250, 0, 580)
MainPhys.Position = UDim2.new(0.1, 0, 0.5, -290)
MainPhys.BackgroundColor3 = COR_FUNDO
MainPhys.Active = true
MainPhys.Draggable = true
Instance.new("UICorner", MainPhys).CornerRadius = UDim.new(0, 10)

local function GetTargetPhys()
    local text = MainPhys:FindFirstChild("TargetBox") and MainPhys.TargetBox.Text:lower() or ""
    local targets = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if text == "all" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            table.insert(targets, p)
        end
    end
    return targets
end

local function SendVisualChat(msg)
    for _, p in pairs(GetTargetPhys()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            game:GetService("Chat"):Chat(p.Character.Head, msg, Enum.ChatColor.White)
        end
    end
end

local function PhraseBtnPhys(text, pos)
    local btn = Instance.new("TextButton", MainPhys)
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

PhraseBtnPhys("Obrigado", UDim2.new(0, 10, 0, 80))
PhraseBtnPhys("Vlw MN", UDim2.new(0, 130, 0, 80))
PhraseBtnPhys("Tmj", UDim2.new(0, 10, 0, 120))
PhraseBtnPhys("Vouch", UDim2.new(0, 130, 0, 120))

local function CmdBtnPhys(name, pos, callback)
    local btn = Instance.new("TextButton", MainPhys)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = COR_BOTAO
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

local function GodModePhys(state)
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Dead, not state) end
end

CmdBtnPhys("Ragdoll (Immortal)", UDim2.new(0, 10, 0, 180), function()
    GodModePhys(true)
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    task.wait(1.5)
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    GodModePhys(false)
end)

CmdBtnPhys("Rocket (Immortal)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        GodModePhys(true)
        local f = Instance.new("Fire", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, 99999, 0)
        bv.Velocity = Vector3.new(0, 50, 0)
        task.wait(1.5)
        bv:Destroy() f:Destroy()
        GodModePhys(false)
    end
end)

CmdBtnPhys("Balloon (Immortal)", UDim2.new(0, 10, 0, 270), function()
    local head = player.Character:FindFirstChild("Head")
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if head and hrp then
        GodModePhys(true)
        local m = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        m.Scale = Vector3.new(3.5, 3.5, 3.5)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, 25000, 0)
        bv.Velocity = Vector3.new(0, 18, 0)
        task.wait(4)
        bv:Destroy() m.Scale = Vector3.new(1, 1, 1)
        GodModePhys(false)
    end
end)

CmdBtnPhys("Force Jump 3x (Fix)", UDim2.new(0, 10, 0, 315), function()
    for _, p in pairs(GetTargetPhys()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                for i = 1, 3 do
                    local bv = Instance.new("BodyVelocity", p.Character.HumanoidRootPart)
                    bv.MaxForce = Vector3.new(0, 9e9, 0)
                    bv.Velocity = Vector3.new(0, 50, 0)
                    task.wait(0.2) bv:Destroy() task.wait(0.6)
                end
            end)
        end
    end
end)

local TargetBoxPhys = Instance.new("TextBox", MainPhys)
TargetBoxPhys.Name = "TargetBox"
TargetBoxPhys.PlaceholderText = "Jogador (all / nome)"
TargetBoxPhys.Size = UDim2.new(0, 230, 0, 30)
TargetBoxPhys.Position = UDim2.new(0, 10, 0, 40)
TargetBoxPhys.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBoxPhys.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBoxPhys)

local RobuxLabel = Instance.new("TextLabel", MainPhys)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 530)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

local MainTools = Instance.new("Frame", sg)
MainTools.Name = "ToolsPanel"
MainTools.Size = UDim2.new(0, 280, 0, 420)
MainTools.Position = UDim2.new(0.6, 0, 0.5, -210)
MainTools.BackgroundColor3 = COR_FUNDO
MainTools.Active = true
MainTools.Draggable = true
Instance.new("UICorner", MainTools).CornerRadius = UDim.new(0, 12)

local TitleTools = Instance.new("TextLabel", MainTools)
TitleTools.Text = "Tsk Fake Tools"
TitleTools.Size = UDim2.new(1, 0, 0, 40)
TitleTools.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleTools.BackgroundTransparency = 1
TitleTools.Font = Enum.Font.GothamBold
TitleTools.TextSize = 16

local TargetBoxTools = Instance.new("TextBox", MainTools)
TargetBoxTools.PlaceholderText = "reabremntei"
TargetBoxTools.Size = UDim2.new(0, 250, 0, 40)
TargetBoxTools.Position = UDim2.new(0, 15, 0, 75)
TargetBoxTools.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TargetBoxTools.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBoxTools)

local SelectedTool = "Hammer"
local function CreateToolBtn(name, pos)
    local btn = Instance.new("TextButton", MainTools)
    btn.Name = name.."Btn"
    btn.Size = UDim2.new(0, 75, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
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

local function ClearFakeTools(char)
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Model") and v.Name:find("Fake") then v:Destroy() end
    end
end

EquipBtn.MouseButton1Click:Connect(function()
    local text = TargetBoxTools.Text:lower()
    for _, t in pairs(game.Players:GetPlayers()) do
        if t ~= player and (t.Name:lower():find(text) or t.DisplayName:lower():find(text)) then
            if t.Character and t.Character:FindFirstChild("RightHand") then
                local char = t.Character
                ClearFakeTools(char)
                local toolModel = Instance.new("Model", char)
                toolModel.Name = "Fake"..SelectedTool
                local visualPart = Instance.new("Part", toolModel)
                visualPart.Size = (SelectedTool == "Hammer" and Vector3.new(0.5, 2.5, 1) or SelectedTool == "Laser" and Vector3.new(0.3, 2, 0.3) or Vector3.new(3, 0.1, 4))
                visualPart.Color = (SelectedTool == "Hammer" and Color3.new(0.5, 0.5, 0.5) or SelectedTool == "Laser" and Color3.new(1, 0, 0) or Color3.new(0.6, 0.2, 0.2))
                visualPart.Material = (SelectedTool == "Laser" and Enum.Material.Neon or Enum.Material.Metal)
                visualPart.CanCollide = false
                visualPart.CFrame = char.RightHand.CFrame
                local weld = Instance.new("WeldConstraint", visualPart)
                weld.Part0 = visualPart weld.Part1 = char.RightHand
            end
        end
    end
end)

DisableBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character then ClearFakeTools(p.Character) end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe then
        if input.KeyCode == TECLA_TOGGLE_PHYSICS then MainPhys.Visible = not MainPhys.Visible
        elseif input.KeyCode == TECLA_TOGGLE_TOOLS then MainTools.Visible = not MainTools.Visible end
    end
end)

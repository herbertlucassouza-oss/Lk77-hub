local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "ikzz_V19_AdminVisual"
sg.ResetOnSpawn = false

local VALOR_ROBUX_DISPLAY = 11284
local PRECO_ADMIN = 5599
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 620)
Main.Position = UDim2.new(0.5, -125, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 45)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetBox)

local function GetTarget()
    local text = TargetBox.Text:lower()
    local targets = {}
    if text == "" then return targets end
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
            game:GetService("Chat"):Chat(p.Character.Head, msg, "White")
        end
    end
end

-- Botões de Frase (Simulando Admin)
local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 150)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Visible = false -- Começa invisível até "comprar"
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat("[ADMIN] " .. text) end)
    return btn
end

local b1 = PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 85))
local b2 = PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 85))
local b3 = PhraseBtn("Tmj", UDim2.new(0, 10, 0, 125))
local b4 = PhraseBtn("Vouch", UDim2.new(0, 130, 0, 125))

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- Comandos de Física
CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(2)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

CmdBtn("Rocket (CFrame)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 20 do hrp.CFrame = hrp.CFrame * CFrame.new(0, 2.5, 0) task.wait(0.03) end
    end
end)

-- FUNÇÃO DE COMPRA VISUAL (Baseada na sua foto)
local BuyAdminBtn = Instance.new("TextButton", Main)
BuyAdminBtn.Size = UDim2.new(0, 230, 0, 40)
BuyAdminBtn.Position = UDim2.new(0, 10, 0, 420)
BuyAdminBtn.Text = "Comprar Admin (Visual)"
BuyAdminBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
BuyAdminBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BuyAdminBtn)

BuyAdminBtn.MouseButton1Click:Connect(function()
    BuyAdminBtn.Text = "Processando..."
    task.wait(1.5)
    BuyAdminBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    BuyAdminBtn.Text = "ADQUIRIDO!"
    
    -- Ativa as funções de Admin visualmente
    b1.Visible = true
    b2.Visible = true
    b3.Visible = true
    b4.Visible = true
    
    -- Simula anúncio no chat para você
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[SISTEMA] Você adquiriu Comandos de Administrador com sucesso!";
        Color = Color3.new(1, 1, 0);
        Font = Enum.Font.GothamBold;
    })
end)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX_DISPLAY
RobuxLabel.Position = UDim2.new(0, 10, 0, 570)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

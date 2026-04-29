local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "ikzz_V20_Sim"
sg.ResetOnSpawn = false

local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 580)
Main.Position = UDim2.new(0.5, -125, 0.5, -290)
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

local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 150)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 80))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 80))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 120))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 120))

local function CreateFakePurchase()
    local Overlay = Instance.new("Frame", sg)
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.ZIndex = 10
    
    local Prompt = Instance.new("Frame", Overlay)
    Prompt.Size = UDim2.new(0, 400, 0, 250)
    Prompt.Position = UDim2.new(0.5, -200, 0.5, -125)
    Prompt.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    Instance.new("UICorner", Prompt)
    
    local Icon = Instance.new("TextLabel", Prompt)
    Icon.Text = "AP"
    Icon.Size = UDim2.new(0, 80, 0, 80)
    Icon.Position = UDim2.new(0, 20, 0, 40)
    Icon.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Icon.TextColor3 = Color3.new(0, 0, 0)
    Icon.TextSize = 35
    Icon.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 15)
    
    local Info = Instance.new("TextLabel", Prompt)
    Info.Text = "Comandos de Administrador\n5.599 Robux"
    Info.Position = UDim2.new(0, 110, 0, 40)
    Info.Size = UDim2.new(0, 250, 0, 80)
    Info.BackgroundTransparency = 1
    Info.TextColor3 = Color3.new(1, 1, 1)
    Info.TextXAlignment = Enum.TextXAlignment.Left
    Info.Font = Enum.Font.GothamSemibold
    Info.TextSize = 18
    
    local BuyBtn = Instance.new("TextButton", Prompt)
    BuyBtn.Text = "Comprar"
    BuyBtn.Size = UDim2.new(0, 360, 0, 50)
    BuyBtn.Position = UDim2.new(0, 20, 0, 160)
    BuyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    BuyBtn.TextColor3 = Color3.new(1, 1, 1)
    BuyBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", BuyBtn)
    
    local CloseBtn = Instance.new("TextButton", Prompt)
    CloseBtn.Text = "X"
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0, 10)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    
    CloseBtn.MouseButton1Click:Connect(function() Overlay:Destroy() end)
    
    BuyBtn.MouseButton1Click:Connect(function()
        BuyBtn.Text = "Processando..."
        task.wait(1.5)
        BuyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        BuyBtn.Text = "COMPRA CONCLUÍDA!"
        task.wait(1)
        Overlay:Destroy()
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[SISTEMA] Você adquiriu Comandos de Administrador!";
            Color = Color3.new(0, 1, 0);
        })
    end)
end

local BuySimBtn = Instance.new("TextButton", Main)
BuySimBtn.Text = "Simular Compra Admin"
BuySimBtn.Size = UDim2.new(0, 230, 0, 40)
BuySimBtn.Position = UDim2.new(0, 10, 0, 520)
BuySimBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
BuySimBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BuySimBtn)

BuySimBtn.MouseButton1Click:Connect(CreateFakePurchase)

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_V22_Fixed"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 600)
Main.Position = UDim2.new(0.5, -125, 0.5, -300)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Text = "LK7 HUB"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 45)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    local tList = GetTarget()
    for _, p in pairs(tList) do
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

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 85))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 85))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 125))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 125))

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

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(2)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

CmdBtn("Rocket (Anti-Death)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(0, 999999, 0)
        bv.Velocity = Vector3.new(0, 60, 0)
        bv.Parent = hrp
        
        local fire = Instance.new("Fire", hrp)
        fire.Size = 10
        
        task.wait(1.5)
        bv:Destroy()
        fire:Destroy()
    end
end)

CmdBtn("Balloon (Fixed Float)", UDim2.new(0, 10, 0, 270), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    local head = player.Character:FindFirstChild("Head")
    if hrp and head then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(0, 25000, 0)
        bv.Velocity = Vector3.new(0, 15, 0)
        bv.Parent = hrp
        
        local mesh = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        local oldScale = mesh.Scale
        mesh.Scale = Vector3.new(3, 3, 3)
        
        task.wait(5)
        bv:Destroy()
        mesh.Scale = oldScale
    end
end)

CmdBtn("Force Jump 3x (Safe)", UDim2.new(0, 10, 0, 315), function()
    for _, p in pairs(GetTarget()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            task.spawn(function()
                for i = 1, 3 do
                    p.Character.Humanoid.Jump = true
                    task.wait(0.7)
                end
            end)
        end
    end
end)

CmdBtn("Jail Target (5 Seg)", UDim2.new(0, 10, 0, 360), function()
    local targets = GetTarget()
    for _, t in pairs(targets) do
        if t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = t.Character.HumanoidRootPart
            local oldCF = hrp.CFrame
            local start = tick()
            while tick() - start < 5 do
                hrp.CFrame = oldCF
                task.wait(0.1)
            end
        end
    end
end)

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
    
    local Info = Instance.new("TextLabel", Prompt)
    Info.Text = "Comandos de Administrador\n5.599 Robux"
    Info.Size = UDim2.new(1, 0, 0, 100)
    Info.Position = UDim2.new(0, 0, 0, 40)
    Info.BackgroundTransparency = 1
    Info.TextColor3 = Color3.new(1,1,1)
    Info.TextSize = 20
    
    local BuyBtn = Instance.new("TextButton", Prompt)
    BuyBtn.Text = "Comprar"
    BuyBtn.Size = UDim2.new(0, 360, 0, 50)
    BuyBtn.Position = UDim2.new(0, 20, 0, 170)
    BuyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    BuyBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", BuyBtn)
    
    BuyBtn.MouseButton1Click:Connect(function()
        BuyBtn.Text = "Processando..."
        task.wait(1)
        Overlay:Destroy()
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "Compra realizada com sucesso!", Color = Color3.new(0,1,0)})
    end)
end

local BuySimBtn = Instance.new("TextButton", Main)
BuySimBtn.Text = "Simular Compra Admin"
BuySimBtn.Size = UDim2.new(0, 230, 0, 35)
BuySimBtn.Position = UDim2.new(0, 10, 0, 405)
BuySimBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
BuySimBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", BuySimBtn)
BuySimBtn.MouseButton1Click:Connect(CreateFakePurchase)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 550)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)

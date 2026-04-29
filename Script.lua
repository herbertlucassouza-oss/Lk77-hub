local function Bypass()
    local g = game
    local mt = getrawmetatable(g)
    local old = mt.__namecall
    if setreadonly then setreadonly(mt, false) else make_writeable(mt) end

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            warn("Tentativa de Kick bloqueada pelo Lk7 Hub!")
            return nil
        end
        return old(self, ...)
    end)
    if setreadonly then setreadonly(mt, true) else make_readonly(mt) end
end
pcall(Bypass)

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "Lk7FinalNoKick"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 560)
Main.Position = UDim2.new(0.5, -125, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local function GetTarget()
    local text = Main:FindFirstChild("TargetBox") and Main.TargetBox.Text:lower() or ""
    local targets = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if text == "all" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            table.insert(targets, p)
        end
    end
    return targets
end

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(1.2)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

CmdBtn("Rocket (No-Kick CFrame)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local f = Instance.new("Fire", hrp)
        for i = 1, 40 do
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 1.5, 0)
            task.wait(0.02)
        end
        f:Destroy()
    end
end)

CmdBtn("Balloon (No-Kick CFrame)", UDim2.new(0, 10, 0, 270), function()
    local head = player.Character:FindFirstChild("Head")
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if head and hrp then
        local m = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
        m.Scale = Vector3.new(3.5, 3.5, 3.5)
        for i = 1, 80 do
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0.4, 0)
            task.wait(0.03)
        end
        m.Scale = Vector3.new(1, 1, 1)
    end
end)

CmdBtn("Force Jump 3x (Fix)", UDim2.new(0, 10, 0, 315), function()
    for _, p in pairs(GetTarget()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                for i = 1, 3 do
                    local hrp = p.Character.HumanoidRootPart
                    local bp = Instance.new("BodyPosition", hrp)
                    bp.MaxForce = Vector3.new(0, 9e9, 0)
                    bp.Position = hrp.Position + Vector3.new(0, 25, 0)
                    task.wait(0.3)
                    bp:Destroy()
                    task.wait(0.5)
                end
            end)
        end
    end
end)

CmdBtn("Jail (5 Segundos)", UDim2.new(0, 10, 0, 360), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local cage = Instance.new("Part", workspace)
        cage.Size = Vector3.new(10, 12, 10)
        cage.CFrame = hrp.CFrame
        cage.Transparency = 1 -- Totalmente invisível como pedido
        cage.Anchored = true
        cage.CanCollide = true
        task.wait(5)
        cage:Destroy()
    end
end)

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 40)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBox)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Text = "Robux: " .. VALOR_ROBUX
RobuxLabel.Position = UDim2.new(0, 10, 0, 520)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == TECLA_TOGGLE then
        Main.Visible = not Main.Visible
    end
end)


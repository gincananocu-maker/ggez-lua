local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- Flags
local autoFarmOn = false
local autoAttackOn = false

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmAttackGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Botão para abrir/fechar menu
local menuButton = Instance.new("TextButton")
menuButton.Size = UDim2.new(0, 100, 0, 40)
menuButton.Position = UDim2.new(0, 10, 0, 10)
menuButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menuButton.TextColor3 = Color3.new(1, 1, 1)
menuButton.Font = Enum.Font.SourceSansBold
menuButton.TextSize = 20
menuButton.Text = "Menu"
menuButton.Parent = screenGui

-- Frame do menu (inicialmente invisível)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

-- Função para criar botões toggle
local function createToggleButton(text, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 20
    button.Text = text .. ": OFF"
    button.Parent = frame
    return button
end

local autoFarmBtn = createToggleButton("Auto Farm", 10)
local autoAttackBtn = createToggleButton("Auto Attack", 55)

-- Toggle menu visibility
menuButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Toggle auto farm
autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmOn = not autoFarmOn
    autoFarmBtn.Text = "Auto Farm: " .. (autoFarmOn and "ON" or "OFF")
end)

-- Toggle auto attack
autoAttackBtn.MouseButton1Click:Connect(function()
    autoAttackOn = not autoAttackOn
    autoAttackBtn.Text = "Auto Attack: " .. (autoAttackOn and "ON" or "OFF")
end)

-- Funções básicas, substitua pela lógica do seu jogo
local function attackNearestEnemy()
    print("Atacando inimigo...")
end

local function autoFarm()
    print("Farmando...")
end

-- Loop de execução das ações
runService.Heartbeat:Connect(function()
    if autoFarmOn then
        autoFarm()
    end
    if autoAttackOn then
        attackNearestEnemy()
    end
end)

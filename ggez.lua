local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

local autoFarmOn = false
local autoAttackOn = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmAttackGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Logo (ImageLabel) com desenho simples via ImageColor3 e transparência
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
logo.BorderSizePixel = 0
logo.Image = "" -- Sem imagem externa, vamos desenhar com Frame por cima
logo.Parent = screenGui
logo.Active = true
logo.Selectable = true
logo.Draggable = false -- Vamos controlar drag manualmente para maior controle

-- Desenhar um "V" estilizado dentro da logo usando Frames
local function createVShape(parent)
    local line1 = Instance.new("Frame")
    line1.Size = UDim2.new(0, 12, 0, 40)
    line1.Position = UDim2.new(0, 15, 0, 10)
    line1.BackgroundColor3 = Color3.new(0, 1, 0)
    line1.BorderSizePixel = 0
    line1.Rotation = 45
    line1.Parent = parent

    local line2 = Instance.new("Frame")
    line2.Size = UDim2.new(0, 12, 0, 40)
    line2.Position = UDim2.new(0, 33, 0, 10)
    line2.BackgroundColor3 = Color3.new(0, 1, 0)
    line2.BorderSizePixel = 0
    line2.Rotation = -45
    line2.Parent = parent
end

createVShape(logo)

-- Frame do menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

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

-- Toggle menu visibility ao clicar na logo
logo.MouseButton1Click:Connect(function()
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

-- Dragging logic
local dragging = false
local dragInput, dragStart, startPos

logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = logo.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

logo.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        logo.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        -- Atualiza a posição do menu para ficar logo abaixo da logo
        frame.Position = UDim2.new(0, logo.AbsolutePosition.X, 0, logo.AbsolutePosition.Y + logo.AbsoluteSize.Y + 10)
    end
end)

-- Funções placeholders
local function attackNearestEnemy()
    print("Atacando inimigo...")
end

local function autoFarm()
    print("Farmando...")
end

runService.Heartbeat:Connect(function()
    if autoFarmOn then
        autoFarm()
    end
    if autoAttackOn then
        attackNearestEnemy()
    end
end)

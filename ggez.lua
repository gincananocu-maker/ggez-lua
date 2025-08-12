local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

local autoFarmOn = false
local autoAttackOn = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmAttackGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Logo Sharingan
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0, 80, 0, 80)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logo.BorderSizePixel = 0
logo.Active = true
logo.Selectable = true
logo.Parent = screenGui

-- Círculo vermelho principal (base do Sharingan)
local mainCircle = Instance.new("Frame")
mainCircle.Size = UDim2.new(1, 0, 1, 0)
mainCircle.BackgroundColor3 = Color3.fromRGB(178, 34, 34) -- vermelho escuro
mainCircle.BorderSizePixel = 0
mainCircle.Parent = logo
local mainCircleCorner = Instance.new("UICorner")
mainCircleCorner.CornerRadius = UDim.new(1, 0)
mainCircleCorner.Parent = mainCircle

-- Círculo preto interno
local innerCircle = Instance.new("Frame")
innerCircle.Size = UDim2.new(0.6, 0, 0.6, 0)
innerCircle.Position = UDim2.new(0.2, 0, 0.2, 0)
innerCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
innerCircle.BorderSizePixel = 0
innerCircle.Parent = logo
local innerCircleCorner = Instance.new("UICorner")
innerCircleCorner.CornerRadius = UDim.new(1, 0)
innerCircleCorner.Parent = innerCircle

-- Círculo vermelho menor dentro
local smallRedCircle = Instance.new("Frame")
smallRedCircle.Size = UDim2.new(0.3, 0, 0.3, 0)
smallRedCircle.Position = UDim2.new(0.35, 0, 0.35, 0)
smallRedCircle.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
smallRedCircle.BorderSizePixel = 0
smallRedCircle.Parent = logo
local smallRedCircleCorner = Instance.new("UICorner")
smallRedCircleCorner.CornerRadius = UDim.new(1, 0)
smallRedCircleCorner.Parent = smallRedCircle

-- "Pupilas" do Sharingan (três pontinhos pretos ao redor)
local function createDot(angle)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dot.BorderSizePixel = 0
    dot.Parent = logo
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot

    -- Posição circular simples com trigonometria
    local radius = 30
    local centerX, centerY = 40, 40 -- centro do logo (80x80)
    local rad = math.rad(angle)
    local x = centerX + radius * math.cos(rad) - dot.AbsoluteSize.X/2
    local y = centerY + radius * math.sin(rad) - dot.AbsoluteSize.Y/2

    -- Como AbsoluteSize pode não estar pronto, usar posição aproximada com UDim2:
    dot.Position = UDim2.new(0, 40 + radius * math.cos(rad) - 6, 0, 40 + radius * math.sin(rad) - 6)
end

createDot(0)
createDot(120)
createDot(240)

-- Frame do menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 100)
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
logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        frame.Visible = not frame.Visible
    end
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

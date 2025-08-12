-- Variables
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Criar botão com logo Sharingan
local button = Instance.new("ImageButton")
button.Name = "MenuButton"
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(30,30,30)
button.BackgroundTransparency = 0.3
button.Image = "rbxassetid://10520423879"  -- Sharingan logo
button.Parent = screenGui
button.AutoButtonColor = false
button.Active = true
button.Draggable = false

-- Criar Frame do menu (inicialmente invisível)
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Size = UDim2.new(0, 200, 0, 120)
menuFrame.Position = UDim2.new(0, 10, 0, 75)
menuFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
menuFrame.BackgroundTransparency = 0.1
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false
menuFrame.Parent = screenGui

-- Função pra criar botões de toggle
local function createToggle(text, position)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.Position = position
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = menuFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.3, 0, 0.6, 0)
    toggleButton.Position = UDim2.new(0.7, 0, 0.2, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    toggleButton.TextColor3 = Color3.new(1,1,1)
    toggleButton.Text = "OFF"
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextScaled = true
    toggleButton.Parent = toggleFrame

    local toggled = false
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end
    end)

    return toggleButton
end

local autoFarmToggle = createToggle("Auto Farm", UDim2.new(0, 10, 0, 10))
local autoAttackToggle = createToggle("Auto Attack", UDim2.new(0, 10, 0, 60))

-- Toggle menu visibility ao clicar no botão Sharingan
button.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- Permitir arrastar o botão Sharingan pela tela
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
    button.Position = newPos
    menuFrame.Position = UDim2.new(0, newPos.X.Offset, 0, newPos.Y.Offset + 65)
end

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

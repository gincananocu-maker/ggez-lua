local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFarmGui"
ScreenGui.Parent = PlayerGui

-- Criar o botão de logo Sharingan (ImageButton)
local SharinganButton = Instance.new("ImageButton")
SharinganButton.Name = "SharinganButton"
SharinganButton.Parent = ScreenGui
SharinganButton.Size = UDim2.new(0, 60, 0, 60) -- tamanho do botão
SharinganButton.Position = UDim2.new(0, 20, 0, 20) -- posição inicial
SharinganButton.BackgroundTransparency = 1
SharinganButton.Image = "rbxassetid://10520423879" -- Sharingan (exemplo, pode trocar)

-- Criar o frame do menu (inicialmente invisível)
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0, 200, 0, 150)
MenuFrame.Position = UDim2.new(0, 100, 0, 100)
MenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MenuFrame.Visible = false
MenuFrame.Active = true
MenuFrame.Draggable = false -- vamos controlar drag só do botão

-- Função para criar botões do menu
local function createToggleButton(name, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Parent = MenuFrame
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = name .. ": OFF"
    button.AutoButtonColor = true
    return button
end

-- Criar botões auto farm e auto attack
local autoFarmButton = createToggleButton("Auto Farm", UDim2.new(0, 10, 0, 10))
local autoAttackButton = createToggleButton("Auto Attack", UDim2.new(0, 10, 0, 60))

-- Variáveis de controle
local autoFarmEnabled = false
local autoAttackEnabled = false

-- Alternar estados e texto dos botões
autoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmButton.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")
end)

autoAttackButton.MouseButton1Click:Connect(function()
    autoAttackEnabled = not autoAttackEnabled
    autoAttackButton.Text = "Auto Attack: " .. (autoAttackEnabled and "ON" or "OFF")
end)

-- Mostrar/ocultar menu clicando na logo Sharingan
SharinganButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

-- Código para arrastar o SharinganButton
local UserInputService = game:GetService("UserInputService")

local dragging
local dragInput
local dragStart
local startPos

SharinganButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = SharinganButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

SharinganButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        SharinganButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

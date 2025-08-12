local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variáveis controle
local autoFarm = false
local autoAttack = false

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SharinganGui"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- Criar menu (Frame) com fundo semi-transparente
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.7
Frame.Visible = false
Frame.ZIndex = 10
Frame.Parent = ScreenGui

-- Botão Auto Farm
local ToggleButtonFarm = Instance.new("TextButton")
ToggleButtonFarm.Size = UDim2.new(0, 180, 0, 40)
ToggleButtonFarm.Position = UDim2.new(0, 10, 0, 10)
ToggleButtonFarm.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ToggleButtonFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonFarm.Text = "Auto Farm: OFF"
ToggleButtonFarm.ZIndex = 11
ToggleButtonFarm.Parent = Frame

-- Botão Auto Attack
local ToggleButtonAttack = Instance.new("TextButton")
ToggleButtonAttack.Size = UDim2.new(0, 180, 0, 40)
ToggleButtonAttack.Position = UDim2.new(0, 10, 0, 60)
ToggleButtonAttack.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ToggleButtonAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonAttack.Text = "Auto Attack: OFF"
ToggleButtonAttack.ZIndex = 11
ToggleButtonAttack.Parent = Frame

-- Funções para toggles do menu
ToggleButtonFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    ToggleButtonFarm.Text = "Auto Farm: " .. (autoFarm and "ON" or "OFF")
    print("AutoFarm:", autoFarm)
end)

ToggleButtonAttack.MouseButton1Click:Connect(function()
    autoAttack = not autoAttack
    ToggleButtonAttack.Text = "Auto Attack: " .. (autoAttack and "ON" or "OFF")
    print("AutoAttack:", autoAttack)
end)

-- Função Auto Farm (placeholder)
spawn(function()
    while true do
        wait(1)
        if autoFarm then
            print("Farmando...")
        end
    end
end)

-- Função Auto Attack (placeholder)
spawn(function()
    while true do
        wait(0.5)
        if autoAttack then
            print("Atacando...")
        end
    end
end)

-- Botão Sharingan arrastável
local SharinganButton = Instance.new("ImageButton")
SharinganButton.Size = UDim2.new(0, 60, 0, 60)
SharinganButton.Position = UDim2.new(0, 20, 0, 20)
SharinganButton.BackgroundTransparency = 1
SharinganButton.BorderSizePixel = 0
SharinganButton.ZIndex = 12
SharinganButton.Parent = ScreenGui
SharinganButton.Image = "rbxassetid://1176481231" -- Certifique que esta imagem é pública e válida

-- Variáveis para arrastar
local dragging = false
local dragInput, mousePos, framePos

SharinganButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = SharinganButton.Position

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
        local delta = input.Position - mousePos
        SharinganButton.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Abrir/fechar menu ao clicar no botão Sharingan
SharinganButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
    print("Menu visível?", Frame.Visible)
end)

print("Sharingan GUI carregada com sucesso!")

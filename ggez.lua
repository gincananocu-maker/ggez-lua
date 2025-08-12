local RunService = game:GetService("RunService")
if not RunService:IsClient() then return end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variáveis controle
local autoFarm = false
local autoAttack = false

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "SharinganGui"
ScreenGui.ResetOnSpawn = false

-- Criar menu (Frame) com fundo semi-transparente
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 170)
Frame.Position = UDim2.new(0, 80, 0, 80)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.7
Frame.Visible = false
Frame.ZIndex = 10
Frame.Parent = ScreenGui

local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.ZIndex = 11
    btn.Parent = Frame
    return btn
end

-- Botões do menu
local ToggleButtonFarm = createButton("Auto Farm: OFF", 10)
local ToggleButtonAttack = createButton("Auto Attack: OFF", 60)
local QuitButton = createButton("Quit", 110)

-- Toggle funções
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

QuitButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    print("Menu fechado")
end)

-- Funções placeholders que printam no output
spawn(function()
    while true do
        wait(1)
        if autoFarm then
            print("Farmando...")
        end
    end
end)

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
SharinganButton.Image = "rbxassetid://1176481231" -- imagem Sharingan pública

-- Dragging vars
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

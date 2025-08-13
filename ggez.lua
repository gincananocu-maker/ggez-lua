local RunService = game:GetService("RunService")
if not RunService:IsClient() then return end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "SharinganGui"

-- Criar Frame do menu
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 180)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BackgroundTransparency = 0.8
Frame.Visible = false
Frame.Parent = ScreenGui

-- Bordas arredondadas e borda suave
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = Frame

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(100, 100, 100)
border.Thickness = 2
border.Parent = Frame

-- Variáveis de toggle
local autoFarm = false
local autoAttack = false

-- Botão Auto Farm
local ToggleButtonFarm = Instance.new("TextButton")
ToggleButtonFarm.Size = UDim2.new(0, 200, 0, 40)
ToggleButtonFarm.Position = UDim2.new(0, 10, 0, 20)
ToggleButtonFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButtonFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonFarm.Font = Enum.Font.SourceSansBold
ToggleButtonFarm.TextSize = 20
ToggleButtonFarm.Text = "Auto Farm: OFF"
ToggleButtonFarm.Parent = Frame

ToggleButtonFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    ToggleButtonFarm.Text = "Auto Farm: " .. (autoFarm and "ON" or "OFF")
end)

-- Botão Auto Attack
local ToggleButtonAttack = Instance.new("TextButton")
ToggleButtonAttack.Size = UDim2.new(0, 200, 0, 40)
ToggleButtonAttack.Position = UDim2.new(0, 10, 0, 70)
ToggleButtonAttack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButtonAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonAttack.Font = Enum.Font.SourceSansBold
ToggleButtonAttack.TextSize = 20
ToggleButtonAttack.Text = "Auto Attack: OFF"
ToggleButtonAttack.Parent = Frame

ToggleButtonAttack.MouseButton1Click:Connect(function()
    autoAttack = not autoAttack
    ToggleButtonAttack.Text = "Auto Attack: " .. (autoAttack and "ON" or "OFF")
end)

-- Botão Quit
local QuitButton = Instance.new("TextButton")
QuitButton.Size = UDim2.new(0, 200, 0, 40)
QuitButton.Position = UDim2.new(0, 10, 0, 120)
QuitButton.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
QuitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
QuitButton.Font = Enum.Font.SourceSansBold
QuitButton.TextSize = 20
QuitButton.Text = "Quit"
QuitButton.Parent = Frame

QuitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão Sharingan arrastável
local SharinganButton = Instance.new("ImageButton")
SharinganButton.Size = UDim2.new(0, 60, 0, 60)
SharinganButton.Position = UDim2.new(0, 20, 0, 20)
SharinganButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SharinganButton.BackgroundTransparency = 1
SharinganButton.BorderSizePixel = 0
SharinganButton.Parent = ScreenGui
SharinganButton.Image = "rbxassetid://6023426915" -- Ícone oficial Roblox

-- Variáveis para drag
local dragging = false
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

-- Mostrar/ocultar menu ao clicar no botão
SharinganButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Placeholders das funções Auto Farm e Auto Attack
spawn(function()
    while true do
        wait(1)
        if autoFarm then
            print("Farmando...")
            -- Lógica do Auto Farm aqui
        end
    end
end)

spawn(function()
    while true do
        wait(0.5)
        if autoAttack then
            print("Atacando...")
            -- Lógica do Auto Attack aqui
        end
    end
end)

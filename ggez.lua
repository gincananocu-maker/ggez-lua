local RunService = game:GetService("RunService")
if not RunService:IsClient() then return end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "CheatGui"

-- Criar Frame do menu
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 300)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BackgroundTransparency = 0.8
Frame.Visible = false
Frame.Parent = ScreenGui

-- Bordas arredondadas e borda suave
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = Frame

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(100, 100, 100)
border.Thickness = 2
border.Parent = Frame

-- Variables toggles
local toggles = {
    autoFarm = false,
    autoAttack = false,
    esp = false,
    speedHack = false,
    teleport = false,
}

-- Função para criar botões toggle
local function createToggleButton(text, posY, toggleName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Text = text .. ": OFF"
    btn.Parent = Frame

    btn.MouseButton1Click:Connect(function()
        toggles[toggleName] = not toggles[toggleName]
        btn.Text = text .. ": " .. (toggles[toggleName] and "ON" or "OFF")
        print(text .. " toggled to " .. (toggles[toggleName] and "ON" or "OFF"))
    end)

    return btn
end

-- Criar botões
createToggleButton("Auto Farm", 20, "autoFarm")
createToggleButton("Auto Attack", 70, "autoAttack")
createToggleButton("ESP", 120, "esp")
createToggleButton("Speed Hack", 170, "speedHack")
createToggleButton("Teleport", 220, "teleport")

-- Botão Quit
local QuitButton = Instance.new("TextButton")
QuitButton.Size = UDim2.new(0, 280, 0, 40)
QuitButton.Position = UDim2.new(0, 10, 0, 270)
QuitButton.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
QuitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
QuitButton.Font = Enum.Font.SourceSansBold
QuitButton.TextSize = 20
QuitButton.Text = "Quit"
QuitButton.Parent = Frame

QuitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão arrastável Sharingan
local SharinganButton = Instance.new("ImageButton")
SharinganButton.Size = UDim2.new(0, 60, 0, 60)
SharinganButton.Position = UDim2.new(0, 20, 0, 20)
SharinganButton.BackgroundTransparency = 1
SharinganButton.BorderSizePixel = 0
SharinganButton.Parent = ScreenGui
SharinganButton.Image = "rbxassetid://7072718101" -- ícone azul transparente

-- Dragging vars
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

-- Clique abre/fecha menu (se não estiver arrastando)
SharinganButton.MouseButton1Click:Connect(function()
    if not dragging then
        Frame.Visible = not Frame.Visible
    end
end)

-- Placeholders dos loops para as funções ativas
spawn(function()
    while true do
        wait(1)
        if toggles.autoFarm then
            print("Auto Farm ativo")
            -- lógica real aqui
        end
    end
end)

spawn(function()
    while true do
        wait(0.5)
        if toggles.autoAttack then
            print("Auto Attack ativo")
            -- lógica real aqui
        end
    end
end)

spawn(function()
    while true do
        wait(1)
        if toggles.esp then
            print("ESP ativo")
            -- lógica real aqui
        end
    end
end)

spawn(function()
    while true do
        wait(0.1)
        if toggles.speedHack then
            print("Speed Hack ativo")
            -- lógica real aqui
        end
    end
end)

spawn(function()
    while true do
        wait(0.1)
        if toggles.teleport then
            print("Teleport ativo")
            -- lógica real aqui
        end
    end
end)

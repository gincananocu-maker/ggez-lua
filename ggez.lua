local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "TestGui"
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0, 50, 0, 50)
Button.Text = "Botão Teste"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.Parent = ScreenGui

print("Teste GUI criado")

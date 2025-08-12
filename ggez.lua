local RunService = game:GetService("RunService")
if not RunService:IsClient() then
    warn("Não está rodando no cliente!")
    return
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TestGui"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0, 50, 0, 50)
Button.Text = "Botão Teste"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.Parent = ScreenGui

print("Test GUI criado com sucesso!")

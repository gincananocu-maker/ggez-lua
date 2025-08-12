local RunService = game:GetService("RunService")
if not RunService:IsClient() then return end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "TesteGui"

local Button = Instance.new("TextButton", ScreenGui)
Button.Size = UDim2.new(0, 200, 0, 50)
Button.Position = UDim2.new(0, 100, 0, 100)
Button.Text = "Clique aqui"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

Button.MouseButton1Click:Connect(function()
    print("Botão clicado!")
end)

print("GUI criada com sucesso.")

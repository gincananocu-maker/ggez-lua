local RunService = game:GetService("RunService")
if not RunService:IsClient() then return end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "TestGui"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.5
Frame.Visible = true
Frame.Parent = ScreenGui

local SharinganButton = Instance.new("ImageButton")
SharinganButton.Size = UDim2.new(0, 60, 0, 60)
SharinganButton.Position = UDim2.new(0, 50, 0, 20)
SharinganButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SharinganButton.BackgroundTransparency = 0
SharinganButton.BorderSizePixel = 0
SharinganButton.Parent = ScreenGui
SharinganButton.Image = ""

SharinganButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

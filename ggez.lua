-- Script para Vox Sea com autor modificado para ystresser

local _ENV = (getgenv or getrenv or getfenv)()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local DialogueEvent = ReplicatedStorage.BetweenSides.Remotes.Events.DialogueEvent
local CombatEvent = ReplicatedStorage.BetweenSides.Remotes.Events.CombatEvent
local ToolEvent = ReplicatedStorage.BetweenSides.Remotes.Events.ToolsEvent
local QuestsNpcs = workspace.IgnoreList.Int.NPCs.Quests
local Enemys = workspace.Playability.Enemys
local QuestsDecriptions = require(ReplicatedStorage.MainModules.Essentials.QuestDescriptions)
local EnemiesFolders = {}
local CFrameAngle = CFrame.Angles(math.rad(-90), 0, 0)

local function a()
    local QuestsList = {}
    local CurrentQuest = nil
    local CurrentLevel = -1

    for _, QuestData in QuestsDecriptions do
        if QuestData.Goal <= 1 then continue end
        table.insert(QuestsList, { Level = QuestData.MinLevel, Target = QuestData.Target, NpcName = QuestData.Npc, Id = QuestData.Id })
    end

    table.sort(QuestsList, function(a, b) return a.Level > b.Level end)

    local function b()
        local Level = nil
        local success, result = pcall(function()
            local mainUI = Player.PlayerGui:FindFirstChild("MainUI")
            if mainUI then
                local mainFrame = mainUI:FindFirstChild("MainFrame")
                if mainFrame then
                    local statsFrame = mainFrame:FindFirstChild("StastisticsFrame") or mainFrame:FindFirstChild("StatisticsFrame")
                    if statsFrame then
                        local levelBG = statsFrame:FindFirstChild("LevelBackground")
                        if levelBG then
                            local levelText = levelBG:FindFirstChild("Level")
                            if levelText and levelText.Text then
                                return tonumber(levelText.Text)
                            end
                        end
                        for _, child in pairs(statsFrame:GetDescendants()) do
                            if child:IsA("TextLabel") and child.Text:match("^%d+$") then
                                local num = tonumber(child.Text)
                                if num and num >= 1 and num <= 2000 then
                                    return num
                                end
                            end
                        end
                    end
                end
            end
            return 1
        end)
        if success and result then
            Level = result
        else
            Level = 1
        end
        if Level == CurrentLevel then
            return CurrentQuest
        end
        for _, QuestData in QuestsList do
            if QuestData.Level <= Level then
                CurrentLevel, CurrentQuest = Level, QuestData
                return QuestData
            end
        end
        return nil
    end
    return b()
end

local Settings = {
    ClickV2 = false,
    TweenSpeed = 270,
    SelectedTool = "CombatType",
    BringMobDistance = 35,
    dSpeed = 0.05,
    NoClip = false,
    AutoStats = false,
    SelectedStat = "Strength"
}

local EquippedTool = nil
local CurrentTarget = nil
local conepc = _ENV.cnn or {}
_ENV.cnn = conepc

for i = 1, #conepc do
    conepc[i]:Disconnect()
end
table.clear(conepc)

local function c(Character)
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        return Humanoid and Humanoid.Health > 0
    end
end

local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Velocity = Vector3.zero
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.P = 1000

if _ENV.tween_bodyvelocity then
    _ENV.tween_bodyvelocity:Destroy()
end
_ENV.tween_bodyvelocity = BodyVelocity

local CanCollideObjects = {}

local function ss(Object)
    if Object:IsA("BasePart") and Object.CanCollide then
        table.insert(CanCollideObjects, Object)
    end
end

local function rrr(BasePart)
    local index = table.find(CanCollideObjects, BasePart)
    if index then
        table.remove(CanCollideObjects, index)
    end
end

local function ne(Character)
    table.clear(CanCollideObjects)
    for _, Object in Character:GetDescendants() do
        ss(Object)
    end
    Character.DescendantAdded:Connect(ss)
    Character.DescendantRemoving:Connect(rrr)
end

table.insert(conepc, Player.CharacterAdded:Connect(ne))
task.spawn(ne, Player.Character)

local function np(Character)
    if _ENV.OnFarm then
        for i = 1, #CanCollideObjects do
            CanCollideObjects[i].CanCollide = false
        end
    elseif Character.PrimaryPart and not Character.PrimaryPart.CanCollide then
        for i = 1, #CanCollideObjects do
            CanCollideObjects[i].CanCollide = true
        end
    end
end

local function upe(Character)
    local BasePart = Character:FindFirstChild("UpperTorso")
    local Humanoid = Character:FindFirstChild("Humanoid")
    local BodyVelocity = _ENV.tween_bodyvelocity
    if _ENV.OnFarm and BasePart and Humanoid and Humanoid.Health > 0 then
        if BodyVelocity.Parent ~= BasePart then
            BodyVelocity.Parent = BasePart
        end
    elseif BodyVelocity.Parent then
        BodyVelocity.Parent = nil
    end
    if BodyVelocity.Velocity ~= Vector3.zero and (not Humanoid or not Humanoid.SeatPart or not _ENV.OnFarm) then
        BodyVelocity.Velocity = Vector3.zero
    end
end

table.insert(conepc, RunService.Stepped:Connect(function()
    local Character = Player.Character
    if c(Character) then
        upe(Character)
        np(Character)
    end
end))

local TweenCreator = {}
TweenCreator.__index = TweenCreator
local tweens = {}
local EasingStyle = Enum.EasingStyle.Linear

function TweenCreator.new(obj, time, prop, value)
    local tween = TweenService:Create(obj, TweenInfo.new(time, EasingStyle), { [prop] = value })
    table.insert(tweens, tween)
    return tween
end

function TweenCreator:Play()
    for _, tween in pairs(tweens) do
        tween:Play()
    end
end

function TweenCreator:Cancel()
    for _, tween in pairs(tweens) do
        tween:Cancel()
    end
end

function TweenCreator:Destroy()
    for _, tween in pairs(tweens) do
        tween:Destroy()
    end
end

return TweenCreator

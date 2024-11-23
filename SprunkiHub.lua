local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Main = OrionLib:MakeWindow({Name = "SprunkiHub", HidePremium = false, SaveConfig = true, ConfigFolder = "SprunkiHubConfig"})

local highlightEnabled = false
local destroyEnabled = false
local godModeEnabled = false

local function highlightRandomObjects()
for _, obj in pairs(game.Workspace:GetChildren()) do
if obj:IsA("Model") and not game.Players:GetPlayerFromCharacter(obj) then
if math.random() > 0.5 then
local highlight = Instance.new("Highlight")
highlight.Adornee = obj
highlight.FillColor = Color3.new(1, 0, 0) -- vermelho
highlight.OutlineColor = Color3.new(1, 0, 0) -- vermelho
highlight.Parent = obj
end
end
end
end

local function removeHighlights()
for _, obj in pairs(game.Workspace:GetChildren()) do
if obj:FindFirstChild("Highlight") then
obj.Highlight:Destroy()
end
end
end

local function destroyRandomObjects()
for _, obj in pairs(game.Workspace:GetChildren()) do
if obj:IsA("Model") and not game.Players:GetPlayerFromCharacter(obj) then
if math.random() > 0.5 then
obj:Destroy()
end
end
end
end

local function teleportToPlayer(playerName)
local player = game.Players:FindFirstChild(playerName)
if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
end
end

local function toggleGodMode()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

if godModeEnabled then
humanoid.MaxHealth = math.huge
humanoid.Health = math.huge
else
humanoid.MaxHealth = 100
humanoid.Health = 100
end
end

local function flingAll()
for _, player in pairs(game.Players:GetPlayers()) do
if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 100, 0)
bodyVelocity.P = 10000
bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
bodyVelocity.Parent = player.Character.HumanoidRootPart
wait(0.1)
bodyVelocity:Destroy()
end
end
end

Main:AddSection({
Name = "Highlight"
})

Main:AddToggle({
Name = "Toggle Highlight",
Default = false,
Callback = function(value)
highlightEnabled = value
if highlightEnabled then
highlightRandomObjects()
else
removeHighlights()
end
end
})

Main:AddSection({
Name = "Destroy"
})

Main:AddToggle({
Name = "Toggle Destroy",
Default = false,
Callback = function(value)
destroyEnabled = value
if destroyEnabled then
destroyRandomObjects()
end
end
})

Main:AddSection({
Name = "Admin Powers"
})

Main:AddTextbox({
Name = "Teleport to Player",
Default = "",
TextDisappear = false,
Callback = function(value)
teleportToPlayer(value)
end
})

Main:AddToggle({
Name = "Toggle God Mode",
Default = false,
Callback = function(value)
godModeEnabled = value
toggleGodMode()
end
})

Main:AddButton({
Name = "Fling All",
Callback = function()
flingAll()
end
})

OrionLib:Init()

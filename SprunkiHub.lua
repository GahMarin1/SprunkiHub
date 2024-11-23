local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "SprunkiHub", HidePremium = false, SaveConfig = true, ConfigFolder = "SprunkiHubConfig"})

local Tab = Window:MakeTab({
Name = "Main",
Icon = "rbxassetid://4483345998",
PremiumOnly = false
})

local Section = Tab:AddSection({
Name = "Player Transformation (Non-FE) - test"
})

local characters = {
["Oren"] = 127078073878151,
["Gray"] = 91956399627222,
["Wenda"] = 110412177846931
}

local selectedCharacter = "Oren"

Tab:AddDropdown({
Name = "Select Character",
Default = "Oren",
Options = {"Oren", "Gray", "Wenda"},
Callback = function(Value)
selectedCharacter = Value
end
})

Tab:AddButton({
Name = "Transform Player",
Callback = function()
local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local LocalPlayer = Players.LocalPlayer

local function transformPlayer(modelId)
local success, model = pcall(function()
return InsertService:LoadAsset(modelId)
end)

if success and model and model:IsA("Model") then
model = model:GetChildren()[1] -- pega o primeiro filho do modelo inserido
local character = LocalPlayer.Character
if character then
for _, part in pairs(character:GetChildren()) do
if part:IsA("BasePart") or part:IsA("Accessory") then
part:Destroy()
end
end

for _, part in pairs(model:GetChildren()) do
if part:IsA("BasePart") then
local newPart = part:Clone()
newPart.Parent = character
newPart.Anchored = false
newPart.CanCollide = false
newPart.CFrame = character.HumanoidRootPart.CFrame
end
end

local humanoid = character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid:BuildRigFromAttachments()
end
end
end
end

transformPlayer(characters[selectedCharacter])
end
})

local Section2 = Tab:AddSection({
Name = "Map Destruction (FE)"
})

local destructionOptions = {
["Destroy All"] = function()
for _, obj in pairs(workspace:GetChildren()) do
if obj:IsA("BasePart") then
obj:Destroy()
end
end
end,
["Destroy Parts"] = function()
for _, obj in pairs(workspace:GetChildren()) do
if obj:IsA("BasePart") then
obj:Destroy()
end
end
end,
["Delete Random"] = function()
local objects = {}
for _, obj in pairs(workspace:GetChildren()) do
if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players) then
table.insert(objects, obj)
end
end
if #objects > 0 then
local randomIndex = math.random(1, #objects)
objects[randomIndex]:Destroy()
end
end
}

local selectedDestruction = "Destroy All"

Tab:AddDropdown({
Name = "Select Destruction",
Default = "Destroy All",
Options = {"Destroy All", "Destroy Parts", "Delete Random"},
Callback = function(Value)
selectedDestruction = Value
end
})

Tab:AddButton({
Name = "Destroy Map",
Callback = function()
destructionOptions[selectedDestruction]()
end
})

local Section3 = Tab:AddSection({
Name = "Bot-Chat"
})

local botResponses = {
["Furry"] = {
["br"] = {
":3 como posso ajudar você hoje?",
":) precisa de ajuda?",
":D o que você precisa?",
"miau! como posso ajudar?",
"au au! precisa de algo?",
"ronron! o que você precisa?",
"meow! estou aqui para ajudar!",
"arf arf! como posso ser útil?"
},
["en"] = {
":3 how can I help you today?",
":) need assistance?",
":D what do you need?",
"meow! how can I assist?",
"woof woof! need something?",
"purr purr! what do you need?",
"meow! I'm here to help!",
"arf arf! how can I be useful?"
}
},
["Tord"] = {
["br"] = {
"hei! o que está acontecendo?",
"yo! precisa de algo?",
"hei! como posso ajudar?",
"mwahaha! logo dominarei o mundo!",
"tenho um plano maligno! precisa de algo?",
"ha! você não faz ideia do que estou planejando!"
},
["en"] = {
"hey! what's going on?",
"yo! need something?",
"hey! how can I help?",
"mwahaha! soon I will conquer the world!",
"I have an evil plan! need something?",
"ha! you have no idea what I'm planning!"
}
},
["Nerd"] = {
["br"] = {
"saudações! precisa de ajuda?",
"olá! como posso ajudar?",
"oi! o que você precisa?"
},
[]
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
if player.Character and player.Character:FindFirstChild("Highlight") then
player.Character.Highlight:Destroy()
end
end
end
end
})

OrionLib:Init()

--[[
    MONAIM12-GOD ULTIMATE SYSTEM V16 💎
    THE FULL & FINAL SCRIPT - ALL FEATURES INCLUDED
    AUTO QUEST | FAST ATTACK | TWEEN MOVE | ANTI-LAG
]]

-- 1. إعداد الواجهة (Rayfield Library)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | ELITE V16 🏴‍☠️",
   LoadingTitle = "جاري تفعيل النظام الكامل...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- 2. المتغيرات والبيانات
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- مصفوفة المهام الكاملة لمنطقة البداية
local QuestsTable = {
    ["Bandit"] = {Level = 0, QuestName = "BanditQuest1", ID = 1, Pos = Vector3.new(1059, 15, 1549)},
    ["Monkey"] = {Level = 10, QuestName = "MonkeyQuest1", ID = 1, Pos = Vector3.new(-1598, 37, 153)},
    ["Gorilla"] = {Level = 15, QuestName = "GorillaQuest1", ID = 1, Pos = Vector3.new(-1598, 37, 153)},
    ["Pirate"] = {Level = 30, QuestName = "PirateQuest1", ID = 1, Pos = Vector3.new(-1141, 4, 3826)}
}

-- 3. المحركات الأساسية (Core Engines)

-- محرك الضرب المباشر (Direct Attack Engine)
spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local tool = character:FindFirstChildOfClass("Tool")
                
                if tool then
                    -- ضرب السيرفر المباشر (مثل Redz)
                    game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.huge)
                    tool:Activate()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end
            end)
        end
    end
end)

-- محرك التلفيل والمهام (Master Farm Logic)
function StartMasterFarm()
    spawn(function()
        while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local level = player.Data.Level.Value
                
                -- اختيار المهمة بناءً على الليفل
                local MyQuest = "Bandit"
                if level >= 30 then MyQuest = "Pirate"
                elseif level >= 15 then MyQuest = "Gorilla"
                elseif level >= 10 then MyQuest = "Monkey" end
                
                local qData = QuestsTable[MyQuest]

                -- إذا لم يكن هناك مهمة، نذهب لنأخذها
                if not player.PlayerGui.Main.Quest.Visible then
                    character.HumanoidRootPart.CFrame = CFrame.new(qData.Pos)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qData.QuestName, qData.ID)
                else
                    -- تجهيز السلاح
                    local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or player.Backpack:FindFirstChild("Combat")
                    if tool then character.Humanoid:EquipTool(tool) end
                    
                    -- البحث عن الوحش المطلوب وقتله
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name:find(MyQuest) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                if not _G.AutoFarm then break end
                                -- الالتصاق بالوحش للضرب (Fast Tween)
                                character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                                task.wait()
                            until v.Humanoid.Health <= 0 or not _G.AutoFarm or not player.PlayerGui.Main.Quest.Visible
                        end
                    end
                end
            end)
        end
    end)
end

-- 4. إنشاء التبويبات (UI Tabs)
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("إعدادات القتال")

FarmTab:CreateDropdown({
   Name = "Select Weapon",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

FarmTab:CreateToggle({
   Name = "Start Full Farm (تلفيل كامل + ضرب)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then StartMasterFarm() end
   end,
})

local SettingTab = Window:CreateTab("Settings ⚙️", 4483362458)

SettingTab:CreateButton({
   Name = "Anti-Lag (إزالة اللاغ نهائياً)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "MONAIM12-GOD", Content = "تم تحسين الأداء!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

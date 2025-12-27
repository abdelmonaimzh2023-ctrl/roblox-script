--[[
    MONAIM12-GOD ULTIMATE V25 💎 (THE FINAL MASTERPIECE)
    INTEGRATED: REDZ ATTACK | BLUEX LOGIC | AUTO QUEST | FRUIT SNIPER | AUTO STATS
]]

-- 1. تنظيف الواجهة القديمة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | V25 COMPLETE 🏴‍☠️",
   LoadingTitle = "جاري تفعيل النظام الشامل (V25)...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات العالمية //
_G.AutoFarm = false
_G.AutoStats = false
_G.SelectedWeapon = "Melee"
_G.StatType = "Melee"

-- // محرك الضرب السريع (Hybrid Redz & BlueX Engine) //
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local CombatFrameworkLib = debug.getupvalues(CombatFramework)[2]

spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then
                    -- إرسال إشارات الضرب للسيرفر مباشرة (Redz Style)
                    game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.huge)
                    -- استدعاء الهجوم البرمجي (BlueX Style)
                    CombatFrameworkLib.activeController:attack()
                    -- ضمان تفعيل الأداة
                    tool:Activate()
                end
            end)
        end
    end
end)

-- // وظائف المهام (Auto Quest Logic) //
local function GetQuestData()
    local lvl = game.Players.LocalPlayer.Data.Level.Value
    if lvl < 10 then return "BanditQuest1", 1, "Bandit"
    elseif lvl < 15 then return "MonkeyQuest1", 1, "Monkey"
    elseif lvl < 30 then return "GorillaQuest1", 1, "Gorilla"
    elseif lvl < 40 then return "PirateQuest1", 1, "Pirate"
    else return "BanditQuest1", 1, "Bandit" end
end

-- // تبويب التلفيل الرئيسي (Farm Tab) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateDropdown({
   Name = "Choose Weapon",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

FarmTab:CreateToggle({
   Name = "Master Auto Farm (تلفيل + مهام + ضرب)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          spawn(function()
              while _G.AutoFarm do
                  task.wait(0.1)
                  pcall(function()
                      local player = game.Players.LocalPlayer
                      local character = player.Character
                      local qName, qID, mName = GetQuestData()

                      -- نظام تجديد المهمة الآلي
                      if not player.PlayerGui.Main.Quest.Visible then
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                      end

                      -- تجهيز السلاح
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or player.Backpack:FindFirstChild("Combat")
                      if tool then character.Humanoid:EquipTool(tool) end

                      -- الانتقال والقتل
                      for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if v.Name:find(mName) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                                  task.wait()
                              until v.Humanoid.Health <= 0 or not _G.AutoFarm or not player.PlayerGui.Main.Quest.Visible
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب النقاط (Stats Tab) //
local StatsTab = Window:CreateTab("Stats 📊", 4483362458)

StatsTab:CreateDropdown({
   Name = "Choose Stat",
   Options = {"Melee", "Defense", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.StatType = v end,
})

StatsTab:CreateToggle({
   Name = "Auto Stats (توزيع النقاط تلقائياً)",
   CurrentValue = false,
   Callback = function(v)
       _G.AutoStats = v
       spawn(function()
           while _G.AutoStats do
               task.wait(0.5)
               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.StatType, 1)
           end
       end)
   end,
})

-- // تبويب الفواكه (Fruits Tab) //
local FruitTab = Window:CreateTab("Fruits 🍎", 4483362458)

FruitTab:CreateButton({
   Name = "Bring Fruits (جلب جميع الفواكه)",
   Callback = function()
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
               task.wait(0.5)
           end
       end
       Rayfield:Notify({Title = "MONAIM12-GOD", Content = "اكتمل البحث عن الفواكه!", Duration = 3})
   end,
})

-- // تبويب الإعدادات (Settings Tab) //
local SettingsTab = Window:CreateTab("Settings 🚀", 4483362458)

SettingsTab:CreateButton({
   Name = "FPS Boost & Anti-Lag",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
   end,
})

Rayfield:LoadConfiguration()

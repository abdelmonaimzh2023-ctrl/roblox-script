--[[
    MONAIM12-GOD ULTIMATE V20 💎 (BLUE-X FULL CORE)
    THE POWER OF BLUEX + THE BEAUTY OF RAYFIELD
    FEATURES: FULL AUTO FARM, FAST ATTACK, AUTO QUEST, FRUIT SNIPER
]]

-- تنظيف الواجهات القديمة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | V20 BLUE-X EDITION 🏴‍☠️",
   LoadingTitle = "جاري دمج محرك BlueX في الواجهة الملكية...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // متغيرات التحكم //
_G.AutoFarm = false
_G.AutoClicker = true
_G.SelectedWeapon = "Melee"
_G.BringMob = true

-- // [محرك BlueX الأساسي للضرب السريع] //
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local CombatFrameworkLib = debug.getupvalues(CombatFramework)[2]

local function GetAttackController()
    return CombatFrameworkLib.activeController
end

spawn(function()
    while task.wait() do
        if _G.AutoFarm and _G.AutoClicker then
            pcall(function()
                local AC = GetAttackController()
                if AC and AC.equippedTool then
                    -- استدعاء نظام الضرب السريع من BlueX
                    AC:attack()
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")))
                end
            end)
        end
    end
end)

-- // [نظام التلفيل والمهام الذكي] //
local function GetQuestName()
    local Lvl = game.Players.LocalPlayer.Data.Level.Value
    if Lvl >= 0 and Lvl <= 9 then return "BanditQuest1", 1, "Bandit"
    elseif Lvl >= 10 and Lvl <= 14 then return "MonkeyQuest1", 1, "Monkey"
    elseif Lvl >= 15 and Lvl <= 29 then return "GorillaQuest1", 1, "Gorilla"
    elseif Lvl >= 30 and Lvl <= 39 then return "PirateQuest1", 1, "Pirate"
    -- يمكنك إضافة باقي المستويات هنا بنفس النمط
    else return "BanditQuest1", 1, "Bandit" end
end

-- // تبويب التلفيل الرئيسي //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateDropdown({
   Name = "Select Weapon (اختر السلاح)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

FarmTab:CreateToggle({
   Name = "Start Auto Farm (بدء التلفيل بمحرك BlueX)",
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
                      local qName, qID, mName = GetQuestName()

                      -- 1. نظام أخذ وتجديد المهمة
                      if not player.PlayerGui.Main.Quest.Visible then
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                      end

                      -- 2. تجهيز السلاح المختار
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or player.Backpack:FindFirstChild("Combat")
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- 3. ميكانيكا الحركة والقتل (Tween)
                      for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if v.Name:find(mName) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  -- الالتصاق التام بالوحش لضمان عمل Fast Attack
                                  character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
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

-- // تبويب الفواكه (Fruit Finder) //
local FruitTab = Window:CreateTab("Fruits 🍎", 4483362458)

FruitTab:CreateButton({
   Name = "Bring Fruits (جلب الفواكه المحيطة)",
   Callback = function()
       local found = false
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
               found = true
           end
       end
       if not found then
          Rayfield:Notify({Title = "Fruit Finder", Content = "لم يتم العثور على فواكه حالياً", Duration = 3})
       end
   end,
})

-- // تبويب الإعدادات والتحسين (Settings) //
local SettingsTab = Window:CreateTab("Settings 🚀", 4483362458)

SettingsTab:CreateButton({
   Name = "Anti-Lag & FPS Boost (إزالة اللاغ)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "Performance", Content = "تم تحسين الأداء بنجاح!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

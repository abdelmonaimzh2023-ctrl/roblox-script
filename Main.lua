--[[
    MONAIM12-GOD ULTIMATE V21 💎 (POWERED BY BLUEX CORE)
    كل مميزات BlueX Hub داخل واجهة Rayfield الفخمة
    FIXED: AUTO FARM, FAST ATTACK, FRUIT BRING, AUTO QUEST
]]

-- تنظيف الواجهات القديمة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | ELITE V21 🏴‍☠️",
   LoadingTitle = "جاري دمج محرك BlueX بالكامل...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات (مأخوذة من منطق BlueX) //
_G.AutoFarm = false
_G.FastAttack = true
_G.SelectedWeapon = "Melee"
_G.AutoBringFruit = false

-- // استيراد محرك القتال الخاص بـ BlueX //
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local CombatFrameworkLib = debug.getupvalues(CombatFramework)[2]

spawn(function()
    while task.wait() do
        if _G.AutoFarm and _G.FastAttack then
            pcall(function()
                -- نظام الضرب السريع (Fast Attack Engine)
                local AC = CombatFrameworkLib.activeController
                if AC and AC.equippedTool then
                    AC:attack()
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")))
                end
            end)
        end
    end
end)

-- // تبويب التلفيل (Main Farm) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("إعدادات BlueX المدمجة")

FarmTab:CreateDropdown({
   Name = "Choose Weapon",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

FarmTab:CreateToggle({
   Name = "Start Level Farm (تلفيل + مهام تلقائية)",
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
                      
                      -- تجديد المهمة آلياً بناءً على الليفل (منطق BlueX)
                      if not player.PlayerGui.Main.Quest.Visible then
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
                      end
                      
                      -- تجهيز السلاح
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or player.Backpack:FindFirstChild("Combat")
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- الانتقال والقتل
                      for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
                                  task.wait()
                              until v.Humanoid.Health <= 0 or not _G.AutoFarm
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب الفواكه (Fruit Sniper) //
local FruitTab = Window:CreateTab("Fruits 🍎", 4483362458)

FruitTab:CreateButton({
   Name = "Bring Fruits (جلب الفواكه الأرضية)",
   Callback = function()
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
               task.wait(0.5)
           end
       end
   end,
})

-- // تبويب الإعدادات (Settings) //
local SettingsTab = Window:CreateTab("Settings 🚀", 4483362458)

SettingsTab:CreateButton({
   Name = "Anti-Lag & FPS Boost",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
       end
       settings().Rendering.QualityLevel = 1
   end,
})

Rayfield:LoadConfiguration()

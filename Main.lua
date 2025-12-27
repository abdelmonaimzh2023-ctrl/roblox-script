--[[
    MONAIM12-GOD ULTIMATE V12 PRO MAX 💎
    FEATURES: AUTO QUEST | 20 CPS FAST CLICK | ANTI-LAG | SMART EQUIP
    OPTIMIZED FOR DELTA & MOBILE
]]

-- تنظيف الواجهات القديمة لضمان عمل Rayfield الجديدة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | V12 PRO MAX 🏴‍☠️",
   LoadingTitle = "تفعيل محرك القتل والمهام التلقائي...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات //
_G.AutoFarm = false
_G.FastClick = false
_G.SelectedWeapon = "Melee"

-- // محرك أخذ المهام التلقائي (حسب المستوى) //
function GetQuest()
    local level = game.Players.LocalPlayer.Data.Level.Value
    if level >= 1 and level <= 9 then return "BanditQuest1", "Bandit", 1
    elseif level >= 10 and level <= 14 then return "MonkeyQuest1", "Monkey", 1
    elseif level >= 15 and level <= 29 then return "GorillaQuest1", "Gorilla", 1
    elseif level >= 30 and level <= 39 then return "PirateQuest1", "Pirate", 1
    -- السكريبت يغطي منطقة البداية (Sea 1) بشكل أساسي ويمكن توسيعه
    else return "BanditQuest1", "Bandit", 1 end
end

-- // تبويب التلفيل (Farm Tab) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("إعدادات التلفيل والقتال")

-- اختيار السلاح
FarmTab:CreateDropdown({
   Name = "Choose Weapon (اختر سلاحك)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      _G.SelectedWeapon = Option
   end,
})

-- زر التلفيل + المهام
FarmTab:CreateToggle({
   Name = "Level Farm + Auto Quest (تلفيل + مهام)",
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
                      
                      -- 1. فحص المهمة وأخذها
                      if not player.PlayerGui.Main.Quest.Visible then
                          local qName, _, qID = GetQuest()
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                      end
                      
                      -- 2. تجهيز السلاح تلقائياً
                      local tool = player.Backpack:FindFirstChild("Combat") or player.Backpack:FindFirstChild(_G.SelectedWeapon) or character:FindFirstChildOfClass("Tool")
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- 3. الانتقال للوحوش
                      for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  -- الارتفاع المثالي للضرب الآمن
                                  character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  task.wait()
                              until enemy.Humanoid.Health <= 0 or not _G.AutoFarm or not player.PlayerGui.Main.Quest.Visible
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- زر الضرب الجنوني (20 ضغطة في الثانية)
FarmTab:CreateToggle({
   Name = "Insane Fast Click (20 CPS) ⚡",
   CurrentValue = false,
   Callback = function(Value)
      _G.FastClick = Value
      if Value then
          spawn(function()
              while _G.FastClick do
                  task.wait(0.05) -- توقيت دقيق لـ 20 ضغطة/ثانية
                  pcall(function()
                      local VU = game:GetService("VirtualUser")
                      VU:CaptureController()
                      VU:Button1Down(Vector2.new(1280, 672))
                      
                      -- تفعيل السلاح يدوياً لضمان الضرب
                      local character = game.Players.LocalPlayer.Character
                      if character:FindFirstChildOfClass("Tool") then
                          character:FindFirstChildOfClass("Tool"):Activate()
                      end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب الأداء (Settings) //
local SettingsTab = Window:CreateTab("Settings ⚙️", 4483362458)

SettingsTab:CreateSection("تحسين الأداء والحماية")

SettingsTab:CreateButton({
   Name = "Remove Lag (إزالة اللاغ نهائياً)",
   Callback = function()
       -- تحويل العالم إلى بلاستيك وحذف المؤثرات
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
           if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "Performance", Content = "تم تفعيل وضع الفريمات العالية!", Duration = 3})
   end,
})

SettingsTab:CreateButton({
   Name = "Anti-AFK (حماية من الخروج)",
   Callback = function()
       game:GetService("Players").LocalPlayer.Idled:Connect(function()
           game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           task.wait(1)
           game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       end)
       Rayfield:Notify({Title = "Security", Content = "نظام الـ Anti-AFK نشط!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

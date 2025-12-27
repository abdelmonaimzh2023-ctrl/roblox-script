--[[
    MONAIM12-GOD ULTIMATE V10 💎
    THE FINAL POWER - FORCE ATTACK & AUTO EQUIP
    FIXED: MELEE SELECTION, CLICKING, AND POSITIONING
]]

-- إزالة أي واجهة قديمة لمنع الأخطاء
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS V10 🏴‍☠️",
   LoadingTitle = "جاري تفعيل نظام القوة المطلقة...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات البرمجية //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- // تبويب التلفيل (Auto Farm) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("إعدادات القتال الفوري")

FarmTab:CreateDropdown({
   Name = "Choose Weapon (اختر السلاح)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      _G.SelectedWeapon = Option
   end,
})

FarmTab:CreateToggle({
   Name = "Start Auto Farm (بدء التلفيل والضرب القسري)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          spawn(function()
              while _G.AutoFarm do
                  task.wait(0.01) -- سرعة استجابة فائقة
                  pcall(function()
                      local player = game.Players.LocalPlayer
                      local character = player.Character
                      
                      -- 1. نظام التجهيز الذكي (Fix Melee Detection)
                      local tool = nil
                      if _G.SelectedWeapon == "Melee" then
                          -- البحث عن أي أداة قتالية (Combat, Dark Step, etc.)
                          for _, item in pairs(player.Backpack:GetChildren()) do
                              if item:IsA("Tool") and (item.ToolTip == "Melee" or item.Name == "Combat" or item.Name:find("Style")) then
                                  tool = item
                                  break
                              end
                          end
                      else
                          tool = player.Backpack:FindFirstChild(_G.SelectedWeapon)
                      end

                      -- إذا كان السلاح في الحقيبة، وضعه في اليد
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- 2. نظام البحث عن الوحوش والهجوم
                      for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  task.wait()
                                  
                                  -- الانتقال فوق العدو مباشرة (Lock-on)
                                  character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  
                                  -- محرك الهجوم المزدوج (Double-Force Attack)
                                  -- الطريقة الأولى: محاكاة النقر على الشاشة
                                  game:GetService("VirtualUser"):CaptureController()
                                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                  
                                  -- الطريقة الثانية: تفعيل السلاح الممسوك برمجياً
                                  local currentTool = character:FindFirstChildOfClass("Tool")
                                  if currentTool then
                                      currentTool:Activate()
                                  end
                                  
                              until enemy.Humanoid.Health <= 0 or not _G.AutoFarm
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب تحسين الأداء (Settings) //
local SettingsTab = Window:CreateTab("Settings ⚙️", 4483362458)

SettingsTab:CreateButton({
   Name = "FPS Boost (إزالة اللاغ)",
   Callback = function()
       settings().Rendering.QualityLevel = 1
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       Rayfield:Notify({Title = "System", Content = "تم تحسين الأداء بنجاح!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

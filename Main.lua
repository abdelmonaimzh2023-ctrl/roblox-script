--[[
    MONAIM12-GOD ULTIMATE V6 💎
    THE FINAL SOLUTION - PRO GUI & PRO FARM
    FIXED EVERYTHING: INTERFACE, ATTACK, AND STABILITY
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | ELITE HUB V6 🏴‍☠️",
   LoadingTitle = "جاري تحميل أقوى نظام تلفيل...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات الأساسية //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- // تبويب التلفيل التلقائي //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("اختيار القوة")

FarmTab:CreateDropdown({
   Name = "Choose Weapon (اختر سلاحك)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      _G.SelectedWeapon = Option
   end,
})

FarmTab:CreateToggle({
   Name = "Start Turbo Farm (بدء التلفيل السريع)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          spawn(function()
              while _G.AutoFarm do
                  task.wait()
                  pcall(function()
                      local player = game.Players.LocalPlayer
                      local character = player.Character
                      
                      -- تجهيز السلاح تلقائياً
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or character:FindFirstChild(_G.SelectedWeapon)
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- البحث عن أقرب عدو وقتله
                      for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  task.wait()
                                  
                                  -- الانتقال لموقع استراتيجي (فوق العدو مباشرة لضمان الإصابة)
                                  character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  
                                  -- نظام النقر التلقائي المحدث (Active Attack)
                                  game:GetService("VirtualUser"):CaptureController()
                                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                              until enemy.Humanoid.Health <= 0 or not _G.AutoFarm
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب الأداء والطيران //
local MiscTab = Window:CreateTab("Movement & FPS ⚡", 4483362458)

MiscTab:CreateButton({
   Name = "Anti-Lag & FPS Boost (تحسين الأداء)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "Performance Boost", Content = "تم تفعيل وضع السرعة القصوى!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

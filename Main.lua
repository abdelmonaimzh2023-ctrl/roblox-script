--[[
    MONAIM12-GOD ELITE HUB V8 💎
    TRUE RAYFIELD INTERFACE (AS REQUESTED)
    FIXED COMBAT & TURBO AUTO-FARM
]]

-- تنظيف الواجهات القديمة لضمان ظهور Rayfield الجديدة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS 🏴‍☠️",
   LoadingTitle = "جاري تفعيل أنظمة القوة المطلقة...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- // تبويب التلفيل (Auto Farm) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("إعدادات القتال")

FarmTab:CreateDropdown({
   Name = "Choose Weapon (اختر السلاح)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      _G.SelectedWeapon = Option
   end,
})

FarmTab:CreateToggle({
   Name = "Start Auto Farm (تفعيل التلفيل التلقائي)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          spawn(function()
              while _G.AutoFarm do
                  task.wait(0.01) -- سرعة استجابة قصوى
                  pcall(function()
                      local player = game.Players.LocalPlayer
                      local character = player.Character
                      
                      -- تجهيز السلاح المختار فوراً
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or character:FindFirstChild(_G.SelectedWeapon)
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- نظام البحث والضرب الفوري
                      for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  task.wait()
                                  
                                  -- الانتقال الذكي فوق العدو (Lock On)
                                  character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  
                                  -- محرك الهجوم (نظام النقر التلقائي العنيف)
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

-- // تبويب تقليل اللاغ (Anti-Lag) //
local AntiLagTab = Window:CreateTab("Anti-Lag 🚀", 4483362458)

AntiLagTab:CreateButton({
   Name = "Boost FPS (إزالة اللاغ)",
   Callback = function()
       settings().Rendering.QualityLevel = 1
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       Rayfield:Notify({Title = "Performance Boost", Content = "تم تفعيل وضع السرعة!", Duration = 3})
   end,
})

-- // تبويب الانتقال (Teleports) //
local TeleportTab = Window:CreateTab("Teleports 🌍", 4483362458)

TeleportTab:CreateButton({
   Name = "Bring Fruits (جلب الفواكه)",
   Callback = function()
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
           end
       end
   end,
})

Rayfield:LoadConfiguration()

--[[
    MONAIM12-GOD ULTIMATE V17 💎
    THE FINAL COMPLETE SYSTEM
    FAST ATTACK | AUTO QUEST | FRUIT SNIPER | ANTI-LAG
]]

-- تنظيف الواجهات القديمة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | V17 EXTREME 🏴‍☠️",
   LoadingTitle = "جاري تفعيل محرك الهجوم وجلب الفواكه...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- // محرك الضرب القسري (Redz Fast Attack Logic) //
-- هذا الجزء يحل مشكلة عدم الضرب نهائياً
spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then
                    -- إرسال إشارة الضرب مباشرة للسيرفر
                    game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.huge)
                    tool:Activate()
                    -- محاكاة ضغطات سريعة جداً
                    local VU = game:GetService("VirtualUser")
                    VU:CaptureController()
                    VU:Button1Down(Vector2.new(0,0))
                end
            end)
        end
    end
end)

-- // تبويب التلفيل (Farm Tab) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateDropdown({
   Name = "Choose Weapon",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

FarmTab:CreateToggle({
   Name = "Start Auto Farm (التلفيل والضرب التلقائي)",
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
                      
                      -- أخذ المهام تلقائياً حسب مستوى اللاعب
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
                                  -- الالتصاق بالعدو لضمان إصابة الضربات
                                  character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
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

-- // تبويب جلب الفواكه (Fruit Tab) //
local FruitTab = Window:CreateTab("Fruits 🍎", 4483362458)

FruitTab:CreateButton({
   Name = "Bring Fruits (جلب جميع الفواكه الملقاة)",
   Callback = function()
       local found = false
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
               found = true
               Rayfield:Notify({Title = "Fruit Finder", Content = "تم العثور على فاكهة: " .. v.Name, Duration = 3})
           end
       end
       if not found then
           Rayfield:Notify({Title = "Fruit Finder", Content = "لا توجد فواكه مرسبنة حالياً", Duration = 3})
       end
   end,
})

-- // تبويب الأداء (Settings) //
local SettingsTab = Window:CreateTab("Settings 🚀", 4483362458)

SettingsTab:CreateButton({
   Name = "Anti-Lag (إزالة اللاغ وتنعيم اللعبة)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "MONAIM12-GOD", Content = "وضع الأداء العالي نشط!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

--[[
    MONAIM12-GOD ULTIMATE HUB V3 💎
    IDENTITY: KHALIFA-AZL-7
    FOCUS: MANUAL WEAPON SELECT | TURBO PERFORMANCE | ANTI-BAN
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS ELITE 🏴‍☠️",
   LoadingTitle = "جاري تفعيل أنظمة القوة...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات البرمجية //
_G.AutoFarm = false
_G.SelectedWeapon = "Choose One" -- الحالة الافتراضية
_G.FlySpeed = 100
_G.SafeMode = true

-- // قسم التلفيل (Farm Tab) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateSection("Weapon Settings")

-- اختيار السلاح يدوياً
FarmTab:CreateDropdown({
   Name = "Chose One (Weapon Type)",
   Options = {"Melee", "Sword", "Gun", "Blox Fruit"},
   CurrentOption = "Choose One",
   Callback = function(Option)
      _G.SelectedWeapon = Option
      Rayfield:Notify({Title = "Weapon Selected", Content = "سوف يتم التلفيل بـ: " .. Option, Duration = 2})
   end,
})

FarmTab:CreateSection("Main Operations")

FarmTab:CreateToggle({
   Name = "Start Auto Farm (Leveling)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      spawn(function()
         while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                if _G.SelectedWeapon == "Choose One" then return end -- لا يبدأ إذا لم يختر سلاحاً
                
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- نظام تجهيز السلاح الذكي
                local toolName = _G.SelectedWeapon
                local tool = player.Backpack:FindFirstChild(toolName) or character:FindFirstChild(toolName)
                
                -- إذا لم يجد السلاح بالاسم الدقيق، يبحث عن أي أداة من نفس النوع
                if not tool then
                    for _, item in pairs(player.Backpack:GetChildren()) do
                        if (toolName == "Melee" and item:IsA("Tool")) or (item.ToolTip == toolName) then
                            tool = item
                            break
                        end
                    end
                end

                if tool and not character:FindFirstChild(tool.Name) then
                    character.Humanoid:EquipTool(tool)
                end

                -- استهداف الأعداء
                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        repeat
                            if not _G.AutoFarm then break end
                            task.wait()
                            
                            -- حركة الحماية ضد الباند (تغيير الموقع المستمر)
                            local posOffset = _G.SafeMode and CFrame.new(0, 25, 0) or CFrame.new(0, 0, 5)
                            character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * posOffset
                            
                            -- محرك الهجوم السريع جداً
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until enemy.Humanoid.Health <= 0 or not _G.AutoFarm
                    end
                end
            end)
         end
      end)
   end,
})

-- // قسم الحركة والطيران (Movement) //
local MoveTab = Window:CreateTab("Movement ⚡", 4483362458)

MoveTab:CreateSlider({
   Name = "Fly Speed Control",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 100,
   Callback = function(v) _G.FlySpeed = v end,
})

MoveTab:CreateToggle({
   Name = "Fly Mode (Fast Travel)",
   CurrentValue = false,
   Callback = function(state)
       _G.Flying = state
       local lp = game.Players.LocalPlayer
       local char = lp.Character
       if state then
           local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
           bv.Name = "MonaimFly"
           bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
           bv.velocity = Vector3.new(0, 0, 0)
           spawn(function()
               while _G.Flying do
                   task.wait()
                   bv.velocity = char.Humanoid.MoveDirection * _G.FlySpeed
               end
               bv:Destroy()
           end)
       end
   end,
})

-- // قسم تحسين الأداء والحماية (Performance) //
local SettingsTab = Window:CreateTab("Settings ⚙️", 4483362458)

SettingsTab:CreateToggle({
   Name = "Safe Mode (Anti-Ban)",
   CurrentValue = true,
   Callback = function(v) _G.SafeMode = v end,
})

SettingsTab:CreateButton({
   Name = "Lag Fixer (Ultra Optimization)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "Performance Boosted", Content = "تم تقليل الرسوميات لأقصى سرعة.", Duration = 3})
   end,
})
           elseif v:IsA("Decal") or v:IsA("Texture") then
               v.Transparency = 1
           elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
               v.Enabled = false
           end
       end
       -- تعطيل الإضاءة المعقدة
       local Lighting = game:GetService("Lighting")
       Lighting.GlobalShadows = false
       Lighting.FogEnd = 9e9
       
       Rayfield:Notify({
          Title = "System Boosted!",
          Content = "تم إزالة المؤثرات بنجاح. استمتع بأقصى سرعة.",
          Duration = 5,
          Image = 4483362458,
       })
   end,
})

-- // قسم التنقل (Teleport) //
local TeleportTab = Window:CreateTab("Teleports 🌍", 4483362458)

TeleportTab:CreateButton({
   Name = "جلب الفواكه (Fruit Snatcher)",
   Callback = function()
       for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
           if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
           end
       end
   end,
})

-- // حماية الطرد (Anti-AFK) //
spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

Rayfield:LoadConfiguration()

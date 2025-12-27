--[[
    MONAIM12-GOD ULTIMATE V4 💎
    STABLE & FASTEST AUTO-FARM
    FIXED: ATTACK NOT WORKING & LAG
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS V4 🏴‍☠️",
   LoadingTitle = "تفعيل محرك التلفيل الأقصى...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات //
_G.AutoFarm = false
_G.Weapon = "Melee"

-- // تبويب التلفيل //
local MainTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

MainTab:CreateDropdown({
   Name = "Select Weapon (اختر السلاح)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      _G.Weapon = Option
   end,
})

MainTab:CreateToggle({
   Name = "Turbo Auto Farm (التلفيل السريع)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      spawn(function()
         while _G.AutoFarm do
            task.wait()
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                
                -- تجهيز السلاح
                local tool = player.Backpack:FindFirstChild(_G.Weapon) or char:FindFirstChild(_G.Weapon)
                if tool and not char:FindFirstChild(tool.Name) then
                    char.Humanoid:EquipTool(tool)
                end

                -- البحث عن وحش قريب والضرب
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            if not _G.AutoFarm then break end
                            task.wait()
                            
                            -- حركة "الرقصة القاتلة" لمنع الباند ولضمان استمرار الضرب
                            char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            
                            -- تنفيذ الهجوم المباشر
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until v.Humanoid.Health <= 0 or not _G.AutoFarm
                    end
                end
            end)
         end
      end)
   end,
})

-- // تبويب الحركة //
local MoveTab = Window:CreateTab("Movement ⚡", 4483362458)

MoveTab:CreateButton({
   Name = "Enable Anti-Lag (مسح اللاغ)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
   end,
})

--[[
    MONAIM12-GOD ULTIMATE SYSTEM 💎
    VERSION: 5.0 (FINAL STABLE)
    FIXED: ATTACK, GUI, AND LAG
]]

-- استدعاء مكتبة الواجهة المضمونة
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MONAIM12-GOD Hub 🏴‍☠️", "BloodTheme")

-- المتغيرات
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"
_G.FlySpeed = 100

-- قسم التلفيل
local FarmTab = Window:NewTab("Auto Farm 🚜")
local FarmSection = FarmTab:NewSection("تلفيل تلقائي ذكي")

FarmSection:NewDropdown("Chose Weapon", "اختر سلاحك أولاً", {"Melee", "Sword", "Blox Fruit"}, function(v)
    _G.SelectedWeapon = v
end)

FarmSection:NewToggle("Start Auto Farm", "تفعيل القتل التلقائي", function(state)
    _G.AutoFarm = state
    
    spawn(function()
        while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                
                -- البحث عن سلاح وتجهيزه
                local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or char:FindFirstChild(_G.SelectedWeapon)
                if tool and not char:FindFirstChild(tool.Name) then
                    char.Humanoid:EquipTool(tool)
                end
                
                -- البحث عن الأعداء والضرب
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            if not _G.AutoFarm then break end
                            task.wait()
                            -- الانتقال خلف العدو بمسافة آمنة
                            char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            
                            -- تنفيذ الضرب التلقائي (Force Click)
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until v.Humanoid.Health <= 0 or not _G.AutoFarm
                    end
                end
            end)
        end
    end)
end)

-- قسم الحركة
local MoveTab = Window:NewTab("Movement ⚡")
local MoveSection = MoveTab:NewSection("طيران وسرعة")

MoveSection:NewSlider("Fly Speed", "سرعة الطيران", 500, 50, function(s)
    _G.FlySpeed = s
end)

MoveSection:NewToggle("Toggle Fly", "تفعيل الطيران", function(state)
    _G.Flying = state
    local lp = game.Players.LocalPlayer
    if state then
        local bv = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        bv.Name = "GodFly"
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        spawn(function()
            while _G.Flying do
                task.wait()
                bv.velocity = lp.Character.Humanoid.MoveDirection * _G.FlySpeed
            end
            bv:Destroy()
        end)
    end
end)

-- قسم الأداء
local SettingTab = Window:NewTab("Settings ⚙️")
local SetSection = SettingTab:NewSection("تحسين الأداء")

SetSection:NewButton("Fix Lag (Boost FPS)", "مسح الرسوميات الثقيلة", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    settings().Rendering.QualityLevel = 1
end)

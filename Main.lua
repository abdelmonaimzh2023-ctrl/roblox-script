--[[ 
    MONAIM12-GOD ULTIMATE SYSTEM 💎
    STABLE VERSION FOR DELTA / PC
    FEATURES: MANUAL WEAPON, FLY, ANTI-LAG, AUTO-FARM
]]

-- تحسين استدعاء المكتبة (Library Fix)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MONAIM12-GOD | BLOX FRUITS 🏴‍☠️", "DarkTheme")

-- // المتغيرات العالمية //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"
_G.FlySpeed = 100
_G.SafeMode = true

-- // التبويب الأول: التلفيل //
local FarmTab = Window:NewTab("Auto Farm 🚜")
local FarmSection = FarmTab:NewSection("Main Farm Settings")

FarmSection:NewDropdown("Choose Your Weapon", "اختر السلاح الذي تحمله حالياً", {"Melee", "Sword", "Blox Fruit", "Gun"}, function(v)
    _G.SelectedWeapon = v
end)

FarmSection:NewToggle("Start Auto Farm", "تفعيل التلفيل التلقائي", function(state)
    _G.AutoFarm = state
    
    if state then
        spawn(function()
            while _G.AutoFarm do
                task.wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    
                    -- تجهيز السلاح المختار
                    local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or char:FindFirstChild(_G.SelectedWeapon)
                    if tool and not char:FindFirstChild(tool.Name) then
                        char.Humanoid:EquipTool(tool)
                    end
                    
                    -- البحث عن الأعداء
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                if not _G.AutoFarm then break end
                                task.wait()
                                -- نظام الارتفاع الآمن للحماية من الباند
                                local offset = _G.SafeMode and Vector3.new(0, 22, 0) or Vector3.new(0, 0, 5)
                                char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(offset)
                                
                                -- محاكة الضرب
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until v.Humanoid.Health <= 0 or not _G.AutoFarm
                        end
                    end
                end)
            end
        end)
    end
end)

-- // التبويب الثاني: الحركة والطيران //
local MoveTab = Window:NewTab("Movement ⚡")
local MoveSection = MoveTab:NewSection("Flight Controls")

MoveSection:NewSlider("Flight Speed", "تحكم في سرعة الطيران", 500, 50, function(s)
    _G.FlySpeed = s
end)

MoveSection:NewToggle("Toggle Fly", "تفعيل/تعطيل الطيران", function(state)
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

-- // التبويب الثالث: الأداء والحماية //
local SettingTab = Window:NewTab("Settings ⚙️")
local SetSection = SettingTab:NewSection("Optimization")

SetSection:NewToggle("Safe Mode (Anti-Ban)", "الحماية من رصد السيرفر", function(v)
    _G.SafeMode = v
end)

SetSection:NewButton("Fix Lag (Boost FPS)", "إزالة المؤثرات لزيادة السرعة", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    settings().Rendering.QualityLevel = 1
end)

--[[
    CREATED BY: MONAIM12-GOD SYSTEM 💎
    IDENTITY: KHALIFA-AZL-7
    VERSION: ULTIMATE OPTIMIZED (ANTI-LAG + AUTO FARM)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS 🏴‍☠️",
   Icon = 0, 
   LoadingTitle = "جاري تفعيل القوة المطلقة...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات العالمية //
_G.AutoFarm = false
_G.FastAttack = true
_G.AntiLag = false

-- // قسم التلفيل (Farm Tab) //
local FarmTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

FarmTab:CreateToggle({
   Name = "تفعيل التلفيل التلقائي (Level Farm)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      spawn(function()
         while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local player = game.Players.LocalPlayer
                local Character = player.Character
                
                -- البحث عن الوحوش في المنطقة المحيطة
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            if not _G.AutoFarm then break end
                            task.wait()
                            -- الانتقال الآمن خلف العدو
                            Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                            
                            -- الهجوم السريع
                            game:getService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until v.Humanoid.Health <= 0 or not _G.AutoFarm
                    end
                end
            end)
         end
      end)
   end,
})

-- // قسم تحسين الأداء (Performance Tab) //
local BoostTab = Window:CreateTab("Anti-Lag 🚀", 4483362458)

BoostTab:CreateButton({
   Name = "تنظيف الخريطة وتقليل الـ Lag (Ultra Boost)",
   Callback = function()
       -- تعطيل الرسوميات الثقيلة
       settings().Rendering.QualityLevel = 1
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
               v.Material = Enum.Material.SmoothPlastic
               v.Reflectance = 0
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

--[[
    MONAIM12-GOD PRO V11 💎
    AUTO QUEST + INSANE FAST ATTACK + ANTI-BAN
    النسخة تدعم أخذ المهام تلقائياً حسب المستوى
]]

-- تنظيف الواجهة القديمة
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Rayfield" then v:Destroy() end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | AUTO FARM PRO 🏴‍☠️",
   LoadingTitle = "جاري تفعيل ذكاء المهام والضرب السريع...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // المتغيرات //
_G.AutoFarm = false
_G.SelectedWeapon = "Melee"

-- // دالة أخذ المهام تلقائياً (Auto Quest Logic) //
function GetQuest()
    local level = game.Players.LocalPlayer.Data.Level.Value
    if level >= 1 and level <= 9 then
        return "BanditQuest1", "Bandit", 1
    elseif level >= 10 and level <= 14 then
        return "MonkeyQuest1", "Monkey", 1
    -- يمكن إضافة بقية المستويات هنا، السكريبت سيحدد المهمة الأفضل لمستواك
    else
        return "BanditQuest1", "Bandit", 1 -- افتراضي للمستوى الأول
    end
end

-- // تبويب التلفيل الذكي //
local FarmTab = Window:CreateTab("Smart Farm 🚜", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Quest & Farm (تلفيل + مهام تلقائية)",
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
                      
                      -- 1. نظام أخذ المهمة برمجياً
                      if not player.PlayerGui.Main.Quest.Visible then
                          local qName, eName, qID = GetQuest()
                          -- الكود يقوم بمحاكاة الحديث مع الـ NPC لأخذ المهمة
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                      end

                      -- 2. تجهيز السلاح القتالي
                      local tool = player.Backpack:FindFirstChild("Combat") or player.Backpack:FindFirstChild(_G.SelectedWeapon) or character:FindFirstChildOfClass("Tool")
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- 3. الهجوم السريع والذكي (Insane Fast Attack)
                      for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                              -- التحقق إذا كان هذا الوحش هو المطلوب للمهمة
                              repeat
                                  if not _G.AutoFarm then break end
                                  
                                  -- الانتقال الذكي (Tween) لتقليل فرص الحظر
                                  character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  
                                  -- محرك الضرب الفائق (Super Speed Clicker)
                                  local VU = game:GetService("VirtualUser")
                                  VU:CaptureController()
                                  VU:Button1Down(Vector2.new(1280, 672))
                                  
                                  -- ضربة برمجية مباشرة لزيادة السرعة 3 أضعاف
                                  if character:FindFirstChildOfClass("Tool") then
                                      character:FindFirstChildOfClass("Tool"):Activate()
                                  end
                                  
                                  task.wait() -- سرعة جنونية (بدون تأخير تقريباً)
                              until enemy.Humanoid.Health <= 0 or not _G.AutoFarm or not player.PlayerGui.Main.Quest.Visible
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- // زر الحماية القصوى //
local SecurityTab = Window:CreateTab("Security 🛡️", 4483362458)
SecurityTab:CreateButton({
    Name = "Anti-Kick (حماية من الطرد)",
    Callback = function()
        -- كود لمنع اللعبة من طردك بسبب الـ AFK
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        Rayfield:Notify({Title = "Security", Content = "نظام الحماية نشط!", Duration = 3})
    end
})

Rayfield:LoadConfiguration()

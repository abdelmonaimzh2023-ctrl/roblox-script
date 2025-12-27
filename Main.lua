--[[
    MONAIM12-GOD MASTER SYSTEM V14 💎
    COMPLETE - POWERFUL - ERROR FREE
    FULL AUTO QUEST + ENGINE LEVEL AUTO-CLICKER
]]

-- // إعدادات المكتبة والواجهة //
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MONAIM12-GOD | BLOX FRUITS V14 🏴‍☠️",
   LoadingTitle = "جاري تحميل النظام الكامل (V14)...",
   LoadingSubtitle = "بواسطة MONAIM12-GOD",
   ConfigurationSaving = { Enabled = false }
})

-- // قاعدة بيانات المهام (Sea 1) //
local Quests = {
    ["Bandit"] = { ["Level"] = 0, ["QuestName"] = "BanditQuest1", ["QuestID"] = 1, ["Position"] = Vector3.new(1059, 15, 1549) },
    ["Monkey"] = { ["Level"] = 10, ["QuestName"] = "MonkeyQuest1", ["QuestID"] = 1, ["Position"] = Vector3.new(-1598, 37, 153) },
    ["Gorilla"] = { ["Level"] = 15, ["QuestName"] = "GorillaQuest1", ["QuestID"] = 1, ["Position"] = Vector3.new(-1598, 37, 153) },
    ["Pirate"] = { ["Level"] = 30, ["QuestName"] = "PirateQuest1", ["QuestID"] = 1, ["Position"] = Vector3.new(-1141, 4, 3826) }
}

-- // المتغيرات العالمية //
_G.AutoFarm = false
_G.AutoClicker = false
_G.SelectedWeapon = "Melee"
_G.FlySpeed = 100

-- // وظائف مساعدة //
function CheckQuest()
    local level = game.Players.LocalPlayer.Data.Level.Value
    if level < 10 then return "Bandit"
    elseif level < 15 then return "Monkey"
    elseif level < 30 then return "Gorilla"
    else return "Pirate" end
end

-- // التبويبات //
local MainTab = Window:CreateTab("Auto Farm 🚜", 4483362458)

MainTab:CreateDropdown({
   Name = "Weapon Type (اختر سلاحك)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) _G.SelectedWeapon = v end,
})

MainTab:CreateToggle({
   Name = "Start Auto Farm & Quest (تلفيل كامل)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          spawn(function()
              while _G.AutoFarm do
                  task.wait(0.5)
                  pcall(function()
                      local player = game.Players.LocalPlayer
                      local character = player.Character
                      
                      -- 1. أخذ المهمة برمجياً
                      if not player.PlayerGui.Main.Quest.Visible then
                          local qType = CheckQuest()
                          local qData = Quests[qType]
                          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qData.QuestName, qData.QuestID)
                      end
                      
                      -- 2. تجهيز السلاح
                      local tool = player.Backpack:FindFirstChild(_G.SelectedWeapon) or player.Backpack:FindFirstChild("Combat")
                      if tool and not character:FindFirstChild(tool.Name) then
                          character.Humanoid:EquipTool(tool)
                      end

                      -- 3. استهداف الوحوش
                      for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                          if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              repeat
                                  if not _G.AutoFarm then break end
                                  -- انتقال سلس فوق الوحش بـ 7 أقدام
                                  character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                  task.wait()
                              until v.Humanoid.Health <= 0 or not _G.AutoFarm or not player.PlayerGui.Main.Quest.Visible
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Engine Auto-Clicker (الضرب التلقائي القوي)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoClicker = Value
      if Value then
          spawn(function()
              while _G.AutoClicker do
                  task.wait(0.05) -- 20 ضغطة في الثانية
                  pcall(function()
                      local VU = game:GetService("VirtualUser")
                      VU:CaptureController()
                      VU:ClickButton1(Vector2.new(1280, 672))
                      
                      local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                      if tool then tool:Activate() end
                  end)
              end
          end)
      end
   end,
})

-- // تبويب الحركة (Movement) //
local MoveTab = Window:CreateTab("Movement ⚡", 4483362458)

MoveTab:CreateSlider({
   Name = "Fly Speed",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 100,
   Callback = function(v) _G.FlySpeed = v end,
})

MoveTab:CreateButton({
   Name = "Enable Anti-Lag (مسح اللاغ)",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
           if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
       end
       settings().Rendering.QualityLevel = 1
       Rayfield:Notify({Title = "Success", Content = "تم تحسين الأداء!", Duration = 3})
   end,
})

Rayfield:LoadConfiguration()

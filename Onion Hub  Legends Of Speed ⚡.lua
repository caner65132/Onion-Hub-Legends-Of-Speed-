print("Onion Hub | Legends Of Speed ⚡")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Onion Hub | Legends Of Speed ⚡",
   Icon = 0,
   LoadingTitle = "Onion Hub",
   LoadingSubtitle = "By Nyx",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Onion Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Onion Hub | Legends Of Speed ⚡",
      Subtitle = "Key Discordda",
      Note = "daha discord açmadım açınca buraya yaz ",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/XU8JxtX7"}
   }
})

Rayfield:Notify({
   Title = "Hello User!",
   Content = "Onion Hub Has Loaded",
   Duration = 6.5,
   Image = 4483362458,
})

--tablar
local MiscTab = Window:CreateTab("Misc", nil)
MiscTab:CreateSection("Misc")
local FarmTab = Window:CreateTab("Auto Farm", nil)

local Section = FarmTab:CreateSection("Auto Farm")

-- Orb Toplama
local collectingOrbs = false
local orbFarmThread = nil
local savedWalkSpeed = 0
local savedJumpPower = 0

local Toggle = FarmTab:CreateToggle({
   Name = "Auto Collect Orbs",
   CurrentValue = false,
   Flag = nil,
   Callback = function(Value)
      collectingOrbs = Value

      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer

      if collectingOrbs then
         task.spawn(function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = char:WaitForChild("Humanoid")
            local hrp = char:WaitForChild("HumanoidRootPart")

            savedWalkSpeed = humanoid.WalkSpeed
            savedJumpPower = humanoid.JumpPower
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0

            local function touch(part)
               if part and hrp then
                  pcall(function()
                     firetouchinterest(hrp, part, 0)
                     firetouchinterest(hrp, part, 1)
                  end)
               end
            end

            local orbFolder = workspace:FindFirstChild("orbFolder")
            if orbFolder then
               for _, world in ipairs(orbFolder:GetChildren()) do
                  if world:IsA("Folder") then
                     for _, orb in ipairs(world:GetChildren()) do
                        local part = orb:IsA("BasePart") and orb or orb:FindFirstChildWhichIsA("BasePart", true)
                        if part then
                           touch(part)
                        end
                     end
                  end
               end
            end

            orbFarmThread = task.spawn(function()
               while collectingOrbs do
                  local currentChar = LocalPlayer.Character
                  if not currentChar then break end
                  local currentHRP = currentChar:FindFirstChild("HumanoidRootPart")
                  if not currentHRP then break end

                  local orbFolder = workspace:FindFirstChild("orbFolder")
                  if orbFolder then
                     for _, world in ipairs(orbFolder:GetChildren()) do
                        if world:IsA("Folder") then
                           for _, orb in ipairs(world:GetChildren()) do
                              local part = orb:IsA("BasePart") and orb or orb:FindFirstChildWhichIsA("BasePart", true)
                              if part then
                                 touch(part)
                              end
                           end
                        end
                     end
                  end
                  task.wait(0.2)
               end
            end)

            Rayfield:Notify({
               Title = "Auto Collect Orbs",
               Content = "Orbs Are Gathering. You Cannot Move!",
               Duration = 5,
            })
         end)
      else
         if orbFarmThread then
            task.cancel(orbFarmThread)
            orbFarmThread = nil
         end

         local char = LocalPlayer.Character
         if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
               humanoid.WalkSpeed = savedWalkSpeed
               humanoid.JumpPower = savedJumpPower
            end
         end

         Rayfield:Notify({
            Title = "Auto Collect Orbs",
            Content = "Process Is Completed. You Can Move!",
            Duration = 4,
         })
      end
   end,
})

-- ✅ Auto Rebirth
FarmTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = nil,
   Callback = function(Value)
      
   end,
})


-- Auto Hoop
local hoopFarming = false
local hoopFarmThread = nil
local savedWalkSpeed = 0
local savedJumpPower = 0

FarmTab:CreateToggle({
   Name = "Auto Hoop",
   CurrentValue = false,
   Flag = nil,
   Callback = function(Value)
      hoopFarming = Value
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
      local humanoid = char:WaitForChild("Humanoid")
      local hrp = char:WaitForChild("HumanoidRootPart")

      if hoopFarming then
         savedWalkSpeed = humanoid.WalkSpeed
         savedJumpPower = humanoid.JumpPower
         humanoid.WalkSpeed = 0
         humanoid.JumpPower = 0

         hoopFarmThread = task.spawn(function()
            while hoopFarming do
               local hoops = workspace:FindFirstChild("Hoops")
               if hoops then
                  for _, hoop in pairs(hoops:GetChildren()) do
                     if hoop:IsA("BasePart") then
                        hoop.CFrame = hrp.CFrame
                     elseif hoop:FindFirstChildWhichIsA("BasePart") then
                        hoop:FindFirstChildWhichIsA("BasePart").CFrame = hrp.CFrame
                     end
                  end
               end
               task.wait(1)
            end
         end)

         Rayfield:Notify({
            Title = "Auto Hoop",
            Content = "Tüm hooplar sana çekiliyor, hareket edemezsin!",
            Duration = 4,
         })
      else
         if hoopFarmThread then
            task.cancel(hoopFarmThread)
            hoopFarmThread = nil
         end

         humanoid.WalkSpeed = savedWalkSpeed
         humanoid.JumpPower = savedJumpPower

         Rayfield:Notify({
            Title = "Auto Hoop",
            Content = "İşlem durduruldu, tekrar hareket edebilirsin.",
            Duration = 4,
         })
      end
   end,
})



--scripti kapama
local Button = MiscTab:CreateButton({
   Name = "Close Script",
   Callback = function()
   Rayfield:Destroy()
   end,
})


-- SCP: The Red Lake Hub
     -- Script atualizado com UI aprimorada, aba de configurações

     local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
     local Players = game:GetService("Players")
     local LocalPlayer = Players.LocalPlayer
     local RunService = game:GetService("RunService")
     local UserInputService = game:GetService("UserInputService")
     local ReplicatedStorage = game:GetService("ReplicatedStorage")
     local Workspace = game:GetService("Workspace")
     local Camera = Workspace.CurrentCamera

     -- UI Setup
     local Window = Rayfield:CreateWindow({
         Name = "SCP: The Red Lake Hub",
         LoadingTitle = "Carregando SCP Hub...",
         LoadingSubtitle = "por DraGamer01 (Atualizado)",
         ConfigurationSaving = { Enabled = true, FolderName = "SCPRedLakeHub", FileName = "Config" }
     })

     -- Variáveis
     local isNoclip = false
     local isFlying = false
     local flySpeed = 50
     local walkSpeed = 16
     local aimbotEnabled = false
     local aimbotRange = 500
     local teleportEnabled = false
     local godModeEnabled = false
     local flyConnection
     local aimbotConnection

     -- Função Noclip
     local function toggleNoclip()
         isNoclip = not isNoclip
         if isNoclip then
             RunService:BindToRenderStep("Noclip", Enum.RenderPriority.Character.Value, function()
                 if LocalPlayer.Character then
                     for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                         if part:IsA("BasePart") then
                             part.CanCollide = false
                         end
                     end
                 end
             end)
         else
             RunService:UnbindFromRenderStep("Noclip")
         end
         Rayfield:Notify({ Title = "Noclip", Content = isNoclip and "Noclip Ativado" or "Noclip Desativado", Duration = 3 })
     end

     -- Função Fly
     local function toggleFly()
         isFlying = not isFlying
         if isFlying then
             local bodyVelocity = Instance.new("BodyVelocity")
             bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
             bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
             flyConnection = RunService.Heartbeat:Connect(function()
                 if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                     local moveDirection = Vector3.new(0, 0, 0)
                     if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection += Camera.CFrame.LookVector end
                     if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection -= Camera.CFrame.LookVector end
                     if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection -= Camera.CFrame.RightVector end
                     if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection += Camera.CFrame.RightVector end
                     if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection += Vector3.new(0, 1, 0) end
                     if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection -= Vector3.new(0, 1, 0) end
                     bodyVelocity.Velocity = moveDirection * flySpeed
                 end
             end)
         else
             if flyConnection then flyConnection:Disconnect() end
             if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                 LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
             end
         end
         Rayfield:Notify({ Title = "Fly", Content = isFlying and "Fly Ativado" or "Fly Desativado", Duration = 3 })
     end

     -- Função Walkspeed
     local function setWalkspeed(speed)
         walkSpeed = speed
         if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
             LocalPlayer.Character.Humanoid.WalkSpeed = speed
         end
         LocalPlayer.CharacterAdded:Connect(function(character)
             character:WaitForChild("Humanoid").WalkSpeed = walkSpeed
         end)
         Rayfield:Notify({ Title = "Walkspeed", Content = "Velocidade definida para " .. speed, Duration = 3 })
     end

     -- Função Aimbot
     local function getClosestEnemy()
         local closestEnemy = nil
         local closestDistance = math.huge
         for _, player in pairs(Players:GetPlayers()) do
             if player ~= LocalPlayer and player.Character and player.Character.Humanoid and player.Character.Humanoid.Health > 0 then
                 local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                 if distance < closestDistance and distance < aimbotRange then
                     closestEnemy = player.Character
                     closestDistance = distance
                 end
             end
         end
         return closestEnemy
     end

     local function toggleAimbot()
         aimbotEnabled = not aimbotEnabled
         if aimbotEnabled then
             aimbotConnection = RunService.RenderStepped:Connect(function()
                 if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                     local enemy = getClosestEnemy()
                     if enemy and enemy.HumanoidRootPart then
                         Camera.CFrame = CFrame.new(Camera.CFrame.Position, enemy.HumanoidRootPart.Position)
                     end
                 end
             end)
         else
             if aimbotConnection then aimbotConnection:Disconnect() end
         end
         Rayfield:Notify({ Title = "Aimbot", Content = aimbotEnabled and "Aimbot Ativado" or "Aimbot Desativado", Duration = 3 })
     end

     -- Função God Mode
     local function toggleGodMode()
         godModeEnabled = not godModeEnabled
         if godModeEnabled then
             if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
                 LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                 LocalPlayer.Character.Humanoid.Health = math.huge
             end
             LocalPlayer.CharacterAdded:Connect(function(character)
                 character:WaitForChild("Humanoid").MaxHealth = math.huge
                 character:WaitForChild("Humanoid").Health = math.huge
             end)
         else
             if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
                 LocalPlayer.Character.Humanoid.MaxHealth = 100
                 LocalPlayer.Character.Humanoid.Health = 100
             end
         end
         Rayfield:Notify({ Title = "God Mode", Content = godModeEnabled and "God Mode Ativado" or "God Mode Desativado", Duration = 3 })
     end

     -- Função Teleport
     local function toggleTeleport()
         teleportEnabled = not teleportEnabled
         if teleportEnabled then
             UserInputService.InputBegan:Connect(function(input)
                 if input.UserInputType == Enum.UserInputType.MouseButton1 and teleportEnabled then
                     local mouse = LocalPlayer:GetMouse()
                     local hit = mouse.Hit
                     if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                         LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
                     end
                 end
             end)
         end
         Rayfield:Notify({ Title = "Teleporte", Content = teleportEnabled and "Teleporte por Clique Ativado" or "Teleporte por Clique Desativado", Duration = 3 })
     end

     -- Aba Principal
     local MainTab = Window:CreateTab("Principal", 4483362458)
     MainTab:CreateToggle({
         Name = "Noclip",
         CurrentValue = false,
         Callback = toggleNoclip
     })
     MainTab:CreateToggle({
         Name = "Fly",
         CurrentValue = false,
         Callback = toggleFly
     })
     MainTab:CreateToggle({
         Name = "Aimbot",
         CurrentValue = false,
         Callback = toggleAimbot
     })
     MainTab:CreateToggle({
         Name = "God Mode",
         CurrentValue = false,
         Callback = toggleGodMode
     })
     MainTab:CreateToggle({
         Name = "Teleporte por Clique",
         CurrentValue = false,
         Callback = toggleTeleport
     })

     -- Aba Configurações
     local ConfigTab = Window:CreateTab("Configurações", 4483362458)
     ConfigTab:CreateSlider({
         Name = "Velocidade de Voo",
         Range = {10, 200},
         Increment = 1,
         CurrentValue = 50,
         Callback = function(value)
             flySpeed = value
             Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Voo definida para " .. value, Duration = 3 })
         end
     })
     ConfigTab:CreateSlider({
         Name = "Velocidade de Caminhada",
         Range = {16, 200},
         Increment = 1,
         CurrentValue = 16,
         Callback = function(value)
             setWalkspeed(value)
         end
     })
     ConfigTab:CreateSlider({
         Name = "Alcance do Aimbot",
         Range = {100, 1000},
         Increment = 10,
         CurrentValue = 500,
         Callback = function(value)
             aimbotRange = value
             Rayfield:Notify({ Title = "Configuração", Content = "Alcance do Aimbot definido para " .. value, Duration = 3 })
         end
     })

     -- Lidar com Reset do Personagem
     LocalPlayer.CharacterAdded:Connect(function(character)
         if isNoclip then toggleNoclip() toggleNoclip() end
         if isFlying then toggleFly() toggleFly() end
         if godModeEnabled then toggleGodMode() toggleGodMode() end
     end)

     -- Anti-Kick
     hookfunction(LocalPlayer.Kick, function() warn("Tentativa de kick bloqueada") end)

     -- Mensagem de Depuração
     print("SCP: The Red Lake Hub carregado com sucesso!")
     return "SCP: The Red Lake Hub Carregado"

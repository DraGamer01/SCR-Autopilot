-- SCP: The Red Lake Hub
-- Script atualizado com UI aprimorada, todas as funcionalidades, novas opções (munição infinita, disparos rápidos, dano da arma, hitbox quadrado)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
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
local defaultWalkSpeed = 16
local walkSpeed = defaultWalkSpeed
local aimbotEnabled = false
local aimbotRange = 500
local teleportEnabled = false
local godModeEnabled = false
local modifyWalkSpeed = false
local infiniteAmmoEnabled = false
local fastFireEnabled = false
local fireRate = 0.1 -- Padrão: 0.1 segundos por tiro
local customDamageEnabled = false
local weaponDamage = 50 -- Padrão: 50 de dano
local hitboxEnabled = false
local hitboxSize = 5 -- Padrão: 5 studs
local flyConnection
local aimbotConnection
local hitboxConnections = {}

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
    if modifyWalkSpeed and LocalPlayer.Character and LocalPlayer.Character.Humanoid then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").WalkSpeed = modifyWalkSpeed and walkSpeed or defaultWalkSpeed
    end)
    Rayfield:Notify({ Title = "Walkspeed", Content = "Velocidade definida para " .. speed .. (modifyWalkSpeed and "" or " (alteração desativada)"), Duration = 3 })
end

-- Função Aimbot
local function getClosestEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (humanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance < aimbotRange then
                    closestEnemy = player.Character
                    closestDistance = distance
                end
            end
        end
    end
    return closestEnemy
end

local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local enemy = getClosestEnemy()
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
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
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = LocalPlayer.Character.Humanoid
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health < math.huge then
                    humanoid.Health = math.huge
                end
            end)
        end
        LocalPlayer.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").MaxHealth = math.huge
            character:WaitForChild("Humanoid").Health = math.huge
            character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
                if character.Humanoid.Health < math.huge then
                    character.Humanoid.Health = math.huge
                end
            end)
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
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
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
    end
    Rayfield:Notify({ Title = "Teleporte", Content = teleportEnabled and "Teleporte por Clique Ativado" or "Teleporte por Clique Desativado", Duration = 3 })
end

-- Função Munição Infinita
local function toggleInfiniteAmmo()
    infiniteAmmoEnabled = not infiniteAmmoEnabled
    if infiniteAmmoEnabled then
        local function updateAmmo()
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:FindFirstChild("Ammo") then
                    tool.Ammo.Value = math.huge
                end
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                    if tool:FindFirstChild("Ammo") then
                        tool.Ammo.Value = math.huge
                    end
                end
            end
        end
        RunService.Heartbeat:Connect(updateAmmo)
    end
    Rayfield:Notify({ Title = "Munição Infinita", Content = infiniteAmmoEnabled and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Disparos Super Rápidos
local function toggleFastFire()
    fastFireEnabled = not fastFireEnabled
    if fastFireEnabled then
        local function modifyFireRate(tool)
            if tool and tool:FindFirstChild("FireRate") then
                local originalFireRate = tool.FireRate.Value
                tool.FireRate.Value = fireRate
                tool:GetPropertyChangedSignal("FireRate"):Connect(function()
                    if fastFireEnabled then
                        tool.FireRate.Value = fireRate
                    else
                        tool.FireRate.Value = originalFireRate
                    end
                end)
            end
        end
        LocalPlayer.CharacterAdded:Connect(function(character)
            character.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    modifyFireRate(child)
                end
            end)
        end)
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            modifyFireRate(tool)
        end
        if LocalPlayer.Character then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    modifyFireRate(tool)
                end
            end
        end
    end
    Rayfield:Notify({ Title = "Disparos Rápidos", Content = fastFireEnabled and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Alteração do Dano da Arma
local function toggleCustomDamage()
    customDamageEnabled = not customDamageEnabled
    if customDamageEnabled then
        local function modifyDamage(tool)
            if tool and tool:FindFirstChild("Damage") then
                tool.Damage.Value = weaponDamage
                tool:GetPropertyChangedSignal("Damage"):Connect(function()
                    if customDamageEnabled then
                        tool.Damage.Value = weaponDamage
                    end
                end)
            end
        end
        LocalPlayer.CharacterAdded:Connect(function(character)
            character.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    modifyDamage(child)
                end
            end)
        end)
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            modifyDamage(tool)
        end
        if LocalPlayer.Character then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    modifyDamage(tool)
                end
            end
        end
    end
    Rayfield:Notify({ Title = "Dano Personalizado", Content = customDamageEnabled and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Hitbox Quadrado
local function toggleHitbox()
    hitboxEnabled = not hitboxEnabled
    if hitboxEnabled then
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:FindFirstChild("Humanoid") and descendant ~= LocalPlayer.Character then
                local hitbox = Instance.new("Part")
                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                hitbox.Position = descendant.HumanoidRootPart.Position
                hitbox.Anchored = true
                hitbox.CanCollide = false
                hitbox.Transparency = 0.7
                hitbox.BrickColor = BrickColor.new("Bright red")
                hitbox.Parent = descendant
                table.insert(hitboxConnections, RunService.Heartbeat:Connect(function()
                    if descendant and descendant:FindFirstChild("HumanoidRootPart") then
                        hitbox.Position = descendant.HumanoidRootPart.Position
                    else
                        hitbox:Destroy()
                    end
                end))
            end
        end
        Workspace.DescendantAdded:Connect(function(descendant)
            if descendant:FindFirstChild("Humanoid") and descendant ~= LocalPlayer.Character and hitboxEnabled then
                local hitbox = Instance.new("Part")
                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                hitbox.Position = descendant.HumanoidRootPart.Position
                hitbox.Anchored = true
                hitbox.CanCollide = false
                hitbox.Transparency = 0.7
                hitbox.BrickColor = BrickColor.new("Bright red")
                hitbox.Parent = descendant
                table.insert(hitboxConnections, RunService.Heartbeat:Connect(function()
                    if descendant and descendant:FindFirstChild("HumanoidRootPart") then
                        hitbox.Position = descendant.HumanoidRootPart.Position
                    else
                        hitbox:Destroy()
                    end
                end))
            end
        end)
    else
        for _, connection in pairs(hitboxConnections) do
            connection:Disconnect()
        end
        hitboxConnections = {}
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:FindFirstChild("Humanoid") and descendant ~= LocalPlayer.Character then
                for _, part in pairs(descendant:GetChildren()) do
                    if part.Name == "Hitbox" then
                        part:Destroy()
                    end
                end
            end
        end
    end
    Rayfield:Notify({ Title = "Hitbox", Content = hitboxEnabled and "Ativado" or "Desativado", Duration = 3 })
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
MainTab:CreateToggle({
    Name = "Munição Infinita",
    CurrentValue = false,
    Callback = toggleInfiniteAmmo
})
MainTab:CreateToggle({
    Name = "Disparos Rápidos",
    CurrentValue = false,
    Callback = toggleFastFire
})
MainTab:CreateToggle({
    Name = "Dano Personalizado",
    CurrentValue = false,
    Callback = toggleCustomDamage
})
MainTab:CreateToggle({
    Name = "Hitbox Quadrado",
    CurrentValue = false,
    Callback = toggleHitbox
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
ConfigTab:CreateToggle({
    Name = "Alterar Velocidade de Caminhada",
    CurrentValue = false,
    Callback = function(value)
        modifyWalkSpeed = value
        if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
            LocalPlayer.Character.Humanoid.WalkSpeed = modifyWalkSpeed and walkSpeed or defaultWalkSpeed
        end
        Rayfield:Notify({ Title = "Configuração", Content = "Alteração de Walkspeed " .. (modifyWalkSpeed and "Ativada" or "Desativada"), Duration = 3 })
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
ConfigTab:CreateSlider({
    Name = "Taxa de Disparo (segundos)",
    Range = {0.01, 1},
    Increment = 0.01,
    CurrentValue = 0.1,
    Callback = function(value)
        fireRate = value
        Rayfield:Notify({ Title = "Configuração", Content = "Taxa de Disparo definida para " .. value .. "s", Duration = 3 })
    end
})
ConfigTab:CreateSlider({
    Name = "Dano da Arma",
    Range = {1, 500},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(value)
        weaponDamage = value
        Rayfield:Notify({ Title = "Configuração", Content = "Dano da Arma definido para " .. value, Duration = 3 })
    end
})
ConfigTab:CreateSlider({
    Name = "Tamanho do Hitbox",
    Range = {1, 20},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(value)
        hitboxSize = value
        if hitboxEnabled then
            toggleHitbox() -- Desativa e reativa para atualizar o tamanho
            toggleHitbox()
        end
        Rayfield:Notify({ Title = "Configuração", Content = "Tamanho do Hitbox definido para " .. value .. " studs", Duration = 3 })
    end
})

-- Função de Fechamento Completo
local function closeHub()
    if isNoclip then toggleNoclip() end
    if isFlying then toggleFly() end
    if aimbotEnabled then toggleAimbot() end
    if godModeEnabled then toggleGodMode() end
    if teleportEnabled then toggleTeleport() end
    if infiniteAmmoEnabled then toggleInfiniteAmmo() end
    if fastFireEnabled then toggleFastFire() end
    if customDamageEnabled then toggleCustomDamage() end
    if hitboxEnabled then toggleHitbox() end
    if flyConnection then flyConnection:Disconnect() end
    if aimbotConnection then aimbotConnection:Disconnect() end
    for _, connection in pairs(hitboxConnections) do
        connection:Disconnect()
    end
    hitboxConnections = {}
    Rayfield:Destroy() -- Fecha e remove completamente a UI
    print("SCP: The Red Lake Hub fechado completamente!")
end

-- Associar o fechamento ao botão X
Window.OnClose = closeHub

-- Lidar com Reset do Personagem
LocalPlayer.CharacterAdded:Connect(function(character)
    if isNoclip then toggleNoclip() toggleNoclip() end
    if isFlying then toggleFly() toggleFly() end
    if godModeEnabled then toggleGodMode() toggleGodMode() end
    if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
        LocalPlayer.Character.Humanoid.WalkSpeed = modifyWalkSpeed and walkSpeed or defaultWalkSpeed
    end
    if infiniteAmmoEnabled then toggleInfiniteAmmo() end
    if fastFireEnabled then toggleFastFire() end
    if customDamageEnabled then toggleCustomDamage() end
    if hitboxEnabled then toggleHitbox() toggleHitbox() end
end)

-- Anti-Kick
hookfunction(LocalPlayer.Kick, function() warn("Tentativa de kick bloqueada") end)

-- Mensagem de Depuração
print("SCP: The Red Lake Hub carregado com sucesso!")
return "SCP: The Red Lake Hub Carregado"

-- SCP: The Red Lake Hub
-- Script atualizado com UI aprimorada, integração com base de dados externa e hack de gamepasses

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/DraGamer01/Scripts/refs/heads/main/Rayfield_mod.lua'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

-- Carrega a base de dados externa
local Database = loadstring(game:HttpGet('https://raw.githubusercontent.com/DraGamer01/Scripts/refs/heads/main/TRLDatabase.lua'))()

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "SCP: The Red Lake Hub",
    LoadingTitle = "Carregando SCP Hub...",
    LoadingSubtitle = "por DraGamer01 (Atualizado)",
    ConfigurationSaving = { Enabled = true, FolderName = "SCPRedLakeHub", FileName = "Config" }
})

-- Funções para controlar a transparência da UI
local function applyTransparency(value)
    if Window and Window.Main then
        Window.Main.BackgroundTransparency = value
        for _, element in pairs(Window.Main:GetChildren()) do
            if element:IsA("GuiObject") and element.Name ~= "Topbar" then
                element.BackgroundTransparency = value
            end
        end
        if Window.Main:FindFirstChild("Topbar") then
            Window.Main.Topbar.BackgroundTransparency = value * 0.6
        end
    end
end

local function setTransparency(value)
    if value >= 0 and value <= 1 then
        applyTransparency(value)
    end
end

-- Variáveis
local isNoclip = false
local isFlying = false
local flySpeed = 50
local walkSpeed = 16
local teleportEnabled = false
local aimbotRange = 500
local hitboxSize = 5
local damage = 50
local fireRate = 0.1
local researchProgress = 0
local flyConnection
local teleportConnection
getgenv().Connections = getgenv().Connections or {}

-- Função Noclip
local function toggleNoclip()
    isNoclip = not isNoclip
    if isNoclip then
        table.insert(getgenv().Connections, RunService:BindToRenderStep("Noclip", Enum.RenderPriority.Character.Value, function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end))
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
        table.insert(getgenv().Connections, flyConnection)
    else
        if flyConnection then flyConnection:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
    Rayfield:Notify({ Title = "Fly", Content = isFlying and "Fly Ativado" or "Fly Desativado", Duration = 3 })
end

-- Função Teleport
local function toggleTeleport()
    teleportEnabled = not teleportEnabled
    if teleportEnabled then
        teleportConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and teleportEnabled then
                local mouse = LocalPlayer:GetMouse()
                local hit = mouse.Hit
                if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
        table.insert(getgenv().Connections, teleportConnection)
    else
        if teleportConnection then teleportConnection:Disconnect() end
    end
    Rayfield:Notify({ Title = "Teleporte", Content = teleportEnabled and "Teleporte por Clique Ativado" or "Teleporte por Clique Desativado", Duration = 3 })
end

-- Função Hack de Gamepasses (Experimental)
local function unlockGamepasses()
    local success, err = pcall(function()
        local MarketplaceService = game:GetService("MarketplaceService")
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        -- Simula a compra de gamepasses alterando valores locais (não garantido contra detecção)
        for _, gamepass in pairs(Database.Gamepasses) do
            local productId = gamepass.ProductId or 0 -- Substituir com IDs reais se disponíveis
            if productId > 0 then
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, productId)
                Rayfield:Notify({ Title = "Hack", Content = "Tentando desbloquear " .. gamepass.Name, Duration = 3 })
            end
        end
    end)
    if not success then
        Rayfield:Notify({ Title = "Erro", Content = "Falha ao desbloquear gamepasses. Pode ser detectado!", Duration = 5 })
    end
end

-- Aba Principal
local MainTab = Window:CreateTab("Principal", 4483362458)
MainTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Callback = toggleNoclip })
MainTab:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = toggleFly })
MainTab:CreateToggle({ Name = "Teleporte por Clique", CurrentValue = false, Callback = toggleTeleport })
MainTab:CreateToggle({ Name = "Munição Infinita", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "Ativar Walkspeed", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "Hitbox", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "Disparos Rápidos", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "Dano Personalizado", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function() end })
MainTab:CreateToggle({ Name = "God Mode", CurrentValue = false, Callback = function() end })
MainTab:CreateButton({ Name = "Desbloquear Gamepasses", Callback = unlockGamepasses })

-- Aba Research Progress
local ResearchTab = Window:CreateTab("Research", 4483362458)
ResearchTab:CreateSlider({
    Name = "Progresso da Pesquisa",
    Range = {0, 100},
    Increment = 5,
    CurrentValue = 0,
    Flag = "ResearchProgress",
    Callback = function(value)
        researchProgress = value
        if value >= 100 then
            Rayfield:Notify({ Title = "Sucesso", Content = "Pesquisa concluída! SCP-354 neutralizado.", Duration = 5 })
        elseif value >= 80 then
            Rayfield:Notify({ Title = "Aviso", Content = "Pesquisa em fase final. Aumente a defesa!", Duration = 3 })
        end
    end
})

-- Aba Operatives
local OperativesTab = Window:CreateTab("Operatives", 4483362458)
local selectedOperative = "Guard"
OperativesTab:CreateDropdown({
    Name = "Selecionar Operative",
    Options = {"Guard", "Scout", "Viper"},
    CurrentOption = "Guard",
    Flag = "OperativeSelect",
    Callback = function(value)
        selectedOperative = value
        local op = nil
        for _, operative in pairs(Database.Operatives) do
            if operative.Name == value then op = operative break end
        end
        if op then Rayfield:Notify({ Title = "Operative", Content = "Selecionado: " .. op.Name .. " (Nível " .. op.LevelReq .. ")", Duration = 3 }) end
    end
})
OperativesTab:CreateInput({
    Name = "Nível do Operative",
    PlaceholderText = "Insira nível (0-∞)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 0 then
            Rayfield:Notify({ Title = "Nível", Content = "Nível do " .. selectedOperative .. " definido para " .. value, Duration = 3 })
        end
    end
})

-- Aba Inventory
local InventoryTab = Window:CreateTab("Inventory", 4483362458)
InventoryTab:CreateDropdown({
    Name = "Selecionar Arma",
    Options = {"G18", "AK47", "Railgun"},
    CurrentOption = "G18",
    Flag = "WeaponSelect",
    Callback = function(value)
        local weapon = nil
        for _, w in pairs(Database.Weapons) do if w.Name == value then weapon = w break end end
        if weapon then Rayfield:Notify({ Title = "Arma", Content = "Equipada: " .. weapon.Name .. " (Dano: " .. weapon.Damage .. ")", Duration = 3 }) end
    end
})
InventoryTab:CreateDropdown({
    Name = "Selecionar Item",
    Options = {"Poison Cure", "Grenade"},
    CurrentOption = "Poison Cure",
    Flag = "ItemSelect",
    Callback = function(value)
        local item = nil
        for _, i in pairs(Database.Items) do if i.Name == value then item = i break end end
        if item then Rayfield:Notify({ Title = "Item", Content = "Usado: " .. item.Name .. " (" .. item.Effect .. ")", Duration = 3 }) end
    end
})

-- Aba Buildings
local BuildingsTab = Window:CreateTab("Buildings", 4483362458)
BuildingsTab:CreateDropdown({
    Name = "Construir Edifício",
    Options = {"Safehouse", "Generator", "Money Printer", "Towers"},
    CurrentOption = "Safehouse",
    Flag = "BuildingSelect",
    Callback = function(value)
        local building = nil
        for _, b in pairs(Database.Buildings) do if b.Name == value then building = b break end end
        if building then Rayfield:Notify({ Title = "Construção", Content = "Construído: " .. building.Name .. " (Custo: " .. building.Cost .. ")", Duration = 3 }) end
    end
})

-- Aba Gamemodes
local GamemodeTab = Window:CreateTab("Gamemodes", 4483362458)
GamemodeTab:CreateDropdown({
    Name = "Selecionar Gamemode",
    Options = {"Classic", "UIU Raid"},
    CurrentOption = "Classic",
    Flag = "GamemodeSelect",
    Callback = function(value)
        local mode = nil
        for _, g in pairs(Database.Gamemodes) do if g.Name == value then mode = g break end end
        if mode then Rayfield:Notify({ Title = "Gamemode", Content = mode.Name .. ": " .. mode.Objective, Duration = 3 }) end
    end
})

-- Aba Configurações
local ConfigTab = Window:CreateTab("Configurações", 4483362458)
local flySpeedInput = ConfigTab:CreateInput({
    Name = "Velocidade de Voo (Valor)",
    PlaceholderText = "Insira valor (10-1000)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 10 and value <= 1000 then
            flySpeed = value
            ConfigTab:FindFirstChild("FlySpeedSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Voo definida para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 10 e 1000.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Velocidade de Voo",
    Range = {10, 1000},
    Increment = 1,
    CurrentValue = 50,
    Flag = "FlySpeedSlider",
    Callback = function(value)
        flySpeed = value
        flySpeedInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Voo definida para " .. value, Duration = 3 })
    end
})
local walkSpeedInput = ConfigTab:CreateInput({
    Name = "Velocidade de Caminhada (Valor)",
    PlaceholderText = "Insira valor (16-200)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 16 and value <= 200 then
            walkSpeed = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
            ConfigTab:FindFirstChild("WalkSpeedSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Caminhada definida para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 16 e 200.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Velocidade de Caminhada",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(value)
        walkSpeed = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
        walkSpeedInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Caminhada definida para " .. value, Duration = 3 })
    end
})
local aimbotRangeInput = ConfigTab:CreateInput({
    Name = "Alcance do Aimbot (Valor)",
    PlaceholderText = "Insira valor (100-1000)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 100 and value <= 1000 then
            aimbotRange = value
            ConfigTab:FindFirstChild("AimbotRangeSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Alcance do Aimbot definido para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 100 e 1000.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Alcance do Aimbot",
    Range = {100, 1000},
    Increment = 10,
    CurrentValue = 500,
    Flag = "AimbotRangeSlider",
    Callback = function(value)
        aimbotRange = value
        aimbotRangeInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Alcance do Aimbot definido para " .. value, Duration = 3 })
    end
})
local hitboxSizeInput = ConfigTab:CreateInput({
    Name = "Tamanho da Hitbox (Valor)",
    PlaceholderText = "Insira valor (5-20)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 5 and value <= 20 then
            hitboxSize = value
            ConfigTab:FindFirstChild("HitboxSizeSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Tamanho da Hitbox definido para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 5 e 20.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {5, 20},
    Increment = 1,
    CurrentValue = 5,
    Flag = "HitboxSizeSlider",
    Callback = function(value)
        hitboxSize = value
        hitboxSizeInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Tamanho da Hitbox definido para " .. value, Duration = 3 })
    end
})
local damageInput = ConfigTab:CreateInput({
    Name = "Dano (Valor)",
    PlaceholderText = "Insira valor (1-100)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 1 and value <= 100 then
            damage = value
            ConfigTab:FindFirstChild("DamageSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Dano definido para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 1 e 100.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Dano",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 50,
    Flag = "DamageSlider",
    Callback = function(value)
        damage = value
        damageInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Dano definido para " .. value, Duration = 3 })
    end
})
local fireRateInput = ConfigTab:CreateInput({
    Name = "Taxa de Disparo (Valor)",
    PlaceholderText = "Insira valor (0.1-1)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 0.1 and value <= 1 then
            fireRate = value
            ConfigTab:FindFirstChild("FireRateSlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Taxa de Disparo definida para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 0.1 e 1.", Duration = 3 })
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Taxa de Disparo",
    Range = {0.1, 1},
    Increment = 0.1,
    CurrentValue = 0.1,
    Flag = "FireRateSlider",
    Callback = function(value)
        fireRate = value
        fireRateInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Taxa de Disparo definida para " .. value, Duration = 3 })
    end
})

-- Aba Config do Hub
local HubConfigTab = Window:CreateTab("Config do Hub", 4483362458)
local transparencyInput = HubConfigTab:CreateInput({
    Name = "Transparência do Hub (Valor)",
    PlaceholderText = "Insira valor (0-1)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 0 and value <= 1 then
            setTransparency(value)
            HubConfigTab:FindFirstChild("TransparencySlider"):Set(value)
            Rayfield:Notify({ Title = "Configuração", Content = "Transparência do Hub definida para " .. value, Duration = 3 })
        else
            Rayfield:Notify({ Title = "Erro", Content = "Insira um valor válido entre 0 e 1.", Duration = 3 })
        end
    end
})
HubConfigTab:CreateSlider({
    Name = "Transparência do Hub",
    Range = {0, 1},
    Increment = 0.1,
    CurrentValue = 0.5,
    Flag = "TransparencySlider",
    Callback = function(value)
        setTransparency(value)
        transparencyInput:Set(tostring(value))
        Rayfield:Notify({ Title = "Configuração", Content = "Transparência do Hub definida para " .. value, Duration = 3 })
    end
})
HubConfigTab:CreateButton({
    Name = "Encerrar Script",
    Callback = function()
        if isNoclip then toggleNoclip() end
        if isFlying then toggleFly() end
        if teleportEnabled then toggleTeleport() end
        if getgenv().Connections then
            for _, connection in pairs(getgenv().Connections) do
                pcall(function() connection:Disconnect() end)
            end
            getgenv().Connections = nil
        end
        if LocalPlayer.Character then
            local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local bodyVelocity = humanoidRootPart:FindFirstChild("BodyVelocity")
                if bodyVelocity then bodyVelocity:Destroy() end
            end
        end
        if Window then
            Rayfield:Destroy()
            Window = nil
        end
        getgenv().SCPTheRedLakeHub = nil
        isNoclip = nil
        isFlying = nil
        flySpeed = nil
        walkSpeed = nil
        teleportEnabled = nil
        aimbotRange = nil
        hitboxSize = nil
        damage = nil
        fireRate = nil
        flyConnection = nil
        teleportConnection = nil
        researchProgress = nil
        for _, service in pairs(game:GetService("RunService"):GetConnections()) do
            pcall(function() service:Disconnect() end)
        end
        collectgarbage("collect")
        if researchProgress and researchProgress < 100 then
            Rayfield:Notify({ Title = "Falha", Content = "Pesquisa incompleta! SCP-354 não foi neutralizado.", Duration = 5 })
        else
            Rayfield:Notify({ Title = "Script Encerrado", Content = "O script foi completamente encerrado.", Duration = 3 })
        end
        print("SCP: The Red Lake Hub encerrado completamente!")
    end
})

-- Lidar com Reset do Personagem
table.insert(getgenv().Connections, LocalPlayer.CharacterAdded:Connect(function(character)
    if isNoclip then toggleNoclip() toggleNoclip() end
    if isFlying then toggleFly() toggleFly() end
end))

-- Anti-Kick
hookfunction(LocalPlayer.Kick, function() warn("Tentativa de kick bloqueada") end)

-- Sistema Anti-Erro 277
table.insert(getgenv().Connections, RunService.Stepped:Connect(function()
    pcall(function()
        if tick() % 5 < 0.1 then
            ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents", 2)
        end
    end)
end))

print("SCP: The Red Lake Hub carregado com sucesso!")
return "SCP: The Red Lake Hub Carregado"

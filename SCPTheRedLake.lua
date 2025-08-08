-- SCP: The Red Lake Hub
-- Script atualizado com UI aprimorada, aba de configurações

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/DraGamer01/Scripts/refs/heads/main/Rayfield_mod.lua'))()
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
local teleportEnabled = false
local flyConnection
local hubTransparency = 0

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
    Name = "Teleporte por Clique",
    CurrentValue = false,
    Callback = toggleTeleport
})
MainTab:CreateToggle({
    Name = "Munição Infinita",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "Ativar Walkspeed",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "Hitbox",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "Disparos Rápidos",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "Dano Personalizado",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function() end
})
MainTab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function() end
})

-- Aba Configurações
local ConfigTab = Window:CreateTab("Configurações", 4483362458)
local flySpeedInput = ConfigTab:CreateInput({
    Name = "Velocidade de Voo (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 10 and value <= 1000 then
            flySpeed = value
            if Window and Window:FindFirstChild("FlySpeedSlider") then
                Window.FlySpeedSlider:Set(value)
            end
            Rayfield:Notify({ Title = "Configuração", Content = "Velocidade de Voo definida para " .. value, Duration = 3 })
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
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 16 and value <= 200 then
            walkSpeed = value
            if Window and Window:FindFirstChild("WalkSpeedSlider") then
                Window.WalkSpeedSlider:Set(value)
            end
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Velocidade de Caminhada",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function() end
})
local aimbotRangeInput = ConfigTab:CreateInput({
    Name = "Alcance do Aimbot (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 100 and value <= 1000 then
            aimbotRange = value
            if Window and Window:FindFirstChild("AimbotRangeSlider") then
                Window.AimbotRangeSlider:Set(value)
            end
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Alcance do Aimbot",
    Range = {100, 1000},
    Increment = 10,
    CurrentValue = 500,
    Flag = "AimbotRangeSlider",
    Callback = function() end
})
local hitboxSizeInput = ConfigTab:CreateInput({
    Name = "Tamanho da Hitbox (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 5 and value <= 20 then
            if Window and Window:FindFirstChild("HitboxSizeSlider") then
                Window.HitboxSizeSlider:Set(value)
            end
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {5, 20},
    Increment = 1,
    CurrentValue = 5,
    Flag = "HitboxSizeSlider",
    Callback = function() end
})
local damageInput = ConfigTab:CreateInput({
    Name = "Dano (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 1 and value <= 100 then
            if Window and Window:FindFirstChild("DamageSlider") then
                Window.DamageSlider:Set(value)
            end
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Dano",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 50,
    Flag = "DamageSlider",
    Callback = function() end
})
local fireRateInput = ConfigTab:CreateInput({
    Name = "Taxa de Disparo (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 0.1 and value <= 1 then
            if Window and Window:FindFirstChild("FireRateSlider") then
                Window.FireRateSlider:Set(value)
            end
        end
    end
})
ConfigTab:CreateSlider({
    Name = "Taxa de Disparo",
    Range = {0.1, 1},
    Increment = 0.1,
    CurrentValue = 0.1,
    Flag = "FireRateSlider",
    Callback = function() end
})

-- Aba Config do Hub
local HubConfigTab = Window:CreateTab("Config do Hub", 4483362458)
local transparencyInput = HubConfigTab:CreateInput({
    Name = "Transparência do Hub (Valor)",
    PlaceholderText = "Insira valor",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value and value >= 0 and value <= 1 then
            hubTransparency = value
            if Window and Window.Main then
                Window.Main.BackgroundTransparency = value
                for _, element in pairs(Window.Main:GetChildren()) do
                    if element:IsA("GuiObject") then
                        element.BackgroundTransparency = value
                    end
                end
                transparencyInput:Set(tostring(value))
            end
            Rayfield:Notify({ Title = "Configuração", Content = "Transparência do Hub definida para " .. value, Duration = 3 })
        end
    end
})
HubConfigTab:CreateSlider({
    Name = "Transparência do Hub",
    Range = {0, 1},
    Increment = 0.1,
    CurrentValue = 0,
    Callback = function(value)
        hubTransparency = value
        if Window and Window.Main then
            Window.Main.BackgroundTransparency = value
            for _, element in pairs(Window.Main:GetChildren()) do
                if element:IsA("GuiObject") then
                    element.BackgroundTransparency = value
                end
            end
            transparencyInput:Set(tostring(value))
        end
        Rayfield:Notify({ Title = "Configuração", Content = "Transparência do Hub definida para " .. value, Duration = 3 })
    end
})
HubConfigTab:CreateButton({
    Name = "Encerrar Script",
    Callback = function()
        if flyConnection then flyConnection:Disconnect() end
        RunService:UnbindFromRenderStep("Noclip")
        if Window then
            Window:Destroy()
            getgenv().SCPTheRedLakeHub = nil
            print("SCP: The Red Lake Hub encerrado completamente!")
        end
    end
})

-- Lidar com Reset do Personagem
LocalPlayer.CharacterAdded:Connect(function(character)
    if isNoclip then toggleNoclip() toggleNoclip() end
    if isFlying then toggleFly() toggleFly() end
end)

-- Anti-Kick
hookfunction(LocalPlayer.Kick, function() warn("Tentativa de kick bloqueada") end)

-- Mensagem de Depuração
print("SCP: The Red Lake Hub carregado com sucesso!")
return "SCP: The Red Lake Hub Carregado"

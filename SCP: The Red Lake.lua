-- SCP: The Red Lake Hack Script for Swift Executor
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- GUI Setup (Local ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackPanel_" .. tostring(math.random(1000, 9999))
ScreenGui.Parent = Player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 500)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local ToggleAimbot = Instance.new("TextButton")
ToggleAimbot.Size = UDim2.new(0, 180, 0, 40)
ToggleAimbot.Position = UDim2.new(0, 10, 0, 10)
ToggleAimbot.Text = "Toggle Aimbot"
ToggleAimbot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleAimbot.Parent = MainFrame

local ToggleHitbox = Instance.new("TextButton")
ToggleHitbox.Size = UDim2.new(0, 180, 0, 40)
ToggleHitbox.Position = UDim2.new(0, 10, 0, 60)
ToggleHitbox.Text = "Toggle Dynamic Hitbox"
ToggleHitbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleHitbox.Parent = MainFrame

local HitboxScaleSlider = Instance.new("TextButton")
HitboxScaleSlider.Size = UDim2.new(0, 180, 0, 40)
HitboxScaleSlider.Position = UDim2.new(0, 10, 0, 110)
HitboxScaleSlider.Text = "Hitbox Scale: 1.0 (Click to Adjust)"
HitboxScaleSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
HitboxScaleSlider.Parent = MainFrame

local ToggleGodMode = Instance.new("TextButton")
ToggleGodMode.Size = UDim2.new(0, 180, 0, 40)
ToggleGodMode.Position = UDim2.new(0, 10, 0, 160)
ToggleGodMode.Text = "Toggle God Mode"
ToggleGodMode.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleGodMode.Parent = MainFrame

local ToggleGeneratorImmortal = Instance.new("TextButton")
ToggleGeneratorImmortal.Size = UDim2.new(0, 180, 0, 40)
ToggleGeneratorImmortal.Position = UDim2.new(0, 10, 0, 210)
ToggleGeneratorImmortal.Text = "Toggle Generator Immortal"
ToggleGeneratorImmortal.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleGeneratorImmortal.Parent = MainFrame

local ToggleNoclip = Instance.new("TextButton")
ToggleNoclip.Size = UDim2.new(0, 180, 0, 40)
ToggleNoclip.Position = UDim2.new(0, 10, 0, 260)
ToggleNoclip.Text = "Toggle Noclip"
ToggleNoclip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleNoclip.Parent = MainFrame

local ToggleFly = Instance.new("TextButton")
ToggleFly.Size = UDim2.new(0, 180, 0, 40)
ToggleFly.Position = UDim2.new(0, 10, 0, 310)
ToggleFly.Text = "Toggle Fly Mode"
ToggleFly.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleFly.Parent = MainFrame

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0, 180, 0, 40)
SpeedSlider.Position = UDim2.new(0, 10, 0, 360)
SpeedSlider.Text = "Speed: 16 (Click to Adjust)"
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedSlider.Parent = MainFrame

local ToggleFastFire = Instance.new("TextButton")
ToggleFastFire.Size = UDim2.new(0, 180, 0, 40)
ToggleFastFire.Position = UDim2.new(0, 10, 0, 410)
ToggleFastFire.Text = "Toggle Fast Fire"
ToggleFastFire.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleFastFire.Parent = MainFrame

local FireRateSlider = Instance.new("TextButton")
FireRateSlider.Size = UDim2.new(0, 180, 0, 40)
FireRateSlider.Position = UDim2.new(0, 10, 0, 460)
FireRateSlider.Text = "Fire Rate: 1.0x (Click to Adjust)"
FireRateSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FireRateSlider.Parent = MainFrame

-- Variables
local AimbotEnabled = false
local AimbotFOV = 100
local AimbotSmoothness = 0.1
local TargetPart = "Head"
local DynamicHitboxEnabled = false
local HitboxScale = 1.0
local NoclipEnabled = false
local FlyEnabled = false
local FlySpeed = 50
local SpeedValue = 16
local GodModeEnabled = false
local GeneratorImmortalEnabled = false
local FastFireEnabled = false
local FireRateMultiplier = 1.0 -- 1.0x = normal speed, <1.0 = faster
local DamageMultiplier = 1.0

local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.Velocity = Vector3.new(0, 0, 0)

-- God Mode
local function EnableGodMode()
    if GodModeEnabled then
        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if Humanoid.Health < Humanoid.MaxHealth then
                Humanoid.Health = math.min(Humanoid.MaxHealth, Humanoid.Health + 1000)
            end
        end)
    end
end

-- Generator Immortal
local function EnableGeneratorImmortal()
    local generator = workspace:FindFirstChild("Generator")
    if GeneratorImmortalEnabled and generator then
        if generator:FindFirstChild("Humanoid") then
            generator.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if generator.Humanoid.Health < generator.Humanoid.MaxHealth then
                    generator.Humanoid.Health = generator.Humanoid.MaxHealth
                end
            end)
        elseif generator:FindFirstChild("Health") then
            spawn(function()
                while GeneratorImmortalEnabled and generator.Parent do
                    if generator.Health.Value < generator.Health.MaxValue then
                        generator.Health.Value = generator.Health.MaxValue
                    end
                    wait(0.1)
                end
            end)
        end
    end
end

-- Aimbot with Dynamic Hitbox
local function GetClosestEnemy()
    local ClosestEnemy = nil
    local ClosestDistance = AimbotFOV
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= Character and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
            local EnemyHead = v:FindFirstChild("Head")
            local HeadPos = EnemyHead.Position
            local HeadSize = EnemyHead.Size.X
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")
            local TargetPos = HumanoidRootPart and HumanoidRootPart.Position or HeadPos

            if DynamicHitboxEnabled then
                local DynamicRadius = HeadSize * HitboxScale * (HumanoidRootPart and 2 or 1)
                local MousePos = UserInputService:GetMouseLocation()
                local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(TargetPos)
                local Distance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - Vector2.new(MousePos.X, MousePos.Y)).Magnitude
                if OnScreen and Distance < ClosestDistance + DynamicRadius and v:FindFirstChild("Humanoid").Health > 0 then
                    ClosestDistance = Distance
                    ClosestEnemy = v
                end
            else
                local HeadPos, OnScreen = Camera:WorldToScreenPoint(TargetPos)
                local Distance = (Vector2.new(HeadPos.X, HeadPos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).Magnitude
                if OnScreen and Distance < ClosestDistance and v:FindFirstChild("Humanoid").Health > 0 then
                    ClosestDistance = Distance
                    ClosestEnemy = v
                end
            end
        end
    end
    return ClosestEnemy
end

local function Aimbot()
    if AimbotEnabled then
        local Enemy = GetClosestEnemy()
        if Enemy then
            local TargetPos = Enemy:FindFirstChild(TargetPart).Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, TargetPos), AimbotSmoothness)
        end
    end
end

-- Noclip
local function NoclipLoop()
    if NoclipEnabled then
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    else
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end

-- Fly
local function FlyLoop()
    if FlyEnabled then
        BodyVelocity.Parent = RootPart
        local MoveDirection = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection = MoveDirection + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection = MoveDirection - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection = MoveDirection - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection = MoveDirection + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDirection = MoveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDirection = MoveDirection - Vector3.new(0, 1, 0) end
        BodyVelocity.Velocity = MoveDirection * FlySpeed
    else
        BodyVelocity.Parent = nil
    end
end

-- Weapon Modifications
local function ModifyWeapons()
    if FastFireEnabled then
        for _, tool in pairs(Player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                local script = tool:FindFirstChildWhichIsA("Script") or tool:FindFirstChildWhichIsA("LocalScript")
                if script then
                    for _, conn in pairs(getconnections(script.Activated)) do
                        conn:Disable()
                    end
                    spawn(function()
                        while FastFireEnabled and tool.Parent do
                            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                                script.Activated:Fire()
                                wait(FireRateMultiplier * 0.1) -- Adjustable fire rate
                            end
                            wait(0.01)
                        end
                    end)
                end
                -- Infinite Ammo
                local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild(" ammunition")
                if ammo then
                    ammo.Value = math.huge
                    ammo:GetPropertyChangedSignal("Value"):Connect(function()
                        ammo.Value = math.huge
                    end)
                end
                -- Damage Modifier
                local damage = tool:FindFirstChild("Damage")
                if damage then
                    damage.Value = damage.Value * DamageMultiplier
                    damage:GetPropertyChangedSignal("Value"):Connect(function()
                        damage.Value = damage.Value * DamageMultiplier
                    end)
                end
            end
        end
        Player.Character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                ModifyWeapons()
            end
        end)
    end
end

-- GUI Events
ToggleAimbot.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    ToggleAimbot.Text = "Toggle Aimbot: " .. (AimbotEnabled and "ON" or "OFF")
end)

ToggleHitbox.MouseButton1Click:Connect(function()
    DynamicHitboxEnabled = not DynamicHitboxEnabled
    ToggleHitbox.Text = "Toggle Dynamic Hitbox: " .. (DynamicHitboxEnabled and "ON" or "OFF")
end)

HitboxScaleSlider.MouseButton1Click:Connect(function()
    HitboxScale = math.clamp(HitboxScale + 0.5, 1.0, 5.0)
    HitboxScaleSlider.Text = "Hitbox Scale: " .. string.format("%.1f", HitboxScale) .. " (Click to Adjust)"
end)

ToggleGodMode.MouseButton1Click:Connect(function()
    GodModeEnabled = not GodModeEnabled
    EnableGodMode()
    ToggleGodMode.Text = "Toggle God Mode: " .. (GodModeEnabled and "ON" or "OFF")
end)

ToggleGeneratorImmortal.MouseButton1Click:Connect(function()
    GeneratorImmortalEnabled = not GeneratorImmortalEnabled
    EnableGeneratorImmortal()
    ToggleGeneratorImmortal.Text = "Toggle Generator Immortal: " .. (GeneratorImmortalEnabled and "ON" or "OFF")
end)

ToggleNoclip.MouseButton1Click:Connect(function()
    NoclipEnabled = not NoclipEnabled
    ToggleNoclip.Text = "Toggle Noclip: " .. (NoclipEnabled and "ON" or "OFF")
end)

ToggleFly.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    ToggleFly.Text = "Toggle Fly Mode: " .. (FlyEnabled and "ON" or "OFF")
end)

SpeedSlider.MouseButton1Click:Connect(function()
    SpeedValue = math.clamp(SpeedValue + 10, 16, 100)
    Humanoid.WalkSpeed = SpeedValue
    SpeedSlider.Text = "Speed: " .. SpeedValue .. " (Click to Adjust)"
end)

ToggleFastFire.MouseButton1Click:Connect(function()
    FastFireEnabled = not FastFireEnabled
    ModifyWeapons()
    ToggleFastFire.Text = "Toggle Fast Fire: " .. (FastFireEnabled and "ON" or "OFF")
end)

FireRateSlider.MouseButton1Click:Connect(function()
    FireRateMultiplier = math.clamp(FireRateMultiplier - 0.1, 0.1, 1.0) -- 0.1x = fastest, 1.0x = normal
    FireRateSlider.Text = "Fire Rate: " .. string.format("%.1fx", 1.0 / FireRateMultiplier) .. " (Click to Adjust)"
    ModifyWeapons()
end)

-- Loops
RunService.Stepped:Connect(function()
    NoclipLoop()
    FlyLoop()
    Aimbot()
end)

-- Respawn Handling
Player.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if GodModeEnabled then EnableGodMode() end
    Humanoid.WalkSpeed = math.min(SpeedValue, 50)
    if FastFireEnabled then ModifyWeapons() end
end)

-- Cleanup
Player.AncestryChanged:Connect(function()
    if not Player:IsDescendantOf(game) then
        ScreenGui:Destroy()
        BodyVelocity:Destroy()
    end
end)

print("SCP: The Red Lake Hack Loaded! Use the GUI to toggle features.")

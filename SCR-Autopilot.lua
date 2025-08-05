-- Carrega a biblioteca Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({Name = "SCR Autopilot", LoadingTitle = "Autopilot", LoadingSubtitle = "by xAI", ConfigurationSaving = {Enabled = true, FolderName = "SCR_Autopilot", FileName = "Config"}})

-- Configurações iniciais
local trainMaxSpeed, run, braking, redSignal, yellow = 100, false, false, false, false
local brakeTime = 1.75 -- Ajustável para física da V2.2

-- Função para obter HUD e validar
local function getHUD()
    local trainHUD = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGui") and game.Players.LocalPlayer.PlayerGui.MainGui:FindFirstChild("TrainHUD")
    if not trainHUD then return end
    local mainFrame = trainHUD:FindFirstChild("MainFrame2x")
    if not mainFrame then return end
    return trainHUD, mainFrame:FindFirstChild("NextSignalFrame"), mainFrame:FindFirstChild("StatusFrame"), mainFrame:FindFirstChild("DestinationFrame")
end

-- Funções de ação do trem (substituir pelos RemoteEvents reais)
local function accelerate() local h = getHUD() if h then local e = h[1]:FindFirstChild("AccelerateEvent") if e then e:FireServer(true) else warn("AccelerateEvent não encontrado!") end end end
local function brake() local h = getHUD() if h then local e = h[1]:FindFirstChild("BrakeEvent") if e then e:FireServer(true) wait(brakeTime) e:FireServer(false) else warn("BrakeEvent não encontrado!") end end end
local function openDoors() local h = getHUD() if h then local e = h[1]:FindFirstChild("DoorEvent") if e then e:FireServer() else warn("DoorEvent não encontrado!") end end end
local function nextSchedule() local h = getHUD() if h and h[1]:FindFirstChild("SummaryWindow") and h[1].SummaryWindow:FindFirstChild("NextSchedule") then firesignal(h[1].SummaryWindow.NextSchedule['Activated']) else warn("NextSchedule não encontrado!") end end
local function maintainSpeed() local h = getHUD() if h then local e = h[1]:FindFirstChild("SpeedControlEvent") if e then e:FireServer(trainMaxSpeed) else warn("SpeedControlEvent não encontrado!") end end end

-- Debug para listar eventos
local function debugPaths()
    Rayfield:Notify({Title = "Debug", Content = "Listando eventos no console (F9)", Duration = 5})
    print("=== Debug de Eventos ===")
    for _, v in pairs(game:GetDescendants()) do if v:IsA("RemoteEvent") or v:IsA("BindableEvent") then print(v:GetFullName()) end end
    print("=== Fim ===")
end

-- Interface Rayfield
local Tab = Window:CreateTab("Principal")
local Section = Tab:CreateSection("Autopilot")
Section:CreateToggle({Name = "Ligar/Desligar", CurrentValue = false, Flag = "Autopilot", Callback = function(state) run = state Rayfield:Notify({Title = "Autopilot", Content = state and "Ativado!" or "Desativado!", Duration = 3}) end})
Section:CreateInput({Name = "Vel. Máx.", Info = "Padrão: 100", PlaceholderText = "Ex.: 100", Callback = function(txt) local s = tonumber(txt) if s and s > 0 then trainMaxSpeed = s Rayfield:Notify({Title = "Velocidade", Content = "Definida para " .. s, Duration = 3}) else Rayfield:Notify({Title = "Erro", Content = "Velocidade inválida!", Duration = 3}) end end})
Section:CreateInput({Name = "Tempo Frenagem (s)", Info = "Padrão: 1.75", PlaceholderText = "Ex.: 1.75", Callback = function(txt) local t = tonumber(txt) if t and t > 0 then brakeTime = t Rayfield:Notify({Title = "Frenagem", Content = "Tempo definido para " .. t .. "s", Duration = 3}) else Rayfield:Notify({Title = "Erro", Content = "Tempo inválido!", Duration = 3}) end end})
Section:CreateButton({Name = "Debug Eventos", Info = "Lista eventos no console (F9)", Callback = debugPaths})
Tab:CreateSection("UI"):CreateKeybind({Name = "Ocultar/Mostrar UI", CurrentKeybind = "G", Callback = function() Rayfield:ToggleUI() end})

-- Loop principal
while true do wait(1)
    while run do wait(0.01)
        local hud, signalFrame, statusFrame, destFrame = getHUD()
        if not (hud and signalFrame and statusFrame and destFrame) then warn("HUD incompleto!") continue end

        local signalName, signalColor, yellowSignal, preYellow, speed, dist = signalFrame.SignalName.Text, tostring(signalFrame.Danger.ImageColor3), tostring(signalFrame.Caution.ImageColor3), tostring(signalFrame.Precaution.ImageColor3), tonumber(statusFrame.Speed.SpeedLabel.Text) or 0, tonumber(string.match(destFrame.DistanceLabel.Text, "in (%d%.%d+) miles")) or 0
        local brakingDistance = (200 - (trainMaxSpeed + 100)) * -1
        local playerX, playerZ = game.Workspace.CurrentCamera.CFrame.Position.X, game.Workspace.CurrentCamera.CFrame.Position.Z

        if signalName ~= "----" then
            local signal = game.Workspace.Signals:FindFirstChild(signalName)
            if not signal or not signal:FindFirstChild("ID") then warn("Sinal ou ID não encontrado!") continue end
            local signalX, signalZ = signal.ID.CFrame.Position.X, signal.ID.CFrame.Position.Z
            local distX, distZ = math.abs(playerX - signalX) ^ 2, math.abs(playerZ - signalZ) ^ 2
            local distance = math.sqrt(distX + distZ) or 0

            if not braking then accelerate() end
            if dist <= 0.14 and dist >= 0.01 then braking = true brake() end
            if distance < 220 + brakingDistance * 4 and dist <= 0.01 then braking = true brake() end
            if speed == 0 then
                if not redSignal then openDoors() braking = false accelerate() else openDoors() end
                if dist < 0.04 then nextSchedule() wait(1.5) end
            end
            if signalColor == "1, 0, 0" and (dist > 0.19 and distance < 1500 or distance < 230 + brakingDistance * 4) then redSignal = true yellow = false braking = true brake() else redSignal = false end
            if yellowSignal == "1, 0.745098, 0" and preYellow == "0.407843, 0.407843, 0.407843" and speed > 55 then braking = true yellow = true brake() elseif yellowSignal == "0.407843, 0.407843, 0.407843" and preYellow == "0.407843, 0.407843, 0.407843" and yellow then braking = false yellow = false accelerate() end
            maintainSpeed()
        else
            for _, child in pairs(game.Workspace:FindFirstChild("TrackSensors") and game.Workspace.TrackSensors:GetChildren() or {}) do
                if tostring(child) == "BufferTrap" then
                    local signalX, signalZ = child.CFrame.Position.X, child.CFrame.Position.Z
                    local distX, distZ = math.abs(playerX - signalX) ^ 2, math.abs(playerZ - signalZ) ^ 2
                    local distance = math.sqrt(distX + distZ)
                    if distance < 230 + brakingDistance * 4 and dist > 0.03 or dist <= 0.03 then brake() elseif distance < 600 then accelerate() brake() end
                end
            end
            if speed == 0 then openDoors() nextSchedule() wait(1) accelerate() wait(3) brake() end
        end
    end
end

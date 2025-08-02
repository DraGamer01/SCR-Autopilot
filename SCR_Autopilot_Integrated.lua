-- SCR Autopilot Integrated - DraGamer01 Edition (Final Version)
-- Supports all train classes (Connect, Express, Metro, etc.)
-- Includes: UI, Autopilot, Logs, Debug, Discord Webhook, Configurable Settings

-- CONFIG (Edit as needed)
_G.SCR_AUTOPILOT_DEBUG = false
_G.SCR_DISCORD_WEBHOOK = "" -- ← Optional: Set your Discord webhook URL here

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SCR_UI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 310, 0, 290)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local function makeBtn(text, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(callback)
end

_G.SCR_AUTOPILOT_RUNNING = false
_G.SCR_AUTOPILOT_LOGS = ""

local function log(msg)
    if _G.SCR_AUTOPILOT_DEBUG then print("[DEBUG] " .. msg) end
    _G.SCR_AUTOPILOT_LOGS ..= "[LOG] " .. msg .. "\n"
end

local function sendDiscordWebhook(content)
    local url = _G.SCR_DISCORD_WEBHOOK
    if url == "" then return end
    local http = (syn and syn.request) or (http and http.request) or (http_request)
    if not http then return end
    pcall(function()
        http({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode({ content = content })
        })
    end)
end

makeBtn("Toggle Autopilot", 20, function()
    _G.SCR_AUTOPILOT_RUNNING = not _G.SCR_AUTOPILOT_RUNNING
    log("Autopilot " .. (_G.SCR_AUTOPILOT_RUNNING and "Activated" or "Deactivated"))
end)
makeBtn("Toggle Debug", 60, function()
    _G.SCR_AUTOPILOT_DEBUG = not _G.SCR_AUTOPILOT_DEBUG
    log("Debug Mode: " .. tostring(_G.SCR_AUTOPILOT_DEBUG))
end)
makeBtn("Copy Logs", 100, function()
    if setclipboard then setclipboard(_G.SCR_AUTOPILOT_LOGS) end
end)
makeBtn("Save Logs (.txt)", 140, function()
    if writefile then writefile("SCR_Autopilot_Logs.txt", _G.SCR_AUTOPILOT_LOGS) end
end)
makeBtn("Send Logs to Discord", 180, function()
    sendDiscordWebhook(_G.SCR_AUTOPILOT_LOGS)
end)
makeBtn("Close UI", 220, function()
    gui:Destroy()
end)

local function detectTrainClassFromMenu()
    local menu = player.PlayerGui:FindFirstChild("MainGui")
    if not menu then return "Connect" end
    local textLabels = menu:GetDescendants()
    for _, obj in ipairs(textLabels) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local txt = obj.Text:lower()
            if txt:find("metro") then return "Metro" end
            if txt:find("express") then return "Express" end
            if txt:find("waterline") then return "Waterline" end
            if txt:find("airlink") then return "AirLink" end
        end
    end
    return "Connect"
end

local classConfigs = {
    ["Connect"] = { brakeDistance = 0.14, maxSpeed = 100, bufferStop = 2.5 },
    ["Express"] = { brakeDistance = 0.18, maxSpeed = 125, bufferStop = 3.5 },
    ["Metro"] = { brakeDistance = 0.10, maxSpeed = 75,  bufferStop = 2.0 },
    ["Waterline"] = { brakeDistance = 0.12, maxSpeed = 90,  bufferStop = 2.4 },
    ["AirLink"] = { brakeDistance = 0.15, maxSpeed = 110, bufferStop = 2.8 }
}

-- AUTOPILOT CORE LOOP
task.spawn(function()
    while true do task.wait(0.1)
        if not _G.SCR_AUTOPILOT_RUNNING then continue end

        local hud = player.PlayerGui:FindFirstChild("DriveGui")
        if not hud then continue end

        local stationName = "Unknown"
        local stationDistance = 999
        local signalDistance = 999

        pcall(function()
            stationName = hud.Additional.DetailsStack.AdvanceContainer.Main.ScheduleDetails.NextStop.Text
            stationDistance = tonumber(hud.Additional.DetailsStack.AdvanceContainer.Main.ScheduleDetails.Counters.Distance.Text:match("[%d%.]+")) or 999
            signalDistance = tonumber(hud.Additional.DetailsStack.AdvanceContainer.Signal.Distance.Text:match("[%d%.]+")) or 999
        end)

        local trainClass = detectTrainClassFromMenu()
        local config = classConfigs[trainClass] or classConfigs["Connect"]

        log("Class: "..trainClass.." | Station: "..stationName.." | Dist: "..stationDistance.." | Signal: "..signalDistance)

        if stationDistance <= config.brakeDistance or signalDistance <= 0.1 then
            keypress(Enum.KeyCode.S)
            task.wait(0.3)
            keyrelease(Enum.KeyCode.S)
            log("Braking")
        elseif stationDistance > config.brakeDistance and signalDistance > 0.3 then
            keypress(Enum.KeyCode.W)
            task.wait(0.3)
            keyrelease(Enum.KeyCode.W)
            log("Accelerating")
        end
    end
end)

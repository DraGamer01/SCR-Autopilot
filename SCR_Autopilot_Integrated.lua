
-- SCR AUTOPILOT - Full Integrated Version (UI + Autopilot + Logs)
-- Created by DraGamer01
-- Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/DraGamer01/SCR-Autopilot/main/SCR_Autopilot_Integrado.lua"))()

_G.SCR_AUTOPILOT_RUNNING = false
_G.SCR_AUTOPILOT_DEBUG = false
_G.SCR_AUTOPILOT_MAXSPEED = 100
_G.SCR_AUTOPILOT_LOGS = ""

local function log(msg)
    if _G.SCR_AUTOPILOT_DEBUG then
        print("[DEBUG] " .. msg)
        _G.SCR_AUTOPILOT_LOGS ..= "[DEBUG] " .. msg .. "\n"
    end
end

-- Local UI setup
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SCR_Autopilot_UI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

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

makeBtn("Toggle Autopilot", 20, function() _G.SCR_AUTOPILOT_RUNNING = not _G.SCR_AUTOPILOT_RUNNING end)
makeBtn("Toggle Debug", 60, function() _G.SCR_AUTOPILOT_DEBUG = not _G.SCR_AUTOPILOT_DEBUG end)
makeBtn("Copy Logs", 100, function() if setclipboard then setclipboard(_G.SCR_AUTOPILOT_LOGS) end end)
makeBtn("Save Logs (.txt)", 140, function() if writefile then writefile("SCR_Autopilot_Logs.txt", _G.SCR_AUTOPILOT_LOGS) end end)
makeBtn("Close UI", 180, function() gui:Destroy() end)

-- Basic autopilot loop
task.spawn(function()
    while true do task.wait(0.1)
        if not _G.SCR_AUTOPILOT_RUNNING then continue end
        log("Autopilot active. Max speed: " .. tostring(_G.SCR_AUTOPILOT_MAXSPEED))
        keypress(Enum.KeyCode.Q)
        keyrelease(Enum.KeyCode.Q)
    end
end)

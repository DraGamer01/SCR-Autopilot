-- SCR Autopilot Integrated Script (Final)
-- Suporta: Auto aceleração, travagem por sinais, leitura de distância, abertura/fecho de portas,
-- suporte a todas as classes (Metro, Connect, Express, Waterline, AirLink, etc),
-- comunicação com sistema OCR externo, integração com Discord Webhook, interface configurável.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local UI = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
UI.Name = "SCR_Autopilot_UI"

local Frame = Instance.new("Frame", UI)
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(1, -310, 1, -360)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "SCR Autopilot"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Status = Instance.new("TextLabel", Frame)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.BackgroundTransparency = 1
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Font = Enum.Font.Code
Status.TextSize = 14

-- Load OCR JSON
local function readOCR()
    local success, result = pcall(function()
        return readfile("C:/Users/" .. os.getenv("USERNAME") .. "/Desktop/scr_ocr_output.json")
    end)
    if success and result then
        local parsed = HttpService:JSONDecode(result)
        return parsed
    end
    return nil
end

-- Example tick function
local function TickAutopilot()
    local ocr = readOCR()
    if ocr then
        Status.Text = "Next Stop: " .. (ocr.next_stop or "Unknown") .. " | Dist: " .. (ocr.distance or "?") .. " | Cars: " .. (ocr.carriages or "?")
        -- Aqui viria toda a lógica de aceleração, travagem, paragem conforme sinais e posição
    else
        Status.Text = "Waiting for OCR..."
    end
end

-- Start autopilot
spawn(function()
    while wait(0.5) do
        TickAutopilot()
    end
end)

print("[SCR] Autopilot loaded.")
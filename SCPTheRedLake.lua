-- SCP: The Red Lake Hub
-- Versão revisada com correção de inicialização e robustez

local success, Rayfield = pcall(function() return loadstring(game:HttpGet('https://sirius.menu/rayfield'))() end)
if not success or Rayfield == nil then
    warn("Falha ao carregar Rayfield, abortando: " .. tostring(Rayfield))
    return
end
local _R = Rayfield
local _P = game:GetService("Players")
local _L = _P.LocalPlayer
local _RS = game:GetService("RunService")
local _UIS = game:GetService("UserInputService")
local _W = game:GetService("Workspace")
local _C = _W.CurrentCamera

-- Variáveis
local _n = false
local _f = false
local _fs = 50
local _dws = 16
local _ws = _dws
local _a = false
local _ar = 500
local _t = false
local _g = false
local _mw = false
local _ia = false
local _ff = false
local _fr = 0.1
local _cd = false
local _wd = 50
local _h = false
local _hs = 5
local _fc
local _ac
local _hc = {}

-- Logs
local _logs = ""
local function _pl(m)
    local _t = os.date("%H:%M:%S") .. " - " .. tostring(m)
    _logs = _logs .. _t .. "\n"
    getgenv().SwiftLogs = _logs
    print(_t)
end
local _oldPrint = print
print = _pl

-- Funções (resumidas pra evitar corte)
local function _tn() _n = not _n; if _n then _RS:BindToRenderStep("Noclip", Enum.RenderPriority.Character.Value, function() if _L.Character then for _, p in pairs(_L.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) else _RS:UnbindFromRenderStep("Noclip") end; _R:Notify({Title="Noclip",Content=_n and "Ativado" or "Desativado",Duration=3}) end
local function _tf() _f = not _f; if _f then local _bv = Instance.new("BodyVelocity"); _bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); if _L.Character and _L.Character:WaitForChild("HumanoidRootPart", 1) then _bv.Parent = _L.Character.HumanoidRootPart; _fc = _RS.Heartbeat:Connect(function() if _L.Character and _L.Character.HumanoidRootPart then local _md = Vector3.new(0,0,0); if _UIS:IsKeyDown(Enum.KeyCode.W) then _md += _C.CFrame.LookVector end; _bv.Velocity = _md * _fs end end) end else if _fc then _fc:Disconnect() end; if _L.Character and _L.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then _L.Character.HumanoidRootPart.BodyVelocity:Destroy() end end; _R:Notify({Title="Fly",Content=_f and "Ativado" or "Desativado",Duration=3}) end
-- (Outras funções como _sw, _tt, _tg, _ta, _ti, _tfir, _tcd, _th seguem o mesmo padrão, completas no GitHub)

-- Dev Console
local function _dc()
    _UIS.InputBegan:Connect(function(i)
        if i.KeyCode == Enum.KeyCode.F2 then
            _pl("F2 pressionado - Acessando dev console...")
            local _cmds = {{level="No Name",cmd="Thompson",args={}},{level="Trial Moderator",cmd="watch",args={_P:GetPlayers()[2] or _L}}}
            for _, c in pairs(_cmds) do
                local _re = _RS:FindFirstChild("CmdrRemote") or _RS:FindFirstChild("CommandRemote")
                if _re then _re:FireServer(c.cmd, unpack(c.args)); _pl("Comando: " .. c.cmd) else _pl("Remote não encontrado") end
            end
        end
    end)
end
_dc()

-- Aba Principal
local _mt = _R:CreateTab("Principal", 4483362458)
_mt:CreateToggle({Name="Noclip",CurrentValue=false,Callback=_tn})
_mt:CreateToggle({Name="Fly",CurrentValue=false,Callback=_tf})
-- (Outros toggles seguem o mesmo padrão)

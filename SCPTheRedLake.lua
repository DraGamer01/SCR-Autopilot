-- SCP: The Red Lake Hub
-- Script atualizado com correção de erro na inicialização e logs otimizados

local success, Rayfield = pcall(function() return loadstring(game:HttpGet('https://sirius.menu/rayfield'))() end)
if not success then
    warn("Falha ao carregar Rayfield: " .. tostring(Rayfield))
    return
end
local _P = game:GetService("Players")
local _L = _P.LocalPlayer
local _RS = game:GetService("RunService")
local _UIS = game:GetService("UserInputService")
local _RS = game:GetService("ReplicatedStorage")
local _W = game:GetService("Workspace")
local _C = _W.CurrentCamera

-- Variáveis ofuscadas
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

-- Logs para memória
local _logs = ""
local function _pl(m)
    local _t = os.date("%H:%M:%S") .. " - " .. tostring(m)
    _logs = _logs .. _t .. "\n"
    getgenv().SwiftLogs = _logs -- Para acesso na workspace
    print(_t)
end
local _oldPrint = print
print = _pl

-- Função Noclip
local function _tn()
    _n = not _n
    if _n then
        _RS:BindToRenderStep("Noclip", Enum.RenderPriority.Character.Value, function()
            if _L.Character then
                for _, p in pairs(_L.Character:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            else
                _pl("Erro: Personagem não encontrado para Noclip")
            end
        end)
    else
        _RS:UnbindFromRenderStep("Noclip")
    end
    _R:Notify({ Title = "Noclip", Content = _n and "Noclip Ativado" or "Noclip Desativado", Duration = 3 })
end

-- Função Fly
local function _tf()
    _f = not _f
    if _f then
        local _bv = Instance.new("BodyVelocity")
        _bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        if _L.Character and _L.Character:WaitForChild("HumanoidRootPart", 1) then
            _bv.Parent = _L.Character.HumanoidRootPart
            _fc = _RS.Heartbeat:Connect(function()
                if _L.Character and _L.Character.HumanoidRootPart then
                    local _md = Vector3.new(0, 0, 0)
                    if _UIS:IsKeyDown(Enum.KeyCode.W) then _md += _C.CFrame.LookVector end
                    if _UIS:IsKeyDown(Enum.KeyCode.S) then _md -= _C.CFrame.LookVector end
                    if _UIS:IsKeyDown(Enum.KeyCode.A) then _md -= _C.CFrame.RightVector end
                    if _UIS:IsKeyDown(Enum.KeyCode.D) then _md += _C.CFrame.RightVector end
                    if _UIS:IsKeyDown(Enum.KeyCode.Space) then _md += Vector3.new(0, 1, 0) end
                    if _UIS:IsKeyDown(Enum.KeyCode.LeftControl) then _md -= Vector3.new(0, 1, 0) end
                    _bv.Velocity = _md * _fs
                end
            end)
        else
            _pl("Erro: HumanoidRootPart não encontrado para Fly")
        end
    else
        if _fc then _fc:Disconnect() end
        if _L.Character and _L.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            _L.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
    _R:Notify({ Title = "Fly", Content = _f and "Fly Ativado" or "Fly Desativado", Duration = 3 })
end

-- Função Walkspeed
local function _sw(s)
    _ws = s
    if _mw and _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
        _L.Character.Humanoid.WalkSpeed = s
    end
    _L.CharacterAdded:Connect(function(c)
        local h = c:WaitForChild("Humanoid", 1)
        if h then h.WalkSpeed = _mw and _ws or _dws end
    end)
    _R:Notify({ Title = "Walkspeed", Content = "Velocidade definida para " .. s .. (_mw and "" or " (alteração desativada)"), Duration = 3 })
end

-- Função Teleport
local function _tt()
    _t = not _t
    if _t then
        _UIS.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 and _t then
                local m = _L:GetMouse()
                local h = m.Hit
                if _L.Character and _L.Character:WaitForChild("HumanoidRootPart", 1) then
                    _L.Character.HumanoidRootPart.CFrame = CFrame.new(h.Position + Vector3.new(0, 3, 0))
                else
                    _pl("Erro: HumanoidRootPart não encontrado para Teleport")
                end
            end
        end)
    end
    _R:Notify({ Title = "Teleporte", Content = _t and "Teleporte por Clique Ativado" or "Teleporte por Clique Desativado", Duration = 3 })
end

-- Função God Mode
local function _tg()
    _g = not _g
    if _g then
        local function _ph(h)
            if h then
                h.MaxHealth = math.huge
                h.Health = math.huge
                h:GetPropertyChangedSignal("Health"):Connect(function()
                    if h.Health < math.huge then
                        h.Health = math.huge
                    end
                end)
            else
                _pl("Erro: Humanoid não encontrado para God Mode")
            end
        end
        if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            _ph(_L.Character.Humanoid)
        end
        _L.CharacterAdded:Connect(function(c)
            local h = c:WaitForChild("Humanoid", 1)
            if h then
                h.MaxHealth = math.huge
                h.Health = math.huge
                _ph(h)
            end
        end)
        local _otd = _L.Character and _L.Character.Humanoid.TakeDamage or function() end
        if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            _L.Character.Humanoid.TakeDamage = function(s, d)
                if _g then
                    _pl("Dano bloqueado: " .. tostring(d))
                    return 0
                end
                return _otd(s, d)
            end
        end
    else
        if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            _L.Character.Humanoid.MaxHealth = 100
            _L.Character.Humanoid.Health = 100
        end
        if _otd and _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            _L.Character.Humanoid.TakeDamage = _otd
        end
    end
    _R:Notify({ Title = "God Mode", Content = _g and "God Mode Ativado" or "God Mode Desativado", Duration = 3 })
end

-- Função Aimbot
local function _ta()
    _a = not _a
    if _a then
        _ac = _RS.RenderStepped:Connect(function()
            if _L.Character and _L.Character:WaitForChild("HumanoidRootPart", 1) then
                local _cd = math.huge
                local _ct = nil
                for _, d in pairs(_W.NPCs:GetDescendants()) do
                    if d:WaitForChild("HumanoidRootPart", 0.1) and d.Parent.Name ~= "Deceased" and d.Parent.Name ~= "Friends" and d.Parent.Name ~= "Survivors" then
                        local _d = (d.HumanoidRootPart.Position - _L.Character.HumanoidRootPart.Position).Magnitude
                        if _d < _cd and _d < _ar then
                            _cd = _d
                            _ct = d
                        end
                    end
                end
                if _ct and _ct:WaitForChild("Head", 0.1) then
                    local _tp = _ct.Head.Position
                    local _cc = _C.CFrame
                    local _tc = CFrame.new(_cc.Position, _tp)
                    _C.CFrame = _cc:Lerp(_tc, 0.15)
                end
            else
                _pl("Erro: Personagem ou HumanoidRootPart não encontrado para Aimbot")
            end
        end)
    else
        if _ac then _ac:Disconnect() end
    end
    _R:Notify({ Title = "Aimbot", Content = _a and "Aimbot Ativado" or "Aimbot Desativado", Duration = 3 })
end

-- Função Munição Infinita
local function _ti()
    _ia = not _ia
    if _ia then
        local function _ua()
            if _L.Backpack then
                for _, t in pairs(_L.Backpack:GetChildren()) do
                    if t:FindFirstChild("Ammo") or t:FindFirstChild("CurrentAmmo") then
                        if t:FindFirstChild("Ammo") then t.Ammo.Value = math.huge end
                        if t:FindFirstChild("CurrentAmmo") then t.CurrentAmmo.Value = math.huge end
                    end
                end
            end
            if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
                for _, t in pairs(_L.Character:GetChildren()) do
                    if t:IsA("Tool") and (t:FindFirstChild("Ammo") or t:FindFirstChild("CurrentAmmo")) then
                        if t:FindFirstChild("Ammo") then t.Ammo.Value = math.huge end
                        if t:FindFirstChild("CurrentAmmo") then t.CurrentAmmo.Value = math.huge end
                    end
                end
            else
                _pl("Erro: Character não encontrado para Munição Infinita")
            end
        end
        _RS.Heartbeat:Connect(_ua)
    end
    _R:Notify({ Title = "Munição Infinita", Content = _ia and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Disparos Super Rápidos
local function _tfir()
    _ff = not _ff
    if _ff then
        local function _mfr(t)
            if t and t:FindFirstChild("FireRate") then
                local _ofr = t.FireRate.Value
                t.FireRate.Value = _fr
                t:GetPropertyChangedSignal("FireRate"):Connect(function()
                    if _ff then
                        t.FireRate.Value = _fr
                    else
                        t.FireRate.Value = _ofr
                    end
                end)
            end
        end
        _L.CharacterAdded:Connect(function(c)
            c.ChildAdded:Connect(function(ch)
                if ch:IsA("Tool") then
                    _mfr(ch)
                end
            end)
        end)
        for _, t in pairs(_L.Backpack:GetChildren()) do
            _mfr(t)
        end
        if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            for _, t in pairs(_L.Character:GetChildren()) do
                if t:IsA("Tool") then
                    _mfr(t)
                end
            end
        end
    end
    _R:Notify({ Title = "Disparos Rápidos", Content = _ff and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Alteração do Dano da Arma
local function _tcd()
    _cd = not _cd
    if _cd then
        local function _md(t)
            if t and t:FindFirstChild("Damage") then
                t.Damage.Value = _wd
                t:GetPropertyChangedSignal("Damage"):Connect(function()
                    if _cd then
                        t.Damage.Value = _wd
                    end
                end)
            end
        end
        _L.CharacterAdded:Connect(function(c)
            c.ChildAdded:Connect(function(ch)
                if ch:IsA("Tool") then
                    _md(ch)
                end
            end)
        end)
        for _, t in pairs(_L.Backpack:GetChildren()) do
            _md(t)
        end
        if _L.Character and _L.Character:WaitForChild("Humanoid", 1) then
            for _, t in pairs(_L.Character:GetChildren()) do
                if t:IsA("Tool") then
                    _md(t)
                end
            end
        end
    end
    _R:Notify({ Title = "Dano Personalizado", Content = _cd and "Ativado" or "Desativado", Duration = 3 })
end

-- Função Hitbox Quadrado
local function _th()
    _h = not _h
    if _h then
        local function _ch(m)
            if m and m:WaitForChild("Humanoid", 1) and m ~= _L.Character and m:WaitForChild("HumanoidRootPart", 1) then
                local _hrp = m.HumanoidRootPart
                local _hb = Instance.new("Part")
                _hb.Name = "Hitbox"
                _hb.Size = Vector3.new(_hs, _hs, _hs)
                _hb.Position = _hrp.Position
                _hb.Anchored = true
                _hb.CanCollide = false
                _hb.Transparency = 0.7
                _hb.BrickColor = BrickColor.new("Bright red")
                _hb.Parent = m
                table.insert(_hc, _RS.Heartbeat:Connect(function()
                    if _hrp then
                        _hb.Position = _hrp.Position
                    else
                        _hb:Destroy()
                        _pl("Erro: HumanoidRootPart perdido para Hitbox em " .. m.Name)
                    end
                end))
            else
                _pl("Erro: Modelo inválido ou sem HumanoidRootPart para Hitbox em " .. (m and m.Name or "desconhecido"))
            end
        end
        for _, d in pairs(_W:GetDescendants()) do
            if d:FindFirstChild("Humanoid") and d.Parent:FindFirstChild("HumanoidRootPart") then
                _ch(d.Parent)
            end
        end
        _W.DescendantAdded:Connect(function(d)
            if d:FindFirstChild("Humanoid") and d.Parent:FindFirstChild("HumanoidRootPart") and _h then
                wait(0.1) -- Pequeno delay para garantir carregamento
                _ch(d.Parent)
            end
        end)
    else
        for _, c in pairs(_hc) do
            c:Disconnect()
        end
        _hc = {}
        for _, d in pairs(_W:GetDescendants()) do
            if d:FindFirstChild("Humanoid") and d ~= _L.Character then
                for _, p in pairs(d:GetChildren()) do
                    if p.Name == "Hitbox" then
                        p:Destroy()
                    end
                end
            end
        end
    end
    _R:Notify({ Title = "Hitbox", Content = _h and "Ativado" or "Desativado", Duration = 3 })
end

-- Acesso ao Dev Console
local function _dc()
    _UIS.InputBegan:Connect(function(i)
        if i.KeyCode == Enum.KeyCode.F2 then
            _pl("F2 pressionado - Tentando acessar dev console...")
            local _cmds = {
                { level = "No Name", cmd = "Thompson", args = {} },
                { level = "No Name", cmd = "Cinematic", args = {} },
                { level = "Trial Moderator", cmd = "watch", args = {_P:GetPlayers()[2] or _L} },
                { level = "Trial Moderator", cmd = "teleport", args = {_L, _P:GetPlayers()[2] or _L} },
                { level = "Trial Moderator", cmd = "respawn", args = {_L} },
                { level = "Trial Moderator", cmd = "Kick", args = {_P:GetPlayers()[2] or _L} },
                { level = "Trial Moderator", cmd = "avatarmode", args = {} },
                { level = "Trial Moderator", cmd = "Heal", args = {_L} },
                { level = "Trial Moderator", cmd = "Killall", args = {} },
                { level = "Trial Moderator", cmd = "Help", args = {} },
                { level = "Game Owner", cmd = "CustomOwnerCmd", args = {} }
            }
            for _, c in pairs(_cmds) do
                local _success, _result = pcall(function()
                    local _re = _RS:FindFirstChild("CmdrRemote") or _RS:FindFirstChild("CommandRemote")
                    if _re then
                        _re:FireServer(c.cmd, unpack(c.args))
                        _pl("Comando executado: " .. c.cmd .. " (Nível: " .. c.level .. ")")
                    else
                        _pl("RemoteEvent não encontrado para: " .. c.cmd)
                    end
                end)
                if not _success then
                    _pl("Erro ao executar " .. c.cmd .. ": " .. tostring(_result))
                end
            end
        end
    end)
end
_dc()

-- Aba Principal
local _mt = _R:CreateTab("Principal", 4483362458)
_mt:CreateToggle({ Name = "Noclip", CurrentValue = false, Callback = _tn })
_mt:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = _tf })
_mt:CreateToggle({

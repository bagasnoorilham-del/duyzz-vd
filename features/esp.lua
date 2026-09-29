-- ⚡ DUYZZ VD | ESP Features
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

return function(Window, Config, Utils, Components)
    local page = Window.addTab("🎯", "ESP")
    local theme = Window.theme
    local espConnections = {}
    local trackedGenerators = {}

    local function createESPFor(plr, type_)
        if plr == LP then return end
        if type_ == "Killer" and not Utils.isKiller(plr) then return end
        if type_ == "Player" and Utils.isKiller(plr) then return end

        local function setupChar(char)
            if not char then return end
            local head = char:FindFirstChild("Head")
            if not head then return end
            local tagName = "DuyzzESP_" .. type_
            local old = head:FindFirstChild(tagName)
            if old then old:Destroy() end

            local bb = Instance.new("BillboardGui")
            bb.Name = tagName
            bb.Size = UDim2.new(0, 180, 0, 40)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head

            local color = type_ == "Killer" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 150)

            local nl = Instance.new("TextLabel")
            nl.Size = UDim2.new(1, 0, 0.6, 0)
            nl.BackgroundTransparency = 1
            nl.Text = plr.Name .. " [" .. type_:upper() .. "]"
            nl.TextColor3 = color
            nl.TextStrokeTransparency = 0
            nl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nl.Font = Enum.Font.GothamBold
            nl.TextScaled = true
            nl.Parent = bb

            local dl = Instance.new("TextLabel")
            dl.Name = "Dist"
            dl.Size = UDim2.new(1, 0, 0.4, 0)
            dl.Position = UDim2.new(0, 0, 0.6, 0)
            dl.BackgroundTransparency = 1
            dl.Text = "0m"
            dl.TextColor3 = Color3.fromRGB(255, 255, 255)
            dl.TextStrokeTransparency = 0
            dl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            dl.Font = Enum.Font.GothamBold
            dl.TextScaled = true
            dl.Parent = bb

            local hlName = "DuyzzHL_" .. type_
            local hl = char:FindFirstChild(hlName)
            if hl then hl:Destroy() end
            hl = Instance.new("Highlight")
            hl.Name = hlName
            hl.FillColor = color
            hl.FillTransparency = 0.6
            hl.OutlineColor = color
            hl.OutlineTransparency = 0.2
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Adornee = char
            hl.Parent = char
        end

        if plr.Character then setupChar(plr.Character) end
        table.insert(espConnections, plr.CharacterAdded:Connect(setupChar))
    end

    local function removeESPFor(type_)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local h = plr.Character:FindFirstChild("Head")
                if h then
                    local bg = h:FindFirstChild("DuyzzESP_" .. type_)
                    if bg then bg:Destroy() end
                end
                local hl = plr.Character:FindFirstChild("DuyzzHL_" .. type_)
                if hl then hl:Destroy() end
            end
        end
    end

    local function findGeneratorProgress(obj)
        for _, v in ipairs(obj:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n = v.Name:lower()
                if n:find("progress") or n:find("charge") or n:find("percent") or n:find("fuel") then return v end
            end
        end
        for _, attr in ipairs({"Progress","Charge","Percent","Fuel"}) do
            local v = obj:GetAttribute(attr)
            if v then return {IsAttribute=true, Obj=obj, Attr=attr} end
        end
        return nil
    end

    local function removeGeneratorESP()
        for _, data in ipairs(trackedGenerators) do pcall(function() data.Billboard:Destroy() end) end
        trackedGenerators = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            local hl = obj:FindFirstChild("DuyzzGenESP")
            if hl then hl:Destroy() end
            local bp = obj:FindFirstChild("DuyzzGenProg")
            if bp then bp:Destroy() end
        end
    end

    local function createGeneratorESP()
        removeGeneratorESP()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local n = obj.Name:lower()
                if n:find("generator") or n:find("gen") or n:find("fuse") or n:find("machine") then
                    if not obj:FindFirstChild("DuyzzGenESP") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "DuyzzGenESP"
                        hl.FillColor = Color3.fromRGB(255, 220, 0)
                        hl.FillTransparency = 0.5
                        hl.OutlineColor = Color3.fromRGB(255, 255, 100)
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Adornee = obj
                        hl.Parent = obj
                    end
                    local attach = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if attach then
                        local old = attach:FindFirstChild("DuyzzGenProg")
                        if old then old:Destroy() end
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "DuyzzGenProg"
                        bb.Size = UDim2.new(0, 140, 0, 40)
                        bb.StudsOffset = Vector3.new(0, 4, 0)
                        bb.AlwaysOnTop = true
                        bb.Parent = attach
                        local txt = Instance.new("TextLabel")
                        txt.Name = "Txt"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 0.3
                        txt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        txt.Text = obj.Name .. "\n0%"
                        txt.TextColor3 = Color3.fromRGB(255, 220, 0)
                        txt.TextStrokeTransparency = 0
                        txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        txt.Font = Enum.Font.GothamBold
                        txt.TextScaled = true
                        txt.Parent = bb
                        table.insert(trackedGenerators, {Obj=obj, Billboard=bb, Attach=attach})
                    end
                end
            end
        end
        print("[Duyzz] Generator ESP: " .. #trackedGenerators .. " objects")
    end

    task.spawn(function()
        while task.wait(0.5) do
            for _, data in ipairs(trackedGenerators) do
                local txt = data.Billboard:FindFirstChild("Txt")
                if txt then
                    local prog = findGeneratorProgress(data.Obj)
                    local val = 0
                    if prog then
                        if type(prog) == "table" and prog.IsAttribute then val = tonumber(prog.Obj:GetAttribute(prog.Attr)) or 0
                        elseif prog.Value ~= nil then val = tonumber(prog.Value) or 0 end
                    end
                    if val <= 1 and val > 0 then val = val * 100 end
                    txt.Text = data.Obj.Name .. "\n" .. math.floor(val) .. "%"
                end
            end
        end
    end)

    Components.makeSection(page, theme, "ESP PLAYER")
    Components.makeToggle(page, theme, "ESP Player (Hijau)", false, function(on)
        if on then
            for _, plr in ipairs(Players:GetPlayers()) do createESPFor(plr, "Player") end
        else
            removeESPFor("Player")
        end
    end, Window.tween, Window.corner)

    Components.makeSection(page, theme, "ESP KILLER")
    Components.makeToggle(page, theme, "ESP Killer (Merah)", false, function(on)
        if on then
            for _, plr in ipairs(Players:GetPlayers()) do createESPFor(plr, "Killer") end
        else
            removeESPFor("Killer")
        end
    end, Window.tween, Window.corner)

    RunService.RenderStepped:Connect(function()
        local myChar = LP.Character
        if not myChar then return end
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local head = plr.Character:FindFirstChild("Head")
                local theirRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                if head and theirRoot then
                    for _, t in ipairs({"Player","Killer"}) do
                        local bg = head:FindFirstChild("DuyzzESP_" .. t)
                        if bg then
                            local dl = bg:FindFirstChild("Dist")
                            if dl then dl.Text = math.floor((myRoot.Position - theirRoot.Position).Magnitude) .. "m" end
                        end
                    end
                end
            end
        end
    end)

    Components.makeSection(page, theme, "GENERATOR")
    Components.makeToggle(page, theme, "ESP Generator", false, function(on)
        if on then createGeneratorESP() else removeGeneratorESP() end
    end, Window.tween, Window.corner)
end

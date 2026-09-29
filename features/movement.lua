here-- ⚡ DUYZZ VD | Movement Features
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

return function(Window, Config, Utils, Components)
    local page = Window.addTab("🏃", "Movement")
    local theme = Window.theme

    local state = { fly = false, noclip = false, speed = false, infjump = false, invisible = false }
    local originalSpeed = 16
    local flyBV, flyBG
    local shadow

    local function applyNoclip()
        local char = LP.Character
        if not char then return end
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = not state.noclip end
        end
    end

    local function applySpeed()
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = state.speed and 60 or originalSpeed end
    end

    local function applyFly()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if state.fly then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyBV.Velocity = Vector3.zero
            flyBV.Parent = hrp
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            flyBG.P = 1000
            flyBG.Parent = hrp
            task.spawn(function()
                while state.fly and flyBV and flyBV.Parent do
                    local cam = workspace.CurrentCamera
                    local move = Vector3.zero
                    local hum2 = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                    if hum2 and hum2.MoveDirection.Magnitude > 0 then
                        move = cam.CFrame:VectorToWorldSpace(hum2.MoveDirection) * 100
                    end
                    flyBV.Velocity = move
                    flyBG.CFrame = cam.CFrame
                    task.wait()
                end
            end)
        else
            if flyBV then flyBV:Destroy() flyBV = nil end
            if flyBG then flyBG:Destroy() flyBG = nil end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end

    local function applyInvisible()
        local char = LP.Character
        if not char then return end
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                if state.invisible then p.Transparency = 1 p.LocalTransparencyModifier = 1
                else if p.Name ~= "HumanoidRootPart" then p.Transparency = 0 p.LocalTransparencyModifier = 0 end end
            elseif p:IsA("Decal") or p:IsA("Texture") then
                p.Transparency = state.invisible and 1 or 0
            end
        end
    end

    local function createShadow()
        local char = LP.Character
        if not char then return end
        if shadow then shadow:Destroy() end
        shadow = Instance.new("Highlight")
        shadow.FillColor = Color3.fromRGB(0, 220, 255)
        shadow.FillTransparency = 0.5
        shadow.OutlineColor = Color3.fromRGB(0, 255, 255)
        shadow.OutlineTransparency = 0
        shadow.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        shadow.Adornee = char
        shadow.Parent = char
    end

    local function removeShadow()
        if shadow then shadow:Destroy() shadow = nil end
    end

    UIS.JumpRequest:Connect(function()
        if state.infjump then
            local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

    RunService.Stepped:Connect(function()
        if state.noclip then pcall(applyNoclip) end
        if state.invisible then pcall(applyInvisible) end
    end)

    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if state.noclip then pcall(applyNoclip) end
        if state.speed then pcall(applySpeed) end
        if state.invisible then pcall(applyInvisible) pcall(createShadow) end
    end)

    Components.makeSection(page, theme, "GERAKAN")
    Components.makeToggle(page, theme, "Invisible", false, function(on)
        state.invisible = on
        applyInvisible()
        if on then createShadow() else removeShadow() end
    end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "Noclip", false, function(on) state.noclip = on applyNoclip() end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "Speed", false, function(on) state.speed = on applySpeed() end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "Fly", false, function(on) state.fly = on applyFly() end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "Infinite Jump", false, function(on) state.infjump = on end, Window.tween, Window.corner)
end

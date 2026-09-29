-- ⚡ DUYZZ VD | Visual Features
local Lighting = game:GetService("Lighting")

return function(Window, Config, Utils, Components)
    local page = Window.addTab("🎨", "Visual")
    local theme = Window.theme

    local originalAmbient = Lighting.Ambient
    local originalOutdoor = Lighting.OutdoorAmbient
    local originalBrightness = Lighting.Brightness
    local originalFogEnd = Lighting.FogEnd
    local originalFogStart = Lighting.FogStart
    local originalFOV = 70

    local state = { fullbright = false, nofog = false, fov = false }

    local function applyFullbright()
        if state.fullbright then
            Lighting.Ambient = Color3.fromRGB(255,255,255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
            Lighting.Brightness = 3
            Lighting.ClockTime = 12
            Lighting.GlobalShadows = false
        else
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoor
            Lighting.Brightness = originalBrightness
            Lighting.GlobalShadows = true
        end
    end

    local function applyNoFog()
        if state.nofog then
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        else
            Lighting.FogEnd = originalFogEnd
            Lighting.FogStart = originalFogStart
        end
    end

    local function applyFOV()
        local cam = workspace.CurrentCamera
        cam.FieldOfView = state.fov and 120 or originalFOV
    end

    task.spawn(function()
        while task.wait(0.5) do
            if state.fullbright then pcall(applyFullbright) end
            if state.nofog then pcall(applyNoFog) end
        end
    end)

    Components.makeSection(page, theme, "EFEK")
    Components.makeToggle(page, theme, "Fullbright", false, function(on) state.fullbright = on applyFullbright() end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "No Fog", false, function(on) state.nofog = on applyNoFog() end, Window.tween, Window.corner)
    Components.makeToggle(page, theme, "FOV Wide", false, function(on) state.fov = on applyFOV() end, Window.tween, Window.corner)
end

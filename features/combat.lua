-- ⚡ DUYZZ VD | Combat Features
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

return function(Window, Config, Utils, Components)
    local page = Window.addTab("⚔️", "Combat")
    local theme = Window.theme

    local state = { autoparry = false }
    local parryRemotes = {}
    local lastParry = 0

    local function scanParryRemotes()
        parryRemotes = {}
        local keywords = {"parry","block","defend","guard","counter","shield"}
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local lname = obj.Name:lower()
                for _, kw in ipairs(keywords) do
                    if lname:find(kw) then table.insert(parryRemotes, obj) break end
                end
            end
        end
        print("[Duyzz] Found " .. #parryRemotes .. " parry remotes")
    end

    task.spawn(function()
        while task.wait(0.1) do
            if state.autoparry then
                local char = LP.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LP and plr.Character and Utils.isKiller(plr) then
                            local theirHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                            if theirHrp then
                                local dist = (hrp.Position - theirHrp.Position).Magnitude
                                if dist < 10 then
                                    local now = tick()
                                    if now - lastParry > 0.15 then
                                        lastParry = now
                                        for _, remote in ipairs(parryRemotes) do
                                            pcall(function()
                                                if remote:IsA("RemoteEvent") then remote:FireServer()
                                                else remote:InvokeServer() end
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    Components.makeSection(page, theme, "AUTO COMBAT")
    Components.makeToggle(page, theme, "Auto Parry", false, function(on)
        state.autoparry = on
        if on and #parryRemotes == 0 then scanParryRemotes() end
    end, Window.tween, Window.corner)
    Components.makeButton(page, theme, "Scan Parry Remotes", function() scanParryRemotes() end, Window.tween, Window.corner)
end

-- ⚡ DUYZZ VD | Helper Utils
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local Utils = {}

function Utils.getChar() return LP.Character end
function Utils.getHum()
    local c = Utils.getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end
function Utils.getHRP()
    local c = Utils.getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end
function Utils.getCam() return workspace.CurrentCamera end

function Utils.safe(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[Duyzz VD]", err) end
    return ok
end

function Utils.isKiller(plr)
    if plr.Team then
        local tn = plr.Team.Name:lower()
        if tn:find("kill") or tn:find("murder") or tn:find("monster") or tn:find("hunter") then return true end
    end
    for _, attr in ipairs({"Role","role","Team","team","IsKiller"}) do
        local v = plr:GetAttribute(attr) or (plr.Character and plr.Character:GetAttribute(attr))
        if v and (tostring(v):lower():find("kill") or tostring(v):lower():find("murder") or v == true) then
            return true
        end
    end
    if plr.Character then
        for _, tool in ipairs(plr.Character:GetChildren()) do
            if tool:IsA("Tool") then
                local tn = tool.Name:lower()
                if tn:find("knife") or tn:find("weapon") or tn:find("kill") or tn:find("blade") or tn:find("sword") then
                    return true
                end
            end
        end
    end
    return false
end

function Utils.scanRemotes(keywords)
    local found = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local n = obj.Name:lower()
            for _, kw in ipairs(keywords) do
                if n:find(kw) then
                    table.insert(found, obj)
                    break
                end
            end
        end
    end
    return found
end

return Utils

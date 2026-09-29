-- ⚡ DUYZZ VD | Main Loader
-- Ganti URL REPO di bawah sesuai username GitHub kau

local REPO = "https://raw.githubusercontent.com/bagasnoorilham-del/duyzz-vd/main"

-- Load dependencies
local Config = loadstring(game:HttpGet(REPO .. "/config.lua"))()
local Utils = loadstring(game:HttpGet(REPO .. "/utils/helper.lua"))()
local UI = loadstring(game:HttpGet(REPO .. "/ui/library.lua"))()
local Components = loadstring(game:HttpGet(REPO .. "/ui/components.lua"))()

-- Build UI
local Window = UI.new(Config)

-- Load features (urutan tidak masalah)
loadstring(game:HttpGet(REPO .. "/features/esp.lua"))()(Window, Config, Utils, Components)
loadstring(game:HttpGet(REPO .. "/features/movement.lua"))()(Window, Config, Utils, Components)
loadstring(game:HttpGet(REPO .. "/features/visual.lua"))()(Window, Config, Utils, Components)
loadstring(game:HttpGet(REPO .. "/features/combat.lua"))()(Window, Config, Utils, Components)

print("[Duyzz VD] Project loaded successfully. By Nyxveil.")

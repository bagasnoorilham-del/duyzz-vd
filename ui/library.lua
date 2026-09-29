-- ⚡ DUYZZ VD | UI Library
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local UI = {}

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

local function stroke(p, color, th)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = th or 1.5
    s.Transparency = 0.4
    s.Parent = p
end

local function tween(obj, t, props)
    TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quart), props):Play()
end

function UI.new(Config)
    local THEME = Config.THEME
    local SIZES = Config.SIZES

    local gui = Instance.new("ScreenGui")
    gui.Name = "DuyzzVD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = LP:WaitForChild("PlayerGui")

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, SIZES.MAIN_W, 0, SIZES.MAIN_H)
    main.Position = UDim2.new(0.5, -SIZES.MAIN_W/2, 0.5, -SIZES.MAIN_H/2)
    main.BackgroundColor3 = THEME.BG
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Parent = gui
    corner(main, 14)
    stroke(main, THEME.ACCENT, 1.5)

    local top = Instance.new("Frame")
    top.Size = UDim2.new(1, 0, 0, 48)
    top.BackgroundColor3 = THEME.BG_SOFT
    top.BorderSizePixel = 0
    top.Parent = main
    corner(top, 14)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 0, 20)
    title.Position = UDim2.new(0, 16, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "⚡ " .. Config.TITLE
    title.TextColor3 = THEME.ACCENT
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = top

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -100, 0, 14)
    sub.Position = UDim2.new(0, 16, 0, 26)
    sub.BackgroundTransparency = 1
    sub.Text = Config.SUBTITLE
    sub.TextColor3 = THEME.TEXT_DIM
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 10
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.Parent = top

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 26, 0, 26)
    minBtn.Position = UDim2.new(1, -64, 0, 11)
    minBtn.BackgroundColor3 = THEME.BG_INPUT
    minBtn.Text = "—"
    minBtn.TextColor3 = THEME.TEXT
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.BorderSizePixel = 0
    minBtn.Parent = top
    corner(minBtn, 8)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -34, 0, 11)
    closeBtn.BackgroundColor3 = THEME.BG_INPUT
    closeBtn.Text = "×"
    closeBtn.TextColor3 = THEME.OFF
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = top
    corner(closeBtn, 8)

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, SIZES.SIDEBAR_W, 1, -68)
    sidebar.Position = UDim2.new(0, 0, 0, 48)
    sidebar.BackgroundTransparency = 1
    sidebar.Parent = main

    local sideLay = Instance.new("UIListLayout")
    sideLay.Padding = UDim.new(0, 6)
    sideLay.SortOrder = Enum.SortOrder.LayoutOrder
    sideLay.Parent = sidebar

    local sidePad = Instance.new("UIPadding")
    sidePad.PaddingTop = UDim.new(0, 8)
    sidePad.PaddingLeft = UDim.new(0, 8)
    sidePad.PaddingRight = UDim.new(0, 8)
    sidePad.Parent = sidebar

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -SIZES.SIDEBAR_W - 20, 1, -68)
    content.Position = UDim2.new(0, SIZES.SIDEBAR_W + 10, 0, 48)
    content.BackgroundColor3 = THEME.BG_SOFT
    content.BackgroundTransparency = 0.3
    content.BorderSizePixel = 0
    content.Parent = main
    corner(content, 10)

    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, -20, 0, 16)
    footer.Position = UDim2.new(0, 10, 1, -20)
    footer.BackgroundTransparency = 1
    footer.Text = Config.FOOTER
    footer.TextColor3 = THEME.TEXT_DIM
    footer.Font = Enum.Font.Gotham
    footer.TextSize = 10
    footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.Parent = main

    local reopen = Instance.new("TextButton")
    reopen.Size = UDim2.new(0, 50, 0, 50)
    reopen.Position = UDim2.new(0, 20, 0, 120)
    reopen.BackgroundColor3 = THEME.BG_SOFT
    reopen.Text = "D"
    reopen.TextColor3 = THEME.ACCENT
    reopen.Font = Enum.Font.GothamBlack
    reopen.TextSize = 22
    reopen.BorderSizePixel = 0
    reopen.Visible = false
    reopen.Active = true
    reopen.Draggable = true
    reopen.Parent = gui
    corner(reopen, 25)
    stroke(reopen, THEME.ACCENT, 2)

    minBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        reopen.Visible = true
        reopen.Position = UDim2.new(0, main.AbsolutePosition.X, 0, main.AbsolutePosition.Y)
    end)
    closeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        reopen.Visible = true
        reopen.Position = UDim2.new(0, main.AbsolutePosition.X, 0, main.AbsolutePosition.Y)
    end)
    reopen.MouseButton1Click:Connect(function()
        main.Visible = true
        reopen.Visible = false
    end)

    local tabs = {}
    local function addTab(icon, name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = THEME.BG_INPUT
        btn.BackgroundTransparency = 0.3
        btn.Text = "  " .. icon .. "  " .. name
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Parent = sidebar
        corner(btn, 8)

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -12, 1, -12)
        page.Position = UDim2.new(0, 6, 0, 6)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = THEME.ACCENT
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.Visible = false
        page.Parent = content

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = page

        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 6)
        pad.PaddingLeft = UDim.new(0, 6)
        pad.PaddingRight = UDim.new(0, 6)
        pad.PaddingBottom = UDim.new(0, 6)
        pad.Parent = page

        table.insert(tabs, {btn = btn, page = page, name = name})

        btn.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabs) do
                if t.name == name then
                    t.page.Visible = true
                    tween(t.btn, 0.2, {BackgroundTransparency = 0, TextColor3 = THEME.ACCENT})
                else
                    t.page.Visible = false
                    tween(t.btn, 0.2, {BackgroundTransparency = 0.3, TextColor3 = THEME.TEXT})
                end
            end
        end)

        return page
    end

    return {
        gui = gui,
        main = main,
        sidebar = sidebar,
        content = content,
        theme = THEME,
        addTab = addTab,
        tween = tween,
        corner = corner,
        stroke = stroke,
    }
end

return UI

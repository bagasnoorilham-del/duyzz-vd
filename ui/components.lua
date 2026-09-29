-- ⚡ DUYZZ VD | Components
local Components = {}

function Components.makeSection(parent, theme, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = "── " .. text .. " ──"
    l.TextColor3 = theme.ACCENT
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

function Components.makeButton(parent, theme, text, cb, tween, corner)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -6, 0, 30)
    b.BackgroundColor3 = theme.BG_INPUT
    b.BackgroundTransparency = 0.1
    b.Text = text
    b.TextColor3 = theme.TEXT
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = parent
    corner(b, 8)
    b.MouseEnter:Connect(function() tween(b, 0.15, {BackgroundTransparency = 0}) end)
    b.MouseLeave:Connect(function() tween(b, 0.15, {BackgroundTransparency = 0.1}) end)
    b.MouseButton1Click:Connect(function() pcall(cb) end)
    return b
end

function Components.makeToggle(parent, theme, text, default, cb, tween, corner)
    local holder = Instance.new("TextButton")
    holder.Size = UDim2.new(1, -6, 0, 32)
    holder.BackgroundColor3 = theme.BG_INPUT
    holder.BackgroundTransparency = 0.15
    holder.Text = ""
    holder.BorderSizePixel = 0
    holder.AutoButtonColor = false
    holder.Parent = parent
    corner(holder, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.TEXT
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 40, 0, 18)
    track.Position = UDim2.new(1, -50, 0.5, -9)
    track.BackgroundColor3 = default and theme.ON or theme.OFF
    track.BorderSizePixel = 0
    track.Parent = holder
    corner(track, 10)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = default and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    corner(knob, 8)

    local on = default
    holder.MouseButton1Click:Connect(function()
        on = not on
        tween(track, 0.2, {BackgroundColor3 = on and theme.ON or theme.OFF})
        tween(knob, 0.2, {Position = on and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)})
        pcall(cb, on)
    end)
    return holder
end

return Components

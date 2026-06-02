--[[
    K4 RGB - Roblox UI Script (Green Theme)
    Sends title text + cycling RGB Color3 to ApplyTitle RemoteEvent
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function getGuiParent()
    local ok, hidden = pcall(function() return gethui() end)
    if ok and hidden then return hidden end
    local ok2, cg = pcall(function() return CoreGui end)
    if ok2 and cg then return cg end
    return PlayerGui
end
local guiParent = getGuiParent()

pcall(function()
    for _, n in ipairs({"K4RGBHub","K4RGBMini","K4RGBSplash"}) do
        local old = guiParent:FindFirstChild(n)
        if old then old:Destroy() end
        local old2 = PlayerGui:FindFirstChild(n)
        if old2 then old2:Destroy() end
    end
end)

----------------------------------------------------------------
-- Loading splash
----------------------------------------------------------------
local function runSplash()
    local splash = Instance.new("ScreenGui")
    splash.Name = "K4RGBSplash"; splash.ResetOnSpawn = false; splash.IgnoreGuiInset = true
    splash.DisplayOrder = 9999
    pcall(function() splash.Parent = guiParent end)
    if not splash.Parent then splash.Parent = PlayerGui end

    local f = Instance.new("Frame", splash)
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.Position = UDim2.new(0.5, 0, 0.5, 0)
    f.Size = UDim2.new(0, 360, 0, 140)
    f.BackgroundColor3 = Color3.fromRGB(8, 18, 10)
    f.BackgroundTransparency = 0.15; f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
    local s = Instance.new("UIStroke", f)
    s.Color = Color3.fromRGB(0, 255, 120); s.Thickness = 1.4; s.Transparency = 0.2

    local n = Instance.new("TextLabel", f)
    n.BackgroundTransparency = 1
    n.Position = UDim2.new(0, 0, 0, 22); n.Size = UDim2.new(1, 0, 0, 44)
    n.Font = Enum.Font.GothamBlack; n.Text = "K4 RGB"
    n.TextSize = 32; n.TextColor3 = Color3.fromRGB(0, 255, 130)

    local st = Instance.new("TextLabel", f)
    st.BackgroundTransparency = 1
    st.Position = UDim2.new(0, 0, 0, 78); st.Size = UDim2.new(1, 0, 0, 28)
    st.Font = Enum.Font.GothamSemibold; st.Text = "K4 - جاري التشغيل..."
    st.TextSize = 18; st.TextColor3 = Color3.fromRGB(180, 255, 200)

    for i = 1, 3 do
        if not splash.Parent then break end
        pcall(function() TweenService:Create(s, TweenInfo.new(0.35), {Transparency = 0.7}):Play() end)
        task.wait(0.35)
        pcall(function() TweenService:Create(s, TweenInfo.new(0.35), {Transparency = 0.1}):Play() end)
        task.wait(0.35)
    end
    pcall(function() TweenService:Create(f, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play() end)
    pcall(function() TweenService:Create(n, TweenInfo.new(0.4), {TextTransparency = 1}):Play() end)
    pcall(function() TweenService:Create(st, TweenInfo.new(0.4), {TextTransparency = 1}):Play() end)
    pcall(function() TweenService:Create(s, TweenInfo.new(0.4), {Transparency = 1}):Play() end)
    task.wait(0.45)
    pcall(function() splash:Destroy() end)
end
pcall(runSplash)

----------------------------------------------------------------
-- Main GUI
----------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "K4RGBHub"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.DisplayOrder = 9000
pcall(function() gui.Parent = guiParent end)
if not gui.Parent then gui.Parent = PlayerGui end

local main = Instance.new("Frame", gui)
main.Name = "Main"; main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0); main.Size = UDim2.new(0, 420, 0, 320)
main.BackgroundColor3 = Color3.fromRGB(6, 16, 9); main.BackgroundTransparency = 0.25
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mStroke = Instance.new("UIStroke", main)
mStroke.Color = Color3.fromRGB(0, 230, 110); mStroke.Thickness = 1.4; mStroke.Transparency = 0.25

local mGradient = Instance.new("UIGradient", main)
mGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 12, 7)),
}
mGradient.Rotation = 135

local glow = Instance.new("Frame", main)
glow.BackgroundColor3 = Color3.fromRGB(0, 255, 130); glow.BorderSizePixel = 0
glow.Size = UDim2.new(1, 0, 0, 2); glow.Position = UDim2.new(0, 0, 0, 44)

-- Header
local header = Instance.new("Frame", main)
header.BackgroundTransparency = 1
header.Size = UDim2.new(1, 0, 0, 44)

local title = Instance.new("TextLabel", header)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 14, 0, 0); title.Size = UDim2.new(1, -60, 1, 0)
title.Font = Enum.Font.GothamBlack; title.Text = "⬛ K4 RGB ⬛"
title.TextSize = 20; title.TextColor3 = Color3.fromRGB(0, 255, 130)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.AnchorPoint = Vector2.new(1, 0.5)
closeBtn.Position = UDim2.new(1, -10, 0.5, 0); closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30); closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold; closeBtn.Text = "X"
closeBtn.TextSize = 16; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Drag main
do
    local dragging, dragStart, startPos = false, nil, nil
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

----------------------------------------------------------------
-- Body with slots
----------------------------------------------------------------
local body = Instance.new("Frame", main)
body.Position = UDim2.new(0, 12, 0, 56); body.Size = UDim2.new(1, -24, 1, -68)
body.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", body)
list.Padding = UDim.new(0, 10)
list.SortOrder = Enum.SortOrder.LayoutOrder

local Remote = ReplicatedStorage:FindFirstChild("ApplyTitle")
local activeLoops = {}

local function makeSlot(index, defaultText)
    local row = Instance.new("Frame", body)
    row.LayoutOrder = index
    row.Size = UDim2.new(1, 0, 0, 42); row.BackgroundTransparency = 1

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(1, -100, 1, 0); box.Position = UDim2.new(0, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(10, 22, 14); box.BackgroundTransparency = 0.15
    box.BorderSizePixel = 0
    box.Text = defaultText; box.PlaceholderText = "اكتب النص..."
    box.TextColor3 = Color3.fromRGB(220, 255, 230); box.PlaceholderColor3 = Color3.fromRGB(120, 160, 130)
    box.Font = Enum.Font.GothamSemibold; box.TextSize = 14
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    local bs = Instance.new("UIStroke", box)
    bs.Color = Color3.fromRGB(0, 200, 100); bs.Thickness = 1; bs.Transparency = 0.5

    local btn = Instance.new("TextButton", row)
    btn.AnchorPoint = Vector2.new(1, 0)
    btn.Position = UDim2.new(1, 0, 0, 0); btn.Size = UDim2.new(0, 92, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 80); btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold; btn.Text = "تشغيل"
    btn.TextSize = 14; btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local bts = Instance.new("UIStroke", btn)
    bts.Color = Color3.fromRGB(0, 255, 130); bts.Thickness = 1; bts.Transparency = 0.3

    btn.MouseButton1Click:Connect(function()
        if activeLoops[index] then
            activeLoops[index] = false
            btn.Text = "تشغيل"
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
            bts.Color = Color3.fromRGB(0, 255, 130)
        else
            if not Remote then
                Remote = ReplicatedStorage:FindFirstChild("ApplyTitle")
            end
            activeLoops[index] = true
            btn.Text = "إيقاف"
            btn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
            bts.Color = Color3.fromRGB(255, 80, 80)

            task.spawn(function()
                while activeLoops[index] do
                    local dynamicColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    pcall(function()
                        if Remote then Remote:FireServer(box.Text, dynamicColor) end
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end)
end

makeSlot(1, "SH ON TOP")
makeSlot(2, "NA WAS HERE")
makeSlot(3, "SHAHAD WAS HERE")

----------------------------------------------------------------
-- Mini draggable bubble
----------------------------------------------------------------
local miniGui = Instance.new("ScreenGui")
miniGui.Name = "K4RGBMini"; miniGui.ResetOnSpawn = false; miniGui.IgnoreGuiInset = true
miniGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; miniGui.DisplayOrder = 9001
pcall(function() miniGui.Parent = guiParent end)
if not miniGui.Parent then miniGui.Parent = PlayerGui end

local miniBubble = Instance.new("TextButton", miniGui)
miniBubble.AnchorPoint = Vector2.new(0, 0.5)
miniBubble.Position = UDim2.new(0, 14, 0.35, 0)
miniBubble.Size = UDim2.new(0, 48, 0, 48)
miniBubble.BackgroundColor3 = Color3.fromRGB(150, 60, 200)
miniBubble.BackgroundTransparency = 0.1; miniBubble.BorderSizePixel = 0
miniBubble.AutoButtonColor = false
miniBubble.Text = "🌈"
miniBubble.Font = Enum.Font.GothamBlack
miniBubble.TextSize = 22
miniBubble.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", miniBubble).CornerRadius = UDim.new(0, 10)
local mbStroke = Instance.new("UIStroke", miniBubble)
mbStroke.Color = Color3.fromRGB(220, 120, 255); mbStroke.Thickness = 2; mbStroke.Transparency = 0.1

local mbGrad = Instance.new("UIGradient", miniBubble)
mbGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 80, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 30, 150)),
}
mbGrad.Rotation = 135

-- color cycling animation (RGB style to differentiate from green SH)
task.spawn(function()
    local t = 0
    while miniBubble.Parent do
        t = t + 0.05
        pcall(function()
            mbStroke.Color = Color3.fromHSV(t % 1, 1, 1)
        end)
        task.wait(0.05)
    end
end)

-- draggable + click-to-toggle
do
    local dragging, dragStart, startPos, moved = false, nil, nil, false
    miniBubble.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; moved = false
            dragStart = input.Position; startPos = miniBubble.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if delta.Magnitude > 4 then moved = true end
            miniBubble.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    miniBubble.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if not moved then
                main.Visible = not main.Visible
            end
        end
    end)
end

closeBtn.MouseButton1Click:Connect(function()
    pcall(function() gui:Destroy() end)
    pcall(function() miniGui:Destroy() end)
end)

print("[K4 RGB] Loaded")
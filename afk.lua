-- الخدمات
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- متغيرات التحكم
local connection = nil
local guiVisible = true

-- تعريف مسبق لـ mainFrame
local mainFrame

-- ═══════════════════════════════════════
--          إنشاء الواجهة الرئيسية
-- ═══════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StickGui_Shahad"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════
--     إشعار الترحيب
-- ═══════════════════════════════════════

local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 320, 0, 70)
notifFrame.Position = UDim2.new(0.5, -160, 0, -80)
notifFrame.BackgroundColor3 = Color3.fromRGB(18, 32, 22)
notifFrame.BorderSizePixel = 0
notifFrame.ZIndex = 10
notifFrame.Parent = screenGui
Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 14)

local notifStroke = Instance.new("UIStroke", notifFrame)
notifStroke.Color = Color3.fromRGB(60, 180, 100)
notifStroke.Thickness = 1.2
notifStroke.Transparency = 0.4

local notifAccent = Instance.new("Frame")
notifAccent.Size = UDim2.new(1, 0, 0, 3)
notifAccent.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
notifAccent.BorderSizePixel = 0
notifAccent.ZIndex = 11
notifAccent.Parent = notifFrame
Instance.new("UICorner", notifAccent).CornerRadius = UDim.new(0, 14)

local notifGradient = Instance.new("UIGradient", notifAccent)
notifGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(30,  160, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80,  230, 130)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(30,  160, 80)),
})

local notifIcon = Instance.new("TextLabel")
notifIcon.Size = UDim2.new(0, 44, 1, 0)
notifIcon.Position = UDim2.new(0, 8, 0, 0)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "🤯"
notifIcon.TextSize = 24
notifIcon.Font = Enum.Font.GothamBold
notifIcon.ZIndex = 11
notifIcon.Parent = notifFrame

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1, -60, 1, -8)
notifText.Position = UDim2.new(0, 52, 0, 4)
notifText.BackgroundTransparency = 1
notifText.Text = "قم الاختفاء والتحدث مكان اي شخص 🤯 ⁉️"
notifText.TextColor3 = Color3.fromRGB(180, 240, 200)
notifText.Font = Enum.Font.GothamBold
notifText.TextSize = 12
notifText.TextWrapped = true
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.ZIndex = 11
notifText.Parent = notifFrame

task.spawn(function()
    task.wait(0.5)
    TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -160, 0, 16)
    }):Play()
    task.wait(3.5)
    TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -160, 0, -80)
    }):Play()
    task.wait(0.45)
    notifFrame:Destroy()
end)

-- ═══════════════════════════════════════
--   الدائرة على الجهة اليسرى (قابلة للسحب)
-- ═══════════════════════════════════════

local toggleCircle = Instance.new("Frame")
toggleCircle.Name = "ToggleCircle"
toggleCircle.Size = UDim2.new(0, 42, 0, 42)
toggleCircle.Position = UDim2.new(0, 16, 0.5, -21)   -- جهة اليسار
toggleCircle.BackgroundColor3 = Color3.fromRGB(20, 55, 30)
toggleCircle.BackgroundTransparency = 0.05
toggleCircle.BorderSizePixel = 0
toggleCircle.ZIndex = 20
toggleCircle.Parent = screenGui
Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)

local toggleStroke = Instance.new("UIStroke", toggleCircle)
toggleStroke.Color = Color3.fromRGB(60, 210, 110)
toggleStroke.Thickness = 1.8
toggleStroke.Transparency = 0.2

local toggleGrad = Instance.new("UIGradient", toggleCircle)
toggleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 110, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 45, 25)),
})
toggleGrad.Rotation = 135

local toggleIcon = Instance.new("TextLabel")
toggleIcon.Size = UDim2.new(1, 0, 1, 0)
toggleIcon.BackgroundTransparency = 1
toggleIcon.Text = "👁"
toggleIcon.TextSize = 19
toggleIcon.Font = Enum.Font.GothamBold
toggleIcon.TextColor3 = Color3.fromRGB(140, 255, 170)
toggleIcon.ZIndex = 21
toggleIcon.Parent = toggleCircle

-- ── منطق السحب السلس ──
local isDragging     = false
local dragStartMouse = Vector2.new()
local dragStartFrame = UDim2.new()
local movedEnough    = false
local THRESHOLD      = 5

toggleCircle.InputBegan:Connect(function(inp)
    if inp.UserInputType ~= Enum.UserInputType.MouseButton1
    and inp.UserInputType ~= Enum.UserInputType.Touch then return end
    isDragging     = true
    movedEnough    = false
    dragStartMouse = Vector2.new(inp.Position.X, inp.Position.Y)
    dragStartFrame = toggleCircle.Position
end)

UserInputService.InputChanged:Connect(function(inp)
    if not isDragging then return end
    if inp.UserInputType ~= Enum.UserInputType.MouseMovement
    and inp.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dragStartMouse
    if delta.Magnitude > THRESHOLD then movedEnough = true end
    if movedEnough then
        toggleCircle.Position = UDim2.new(
            dragStartFrame.X.Scale,  dragStartFrame.X.Offset + delta.X,
            dragStartFrame.Y.Scale,  dragStartFrame.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType ~= Enum.UserInputType.MouseButton1
    and inp.UserInputType ~= Enum.UserInputType.Touch then return end
    if not isDragging then return end
    isDragging = false
    if not movedEnough then
        guiVisible = not guiVisible
        if guiVisible then
            toggleIcon.Text = "👁"
            mainFrame.Visible = true
            TweenService:Create(mainFrame,
                TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 280, 0, 300),
                BackgroundTransparency = 0.2
            }):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(20, 55, 30)
            }):Play()
        else
            toggleIcon.Text = "＋"
            TweenService:Create(mainFrame,
                TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 280, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(18, 38, 22)
            }):Play()
            task.delay(0.3, function() mainFrame.Visible = false end)
        end
    end
    movedEnough = false
end)

-- نبض الدائرة
task.spawn(function()
    while true do
        TweenService:Create(toggleStroke,
            TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.75}):Play()
        task.wait(1.3)
        TweenService:Create(toggleStroke,
            TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.05}):Play()
        task.wait(1.3)
    end
end)

-- ═══════════════════════════════════════
--     الإطار الرئيسي (أخضر شفاف)
-- ═══════════════════════════════════════

mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 300)
mainFrame.Position = UDim2.new(0.5, -140, 0.4, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 38, 22)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(50, 180, 90)
mainStroke.Thickness = 1.2
mainStroke.Transparency = 0.4

-- ═══════════════════════════════════════
--              شريط العنوان
-- ═══════════════════════════════════════

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 54)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 28, 16)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

local titleDivider = Instance.new("Frame")
titleDivider.Size = UDim2.new(1, 0, 0, 1)
titleDivider.Position = UDim2.new(0, 0, 1, -1)
titleDivider.BackgroundColor3 = Color3.fromRGB(50, 170, 85)
titleDivider.BackgroundTransparency = 0.5
titleDivider.BorderSizePixel = 0
titleDivider.Parent = titleBar

local dot = Instance.new("Frame")
dot.Size = UDim2.new(0, 8, 0, 8)
dot.Position = UDim2.new(0, 16, 0.5, -4)
dot.BackgroundColor3 = Color3.fromRGB(60, 220, 110)
dot.BorderSizePixel = 0
dot.Parent = titleBar
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

local dotStroke = Instance.new("UIStroke", dot)
dotStroke.Color = Color3.fromRGB(100, 255, 150)
dotStroke.Thickness = 2
dotStroke.Transparency = 0.2

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 34, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "STICK SYSTEM"
titleLabel.TextColor3 = Color3.fromRGB(170, 255, 200)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -40, 0, 14)
subTitle.Position = UDim2.new(0, 34, 1, -16)
subTitle.BackgroundTransparency = 1
subTitle.Text = "by Shahad"
subTitle.TextColor3 = Color3.fromRGB(70, 150, 95)
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 10
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = titleBar

-- ═══════════════════════════════════════
--          مجموعة المحتوى
-- ═══════════════════════════════════════

local contentGroup = Instance.new("CanvasGroup")
contentGroup.Size = UDim2.new(1, 0, 1, -54)
contentGroup.Position = UDim2.new(0, 0, 0, 54)
contentGroup.BackgroundTransparency = 1
contentGroup.BorderSizePixel = 0
contentGroup.Parent = mainFrame

local contentPadding = Instance.new("UIPadding", contentGroup)
contentPadding.PaddingLeft   = UDim.new(0, 16)
contentPadding.PaddingRight  = UDim.new(0, 16)
contentPadding.PaddingTop    = UDim.new(0, 14)
contentPadding.PaddingBottom = UDim.new(0, 14)

local contentLayout = Instance.new("UIListLayout", contentGroup)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)

-- ═══════════════════════════════════════
--         حقل إدخال الاسم
-- ═══════════════════════════════════════

local inputContainer = Instance.new("Frame")
inputContainer.Size = UDim2.new(1, 0, 0, 40)
inputContainer.BackgroundColor3 = Color3.fromRGB(10, 30, 18)
inputContainer.BackgroundTransparency = 0.3
inputContainer.BorderSizePixel = 0
inputContainer.LayoutOrder = 1
inputContainer.Parent = contentGroup
Instance.new("UICorner", inputContainer).CornerRadius = UDim.new(0, 10)

local inputStroke = Instance.new("UIStroke", inputContainer)
inputStroke.Color = Color3.fromRGB(45, 140, 75)
inputStroke.Thickness = 1
inputStroke.Transparency = 0.4

local searchIcon = Instance.new("TextLabel")
searchIcon.Size = UDim2.new(0, 30, 1, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.Text = "🔍"
searchIcon.TextSize = 14
searchIcon.Font = Enum.Font.GothamBold
searchIcon.Parent = inputContainer

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -36, 1, 0)
textBox.Position = UDim2.new(0, 30, 0, 0)
textBox.BackgroundTransparency = 1
textBox.PlaceholderText = "اكتبي اسم اللاعب..."
textBox.PlaceholderColor3 = Color3.fromRGB(70, 130, 90)
textBox.TextColor3 = Color3.fromRGB(180, 255, 210)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 13
textBox.ClearTextOnFocus = false
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.Parent = inputContainer

textBox.Focused:Connect(function()
    TweenService:Create(inputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(70, 220, 120), Transparency = 0
    }):Play()
end)
textBox.FocusLost:Connect(function()
    TweenService:Create(inputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(45, 140, 75), Transparency = 0.4
    }):Play()
end)

-- ═══════════════════════════════════════
--         مؤشر الحالة
-- ═══════════════════════════════════════

local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 32)
statusBar.BackgroundColor3 = Color3.fromRGB(8, 25, 14)
statusBar.BackgroundTransparency = 0.35
statusBar.BorderSizePixel = 0
statusBar.LayoutOrder = 2
statusBar.Parent = contentGroup
Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 8)

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 7, 0, 7)
statusDot.Position = UDim2.new(0, 10, 0.5, -3.5)
statusDot.BackgroundColor3 = Color3.fromRGB(60, 160, 90)
statusDot.BorderSizePixel = 0
statusDot.Parent = statusBar
Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -26, 1, 0)
statusLabel.Position = UDim2.new(0, 24, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "في وضع الانتظار"
statusLabel.TextColor3 = Color3.fromRGB(80, 170, 110)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusBar

local function setStatus(text, r, g, b)
    statusLabel.Text = text
    statusLabel.TextColor3 = Color3.fromRGB(r, g, b)
    TweenService:Create(statusDot, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(r, g, b)
    }):Play()
end

-- ═══════════════════════════════════════
--         زر بدء الالتصاق (أخضر)
-- ═══════════════════════════════════════

local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(1, 0, 0, 40)
actionButton.BackgroundColor3 = Color3.fromRGB(22, 80, 42)
actionButton.BackgroundTransparency = 0.1
actionButton.Text = ""
actionButton.BorderSizePixel = 0
actionButton.AutoButtonColor = false
actionButton.LayoutOrder = 3
actionButton.Parent = contentGroup
Instance.new("UICorner", actionButton).CornerRadius = UDim.new(0, 10)

local actionGradient = Instance.new("UIGradient", actionButton)
actionGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 120, 65)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 60, 30)),
})
actionGradient.Rotation = 90

local actionStroke = Instance.new("UIStroke", actionButton)
actionStroke.Color = Color3.fromRGB(60, 190, 100)
actionStroke.Thickness = 1
actionStroke.Transparency = 0.45

local actionLabel = Instance.new("TextLabel")
actionLabel.Size = UDim2.new(1, 0, 1, 0)
actionLabel.BackgroundTransparency = 1
actionLabel.Text = "▶  بدء الالتصاق"
actionLabel.TextColor3 = Color3.fromRGB(170, 255, 200)
actionLabel.Font = Enum.Font.GothamBold
actionLabel.TextSize = 13
actionLabel.Parent = actionButton

actionButton.MouseEnter:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 100, 55)}):Play()
end)
actionButton.MouseLeave:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 80, 42)}):Play()
end)
actionButton.MouseButton1Down:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 37)}):Play()
end)
actionButton.MouseButton1Up:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 40)}):Play()
end)

-- ═══════════════════════════════════════
--      صف الأزرار السفلية
-- ═══════════════════════════════════════

local bottomRow = Instance.new("Frame")
bottomRow.Size = UDim2.new(1, 0, 0, 40)
bottomRow.BackgroundTransparency = 1
bottomRow.LayoutOrder = 4
bottomRow.Parent = contentGroup

local bottomLayout = Instance.new("UIListLayout", bottomRow)
bottomLayout.FillDirection = Enum.FillDirection.Horizontal
bottomLayout.SortOrder = Enum.SortOrder.LayoutOrder
bottomLayout.Padding = UDim.new(0, 8)

local function makeButton(parent, order, r, g, b, labelText)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, -4, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(r, g, b)
    btn.BackgroundTransparency = 0.12
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.LayoutOrder = order
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local g2 = Instance.new("UIGradient", btn)
    g2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(r+28, g+28, b+28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(r, g, b)),
    })
    g2.Rotation = 90

    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(r+55, g+55, b+55)
    s.Thickness = 1
    s.Transparency = 0.4

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(200, 255, 215)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(r+18, g+18, b+18)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(r, g, b)}):Play()
    end)
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.5, -4, 0, 37)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.5, -4, 1, 0)}):Play()
    end)
    return btn, lbl
end

-- إيقاف: أحمر مائل للأخضر الداكن / اختفاء: بنفسجي داكن
local stopButton,  stopLabel  = makeButton(bottomRow, 1,  90, 30,  30, "⏹  إيقاف")
local invisButton, invisLabel = makeButton(bottomRow, 2,  40, 60, 100, "👁  اختفاء")

-- ═══════════════════════════════════════
--       أنيميشن ظهور الواجهة
-- ═══════════════════════════════════════

mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
task.wait(0.1)
TweenService:Create(mainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 280, 0, 300),
    BackgroundTransparency = 0.2
}):Play()

-- ═══════════════════════════════════════
--              دوال المنطق
-- ═══════════════════════════════════════

local function findPlayerBySubString(subString)
    local lowerSub = string.lower(subString)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            if string.find(string.lower(player.Name), lowerSub) or
               string.find(string.lower(player.DisplayName), lowerSub) then
                return player
            end
        end
    end
    return nil
end

actionButton.MouseButton1Click:Connect(function()
    if textBox.Text == "" then
        setStatus("أدخلي اسم اللاعب أولاً", 210, 180, 60)
        return
    end
    local targetPlayer = findPlayerBySubString(textBox.Text)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if connection then connection:Disconnect() end
        connection = RunService.RenderStepped:Connect(function()
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            else
                if connection then connection:Disconnect() end
                setStatus("فُقد اللاعب المستهدف", 210, 100, 60)
                actionLabel.Text = "▶  بدء الالتصاق"
            end
        end)
        actionLabel.Text = "✔  ملتصقة بـ: " .. targetPlayer.Name
        setStatus("تتبع: " .. targetPlayer.DisplayName, 80, 220, 130)
    else
        setStatus("اللاعب غير موجود!", 220, 80, 80)
        task.wait(2)
        setStatus("في وضع الانتظار", 80, 170, 110)
    end
end)

stopButton.MouseButton1Click:Connect(function()
    if connection then connection:Disconnect() connection = nil end
    actionLabel.Text = "▶  بدء الالتصاق"
    setStatus("تم الإيقاف", 210, 100, 60)
    task.wait(1.5)
    setStatus("في وضع الانتظار", 80, 170, 110)
end)

invisButton.MouseButton1Click:Connect(function()
    local args = { [1] = ";ref" }
    for i = 1, 4 do
        pcall(function()
            game:GetService("ReplicatedStorage").HDAdminHDClient.Signals.RequestCommandModification:InvokeServer(unpack(args))
        end)
    end
    setStatus("تم تفعيل الاختفاء ✨", 100, 180, 255)
    task.wait(2)
    setStatus("في وضع الانتظار", 80, 170, 110)
end)

-- نبض النقطة في العنوان
task.spawn(function()
    while true do
        TweenService:Create(dotStroke,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.82}):Play()
        task.wait(1)
        TweenService:Create(dotStroke,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.05}):Play()
        task.wait(1)
    end
end)
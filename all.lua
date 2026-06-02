-- [[ نظام الحماية والحظر - SH PROTECTION ]]
local BlacklistedUsers = {
    [5262108948] = "تم حضرك من السكربت =)", 
    [1444034266] = "تم حضرك من السكربت =)",
}

local player = game:GetService("Players").LocalPlayer
if BlacklistedUsers[player.UserId] then
    player:Kick("\n⚠️ [SH SYSTEM]\n\n" .. BlacklistedUsers[player.UserId])
    return 
end

-- [[ تنظيف أي نسخ قديمة ]]
if game:GetService("CoreGui"):FindFirstChild("SH_Ultimate_Bird") then
    game:GetService("CoreGui"):FindFirstChild("SH_Ultimate_Bird"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SH_Ultimate_Bird"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- [[ وظيفة تأثير قوس القزح الدوار ]]
local function applyRainbowGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    gradient.Parent = parent
    
    task.spawn(function()
        local rot = 0
        while gradient.Parent do
            rot = rot + 2
            gradient.Rotation = rot % 360
            task.wait(0.01)
        end
    end)
end

-- [[ اللوحة الرئيسية ]]
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
applyRainbowGradient(MainStroke)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "SH SMART PANEL 🕊️"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local CommandBox = Instance.new("TextBox", MainFrame)
CommandBox.Position = UDim2.new(0.05, 0, 0.3, 0)
CommandBox.Size = UDim2.new(0.65, 0, 0, 38)
CommandBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CommandBox.Text = ""
CommandBox.PlaceholderText = "اكتب الأمر هنا.."
CommandBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CommandBox).CornerRadius = UDim.new(0, 8)

local SpeedInput = Instance.new("TextBox", MainFrame)
SpeedInput.Position = UDim2.new(0.72, 0, 0.3, 0)
SpeedInput.Size = UDim2.new(0.23, 0, 0, 38)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
SpeedInput.Text = "0.7"
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 8)

local ExecBtn = Instance.new("TextButton", MainFrame)
ExecBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
ExecBtn.Size = UDim2.new(0.9, 0, 0, 45)
ExecBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ExecBtn.Text = "تنفيذ على الجميع"
ExecBtn.TextColor3 = Color3.new(1, 1, 1)
ExecBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 10)

-- [[ زر الميني الدائري (🕊️) ]]
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = ""
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 3
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
applyRainbowGradient(ToggleStroke)

local ToggleLabel = Instance.new("TextLabel", ToggleBtn)
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.Text = "🕊️"
ToggleLabel.TextSize = 30
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.TextColor3 = Color3.new(1, 1, 1)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- [[ منطق التنفيذ الذكي ]]
local adminRemote = game:GetService("ReplicatedStorage").HDAdminHDClient.Signals.RequestCommandModification

ExecBtn.MouseButton1Click:Connect(function()
    local inputCmd = CommandBox.Text
    local delayTime = tonumber(SpeedInput.Text) or 0.7
    if inputCmd == "" then return end

    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        local finalCmd = inputCmd
        
        -- إذا وجد all أو me يستبدلها
        if string.find(finalCmd, "all") then
            finalCmd = string.gsub(finalCmd, "all", p.Name)
        elseif string.find(finalCmd, "me") then
            finalCmd = string.gsub(finalCmd, "me", p.Name)
        else
            -- إذا لم يجد شيئاً، يحشر الاسم بعد الكلمة الأولى
            local parts = string.split(finalCmd, " ")
            local firstWord = parts[1]
            table.remove(parts, 1)
            finalCmd = firstWord .. " " .. p.Name .. " " .. table.concat(parts, " ")
        end
        
        pcall(function() adminRemote:InvokeServer(finalCmd) end)
        task.wait(delayTime)
    end
end)
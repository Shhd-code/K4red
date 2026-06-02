-- منع تكرار التشغيل (تنظيف النسخة القديمة إن وجدت)
if game:GetService("CoreGui"):FindFirstChild("SH_SPAM_ULTIMATE") then
    game:GetService("CoreGui"):FindFirstChild("SH_SPAM_ULTIMATE"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local UICorner = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local SpeedInput = Instance.new("TextBox")
local SpamButton = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")

-- إعدادات اللوحة (أسود شفاف)
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "SH_SPAM_ULTIMATE"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
MainFrame.BackgroundTransparency = 0.25 
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -125)
MainFrame.Size = UDim2.new(0, 220, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Thickness = 1.5
UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Transparency = 0.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- العنوان
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "SH SPAM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- مربع النص
TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.22, 0)
TextBox.Size = UDim2.new(0.8, 0, 0.18, 0)
TextBox.PlaceholderText = "اكتبي هنا..."
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.BackgroundTransparency = 0.3
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.TextWrapped = true 
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

-- السرعة
SpeedLabel.Parent = MainFrame
SpeedLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
SpeedLabel.Text = "تأخير الإرسال (ثانية)"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 11

SpeedInput.Parent = MainFrame
SpeedInput.Position = UDim2.new(0.3, 0, 0.58, 0)
SpeedInput.Size = UDim2.new(0.4, 0, 0.12, 0)
SpeedInput.Text = "0.5"
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.BackgroundTransparency = 0.3
SpeedInput.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedInput.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 4)

-- زر التشغيل
SpamButton.Parent = MainFrame
SpamButton.Position = UDim2.new(0.1, 0, 0.78, 0)
SpamButton.Size = UDim2.new(0.8, 0, 0.16, 0)
SpamButton.Text = "بدء التشغيل"
SpamButton.Font = Enum.Font.GothamBold
SpamButton.TextColor3 = Color3.new(1, 1, 1)
SpamButton.TextSize = 15
Instance.new("UICorner", SpamButton).CornerRadius = UDim.new(0, 8)

local BtnGradient = Instance.new("UIGradient", SpamButton)
BtnGradient.Color = ColorSequence.new(Color3.fromRGB(120, 0, 255), Color3.fromRGB(70, 0, 180))

-- زر الميني 🐰
local ToggleButton = Instance.new("TextButton")
local ToggleCorner = Instance.new("UICorner")
local ToggleStroke = Instance.new("UIStroke")
local RabbitLabel = Instance.new("TextLabel")

ToggleButton.Name = "RabbitToggle"
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.Text = ""
ToggleButton.Active = true
ToggleButton.Draggable = true 

ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

ToggleStroke.Parent = ToggleButton
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(120, 0, 255)
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

RabbitLabel.Parent = ToggleButton
RabbitLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
RabbitLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
RabbitLabel.BackgroundTransparency = 1
RabbitLabel.Text = "🐰"
RabbitLabel.TextSize = 24
RabbitLabel.Font = Enum.Font.GothamBold
RabbitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

-- المنطق البرمجي
local spamming = false
local chatRemote = game:GetService("ReplicatedStorage").RemoteEvents.ChatEvent
local adminRemote = game:GetService("ReplicatedStorage").HDAdminHDClient.Signals.RequestCommandModification

SpamButton.MouseButton1Click:Connect(function()
    spamming = not spamming
    if spamming then
        SpamButton.Text = "إيقاف"
        BtnGradient.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(150, 0, 0))
        UIStroke.Color = Color3.fromRGB(255, 0, 0)
        
        task.spawn(function()
            while spamming do
                local text = TextBox.Text
                local waitTime = tonumber(SpeedInput.Text) or 0.5
                if text ~= "" then
                    pcall(function() chatRemote:FireServer(text) end)
                    pcall(function() adminRemote:InvokeServer(text) end)
                end
                task.wait(waitTime)
            end
        end)
    else
        SpamButton.Text = "بدء التشغيل"
        BtnGradient.Color = ColorSequence.new(Color3.fromRGB(120, 0, 255), Color3.fromRGB(70, 0, 180))
        UIStroke.Color = Color3.fromRGB(100, 100, 100)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- حماية الواجهة (حذف إشعارات النظام)
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local function hideSystemNotifications(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextBox") then
        if obj.Text:find("Sending commands") or obj.Text:find("CommandLimit") or obj.Text:find("System") then
            local notificationFrame = obj.Parent
            if notificationFrame then
                pcall(function() notificationFrame:Destroy() end)
            end
        end
    end
end

playerGui.DescendantAdded:Connect(function(descendant)
    task.wait(0.01)
    hideSystemNotifications(descendant)
end)

print("SH SPAM V3 Activated - Anti-System Notification ON")
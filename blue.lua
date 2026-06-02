--[[
    السكربت: SH HUBBB
    المطور: NEHAHAHAHA @shhode320
    التصميم: عصري فخم
]]

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")

-- ========== المسارات ==========
local chatEvent = nil
local execSignal = nil

local remoteEvents = replicatedStorage:FindFirstChild("RemoteEvents")
if remoteEvents then
    chatEvent = remoteEvents:FindFirstChild("ChatEvent")
end
if not chatEvent then
    for _, v in pairs(replicatedStorage:GetDescendants()) do
        if v.Name == "ChatEvent" and v:IsA("RemoteEvent") then
            chatEvent = v
            break
        end
    end
end

local hdClient = replicatedStorage:FindFirstChild("HDAdminHDClient")
if hdClient and hdClient:FindFirstChild("Signals") then
    execSignal = hdClient.Signals:FindFirstChild("RequestCommandModification")
end

-- ========== دوال الحماية الجديدة ==========
local function deleteNightVision()
    local hdClient = replicatedStorage:FindFirstChild("HDAdminHDClient")
    if hdClient then
        local assets = hdClient:FindFirstChild("Assets")
        if assets then
            local nightVision = assets:FindFirstChild("NightVision")
            if nightVision then
                nightVision:Destroy()
                return true
            end
        end
    end
    return false
end

local function deleteHDInterface()
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        local hdInterface = playerGui:FindFirstChild("HDAdminInterface")
        if hdInterface then
            hdInterface:Destroy()
            return true
        end
    end
    return false
end

-- ========== دوال أساسية ==========
local function sendMsg(msg)
    if not chatEvent then return false end
    pcall(function() chatEvent:FireServer(msg) end)
    return true
end

local function execCmd(cmd)
    if not execSignal then return false end
    pcall(function() execSignal:InvokeServer(cmd) end)
    return true
end

-- ========== رسالة ترحيب ==========
local welcomeGui = Instance.new("ScreenGui")
welcomeGui.Name = "WelcomeGUI"
welcomeGui.ResetOnSpawn = false
welcomeGui.Parent = player:WaitForChild("PlayerGui")

local welcomeFrame = Instance.new("Frame")
welcomeFrame.Size = UDim2.new(0, 350, 0, 70)
welcomeFrame.Position = UDim2.new(0.5, -175, 0.3, 0)
welcomeFrame.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
welcomeFrame.BackgroundTransparency = 0.15
welcomeFrame.BorderSizePixel = 0
welcomeFrame.Parent = welcomeGui

local welcomeCorner = Instance.new("UICorner")
welcomeCorner.CornerRadius = UDim.new(0, 18)
welcomeCorner.Parent = welcomeFrame

local welcomeStroke = Instance.new("UIStroke")
welcomeStroke.Thickness = 1.5
welcomeStroke.Color = Color3.fromRGB(0, 150, 255)
welcomeStroke.Parent = welcomeFrame

local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, 0, 1, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "SH HUBBB\nNEHAHAHAHA @shhode320"
welcomeText.Font = Enum.Font.GothamBlack
welcomeText.TextSize = 22
welcomeText.TextScaled = true
welcomeText.TextWrapped = true
welcomeText.TextXAlignment = Enum.TextXAlignment.Center
welcomeText.Parent = welcomeFrame

spawn(function()
    local hue = 0
    while welcomeText and welcomeText.Parent do
        hue = (hue + 0.02) % 1
        welcomeText.TextColor3 = Color3.fromHSV(hue, 1, 1)
        welcomeStroke.Color = Color3.fromHSV(hue, 1, 1)
        wait(0.05)
    end
end)

spawn(function()
    wait(3.5)
    for i = 1, 0, -0.05 do
        welcomeFrame.BackgroundTransparency = i
        welcomeText.TextTransparency = i
        welcomeStroke.Transparency = i
        wait(0.02)
    end
    welcomeGui:Destroy()
end)

-- ========== إنشاء الواجهة الرئيسية ==========
local gui = Instance.new("ScreenGui")
gui.Name = "SHHubbb"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = lighting

-- ========== زر الفتح/الإغلاق (قابل للسحب) ==========
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.85, 0, 0.1, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
toggleBtn.Text = "SH"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(0, 150, 255)
toggleStroke.Parent = toggleBtn

local toggleShadow = Instance.new("ImageLabel")
toggleShadow.Size = UDim2.new(1, 10, 1, 10)
toggleShadow.Position = UDim2.new(0, -5, 0, -5)
toggleShadow.BackgroundTransparency = 1
toggleShadow.Image = "rbxassetid://1316045225"
toggleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
toggleShadow.ImageTransparency = 0.5
toggleShadow.Parent = toggleBtn

-- سحب زر الفتح
local dragToggle = false
local dragStart1, startPos1

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart1 = input.Position
        startPos1 = toggleBtn.Position
    end
end)

toggleBtn.InputEnded:Connect(function()
    dragToggle = false
end)

userInputService.InputChanged:Connect(function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart1
        toggleBtn.Position = UDim2.new(startPos1.X.Scale, startPos1.X.Offset + delta.X, startPos1.Y.Scale, startPos1.Y.Offset + delta.Y)
    end
end)

-- ========== القائمة الرئيسية (حجم أصغر 250x380) ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 380)
mainFrame.Position = UDim2.new(0.5, -125, 0.35, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 45)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.5
mainStroke.Color = Color3.fromRGB(0, 120, 220)
mainStroke.Parent = mainFrame

local mainShadow = Instance.new("ImageLabel")
mainShadow.Size = UDim2.new(1, 12, 1, 12)
mainShadow.Position = UDim2.new(0, -6, 0, -6)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://1316045225"
mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
mainShadow.ImageTransparency = 0.6
mainShadow.Parent = mainFrame

-- ========== شريط العنوان ==========
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 60, 150)
titleBar.BackgroundTransparency = 0.1
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

local titleMain = Instance.new("TextLabel")
titleMain.Size = UDim2.new(1, 0, 0, 25)
titleMain.Position = UDim2.new(0, 0, 0, 6)
titleMain.BackgroundTransparency = 1
titleMain.Text = "SH HUBBB"
titleMain.TextColor3 = Color3.fromRGB(100, 180, 255)
titleMain.Font = Enum.Font.GothamBold
titleMain.TextSize = 16
titleMain.TextXAlignment = Enum.TextXAlignment.Center
titleMain.Parent = titleBar

local titleSub = Instance.new("TextLabel")
titleSub.Size = UDim2.new(1, 0, 0, 18)
titleSub.Position = UDim2.new(0, 0, 0, 32)
titleSub.BackgroundTransparency = 1
titleSub.Text = "@shhode320"
titleSub.TextColor3 = Color3.fromRGB(150, 200, 255)
titleSub.Font = Enum.Font.Gotham
titleSub.TextSize = 11
titleSub.TextXAlignment = Enum.TextXAlignment.Center
titleSub.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -32, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    blur.Size = 0
end)

-- ========== سحب القائمة الرئيسية ==========
local dragMenu = false
local dragStart2, startPos2

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragMenu = true
        dragStart2 = input.Position
        startPos2 = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function()
    dragMenu = false
end)

userInputService.InputChanged:Connect(function(input)
    if dragMenu and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart2
        mainFrame.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
    end
end)

-- ========== نص المطور ==========
local devFrame = Instance.new("Frame")
devFrame.Size = UDim2.new(0.9, 0, 0, 45)
devFrame.Position = UDim2.new(0.05, 0, 0.17, 0)
devFrame.BackgroundColor3 = Color3.fromRGB(0, 25, 65)
devFrame.BackgroundTransparency = 0.3
devFrame.BorderSizePixel = 0
devFrame.Parent = mainFrame

local devCorner = Instance.new("UICorner")
devCorner.CornerRadius = UDim.new(0, 8)
devCorner.Parent = devFrame

local devStroke = Instance.new("UIStroke")
devStroke.Thickness = 0.5
devStroke.Color = Color3.fromRGB(0, 100, 200)
devStroke.Parent = devFrame

local devText1 = Instance.new("TextLabel")
devText1.Size = UDim2.new(1, 0, 0, 20)
devText1.Position = UDim2.new(0, 0, 0, 4)
devText1.BackgroundTransparency = 1
devText1.Text = "NEHAHAHAHA @shhode320"
devText1.TextColor3 = Color3.fromRGB(200, 200, 255)
devText1.Font = Enum.Font.GothamBold
devText1.TextSize = 11
devText1.TextXAlignment = Enum.TextXAlignment.Center
devText1.Parent = devFrame

local devText2 = Instance.new("TextLabel")
devText2.Size = UDim2.new(1, 0, 0, 16)
devText2.Position = UDim2.new(0, 0, 0, 24)
devText2.BackgroundTransparency = 1
devText2.Text = "SH HUBBB"
devText2.TextColor3 = Color3.fromRGB(100, 150, 200)
devText2.Font = Enum.Font.Gotham
devText2.TextSize = 9
devText2.TextXAlignment = Enum.TextXAlignment.Center
devText2.Parent = devFrame

-- ========== صندوق الإدخال ==========
local inputLabel = Instance.new("TextLabel")
inputLabel.Size = UDim2.new(0.85, 0, 0, 16)
inputLabel.Position = UDim2.new(0.075, 0, 0.3, 0)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "النص او الامر:"
inputLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
inputLabel.Font = Enum.Font.GothamBold
inputLabel.TextSize = 10
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = mainFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.85, 0, 0, 38)
inputBox.Position = UDim2.new(0.075, 0, 0.34, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(20, 30, 65)
inputBox.BackgroundTransparency = 0.2
inputBox.PlaceholderText = "اكتب رسالة او امر..."
inputBox.PlaceholderColor3 = Color3.fromRGB(120, 150, 200)
inputBox.Text = ""
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 11
inputBox.ClearTextOnFocus = false
inputBox.BorderSizePixel = 0
inputBox.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

-- ========== زر السبام ==========
local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0.85, 0, 0, 40)
spamBtn.Position = UDim2.new(0.075, 0, 0.49, 0)
spamBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 200)
spamBtn.Text = "تفعيل السبام"
spamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 12
spamBtn.BorderSizePixel = 0
spamBtn.Parent = mainFrame

local spamCorner = Instance.new("UICorner")
spamCorner.CornerRadius = UDim.new(0, 10)
spamCorner.Parent = spamBtn

local indicator = Instance.new("Frame")
indicator.Size = UDim2.new(0, 10, 0, 10)
indicator.Position = UDim2.new(0.92, 0, 0.5, -5)
indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
indicator.BorderSizePixel = 0
indicator.Parent = spamBtn

local indCorner = Instance.new("UICorner")
indCorner.CornerRadius = UDim.new(1, 0)
indCorner.Parent = indicator

-- ========== خانة اسم الهدف ==========
local playerLabel = Instance.new("TextLabel")
playerLabel.Size = UDim2.new(0.85, 0, 0, 14)
playerLabel.Position = UDim2.new(0.075, 0, 0.62, 0)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "اسم الهدف:"
playerLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
playerLabel.Font = Enum.Font.GothamBold
playerLabel.TextSize = 10
playerLabel.TextXAlignment = Enum.TextXAlignment.Left
playerLabel.Parent = mainFrame

local playerNameBox = Instance.new("TextBox")
playerNameBox.Size = UDim2.new(0.85, 0, 0, 30)
playerNameBox.Position = UDim2.new(0.075, 0, 0.66, 0)
playerNameBox.BackgroundColor3 = Color3.fromRGB(20, 30, 65)
playerNameBox.BackgroundTransparency = 0.2
playerNameBox.PlaceholderText = "اكتب اسم اللاعب..."
playerNameBox.PlaceholderColor3 = Color3.fromRGB(120, 150, 200)
playerNameBox.Text = ""
playerNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
playerNameBox.Font = Enum.Font.Gotham
playerNameBox.TextSize = 11
playerNameBox.ClearTextOnFocus = false
playerNameBox.BorderSizePixel = 0
playerNameBox.Parent = mainFrame

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 8)
playerCorner.Parent = playerNameBox

-- ========== النص الجاهز ==========
local templateText = "!re na !logs na !nv na !re na !logs na !nv na !re na !logs na !nv na !re na !logs na !nv !re na !logs na !nv na !re na !logs na !nv na !re na !logs na !nv na"

-- ========== زر تجهيز النسخ ==========
local prepareBtn = Instance.new("TextButton")
prepareBtn.Size = UDim2.new(0.4, 0, 0, 32)
prepareBtn.Position = UDim2.new(0.075, 0, 0.76, 0)
prepareBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 130)
prepareBtn.Text = "تجهيز النسخ"
prepareBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
prepareBtn.Font = Enum.Font.GothamBold
prepareBtn.TextSize = 10
prepareBtn.BorderSizePixel = 0
prepareBtn.Parent = mainFrame

local prepareCorner = Instance.new("UICorner")
prepareCorner.CornerRadius = UDim.new(0, 8)
prepareCorner.Parent = prepareBtn

prepareBtn.MouseButton1Click:Connect(function()
    local targetName = playerNameBox.Text
    if targetName == "" then
        playerNameBox.PlaceholderText = "اكتب الاسم اولاً!"
        wait(1)
        playerNameBox.PlaceholderText = "اكتب اسم اللاعب..."
        return
    end
    
    local resultText = string.gsub(templateText, "na", targetName)
    inputBox.Text = resultText
    
    prepareBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    prepareBtn.Text = "تم"
    wait(0.6)
    prepareBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 130)
    prepareBtn.Text = "تجهيز النسخ"
end)

-- ========== زر الحماية ==========
local protectBtn = Instance.new("TextButton")
protectBtn.Size = UDim2.new(0.4, 0, 0, 32)
protectBtn.Position = UDim2.new(0.525, 0, 0.76, 0)
protectBtn.BackgroundColor3 = Color3.fromRGB(140, 35, 70)
protectBtn.Text = "حماية"
protectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
protectBtn.Font = Enum.Font.GothamBold
protectBtn.TextSize = 10
protectBtn.BorderSizePixel = 0
protectBtn.Parent = mainFrame

local protectCorner = Instance.new("UICorner")
protectCorner.CornerRadius = UDim.new(0, 8)
protectCorner.Parent = protectBtn

protectBtn.MouseButton1Click:Connect(function()
    local deleted1 = deleteNightVision()
    local deleted2 = deleteHDInterface()
    local protectionMsg = "تم تفعيل الحماية SH HUBBB"
    sendMsg(protectionMsg)
    execCmd(protectionMsg)
    
    if deleted1 or deleted2 then
        protectBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 80)
        protectBtn.Text = "تم"
    else
        protectBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 50)
        protectBtn.Text = "ارسل"
    end
    wait(0.6)
    protectBtn.BackgroundColor3 = Color3.fromRGB(140, 35, 70)
    protectBtn.Text = "حماية"
end)

-- ========== منطق السبام ==========
local isSpamming = false
local spamConn = nil

local function startSpamming()
    if isSpamming then return end
    local txt = inputBox.Text
    if txt == "" then
        inputBox.PlaceholderText = "اكتب شيئاً اولاً!"
        wait(1)
        inputBox.PlaceholderText = "اكتب رسالة او امر..."
        return
    end
    
    isSpamming = true
    indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    spamBtn.Text = "ايقاف السبام"
    spamBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    
    spamConn = runService.Stepped:Connect(function()
        if isSpamming then
            sendMsg(txt)
            execCmd(txt)
        end
    end)
end

local function stopSpamming()
    isSpamming = false
    if spamConn then
        spamConn:Disconnect()
        spamConn = nil
    end
    indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    spamBtn.Text = "تفعيل السبام"
    spamBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 200)
end

spamBtn.MouseButton1Click:Connect(function()
    if isSpamming then
        stopSpamming()
    else
        startSpamming()
    end
end)

-- ========== زر المؤثرات ==========
local effectBtn = Instance.new("TextButton")
effectBtn.Size = UDim2.new(0.85, 0, 0, 30)
effectBtn.Position = UDim2.new(0.075, 0, 0.87, 0)
effectBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 120)
effectBtn.Text = "تفعيل المؤثرات"
effectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
effectBtn.Font = Enum.Font.GothamBold
effectBtn.TextSize = 10
effectBtn.BorderSizePixel = 0
effectBtn.Parent = mainFrame

local effectCorner = Instance.new("UICorner")
effectCorner.CornerRadius = UDim.new(0, 8)
effectCorner.Parent = effectBtn

local effectsActive = false
local particlesList = {}

effectBtn.MouseButton1Click:Connect(function()
    effectsActive = not effectsActive
    
    if effectsActive then
        effectBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 160)
        effectBtn.Text = "المؤثرات مفعلة"
        blur.Size = 5
        
        for i = 1, 15 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(2, 3), 0, math.random(2, 3))
            particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
            particle.BackgroundColor3 = Color3.fromRGB(math.random(100, 200), math.random(100, 200), 255)
            particle.BorderSizePixel = 0
            particle.BackgroundTransparency = 0.3
            particle.Parent = mainFrame
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(1, 0)
            pCorner.Parent = particle
            
            table.insert(particlesList, particle)
            
            spawn(function()
                while particle and particle.Parent and effectsActive do
                    local x = particle.Position.X.Scale + (math.random(-2, 2) * 0.002)
                    local y = particle.Position.Y.Scale + (math.random(-2, 2) * 0.002)
                    if x < 0 then x = 1 elseif x > 1 then x = 0 end
                    if y < 0 then y = 1 elseif y > 1 then y = 0 end
                    particle.Position = UDim2.new(x, 0, y, 0)
                    wait(0.03)
                end
            end)
        end
        
        spawn(function()
            local hue = 0
            while effectsActive and mainFrame and mainFrame.Parent do
                hue = (hue + 0.002) % 1
                mainFrame.BackgroundColor3 = Color3.fromHSV(hue, 0.4, 0.12)
                mainStroke.Color = Color3.fromHSV(hue, 1, 1)
                wait(0.05)
            end
        end)
    else
        effectBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 120)
        effectBtn.Text = "تفعيل المؤثرات"
        blur.Size = 0
        for _, p in pairs(particlesList) do
            p:Destroy()
        end
        particlesList = {}
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 45)
        mainStroke.Color = Color3.fromRGB(0, 120, 220)
    end
end)

-- ========== فتح القائمة ==========
local menuVisible = false

toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
    
    if menuVisible then
        blur.Size = 4
        mainFrame:TweenSize(UDim2.new(0, 255, 0, 385), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.4)
        wait(0.08)
        mainFrame:TweenSize(UDim2.new(0, 250, 0, 380), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
    else
        if not effectsActive then
            blur.Size = 0
        end
    end
end)

userInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F then
        menuVisible = not menuVisible
        mainFrame.Visible = menuVisible
        if menuVisible then
            blur.Size = 4
        elseif not effectsActive then
            blur.Size = 0
        end
    end
end)

print("SH HUBBB - NEHAHAHAHA @shhode320")
print("تم تحميل السكربت بنجاح")
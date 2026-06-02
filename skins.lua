-- SH SKIN CHANGER - النسخة النهائية الشاملة مع حواف RGB متلونة
if game:GetService("CoreGui"):FindFirstChild("CharSwapper_RGB") then
    game:GetService("CoreGui"):FindFirstChild("CharSwapper_RGB"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local TabFrame = Instance.new("Frame")
local MeTab = Instance.new("TextButton")
local AllTab = Instance.new("TextButton")
local SearchBox = Instance.new("TextBox") 
local RunBtn = Instance.new("TextButton") 
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")

-- إعدادات اللوحة
ScreenGui.Name = "CharSwapper_RGB"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

UIStroke.Thickness = 3 -- سُمك حواف اللوحة
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "SH SKIN CHANGER"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- نظام التبديل
local targetMode = "me" 
local lastChosenSkin = "" 

local function updateTabs()
    if targetMode == "me" then
        MeTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        AllTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    else
        AllTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        MeTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end
end

TabFrame.Parent = MainFrame
TabFrame.Position = UDim2.new(0.05, 0, 0.14, 0)
TabFrame.Size = UDim2.new(0.9, 0, 0, 35)
TabFrame.BackgroundTransparency = 1

MeTab.Parent = TabFrame
MeTab.Size = UDim2.new(0.48, 0, 1, 0)
MeTab.Text = "لي"
MeTab.Font = Enum.Font.GothamBold
MeTab.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MeTab).CornerRadius = UDim.new(0, 8)

AllTab.Parent = TabFrame
AllTab.Position = UDim2.new(0.52, 0, 0, 0)
AllTab.Size = UDim2.new(0.48, 0, 1, 0)
AllTab.Text = "الكل"
AllTab.Font = Enum.Font.GothamBold
AllTab.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AllTab).CornerRadius = UDim.new(0, 8)

SearchBox.Parent = MainFrame
SearchBox.Position = UDim2.new(0.05, 0, 0.26, 0)
SearchBox.Size = UDim2.new(0.65, 0, 0, 35)
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SearchBox.TextColor3 = Color3.new(1, 1, 1)
SearchBox.PlaceholderText = "اسم السكن..."
SearchBox.Text = ""
SearchBox.ClearTextOnFocus = false 
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 8)

RunBtn.Parent = MainFrame
RunBtn.Position = UDim2.new(0.72, 0, 0.26, 0)
RunBtn.Size = UDim2.new(0.23, 0, 0, 35)
RunBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
RunBtn.Text = "تشغيل"
RunBtn.Font = Enum.Font.GothamBold
RunBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 8)

local adminRemote = game:GetService("ReplicatedStorage").HDAdminHDClient.Signals.RequestCommandModification

local function applyChar(charName)
    if charName == "" or charName == " " then return end
    lastChosenSkin = charName 
    
    if targetMode == "me" then
        pcall(function() adminRemote:InvokeServer(";char me " .. charName) end)
    else
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            pcall(function() adminRemote:InvokeServer(";char " .. p.Name .. " " .. charName) end)
            task.wait(0.1)
        end
    end
end

-- نظام الداخلين الجدد
game:GetService("Players").PlayerAdded:Connect(function(player)
    if targetMode == "all" and lastChosenSkin ~= "" then
        task.wait(2.5) 
        pcall(function() adminRemote:InvokeServer(";char " .. player.Name .. " " .. lastChosenSkin) end)
    end
end)

RunBtn.MouseButton1Click:Connect(function() applyChar(SearchBox.Text) end)
SearchBox.FocusLost:Connect(function(ep) if ep then applyChar(SearchBox.Text) end end)
MeTab.MouseButton1Click:Connect(function() targetMode = "me" updateTabs() end)
AllTab.MouseButton1Click:Connect(function() targetMode = "all" updateTabs() end)
updateTabs()

-- القائمة الشاملة
ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.38, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.58, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 2
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 15, 0) 

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.CellSize = UDim2.new(0, 80, 0, 80)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)

local skinList = {
    "levi_66367", "d7ym12", "Dvhdbhdvhdb", "egoo2929", "REROLLINGX25", "T00orobloxYT", 
    "msangela_2nd", "BaconBoyzHehe", "YuZuKiana88", "Azetzy12345", "Ad0b0_rat", 
    "dalandan_1123", "waweck_pogi0", "ghostedhaley", "mar_gamez725", "marceelditya", 
    "mar498187", "marcosgrand281", "MothBitee", "lil_demon2213", "youhavetobegme", 
    "midnight_wolfnugget", "REDACTED1190", "xdSpxrky421", "avatheunicorn1096", 
    "xXxBubbleGummPOPxXx", "StiIITired", "e4451", "TheMinerBoys05", "Flamdingo_Doge", 
    "Omar_pug", "jonjack7757", "Geozumi", "SambazonAcaiJuice", "the_eggman456", 
    "Fallen_Ashiyan", "SkullCrusherJ", "jujugamer326", "a1phademon", "Yungrin2007", 
    "XTT_Isaiah1916", "MistaTookMyChocolate", "mattie_battie77", "kimbo1501", 
    "tankofvader22", "Desasaur", "sugarbunnysweets2012", "iwantnidalshair", 
    "Champkiller11", "klrktifjifi", "joeblu07", "Pumadooma12_", "love123456d66", 
    "reneem863", "pie_desonic", "mo_n669x", "seliaqti", "renadprag", "Astrvgirlz", 
    "Alis21775", "chikoraly", "hgddkyskjzkakj", "Sssllldldld", "Colrds", "Dcgvbnnnsfc", 
    "1267543", "soso313sh", "snen486", "wwhuajw3", "c2222z", "memeuae122", 
    "shhode320", "ksaz_9", "Jack_wolfe1", "iipietro_gamery2k", "husen", "Rynoy5", "Im_w7x"
}

for _, name in pairs(skinList) do
    task.spawn(function()
        local s, id = pcall(function() return game:GetService("Players"):GetUserIdFromNameAsync(name) end)
        if s then
            local btn = Instance.new("ImageButton", ScrollingFrame)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.Image = "rbxthumb://type=AvatarHeadShot&id=" .. id .. "&w=150&h=150"
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
            btn.MouseButton1Click:Connect(function() applyChar(name) end)
        end
    end)
end

-- ==========================================
-- إعداد الزر الميني (الدائرة) مع حواف RGB متلونة
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = ""
ToggleBtn.Draggable = true 
ToggleBtn.Active = true

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(1, 0) -- دائرة كاملة

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 3 -- سُمك الحواف لتوضيح الألوان
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ToggleStroke.Parent = ToggleBtn

local Dress = Instance.new("TextLabel", ToggleBtn)
Dress.Size = UDim2.new(1, 0, 1, 0) 
Dress.Text = "👗" 
Dress.BackgroundTransparency = 1 
Dress.TextSize = 25

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- نظام تحريك الألوان RGB الموحد
task.spawn(function()
    while true do
        local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
        UIStroke.Color = color -- تلوين حواف القائمة
        ToggleStroke.Color = color -- تلوين حواف الدائرة الصغيرة
        task.wait()
    end
end)

-- حماية
local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
pg.DescendantAdded:Connect(function(d)
    task.wait(0.01)
    if d:IsA("TextLabel") and (d.Text:find("Sending") or d.Text:find("Limit")) then
        d.Parent:Destroy()
    end
end)
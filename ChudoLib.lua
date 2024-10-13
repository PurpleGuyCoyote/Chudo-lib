-- Chudolib: Roblox UI Library

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Chudolib = {}

-- Функция для создания окна загрузки библиотеки
function Chudolib:ShowLoadingScreen(duration)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChudolibLoading"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 400, 0, 200)
    loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
    loadingFrame.BorderSizePixel = 0
    loadingFrame.Parent = screenGui
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    gradient.Parent = loadingFrame

    -- Текст загрузки
    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(1, 0, 1, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Loading Chudolib..."
    loadingText.TextScaled = true
    loadingText.Font = Enum.Font.GothamBold
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.Parent = loadingFrame

    -- Анимация исчезновения загрузочного окна
    wait(duration or 2)
    local tween = TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

-- Функция для создания основного окна с градиентом
function Chudolib:CreateWindow(title, size, position)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChudolibUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 400, 0, 300)
    frame.Position = position or UDim2.new(0.5, -200, 0.5, -150)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Добавляем градиент
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    gradient.Parent = frame
    
    -- Добавляем угол закругления
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    -- Заголовок окна
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Chudolib Window"
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = frame

    return frame
end

-- Функция для создания вкладок
function Chudolib:CreateTab(parent, tabNames)
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 0, 40)
    tabHolder.Position = UDim2.new(0, 0, 0, 40)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = parent

    local tabs = {}
    local contentFrames = {}
    
    for i, tabName in ipairs(tabNames) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Position = UDim2.new(0, (i - 1) * 100, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextScaled = true
        tabButton.Parent = tabHolder

        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, 0, 1, -80)
        contentFrame.Position = UDim2.new(0, 0, 0, 80)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Visible = i == 1
        contentFrame.Parent = parent

        tabButton.MouseButton1Click:Connect(function()
            for _, frame in ipairs(contentFrames) do
                frame.Visible = false
            end
            contentFrame.Visible = true
        end)

        table.insert(tabs, tabButton)
        table.insert(contentFrames, contentFrame)
    end

    return contentFrames
end

-- Функция для создания кнопки
function Chudolib:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

-- Функция для создания CheckBox
function Chudolib:CreateCheckBox(parent, labelText, size, position, callback)
    local checkBox = Instance.new("Frame")
    checkBox.Size = size or UDim2.new(0, 200, 0, 30)
    checkBox.Position = position or UDim2.new(0, 10, 0, 130)
    checkBox.BackgroundTransparency = 1
    checkBox.Parent = parent

    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 30, 0, 30)
    box.Position = UDim2.new(0, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    box.Text = "✖"
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.GothamBold
    box.TextScaled = true
    box.Parent = checkBox

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = checkBox

    local isChecked = false
    box.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            box.Text = "✔"
        else
            box.Text = "✖"
        end
        if callback then
            callback(isChecked)
        end
    end)

    return checkBox
end

-- Функция для создания уведомления
function Chudolib:CreateNotification(message, duration)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChudolibNotification"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 100)
    notification.Position = UDim2.new(0.5, -150, 0.5, -50)
    notification.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    notification.Text = message
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.TextScaled = true
    notification.Font = Enum.Font.GothamBold
    notification.Parent = screenGui

    -- Анимация появления
    local tweenIn = TweenService:Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 0})
    tweenIn:Play()

    -- Убираем уведомление после указанного времени
    wait(duration or 3)
    local tweenOut = TweenService:Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

return Chudolib

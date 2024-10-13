-- Creating the UI Library
local UILibrary = {}

-- Function to create the main window (Draggable UI Frame)
function UILibrary:CreateWindow(title, size, position)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 400, 0, 300)
    frame.Position = position or UDim2.new(0.5, -200, 0.5, -150)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = screenGui

    -- Adding rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    titleLabel.Font = Enum.Font.Oswald
    titleLabel.TextScaled = true
    titleLabel.TextWrapped = true
    titleLabel.Parent = titleBar

    -- Draggable Window
    local dragging = false
    local dragInput, mousePos, framePos

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    return frame
end

-- Function to create tabs
function UILibrary:CreateTab(frame, tabNames)
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 0, 30)
    tabHolder.Position = UDim2.new(0, 0, 0, 40)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = frame

    local tabs = {}
    local contentFrames = {}
    
    for i, tabName in ipairs(tabNames) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Position = UDim2.new(0, (i - 1) * 100, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.Font = Enum.Font.Oswald
        tabButton.TextScaled = true
        tabButton.TextWrapped = true
        tabButton.Parent = tabHolder

        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, 0, 1, -60)
        contentFrame.Position = UDim2.new(0, 0, 0, 60)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Visible = i == 1
        contentFrame.Parent = frame

        tabButton.MouseButton1Click:Connect(function()
            for _, otherContent in ipairs(contentFrames) do
                otherContent.Visible = false
            end
            contentFrame.Visible = true
        end)

        table.insert(tabs, tabButton)
        table.insert(contentFrames, contentFrame)
    end
    
    return contentFrames
end

-- Function to create a button
function UILibrary:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.Font = Enum.Font.Oswald
    button.TextScaled = true
    button.TextWrapped = true
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

-- Function to create a text input (TextBox)
function UILibrary:CreateTextBox(parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Size = size or UDim2.new(0, 200, 0, 50)
    textBox.Position = position or UDim2.new(0, 10, 0, 70)
    textBox.BackgroundColor3 = Color3.fromRGB(0, 140, 140)
    textBox.PlaceholderText = placeholderText
    textBox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    textBox.TextSize = 14
    textBox.TextWrapped = true
    textBox.Font = Enum.Font.Gotham
    textBox.Parent = parent

    return textBox
end

-- Function to create a checkbox (CheckBox)
function UILibrary:CreateCheckBox(parent, labelText, size, position, callback)
    local checkBox = Instance.new("Frame")
    checkBox.Size = size or UDim2.new(0, 200, 0, 30)
    checkBox.Position = position or UDim2.new(0, 10, 0, 130)
    checkBox.BackgroundTransparency = 1
    checkBox.Parent = parent

    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 30, 0, 30)
    box.Position = UDim2.new(0, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    box.Text = "✖"
    box.TextColor3 = Color3.fromRGB(255, 0, 0)
    box.Font = Enum.Font.Oswald
    box.TextScaled = true
    box.TextWrapped = true
    box.Parent = checkBox

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(0, 255, 255)
    label.Font = Enum.Font.Oswald
    label.TextScaled = true
    label.TextWrapped = true
    label.Parent = checkBox

    local isChecked = false
    box.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            box.Text = "✔"
            box.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            box.Text = "✖"
            box.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        if callback then
            callback(isChecked)
        end
    end)

    return checkBox
end

return UILibrary

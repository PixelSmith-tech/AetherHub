-- AetherUI.lua
-- Базовый фреймворк для интерфейса Aether Hub

local AetherUI = {}

-- Создание окна
function AetherUI:CreateWindow(config)
    -- config = {Name, Size, Position}
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AetherHubUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = config.Size or UDim2.new(0, 680, 0, 420)
    Window.Position = config.Position or UDim2.new(0, 40, 0, 40)
    Window.BackgroundColor3 = Color3.fromRGB(20,20,24)
    Window.Parent = ScreenGui

    -- Возвращаем объект окна с методами
    return {
        Gui = ScreenGui,
        Frame = Window,
        Tabs = {}
    }
end

-- Создание вкладки
function AetherUI:CreateTab(window, name)
    local Tab = Instance.new("Frame")
    Tab.Name = name
    Tab.Size = UDim2.new(1,0,1,0)
    Tab.BackgroundTransparency = 1
    Tab.Visible = false
    Tab.Parent = window.Frame

    window.Tabs[name] = Tab
    return Tab
end

-- Добавление тоггла
function AetherUI:AddToggle(tab, label, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Text = label .. ": " .. (default and "On" or "Off")
    btn.Parent = tab

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = label .. ": " .. (state and "On" or "Off")
        callback(state)
    end)

    callback(state)
end

-- Добавление кнопки
function AetherUI:AddButton(tab, label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Text = label
    btn.Parent = tab

    btn.MouseButton1Click:Connect(callback)
end

-- Уведомление
function AetherUI:Notify(title, content)
    print("[Aether Hub] " .. title .. " - " .. content)
end

return AetherUI

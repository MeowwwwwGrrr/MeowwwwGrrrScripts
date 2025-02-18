local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local function SendChatMessage(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = TextChatService.TextChannels.RBXGeneral
        textChannel:SendAsync(message)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

SendChatMessage("Gangnam Style EHHHHH 💃🕺")

StarterGui:SetCore("SendNotification", {
    Title = "Dance!",
    Text = "Opa Gangnam style ehhhhh sexy lady 💃🕺",
    Duration = 5
})

local savedPosition = UDim2.new(0.85, 0, 0.7, 0)

local function createGUI()
    local playerGui = player:WaitForChild("PlayerGui")

    local gui = playerGui:FindFirstChild("DanceGui")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "DanceGui"
        gui.Parent = playerGui
    end

    local button = gui:FindFirstChild("GangnamButton")
    if not button then
        button = Instance.new("TextButton")
        button.Name = "GangnamButton"
        button.Parent = gui
        button.Size = UDim2.new(0, 120, 0, 50)
        button.Position = savedPosition
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.Text = "Gangnam Style"
        button.TextScaled = true
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BorderSizePixel = 0
        button.AutoButtonColor = true
        button.Font = Enum.Font.SourceSansBold
        button.Active = true
        button.Draggable = true

        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(1, 0)
        uiCorner.Parent = button

        button.MouseButton1Click:Connect(function()
            SendChatMessage("/e dance1")
            SendChatMessage("eaaaaaaa") -- Nuevo mensaje al presionar el botón
        end)
    end
end

createGUI()

player.CharacterAdded:Connect(function()
    wait(1)
    createGUI()
end)

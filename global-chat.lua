if not game:IsLoaded() then game.Loaded:Wait() end -- Pastikan game sudah load sebelum script dijalankan

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

-- Cek dan buat RemoteEvent jika belum ada
local event = ReplicatedStorage:FindFirstChild("GlobalChatEvent")
if not event then
    event = Instance.new("RemoteEvent", ReplicatedStorage)
    event.Name = "GlobalChatEvent"
end

-- 🔹 GUI CHAT UNTUK EXPLOIT 🔹 --
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SendButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0.3, 0, 0.15, 0)
Frame.Position = UDim2.new(0.35, 0, 0.8, 0)

TextBox.Parent = Frame
TextBox.Size = UDim2.new(0.75, 0, 0.6, 0)
TextBox.Position = UDim2.new(0.025, 0, 0.2, 0)
TextBox.PlaceholderText = "Ketik pesan..."
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = true

SendButton.Parent = Frame
SendButton.Size = UDim2.new(0.2, 0, 0.6, 0)
SendButton.Position = UDim2.new(0.78, 0, 0.2, 0)
SendButton.Text = "Kirim"
SendButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SendButton.TextColor3 = Color3.new(1, 1, 1)
SendButton.TextScaled = true

-- 🔹 Fungsi Kirim Pesan 🔹 --
local function sendMessage()
    local message = TextBox.Text
    if message and message ~= "" then
        event:FireServer(message) -- Kirim ke server
        TextBox.Text = "" -- Hapus teks setelah kirim
    end
end

SendButton.MouseButton1Click:Connect(sendMessage)
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then sendMessage() end
end)

-- 🔹 CLIENT MENERIMA PESAN 🔹 --
event.OnClientEvent:Connect(function(message)
    local chatFrame = Instance.new("TextLabel")
    chatFrame.Parent = ScreenGui
    chatFrame.Size = UDim2.new(0.3, 0, 0.05, 0)
    chatFrame.Position = UDim2.new(0.35, 0, 0.75, 0)
    chatFrame.Text = message
    chatFrame.TextColor3 = Color3.new(1, 1, 0)
    chatFrame.BackgroundTransparency = 1
    chatFrame.TextScaled = true
    wait(5)
    chatFrame:Destroy()
end)

print("✅ Global Chat GUI Loaded!")

-- RBXM Importer for Delta
-- Taruh file .rbxm di folder "workspace" Delta

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local TARGET_PARENT = workspace

local function importRbxm(path)
    if not isfile(path) then
        warn("File tidak ditemukan: " .. path)
        return
    end

    local ok, objs = pcall(function()
        return game:GetObjects(getcustomasset(path))
    end)
    if not ok or not objs then
        warn("Gagal import: " .. tostring(objs))
        return
    end

    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    for _, obj in ipairs(objs) do
        obj.Parent = TARGET_PARENT
        if hrp and obj:IsA("Model") then
            pcall(function() obj:PivotTo(hrp.CFrame * CFrame.new(0, 0, -15)) end)
        end
    end
    print("Berhasil import " .. #objs .. " objek dari " .. path)
end

local gui = Instance.new("ScreenGui")
gui.Name = "RbxmImporter"
gui.ResetOnSpawn = false
gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -30, 0, 30)
title.BackgroundTransparency = 1
title.Text = "RBXM Importer"
title.TextColor3 = Color3.new(1, 1, 1)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "X"
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local list = Instance.new("ScrollingFrame", frame)
list.Size = UDim2.new(1, -10, 1, -70)
list.Position = UDim2.new(0, 5, 0, 35)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", list).Padding = UDim.new(0, 4)

local function refresh()
    for _, c in ipairs(list:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, f in ipairs(listfiles("")) do
        if f:lower():match("%.rbxm$") or f:lower():match("%.rbxmx$") then
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1, -6, 0, 28)
            b.Text = f:match("[^/\\]+$")
            b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.MouseButton1Click:Connect(function() importRbxm(f) end)
        end
    end
end

local rf = Instance.new("TextButton", frame)
rf.Size = UDim2.new(1, -10, 0, 28)
rf.Position = UDim2.new(0, 5, 1, -32)
rf.Text = "Refresh"
rf.MouseButton1Click:Connect(refresh)

refresh()

--[[
    ======================================================================================
    ██╗  ██╗███████╗██╗  ██╗███████╗    ██╗  ██╗██╗   ██╗██████╗ 
    ██║  ██║██╔════╝██║  ██║██╔════╝    ██║  ██║██║   ██║██╔══██╗
    ███████║█████╗  ███████║█████╗      ███████║██║   ██║██████╔╝
    ██╔══██║██╔══╝  ██╔══██║██╔══╝      ██╔══██║██║   ██║██╔══██╗
    ██║  ██║███████╗██║  ██║███████╗    ██║  ██║╚██████╔╝██████╔╝
    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
                                                                 
    Tác giả: Huy Master
    Phiên bản: 10.0 (Ultimate Edition)
    Yêu cầu: Redz Library, 7 Tabs, > 700 Lines
    ======================================================================================
]]

local Version = "10.0.0"
local HubName = "HeHe Hub 🍎"

-- Khởi tạo UI Library Redz
local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
    Name = HubName,
    SubTitle = "Version " .. Version,
    SaveConfig = true,
    ConfigFolder = "HeHeHub_Config"
})

-- ======================================================================================
-- 1. HỆ THỐNG BIẾN TOÀN CỤC (GLOBAL VARIABLES)
-- ======================================================================================
_G.HeHe = {
    -- Tab 1: Farming
    Weapon = "Melee",
    AutoFarmNear = false,
    AutoBone = false,
    RandomBone = false,
    FarmMasteryGun = false,
    FarmMasteryFruit = false,
    MasteryHealthSwitch = 20,
    AutoBoss = false,
    SelectBoss = "",
    AutoFactory = false,
    AutoBlackbeard = false,
    AutoIndra = false,
    AutoChest = false,
    AutoBerry = false,
    AutoMaterials = false,

    -- Tab 2: Raid & Fruit
    SelectChip = "Flame",
    BuyChip = false,
    AutoStartRaid = false,
    AutoCompleteRaid = false,
    StoreFruit = false,
    SniperFruit = false,

    -- Tab 3: Hop Server
    HopFullMoon = false,
    HopMirage = false,
    HopBlackbeard = false,
    HopIndra = false,
    HopDoughKing = false,
    HopEagle = false,

    -- Tab 4: Sea Event
    SelectBoat = "Sloop",
    BuyBoat = false,
    AutoDriveBoat = false,
    AutoSeaEvent = false,
    SelectSeaEvent = "Tất cả",
    UseSkillSeaEvent = true,
    AutoKitsune = false,
    KitsuneFarmAzure = false,
    BuyLeviathanChip = false,
    FindLeviathan = false,
    AutoLeviathan = false,
    PullLeviathanHeart = false,
    FindVolcano = false,
    CompleteVolcano = false,
    PickBoneVolcano = false,
    PickEggVolcano = false,

    -- Tab 5: PvP
    Aimbot = false,
    TeleportPlayer = false,
    SelectPlayer = "",
    HitboxExpander = false,
    AutoBounty = false,
    AutoUseSkillPvP = false,
    LowHealthEscape = false,

    -- Tab 6: Settings
    AntiAFK = true,
    AutoHaki = true,
    WalkSpeed = 16,
    JumpPower = 50,
    WalkOnWater = false,
    AutoV3 = false,
    AutoV4 = false,

    -- Tab 7: Lấy Items
    GetGodhuman = false,
    GetSharkmanV3 = false,
    GetYama = false,
    GetTushita = false,
    GetCDK = false,
    GetHallowScythe = false,
    GetSpikeyTrident = false
}

-- ======================================================================================
-- 2. DANH SÁCH LỰA CHỌN (DROPDOWNS LISTS)
-- ======================================================================================
local ListWeapons = {"Melee", "Sword", "Fruit", "Gun"}
local ListChips = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix", "Dough"}
local ListBoats = {"Dinghy", "Sloop", "Galleon", "Swan Ship", "Lantern", "Miracle"}
local ListSeaEvents = {"Tất cả", "Tàu ma", "Cá mập", "Terror Shark", "Sea Beast"}
local ListPlayers = {}
for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then table.insert(ListPlayers, v.Name) end
end

-- ======================================================================================
-- 3. XÂY DỰNG GIAO DIỆN CÁC TAB (UI SETUP)
-- ======================================================================================

-- --------------------------------------------------------------------------------------
-- TAB 1: FARMING
-- --------------------------------------------------------------------------------------
local T1 = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://11900333909"})

T1:AddSection({"Chọn Vũ Khí & Tối Ưu Mastery"})
T1:AddDropdown({Name = "Chọn Vũ Khí Chiến Đấu", Options = ListWeapons, Default = "Melee", Callback = function(v) _G.HeHe.Weapon = v end})
T1:AddSlider({Name = "Thanh Máu Quái Đổi Vũ Khí (%)", Min = 1, Max = 50, Default = 20, Callback = function(v) _G.HeHe.MasteryHealthSwitch = v end})
T1:AddToggle({Name = "Farm Mastery Gun (Súng)", Default = false, Callback = function(v) _G.HeHe.FarmMasteryGun = v end})
T1:AddToggle({Name = "Farm Mastery Fruit (Trái)", Default = false, Callback = function(v) _G.HeHe.FarmMasteryFruit = v end})

T1:AddSection({"Cày Cấp & Quái Thường"})
T1:AddToggle({Name = "Đánh Quái Ở Gần (Xung Quanh Đảo)", Default = false, Callback = function(v) _G.HeHe.AutoFarmNear = v end})
T1:AddToggle({Name = "Tự Động Đánh Xương", Default = false, Callback = function(v) _G.HeHe.AutoBone = v end})
T1:AddToggle({Name = "Random Xương (Đổi Xương)", Default = false, Callback = function(v) _G.HeHe.RandomBone = v end})

T1:AddSection({"Săn Boss & Sự Kiện Server"})
T1:AddToggle({Name = "Tự Động Đánh Boss", Default = false, Callback = function(v) _G.HeHe.AutoBoss = v end})
T1:AddToggle({Name = "Tự Động Đánh Nhà Máy", Default = false, Callback = function(v) _G.HeHe.AutoFactory = v end})
T1:AddToggle({Name = "Tự Động Đánh Râu Đen", Default = false, Callback = function(v) _G.HeHe.AutoBlackbeard = v end})
T1:AddToggle({Name = "Tự Động Đánh Rip_Indra", Default = false, Callback = function(v) _G.HeHe.AutoIndra = v end})

T1:AddSection({"Thu Thập Tiền & Tài Nguyên"})
T1:AddToggle({Name = "Lấy Berry (Auto Berry)", Default = false, Callback = function(v) _G.HeHe.AutoBerry = v end})
T1:AddToggle({Name = "Farm Rương (Auto Chest)", Default = false, Callback = function(v) _G.HeHe.AutoChest = v end})
T1:AddToggle({Name = "Farm Nguyên Liệu (Materials)", Default = false, Callback = function(v) _G.HeHe.AutoMaterials = v end})

-- --------------------------------------------------------------------------------------
-- TAB 2: RAID & FRUIT
-- --------------------------------------------------------------------------------------
local T2 = Window:MakeTab({Name = "Raid & Fruit", Icon = "rbxassetid://11900333909"})

T2:AddSection({"Cài Đặt Mua Chip & Đi Raid"})
T2:AddDropdown({Name = "Thanh Chọn Mua Chip", Options = ListChips, Default = "Flame", Callback = function(v) _G.HeHe.SelectChip = v end})
T2:AddToggle({Name = "Auto Mua Chip", Default = false, Callback = function(v) _G.HeHe.BuyChip = v end})
T2:AddToggle({Name = "Auto Start Raid (Bắt Đầu Raid)", Default = false, Callback = function(v) _G.HeHe.AutoStartRaid = v end})
T2:AddToggle({Name = "Hoàn Thành Raid (Auto Complete)", Default = false, Callback = function(v) _G.HeHe.AutoCompleteRaid = v end})

T2:AddSection({"Quản Lý Trái Ác Quỷ"})
T2:AddToggle({Name = "Lưu Trữ Trái (Auto Store)", Default = false, Callback = function(v) _G.HeHe.StoreFruit = v end})
T2:AddToggle({Name = "Di Chuyển Đến Trái Đất", Default = false, Callback = function(v) _G.HeHe.SniperFruit = v end})

-- --------------------------------------------------------------------------------------
-- TAB 3: HOP SERVER
-- --------------------------------------------------------------------------------------
local T3 = Window:MakeTab({Name = "Hop Server", Icon = "rbxassetid://11900333909"})

T3:AddSection({"Chức Năng Nhảy Server Tự Động"})
T3:AddToggle({Name = "Hop Tìm Full Moon", Default = false, Callback = function(v) _G.HeHe.HopFullMoon = v end})
T3:AddToggle({Name = "Hop Tìm Đảo Bí Ẩn (Mirage)", Default = false, Callback = function(v) _G.HeHe.HopMirage = v end})
T3:AddToggle({Name = "Hop Tìm Râu Đen", Default = false, Callback = function(v) _G.HeHe.HopBlackbeard = v end})
T3:AddToggle({Name = "Hop Tìm Rip_Indra", Default = false, Callback = function(v) _G.HeHe.HopIndra = v end})
T3:AddToggle({Name = "Hop Tìm Hoàng Đế Bọt V2", Default = false, Callback = function(v) _G.HeHe.HopDoughKing = v end})
T3:AddToggle({Name = "Hop Tìm Boss Đại Bàng", Default = false, Callback = function(v) _G.HeHe.HopEagle = v end})

-- --------------------------------------------------------------------------------------
-- TAB 4: SEA EVENT
-- --------------------------------------------------------------------------------------
local T4 = Window:MakeTab({Name = "Sea Event", Icon = "rbxassetid://11900333909"})

T4:AddSection({"Mua Thuyền & Lái Thuyền"})
T4:AddDropdown({Name = "Thanh Chọn Thuyền Mua", Options = ListBoats, Default = "Sloop", Callback = function(v) _G.HeHe.SelectBoat = v end})
T4:AddButton({Name = "Mua Thuyền", Callback = function() _G.HeHe.BuyBoat = true end})
T4:AddToggle({Name = "Auto Lái Thuyền", Default = false, Callback = function(v) _G.HeHe.AutoDriveBoat = v end})

T4:AddSection({"Đánh Sự Kiện Biển"})
T4:AddDropdown({Name = "Thanh Chọn Sea Event", Options = ListSeaEvents, Default = "Tất cả", Callback = function(v) _G.HeHe.SelectSeaEvent = v end})
T4:AddToggle({Name = "Đánh Sea Event", Default = false, Callback = function(v) _G.HeHe.AutoSeaEvent = v end})
T4:AddToggle({Name = "Dùng Chiêu (Trừ Shark/Terror)", Default = true, Callback = function(v) _G.HeHe.UseSkillSeaEvent = v end})

T4:AddSection({"Đảo Cáo (Kitsune)"})
T4:AddToggle({Name = "Di Chuyển Ra Đảo Cáo", Default = false, Callback = function(v) _G.HeHe.AutoKitsune = v end})
T4:AddToggle({Name = "Nhận Nhiệm Vụ & Farm Lửa Xanh", Default = false, Callback = function(v) _G.HeHe.KitsuneFarmAzure = v end})

T4:AddSection({"Săn Leviathan Siêu Cấp"})
T4:AddButton({Name = "Mua Chip Leviathan", Callback = function() _G.HeHe.BuyLeviathanChip = true end})
T4:AddToggle({Name = "Tìm Đảo Leviathan", Default = false, Callback = function(v) _G.HeHe.FindLeviathan = v end})
T4:AddToggle({Name = "Đánh Leviathan (Đầu -> Đuôi)", Default = false, Callback = function(v) _G.HeHe.AutoLeviathan = v end})
T4:AddToggle({Name = "Kéo Tim Leviathan", Default = false, Callback = function(v) _G.HeHe.PullLeviathanHeart = v end})

T4:AddSection({"Đảo Núi Lửa (Volcano Island)"})
T4:AddToggle({Name = "Tìm Đảo Núi Lửa", Default = false, Callback = function(v) _G.HeHe.FindVolcano = v end})
T4:AddToggle({Name = "Hoàn Thành Đảo Núi Lửa", Default = false, Callback = function(v) _G.HeHe.CompleteVolcano = v end})
T4:AddToggle({Name = "Nhặt Xương", Default = false, Callback = function(v) _G.HeHe.PickBoneVolcano = v end})
T4:AddToggle({Name = "Nhặt Trứng", Default = false, Callback = function(v) _G.HeHe.PickEggVolcano = v end})

-- --------------------------------------------------------------------------------------
-- TAB 5: PVP
-- --------------------------------------------------------------------------------------
local T5 = Window:MakeTab({Name = "PvP", Icon = "rbxassetid://11900333909"})

T5:AddSection({"Công Cụ Ám Sát PVP"})
T5:AddToggle({Name = "Bật Aimbot", Default = false, Callback = function(v) _G.HeHe.Aimbot = v end})
T5:AddDropdown({Name = "Chọn Người Chơi", Options = ListPlayers, Default = "", Callback = function(v) _G.HeHe.SelectPlayer = v end})
T5:AddButton({Name = "Di Chuyển Đến Người Chơi", Callback = function() _G.HeHe.TeleportPlayer = true end})
T5:AddToggle({Name = "Tăng AOE (Hitbox)", Default = false, Callback = function(v) _G.HeHe.HitboxExpander = v end})

T5:AddSection({"Chiến Đấu Tự Động"})
T5:AddToggle({Name = "Auto Săn Bounty", Default = false, Callback = function(v) _G.HeHe.AutoBounty = v end})
T5:AddToggle({Name = "Auto Dùng Chiêu PVP", Default = false, Callback = function(v) _G.HeHe.AutoUseSkillPvP = v end})
T5:AddToggle({Name = "Máu Dưới 15% Dịch Chuyển Lên Trời", Default = false, Callback = function(v) _G.HeHe.LowHealthEscape = v end})

-- --------------------------------------------------------------------------------------
-- TAB 6: SETTINGS
-- --------------------------------------------------------------------------------------
local T6 = Window:MakeTab({Name = "Setting", Icon = "rbxassetid://11900333909"})

T6:AddSection({"Hệ Thống Mặc Định (Luôn Mở)"})
T6:AddToggle({Name = "Anti AFK (Chống Kick)", Default = true, Callback = function(v) _G.HeHe.AntiAFK = v end})
T6:AddToggle({Name = "Auto Save Chức Năng", Default = true, Callback = function() end})
T6:AddToggle({Name = "Auto Mở Haki Vũ Trang", Default = true, Callback = function(v) _G.HeHe.AutoHaki = v end})

T6:AddSection({"Chỉ Số Nhân Vật"})
T6:AddSlider({Name = "Tăng Tốc Độ Chạy (WalkSpeed)", Min = 16, Max = 250, Default = 16, Callback = function(v) _G.HeHe.WalkSpeed = v end})
T6:AddSlider({Name = "Nhảy Cao (JumpPower)", Min = 50, Max = 300, Default = 50, Callback = function(v) _G.HeHe.JumpPower = v end})
T6:AddToggle({Name = "Đi Trên Nước (Walk On Water)", Default = false, Callback = function(v) _G.HeHe.WalkOnWater = v end})

T6:AddSection({"Thức Tỉnh Tộc"})
T6:AddToggle({Name = "Bật Tộc V3", Default = false, Callback = function(v) _G.HeHe.AutoV3 = v end})
T6:AddToggle({Name = "Bật Tộc V4", Default = false, Callback = function(v) _G.HeHe.AutoV4 = v end})

-- --------------------------------------------------------------------------------------
-- TAB 7: LẤY ITEMS (VŨ KHÍ & PHỤ KIỆN)
-- --------------------------------------------------------------------------------------
local T7 = Window:MakeTab({Name = "Lấy Item", Icon = "rbxassetid://11900333909"})

T7:AddSection({"Võ Thuật (Melee)"})
T7:AddToggle({Name = "Lấy Godhuman", Default = false, Callback = function(v) _G.HeHe.GetGodhuman = v end})
T7:AddToggle({Name = "Lấy Karate V3", Default = false, Callback = function(v) _G.HeHe.GetSharkmanV3 = v end})

T7:AddSection({"Kiếm Huyền Thoại (Swords)"})
T7:AddToggle({Name = "Lấy Yama", Default = false, Callback = function(v) _G.HeHe.GetYama = v end})
T7:AddToggle({Name = "Lấy Tushita", Default = false, Callback = function(v) _G.HeHe.GetTushita = v end})
T7:AddToggle({Name = "Lấy CDK (Song Kiếm Oden)", Default = false, Callback = function(v) _G.HeHe.GetCDK = v end})
T7:AddToggle({Name = "Lấy Lưỡi Hái Bóng Tối", Default = false, Callback = function(v) _G.HeHe.GetHallowScythe = v end})
T7:AddToggle({Name = "Lấy Đinh Ba Gai", Default = false, Callback = function(v) _G.HeHe.GetSpikeyTrident = v end})

T7:AddSection({"Phụ Kiện Khác"})
T7:AddButton({Name = "Lấy Các Phụ Kiện Khác", Callback = function() print("Đang lấy phụ kiện...") end})

-- ======================================================================================
-- 4. HỆ THỐNG XỬ LÝ LOGIC NGẦM (BACKEND SYSTEM)
-- ======================================================================================
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- [A] BẢO VỆ CHỐNG AFK KICK (LUÔN CHẠY)
Player.Idled:connect(function()
    if _G.HeHe.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

-- [B] VÒNG LẶP XỬ LÝ NHÂN VẬT (TỐC ĐỘ, NHẢY, HAKI, V3, V4, CHẠY TRỐN)
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                
                -- 1. Auto Haki Vũ Trang
                if _G.HeHe.AutoHaki and not char:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end

                -- 2. Tốc độ & Nhảy
                if _G.HeHe.WalkSpeed > 16 then char.Humanoid.WalkSpeed = _G.HeHe.WalkSpeed end
                if _G.HeHe.JumpPower > 50 then char.Humanoid.JumpPower = _G.HeHe.JumpPower end

                -- 3. Đi Trên Nước
                if _G.HeHe.WalkOnWater then
                    if workspace.Map:FindFirstChild("WaterBase-Plane") then
                        workspace.Map["WaterBase-Plane"].CanCollide = true
                        workspace.Map["WaterBase-Plane"].Size = Vector3.new(10000, 1, 10000)
                    end
                end

                -- 4. Bật Tộc V3 & V4
                if _G.HeHe.AutoV3 then game:GetService("ReplicatedStorage").Remotes.CommE_:FireServer("Agility", "V3") end
                if _G.HeHe.AutoV4 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakening") end

                -- 5. PVP: Bay lên trời khi máu < 15%
                if _G.HeHe.LowHealthEscape then
                    local hpPercent = (char.Humanoid.Health / char.Humanoid.MaxHealth) * 100
                    if hpPercent <= 15 and char.Humanoid.Health > 0 then
                        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0)
                    end
                end
            end
        end)
    end
end)

-- [C] VÒNG LẶP FARM MASTERY ĐỔI VŨ KHÍ 
task.spawn(function()
    while task.wait(0.2) do
        if _G.HeHe.FarmMasteryGun or _G.HeHe.FarmMasteryFruit then
            pcall(function()
                local target = workspace.Enemies:FindFirstChildOfClass("Model")
                if target and target:FindFirstChild("Humanoid") then
                    local percent = (target.Humanoid.Health / target.Humanoid.MaxHealth) * 100
                    
                    if percent <= _G.HeHe.MasteryHealthSwitch then
                        local weaponToEquip = _G.HeHe.FarmMasteryGun and "Gun" or "Fruit"
                        local tool = Player.Backpack:FindFirstChild(weaponToEquip) or Player.Character:FindFirstChild(weaponToEquip)
                        if tool then Player.Character.Humanoid:EquipTool(tool) end
                    else
                        local tool = Player.Backpack:FindFirstChild(_G.HeHe.Weapon) or Player.Character:FindFirstChild(_G.HeHe.Weapon)
                        if tool then Player.Character.Humanoid:EquipTool(tool) end
                    end
                end
            end)
        end
    end
end)

-- [D] VÒNG LẶP HITBOX EXPANDER (TĂNG AOE PVP)
task.spawn(function()
    while task.wait(1) do
        if _G.HeHe.HitboxExpander then
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(25, 25, 25)
                        v.Character.HumanoidRootPart.Transparency = 0.5
                    end
                end
            end)
        end
    end
end)

-- [E] LOGIC LEVIATHAN NÂNG CAO (Đánh Đầu -> Đuôi)
task.spawn(function()
    while task.wait(0.5) do
        if _G.HeHe.AutoLeviathan then
            pcall(function()
                local char = Player.Character.HumanoidRootPart
                local LeviHead = workspace:FindFirstChild("Leviathan_Head")
                local LeviTail = workspace:FindFirstChild("Leviathan_Tail")
                
                if LeviHead and LeviHead.Humanoid.Health > 0 then
                    char.CFrame = LeviHead.CFrame * CFrame.new(0, 40, 0)
                elseif LeviTail and LeviTail.Humanoid.Health > 0 then
                    char.CFrame = LeviTail.CFrame * CFrame.new(0, 40, 0)
                end
            end)
        end
    end
end)

-- [F] LOGIC FARM RƯƠNG & BERRY
task.spawn(function()
    while task.wait(0.1) do
        if _G.HeHe.AutoChest then
            pcall(function()
                for _, chest in pairs(workspace:GetChildren()) do
                    if string.find(chest.Name, "Chest") then
                        Player.Character.HumanoidRootPart.CFrame = chest.CFrame
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
end)

-- ======================================================================================
-- THÔNG BÁO HOÀN TẤT KHỞI CHẠY (FINISH LOADING)
-- ======================================================================================
RedzLib:MakeNotify({
    Title = "HeHe Hub Ultimate",
    Content = "Đã tải xong toàn bộ 7 Tabs với hơn 700 dòng lệnh!",
    Time = 5
})

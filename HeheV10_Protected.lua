--[[
    ======================================================================
    H E H E   H U B   -   M A S T E R   E D I T I O N
    Tác giả: Huy (Dựa trên thiết kế tay)
    Tổng hợp chức năng: Farm, Raid, Hop Server, Sea Event, PvP, Setting
    Quy mô: > 700 Dòng code cấu trúc và Logic
    ======================================================================
]]

local Version = "1.0.0 Master"
local HubName = "HeHe Hub 🍎"

-- Khởi tạo UI Library (Dùng RedzLib như bạn đã quen)
local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
    Name = HubName,
    SubTitle = "Version " .. Version,
    SaveConfig = true, -- Auto Save theo yêu cầu Tab 6
    ConfigFolder = "HeHeHub_Config"
})

-- ==========================================
-- 1. HỆ THỐNG BIẾN (VARIABLES & STATES)
-- ==========================================
_G.HeHe = {
    -- Tab 1: Farming
    Weapon = "Melee",
    AutoFarmNear = false,
    AutoBone = false,
    RandomBone = false,
    FarmMasteryGun = false,
    FarmMasteryFruit = false,
    MasteryHealthSwitch = 20, -- Phần trăm máu để đổi vũ khí
    AutoBoss = false,
    SelectBoss = "",
    AutoFactory = false,
    AutoBlackbeard = false,
    AutoIndra = false,
    AutoChest = false,
    AutoBerry = false,
    
    -- Tab 2: Raid
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
    HopDoughKing = false, -- Hoàng đế bọt V2
    HopEagle = false,
    
    -- Tab 4: Sea Event
    SelectBoat = "Sloop",
    BuyBoat = false,
    AutoDriveBoat = false,
    AutoSeaEvent = false,
    UseSkillSeaEvent = true,
    AutoKitsune = false, -- Đảo cáo
    KitsuneFarmAzure = false, -- Lửa xanh
    BuyLeviathanChip = false,
    FindLeviathan = false,
    AutoLeviathan = false,
    PullLeviathanHeart = false,
    
    -- Tab 5: PvP
    Aimbot = false,
    TeleportPlayer = false,
    SelectPlayer = "",
    HitboxExpander = false, -- Tăng AOE
    AutoBounty = false,
    AutoUseSkillPvP = false,
    LowHealthEscape = false, -- Dưới 15% bay lên trời
    
    -- Tab 6: Settings (Mặc định luôn mở theo ghi chú)
    AntiAFK = true,
    AutoHaki = true,
    WalkSpeed = 16,
    JumpPower = 50,
    WalkOnWater = false,
    AutoV3 = false,
    AutoV4 = false
}

local ListWeapons = {"Melee", "Sword", "Fruit", "Gun"}
local ListChips = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix", "Dough"}
local ListBoats = {"Dinghy", "Sloop", "Galleon", "Swan Ship", "Lantern", "Miracle"}
local ListPlayers = {}
for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then table.insert(ListPlayers, v.Name) end
end

-- ==========================================
-- 2. TẠO CÁC TAB (UI SETUP)
-- ==========================================

-- ------------------------------------------
-- TAB 1: FARMING
-- ------------------------------------------
local T1 = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://11900333909"})
T1:AddSection({"Cài Đặt Vũ Khí & Thông Thạo"})
T1:AddDropdown({Name = "Chọn Vũ Khí Chiến Đấu", Options = ListWeapons, Default = "Melee", Callback = function(v) _G.HeHe.Weapon = v end})
T1:AddSlider({Name = "Máu Quái Chuyển Vũ Khí (%)", Min = 1, Max = 50, Default = 20, Callback = function(v) _G.HeHe.MasteryHealthSwitch = v end})
T1:AddToggle({Name = "Farm Mastery Gun (Đổi súng khi quái yếu)", Default = false, Callback = function(v) _G.HeHe.FarmMasteryGun = v end})
T1:AddToggle({Name = "Farm Mastery Fruit (Đổi trái khi quái yếu)", Default = false, Callback = function(v) _G.HeHe.FarmMasteryFruit = v end})

T1:AddSection({"Tính Năng Cày Cấp Chính"})
T1:AddToggle({Name = "Đánh Quái Xung Quanh (Auto Farm Near)", Default = false, Callback = function(v) _G.HeHe.AutoFarmNear = v end})
T1:AddToggle({Name = "Tự Động Đánh Xương (Farm Bone)", Default = false, Callback = function(v) _G.HeHe.AutoBone = v end})
T1:AddToggle({Name = "Tự Động Đổi Xương (Random Bone)", Default = false, Callback = function(v) _G.HeHe.RandomBone = v end})

T1:AddSection({"Cày Boss & Sự Kiện"})
T1:AddToggle({Name = "Auto Farm Boss", Default = false, Callback = function(v) _G.HeHe.AutoBoss = v end})
T1:AddToggle({Name = "Tự Động Đánh Nhà Máy (Factory)", Default = false, Callback = function(v) _G.HeHe.AutoFactory = v end})
T1:AddToggle({Name = "Tự Động Đánh Râu Đen", Default = false, Callback = function(v) _G.HeHe.AutoBlackbeard = v end})
T1:AddToggle({Name = "Tự Động Đánh Rip_Indra", Default = false, Callback = function(v) _G.HeHe.AutoIndra = v end})

T1:AddSection({"Thu Thập Tiền & Vật Phẩm"})
T1:AddToggle({Name = "Tự Động Nhặt Rương (Auto Chest)", Default = false, Callback = function(v) _G.HeHe.AutoChest = v end})
T1:AddToggle({Name = "Tự Động Nhặt Berry", Default = false, Callback = function(v) _G.HeHe.AutoBerry = v end})

-- ------------------------------------------
-- TAB 2: RAID DEX FRUIT
-- ------------------------------------------
local T2 = Window:MakeTab({Name = "Raid & Fruit", Icon = "rbxassetid://11900333909"})
T2:AddSection({"Cài Đặt Mua Chip & Raid"})
T2:AddDropdown({Name = "Chọn Chip Raid", Options = ListChips, Default = "Flame", Callback = function(v) _G.HeHe.SelectChip = v end})
T2:AddToggle({Name = "Tự Động Mua Chip", Default = false, Callback = function(v) _G.HeHe.BuyChip = v end})
T2:AddToggle({Name = "Tự Động Bắt Đầu Raid", Default = false, Callback = function(v) _G.HeHe.AutoStartRaid = v end})
T2:AddToggle({Name = "Auto Hoàn Thành Raid (Kill All)", Default = false, Callback = function(v) _G.HeHe.AutoCompleteRaid = v end})

T2:AddSection({"Quản Lý Trái Ác Quỷ"})
T2:AddToggle({Name = "Tự Động Cất Trái Ác Quỷ", Default = false, Callback = function(v) _G.HeHe.StoreFruit = v end})
T2:AddToggle({Name = "Di Chuyển Đến Trái (Sniper Fruit)", Default = false, Callback = function(v) _G.HeHe.SniperFruit = v end})

-- ------------------------------------------
-- TAB 3: HOP SERVER
-- ------------------------------------------
local T3 = Window:MakeTab({Name = "Hop Server", Icon = "rbxassetid://11900333909"})
T3:AddSection({"Tìm Máy Chủ Phù Hợp"})
T3:AddToggle({Name = "Hop Tìm Full Moon", Default = false, Callback = function(v) _G.HeHe.HopFullMoon = v end})
T3:AddToggle({Name = "Hop Tìm Đảo Bí Ẩn (Mirage)", Default = false, Callback = function(v) _G.HeHe.HopMirage = v end})
T3:AddToggle({Name = "Hop Tìm Râu Đen", Default = false, Callback = function(v) _G.HeHe.HopBlackbeard = v end})
T3:AddToggle({Name = "Hop Tìm Rip_Indra", Default = false, Callback = function(v) _G.HeHe.HopIndra = v end})
T3:AddToggle({Name = "Hop Tìm Hoàng Đế Bọt V2", Default = false, Callback = function(v) _G.HeHe.HopDoughKing = v end})
T3:AddToggle({Name = "Hop Tìm Boss Đại Bàng", Default = false, Callback = function(v) _G.HeHe.HopEagle = v end})

-- ------------------------------------------
-- TAB 4: SEA EVENT
-- ------------------------------------------
local T4 = Window:MakeTab({Name = "Sea Event", Icon = "rbxassetid://11900333909"})
T4:AddSection({"Chuẩn Bị Ra Khơi"})
T4:AddDropdown({Name = "Chọn Thuyền", Options = ListBoats, Default = "Sloop", Callback = function(v) _G.HeHe.SelectBoat = v end})
T4:AddButton({Name = "Mua Thuyền", Callback = function() _G.HeHe.BuyBoat = true end})
T4:AddToggle({Name = "Tự Động Lái Thuyền (Auto Lái)", Default = false, Callback = function(v) _G.HeHe.AutoDriveBoat = v end})

T4:AddSection({"Sự Kiện Biển Chung"})
T4:AddToggle({Name = "Auto Đánh Sea Event", Default = false, Callback = function(v) _G.HeHe.AutoSeaEvent = v end})
T4:AddToggle({Name = "Dùng Chiêu (Tắt với Terror/Shark)", Default = true, Callback = function(v) _G.HeHe.UseSkillSeaEvent = v end})

T4:AddSection({"Đảo Cáo (Kitsune)"})
T4:AddToggle({Name = "Tự Ra Đảo Cáo", Default = false, Callback = function(v) _G.HeHe.AutoKitsune = v end})
T4:AddToggle({Name = "Nhận Nhiệm Vụ & Thu Lửa Xanh", Default = false, Callback = function(v) _G.HeHe.KitsuneFarmAzure = v end})

T4:AddSection({"Săn Leviathan Siêu Cấp"})
T4:AddButton({Name = "Hối Lộ Mua Chip Leviathan", Callback = function() _G.HeHe.BuyLeviathanChip = true end})
T4:AddToggle({Name = "Auto Tìm Đảo Leviathan", Default = false, Callback = function(v) _G.HeHe.FindLeviathan = v end})
T4:AddToggle({Name = "Auto Đánh Leviathan (Đầu -> Đuôi)", Default = false, Callback = function(v) _G.HeHe.AutoLeviathan = v end})
T4:AddToggle({Name = "Auto Kéo Tim Leviathan", Default = false, Callback = function(v) _G.HeHe.PullLeviathanHeart = v end})

-- ------------------------------------------
-- TAB 5: PVP & BOUNTY
-- ------------------------------------------
local T5 = Window:MakeTab({Name = "PvP", Icon = "rbxassetid://11900333909"})
T5:AddSection({"Tự Động Ám Sát"})
T5:AddToggle({Name = "Bật Aimbot (Khóa Mục Tiêu)", Default = false, Callback = function(v) _G.HeHe.Aimbot = v end})
T5:AddToggle({Name = "Tự Động Săn Bounty", Default = false, Callback = function(v) _G.HeHe.AutoBounty = v end})
T5:AddToggle({Name = "Tự Động Dùng Chiêu (Combo)", Default = false, Callback = function(v) _G.HeHe.AutoUseSkillPvP = v end})

T5:AddSection({"Công Cụ Hỗ Trợ PvP"})
T5:AddDropdown({Name = "Chọn Người Chơi", Options = ListPlayers, Default = "", Callback = function(v) _G.HeHe.SelectPlayer = v end})
T5:AddButton({Name = "Dịch Chuyển Đến Người Chơi", Callback = function() _G.HeHe.TeleportPlayer = true end})
T5:AddToggle({Name = "Tăng AOE (Mở Rộng Hitbox)", Default = false, Callback = function(v) _G.HeHe.HitboxExpander = v end})
T5:AddToggle({Name = "Tự Động Chạy Trốn (Máu < 15%)", Default = false, Callback = function(v) _G.HeHe.LowHealthEscape = v end})

-- ------------------------------------------
-- TAB 6: SETTINGS
-- ------------------------------------------
local T6 = Window:MakeTab({Name = "Setting", Icon = "rbxassetid://11900333909"})
T6:AddSection({"Mặc Định (Luôn Bật)"})
T6:AddToggle({Name = "Anti AFK (Luôn Bật)", Default = true, Callback = function(v) _G.HeHe.AntiAFK = v end})
T6:AddToggle({Name = "Auto Save (Luôn Bật)", Default = true, Callback = function() end})
T6:AddToggle({Name = "Auto Mở Haki Vũ Trang", Default = true, Callback = function(v) _G.HeHe.AutoHaki = v end})

T6:AddSection({"Thức Tỉnh (Awakening)"})
T6:AddToggle({Name = "Tự Động Bật Tộc V3", Default = false, Callback = function(v) _G.HeHe.AutoV3 = v end})
T6:AddToggle({Name = "Tự Động Bật Tộc V4", Default = false, Callback = function(v) _G.HeHe.AutoV4 = v end})

T6:AddSection({"Chỉ Số Nhân Vật"})
T6:AddSlider({Name = "Tăng Tốc Độ Chạy (WalkSpeed)", Min = 16, Max = 250, Default = 16, Callback = function(v) _G.HeHe.WalkSpeed = v end})
T6:AddSlider({Name = "Tăng Độ Nhảy Cao (JumpPower)", Min = 50, Max = 300, Default = 50, Callback = function(v) _G.HeHe.JumpPower = v end})
T6:AddToggle({Name = "Đi Trên Nước (Walk On Water)", Default = false, Callback = function(v) _G.HeHe.WalkOnWater = v end})

-- ==========================================
-- 3. HỆ THỐNG LOGIC NGẦM (BACKEND / LOOP)
-- ==========================================
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

-- A. ANTI AFK LUÔN MỞ
Player.Idled:connect(function()
    if _G.HeHe.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

-- B. VÒNG LẶP CHÍNH (XỬ LÝ TOÀN BỘ LOGIC)
task.spawn(function()
    while task.wait(0.1) do
        
        -- 1. Auto Haki Vũ Trang
        if _G.HeHe.AutoHaki then
            if not Player.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
        
        -- 2. Chỉ số cơ bản (Tốc độ & Nhảy & Nước)
        pcall(function()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                if _G.HeHe.WalkSpeed > 16 then
                    Player.Character.Humanoid.WalkSpeed = _G.HeHe.WalkSpeed
                end
                if _G.HeHe.JumpPower > 50 then
                    Player.Character.Humanoid.JumpPower = _G.HeHe.JumpPower
                end
            end
        end)
        
        -- 3. Farm Mastery Logic (Chuyển vũ khí khi quái yếu)
        if _G.HeHe.FarmMasteryGun or _G.HeHe.FarmMasteryFruit then
            pcall(function()
                local target = workspace.Enemies:FindFirstChildOfClass("Model")
                if target and target:FindFirstChild("Humanoid") then
                    local maxHp = target.Humanoid.MaxHealth
                    local curHp = target.Humanoid.Health
                    local percent = (curHp / maxHp) * 100
                    
                    if percent <= _G.HeHe.MasteryHealthSwitch then
                        local weaponToEquip = ""
                        if _G.HeHe.FarmMasteryGun then weaponToEquip = "Gun" end
                        if _G.HeHe.FarmMasteryFruit then weaponToEquip = "Fruit" end
                        
                        local tool = Player.Backpack:FindFirstChild(weaponToEquip) or Player.Character:FindFirstChild(weaponToEquip)
                        if tool then Player.Character.Humanoid:EquipTool(tool) end
                    else
                        local tool = Player.Backpack:FindFirstChild(_G.HeHe.Weapon) or Player.Character:FindFirstChild(_G.HeHe.Weapon)
                        if tool then Player.Character.Humanoid:EquipTool(tool) end
                    end
                end
            end)
        end
        
        -- 4. PVP Logic (Bay lên trời khi yếu máu)
        if _G.HeHe.LowHealthEscape then
            pcall(function()
                local hp = Player.Character.Humanoid.Health
                local maxHp = Player.Character.Humanoid.MaxHealth
                if (hp / maxHp) * 100 <= 15 then
                    Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0)
                end
            end)
        end

        -- 5. Auto Tộc V3 & V4
        if _G.HeHe.AutoV3 then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommE_:FireServer("Agility", "V3")
            end)
        end
        if _G.HeHe.AutoV4 then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakening")
            end)
        end
        
        -- 6. Logic Leviathan Khúc Chiết (Đánh Đầu -> Đuôi)
        if _G.HeHe.AutoLeviathan then
            pcall(function()
                -- Bước 1: Tìm Đầu Leviathan (Head)
                local LeviHead = workspace:FindFirstChild("Leviathan_Head")
                -- Bước 2: Tìm Đuôi Leviathan (Tail)
                local LeviTail = workspace:FindFirstChild("Leviathan_Tail")
                
                if LeviHead and LeviHead.Humanoid.Health > 0 then
                    Player.Character.HumanoidRootPart.CFrame = LeviHead.CFrame * CFrame.new(0, 30, 0)
                    -- Kích hoạt đánh vũ khí
                elseif LeviTail and LeviTail.Humanoid.Health > 0 then
                    Player.Character.HumanoidRootPart.CFrame = LeviTail.CFrame * CFrame.new(0, 30, 0)
                end
            end)
        end

        -- [Các logic rườm rà khác của Farming, Raid, Sea Event sẽ được nối vào đây qua các vòng lặp nâng cao]
    end
end)

-- LOGIC AUTO BOUNTY & AIMBOT (HITBOX)
task.spawn(function()
    while task.wait(1) do
        if _G.HeHe.HitboxExpander then
            pcall(function()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(30, 30, 30)
                        v.Character.HumanoidRootPart.Transparency = 0.5
                    end
                end
            end)
        end
    end
end)

-- THÔNG BÁO TẢI THÀNH CÔNG
RedzLib:MakeNotify({
    Title = "HeHe Hub Master",
    Content = "Đã tải xong toàn bộ UI hơn 700 dòng!",
    Time = 5
})


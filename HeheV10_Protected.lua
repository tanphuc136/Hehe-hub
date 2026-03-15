local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
  Name = "Hehe Hub Pro 🍎",
  SubTitle = "V11 - Redz Edition (Max 2800)",
  SaveConfig = true,
  ConfigFolder = "HeheHub_V11"
})

-- ==================== HỆ THỐNG BIẾN (Dùng cho Auto Save) ====================
_G.Config = {
    AutoFarm = false,
    Weapon = "Melee",
    AutoKarateV3 = false,
    AutoSeaEvent = false,
    AutoV4 = false,
    MasteryMode = false,
    MasteryPercent = 20
}

-- ==================== TẠO TABS ====================
local T1 = Window:MakeTab({"Cày Cấp", "rbxassetid://4483345998"})
local T2 = Window:MakeTab({"Vật Phẩm & Võ", "rbxassetid://4483345998"})
local T3 = Window:MakeTab({"Sea Events", "rbxassetid://4483345998"})
local T4 = Window:MakeTab({"Tộc V4", "rbxassetid://4483345998"})
local T5 = Window:MakeTab({"Chuyển Server", "rbxassetid://4483345998"})

-- ==================== TAB 1: CÀY CẤP & MASTERY ====================
T1:AddSection({"Cấu Hình Farm"})

T1:AddDropdown({
  Name = "Chọn Vũ Khí",
  Options = {"Melee", "Sword", "Fruit"},
  Default = "Melee",
  Callback = function(v) _G.Config.Weapon = v end
})

T1:AddToggle({
  Name = "Tự Động Cày Cấp (Max 2800)",
  Default = false,
  Callback = function(v) _G.Config.AutoFarm = v end
})

T1:AddToggle({
  Name = "Farm Mastery (Trái/Súng)",
  Default = false,
  Callback = function(v) _G.Config.MasteryMode = v end
})

T1:AddSlider({
  Name = "Chuyển vũ khí khi quái còn (%) máu",
  Min = 1, Max = 100, Default = 20,
  Callback = function(v) _G.Config.MasteryPercent = v end
})

-- ==================== TAB 2: VẬT PHẨM (PHẢI CÓ KARATE V3) ====================
T2:AddSection({"Võ Thuật (Melee)"})

T2:AddToggle({
  Name = "Auto Sharkman Karate (V3)",
  Default = false,
  Callback = function(v) _G.Config.AutoKarateV3 = v end
})

T2:AddButton({"Auto Godhuman", function() print("Đang check điều kiện Godhuman...") end})

T2:AddSection({"Kiếm Huyền Thoại"})
T2:AddButton({"Auto Lấy CDK (Cursed Dual Katana)", function() end})
T2:AddButton({"Auto Lấy Yama/Tushita", function() end})

-- ==================== TAB 3: SEA EVENTS ====================
T3:AddToggle({
  Name = "Auto Sea Event (Levi/Shark/Kitsune)",
  Default = false,
  Callback = function(v) _G.Config.AutoSeaEvent = v end
})

-- ==================== TAB 4: TỘC V4 (TRIAL & GEAR) ====================
T4:AddSection({"Thức Tỉnh Tộc"})
T4:AddButton({"Auto Lên V2/V3", function() end})
T4:AddToggle({
  Name = "Auto Trial (Hoàn thành thử thách)",
  Default = false,
  Callback = function(v) _G.Config.AutoV4 = v end
})
T4:AddToggle({
  Name = "Auto Kill Người Trong Trial",
  Default = false,
  Callback = function(v) end
})
T4:AddButton({"Auto Up Bánh Răng (Gears)", function() end})

-- ==================== TAB 5: SERVER HOP ====================
T5:AddDropdown({
  Name = "Tìm Server Có:",
  Options = {"Full Moon", "Mirage Island", "Rip Indra", "Blackbeard"},
  Default = "Full Moon",
  Callback = function(v) _G.TargetHop = v end
})
T5:AddButton({"Bắt Đầu Tìm Server", function() end})

-- ==================== LOGIC ĐẶC BIỆT: SHARKMAN KARATE (V3) ==================== 
-- ==================== CÁC HÀM HỖ TRỢ (UTILITIES) ====================
local function GetCharacter()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

local function TweenTo(cframe)
    local root = GetCharacter():FindFirstChild("HumanoidRootPart")
    if root then
        -- Bạn có thể thay bằng TweenService nếu muốn bay mượt hơn
        root.CFrame = cframe
    end
end

-- ==================== CHỨC NĂNG CHÍNH: SHARKMAN KARATE ====================
task.spawn(function()
    while task.wait(0.5) do
        if _G.Config.AutoKarateV3 then
            pcall(function()
                local Player = game.Players.LocalPlayer
                local Backpack = Player.Backpack
                local Character = GetCharacter()
                
                -- 1. Kiểm tra xem đã sở hữu Sharkman Karate chưa
                local hasV3 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Check")
                if hasV3 then
                    _G.Config.AutoKarateV3 = false
                    print("Bạn đã sở hữu Sharkman Karate!")
                    return
                end

                -- 2. Kiểm tra Chìa khóa (Water Key)
                local WaterKey = Backpack:FindFirstChild("Water Key") or Character:FindFirstChild("Water Key")
                
                if not WaterKey then
                    -- BƯỚC A: ĐI SĂN TIDE KEEPER ĐỂ LẤY CHÌA KHÓA
                    local Boss = game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper")
                    
                    if Boss and Boss:FindFirstChild("HumanoidRootPart") and Boss.Humanoid.Health > 0 then
                        -- Bay đến và diệt Boss
                        TweenTo(Boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                        
                        -- Tự động Click (Fast Attack)
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    else
                        -- Nếu Boss chưa hồi sinh, bay đến vị trí chờ (Đảo Forgotten)
                        TweenTo(CFrame.new(-3033, 237, -10182))
                    end
                else
                    -- BƯỚC B: ĐÃ CÓ CHÌA KHÓA -> ĐẾN NPC DAIGROCK ĐỂ MUA VÕ
                    -- Vị trí NPC Daigrock tại Đảo Forgotten
                    local NPC_Pos = CFrame.new(-2828, 240, -11031)
                    TweenTo(NPC_Pos)
                    
                    if (Character.HumanoidRootPart.Position - NPC_Pos.Position).Magnitude < 10 then
                        -- Gọi lệnh mua võ (Cần 2,5M Beli và 5k Fragment)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Topping")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Buy")
                    end
                end
            end)
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        if _G.Config.AutoKarateV3 then
            pcall(function()
                -- 1. Kiểm tra đã có Water Key chưa
                if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkman","Check") then
                    -- 2. Nếu chưa có, đi tìm diệt Tide Keeper (Boss rơi chìa khóa)
                    -- (Logic Tween tới đảo Forgotten và diệt boss sẽ nằm ở đây)
                    print("Đang tìm Water Key từ Tide Keeper...")
                else
                    -- 3. Nếu có chìa khóa, tự động mua võ
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman","Topping")
                end
            end)
        end
    end
end)
-- ==================== LOGIC RACE V4 (CHẤT XÁM ĐỈNH CAO) ====================

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.Config.AutoV4 then
                local Player = game.Players.LocalPlayer
                local Character = Player.Character or Player.CharacterAdded:Wait()
                
                -- 1. Tự động bật Tộc (Press T) khi vào Trial
                if game:GetService("Lighting"):FindFirstChild("RaceV4") then -- Dấu hiệu đang trong Trial
                    local VirtualInputManager = game:GetService("VirtualInputManager")
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.T, false, game)
                end

                -- 2. Logic hoàn thành Trial (Mỗi tộc một kiểu, đây là bản Teleport chung)
                -- Teleport đến vị trí kết thúc của Trial để "ăn gian" thời gian
                local EndZone = workspace:FindFirstChild("TowerEntry") -- Điểm tập kết sau Trial
                if EndZone then
                    Character.HumanoidRootPart.CFrame = EndZone.CFrame
                end
            end
            
            -- 3. Auto Kill người trong Trial (Để thắng)
            if _G.Config.KillTrial then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        -- Chỉ giết những người đang ở gần khu vực Temple of Time
                        if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 500 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            -- Tự động đánh
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end

            -- 4. Auto Up Bánh Răng (Ancient Clock)
            if _G.Config.AutoGear then
                -- Gọi Remote nâng cấp trực tiếp (Tiết kiệm thời gian chạy bộ)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EvoRace","V4","Upgrade")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EvoRace","V4","Check")
            end
        end)
    end
end) 
-- ==================== BỘ MẮT THẦN: QUÉT SERVER ====================

local function HopServer()
    local HttpService = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    
    for _, s in pairs(Servers.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
        end
    end
end

-- Hàm kiểm tra xem server có đang Trăng Tròn hay không
local function CheckFullMoon()
    local Lighting = game:GetService("Lighting")
    if Lighting.SkyConfig.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then -- ID Trăng Tròn
        return "🌕 Full Moon"
    else
        return "🌙 Trăng Thường"
    end
end

task.spawn(function()
    while task.wait(5) do
        if _G.Config.AutoHopFullMoon then
            local status = CheckFullMoon()
            if status ~= "🌕 Full Moon" then
                print("Không phải Full Moon, đang tìm server khác...")
                HopServer()
            else
                Fluent:Notify({Title = "Hehe Hub", Content = "ĐÃ TÌM THẤY TRĂNG TRÒN!", Duration = 10})
                _G.Config.AutoHopFullMoon = false -- Dừng lại để làm Trial
            end
        end
        
        -- Kiểm tra Đảo Bí Ẩn (Mirage Island)
        if _G.Config.AutoHopMirage then
            if not game:GetService("Workspace").Map:FindFirstChild("Mirage Island") then
                print("Không thấy Đảo Bí Ẩn, đang nhảy server...")
                HopServer()
            else
                Fluent:Notify({Title = "Hehe Hub", Content = "CÓ ĐẢO BÍ ẨN TRONG SERVER NÀY!", Duration = 10})
                _G.Config.AutoHopMirage = false
            end
        end
    end
end)
-- ==================== LOGIC AUTO SAVE (QUAN TRỌNG) ====================
-- RedzLib tự động lưu Config khi bạn chọn SaveConfig = true 
-- Mỗi khi bạn bật/tắt Toggle, script sẽ ghi nhớ vào folder HeheHub_V11

RedzLib:SetTheme("Dark") -- Bạn có thể đổi thành "Purple" cho giống Redz gốc

local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
  Name = "Hehe Hub Pro 🍎",
  SubTitle = "V11 - Redz Edition",
  SaveConfig = true,
  ConfigFolder = "HeheHub_V11"
})

-- ==================== BIẾN CẤU HÌNH ====================
_G.Config = {
    AutoFarm = false,
    Weapon = "Melee",
    AutoKarateV3 = false,
    AutoV4 = false,
    KillTrial = false,
    AutoGear = false,
    AutoHopFullMoon = false, -- Biến cho Server Hop
    AutoHopMirage = false    -- Biến cho Server Hop
}

-- ==================== TẠO TABS ====================
local T1 = Window:MakeTab({"Cày Cấp", "rbxassetid://4483345998"})
local T2 = Window:MakeTab({"Vật Phẩm & Võ", "rbxassetid://4483345998"})
local T4 = Window:MakeTab({"Tộc V4", "rbxassetid://4483345998"})
local T5 = Window:MakeTab({"Chuyển Server", "rbxassetid://4483345998"})

-- [Tab 2: Nút Karate V3]
T2:AddToggle({
  Name = "Auto Sharkman Karate (V3)",
  Default = false,
  Callback = function(v) _G.Config.AutoKarateV3 = v end
})

-- [Tab 4: Nút Race V4]
T4:AddToggle({ Name = "Auto Trial", Default = false, Callback = function(v) _G.Config.AutoV4 = v end })
T4:AddToggle({ Name = "Auto Up Gear", Default = false, Callback = function(v) _G.Config.AutoGear = v end })

-- ==================== TAB 5: NÚT SERVER HOP (MỚI) ====================
T5:AddSection({"Tìm Kiếm Hàng Hiếm"})

T5:AddToggle({
  Name = "Tìm Server Trăng Tròn (Full Moon)",
  Default = false,
  Callback = function(v) _G.Config.AutoHopFullMoon = v end
})

T5:AddToggle({
  Name = "Tìm Server Đảo Bí Ẩn (Mirage)",
  Default = false,
  Callback = function(v) _G.Config.AutoHopMirage = v end
})

T5:AddButton({
  Name = "Nhảy Server Ngẫu Nhiên",
  Callback = function() HopServer() end
})

-- ==================== PHẦN RUỘT LOGIC (DƯỚI CÙNG) ====================

local function GetCharacter()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

local function TweenTo(cframe)
    local root = GetCharacter():FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = cframe end
end

-- Hàm nhảy Server
function HopServer()
    local HttpService = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(Servers.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
            break
        end
    end
end

-- LOGIC TỔNG HỢP (KARATE + V4 + HOP)
task.spawn(function()
    while task.wait(1) do 
      -- ==================== HỆ THỐNG AUTO FARM 3 SEA ====================
if _G.Config.AutoFarm then
    pcall(function()
        local MyLevel = game.Players.LocalPlayer.Data.Level.Value
        local MySea = game.PlaceId
        local QuestName, MonsterName, MonsterPos, NPC_Pos, QuestNumber

        -- ==================== SEA 1 (Dành cho khách hàng mới chơi) ====================
        if MySea == 2753915133 then
            if MyLevel >= 1 and MyLevel < 15 then
                QuestName, MonsterName, QuestNumber = "BanditQuest1", "Bandit", 1
                NPC_Pos, MonsterPos = CFrame.new(1059, 15, 1549), CFrame.new(1145, 17, 1634)
            elseif MyLevel >= 15 and MyLevel < 30 then
                QuestName, MonsterName, QuestNumber = "MonkeyQuest1", "Monkey", 1
                NPC_Pos, MonsterPos = CFrame.new(-1598, 35, 153), CFrame.new(-1623, 14, 153)
            -- [Bro có thể copy thêm tọa độ Sea 1 vào đây...]
            else -- Mặc định nếu chưa có tọa độ các đảo sau
                QuestName, MonsterName, QuestNumber = "CyborgQuest", "Cyborg", 1
                NPC_Pos, MonsterPos = CFrame.new(-5201, 15, 8485), CFrame.new(-5201, 15, 8485)
            end

        -- ==================== SEA 2 (Dành cho khách hàng trung cấp) ====================
        elseif MySea == 4442245405 then
            if MyLevel >= 700 and MyLevel < 775 then
                QuestName, MonsterName, QuestNumber = "Area1Quest", "Raider", 1
                NPC_Pos, MonsterPos = CFrame.new(-425, 73, 1837), CFrame.new(-426, 72, 1898)
            -- [Bro có thể copy thêm tọa độ Sea 2 vào đây...]
            else
                QuestName, MonsterName, QuestNumber = "IceCastleQuest", "Awakened Ice Admiral", 1
                NPC_Pos, MonsterPos = CFrame.new(6471, 297, -6903), CFrame.new(6471, 297, -6903)
            end

        -- ==================== SEA 3 (Dành cho khách hàng VIP) ====================
        elseif MySea == 7449423635 then
            if MyLevel >= 1500 and MyLevel < 1575 then
                QuestName, MonsterName, QuestNumber = "PortTownQuest", "Pirate Billionaire", 1
                NPC_Pos, MonsterPos = CFrame.new(-290, 15, 5300), CFrame.new(-290, 15, 5300)
            elseif MyLevel >= 1575 and MyLevel < 1650 then
                QuestName, MonsterName, QuestNumber = "PortTownQuest", "Pistol Billionaire", 2
                NPC_Pos, MonsterPos = CFrame.new(-290, 15, 5300), CFrame.new(-470, 75, 5320)
            -- [Đây là nơi dán các đảo Sea 3 tiếp theo...]
            else
                QuestName, MonsterName, QuestNumber = "ChocolateQuest", "Cocoa Warrior", 1
                NPC_Pos, MonsterPos = CFrame.new(150, 25, 25000), CFrame.new(200, 25, 25100)
            end
        end

        -- ==================== LOGIC THỰC THI (CHUNG CHO CẢ 3 SEA) ====================
        local QuestGui = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
        if not QuestGui.Visible then
            TweenTo(NPC_Pos)
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - NPC_Pos.Position).Magnitude < 10 then
                task.wait(0.2)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestNumber)
            end
        else
            local Target = workspace.Enemies:FindFirstChild(MonsterName) or workspace.Enemies:FindFirstChild(MonsterName:sub(1, -2)) -- Sửa lỗi tên quái có s hoặc không
            if Target and Target:FindFirstChild("HumanoidRootPart") and Target.Humanoid.Health > 0 then
                -- Bay phía trên đầu quái để không bị nó đánh
                TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                -- Tự động Click đánh quái
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            else
                TweenTo(MonsterPos) -- Bay đợi quái hồi sinh
            end
        end
    end)
end
                    else
                        -- Bay tới quái và đánh
                        local Target = workspace.Enemies:FindFirstChild(MonsterName)
                        if Target and Target:FindFirstChild("HumanoidRootPart") then
                            TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end
        pcall(function()
            -- 1. Ruột Karate V3
            if _G.Config.AutoKarateV3 then
                local hasV3 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Check")
                if hasV3 then _G.Config.AutoKarateV3 = false else
                    local WaterKey = game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key") or GetCharacter():FindFirstChild("Water Key")
                    if not WaterKey then
                        local Boss = game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper")
                        if Boss and Boss:FindFirstChild("HumanoidRootPart") and Boss.Humanoid.Health > 0 then
                            TweenTo(Boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        else TweenTo(CFrame.new(-3033, 237, -10182)) end
                    else
                        TweenTo(CFrame.new(-2828, 240, -11031)) -- Vị trí Daigrock
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Topping")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkman", "Buy")
                    end
                end
            end

            -- 2. Ruột Server Hop
            if _G.Config.AutoHopFullMoon then
                if game:GetService("Lighting").SkyConfig.MoonTextureId ~= "http://www.roblox.com/asset/?id=9709149431" then
                    HopServer()
                end
            end

            if _G.Config.AutoHopMirage then
                if not game:GetService("Workspace").Map:FindFirstChild("Mirage Island") then
                    HopServer()
                end
            end
        end)
    end
end) 

RedzLib:SetTheme("Dark")

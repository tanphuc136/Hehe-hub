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
-- Lưu cấu hình khi có thay đổi
Window:SetTheme("Dark") -- Màu giao diện tối cho ngầu

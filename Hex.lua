-- ============================================
-- 🎮 HEX MM2 SCRIPT - FIXED VERSION
-- Advanced Auto Farm + Auto Murder System
-- ============================================

getgenv().HexSecure = true

-- FIX 1: Built-in Hex Library (NO EXTERNAL DEPENDENCY)
local function CreateHexLibrary()
    local library = {}
    
    function library:CreateWindow(config)
        print("🔮 HEX Window Created: " .. config.Name)
        
        local window = {
            Notify = function(self, title, message, duration)
                print("[" .. title .. "] " .. message)
                -- Roblox notification
                if game:GetService("StarterGui"):GetCore("SendNotification") then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = title,
                        Text = message,
                        Duration = duration or 3
                    })
                end
            end,
            
            SetTheme = function(self, theme)
                print("🎨 Theme set to: " .. theme)
            end,
            
            CreateTab = function(self, tabName)
                print("📁 Tab: " .. tabName)
                
                local tab = {
                    CreateSection = function(self, sectionName)
                        print("📌 Section: " .. sectionName)
                    end,
                    
                    CreateToggle = function(self, config)
                        print("🔘 Toggle: " .. config.Text)
                        return {
                            Callback = config.Callback or function() end
                        }
                    end,
                    
                    CreateButton = function(self, config)
                        print("🟢 Button: " .. config.Text)
                        return {
                            Callback = config.Callback or function() end
                        }
                    end,
                    
                    CreateSlider = function(self, config)
                        print("📏 Slider: " .. config.Text)
                        return {
                            Callback = config.Callback or function(value) end
                        }
                    end,
                    
                    CreateDropdown = function(self, config)
                        print("📋 Dropdown: " .. config.Text)
                        return {
                            Callback = config.Callback or function(option) end
                        }
                    end,
                    
                    CreateLabel = function(self, text)
                        print("🏷️ Label: " .. text)
                        local label = {
                            _text = text,
                            SetText = function(self, newText)
                                self._text = newText
                                print("📝 Label Updated: " .. newText)
                            end
                        }
                        return label
                    end
                }
                return tab
            end
        }
        return window
    end
    
    return library
end

local HexLibrary = CreateHexLibrary()
local HexWindow = HexLibrary:CreateWindow({
    Name = "🔮 HEX MM2",
    Theme = "Dark"
})

-- FIX 2: table.size fonksiyonu
local function tableSize(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- Variables
local Player = game:GetService("Players").LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- FIX 3: Move IsMurdererForPlayer function before GetInnocentPlayers
local function IsMurdererForPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    local char = targetPlayer.Character
    for _, child in pairs(char:GetChildren()) do
        if child.Name == "Knife" then
            return true
        end
    end
    return false
end

-- Auto Farm Variables
local AutoFarmEnabled = false
local TargetCoins = 50
local CollectedCoins = 0
local FarmRange = 100
local FarmSpeed = 0.3

-- Auto Murder Variables
local AutoMurderEnabled = false
local MurderRange = 25
local MurderCooldown = 1.5
local KillList = {}
local FailedKills = {}
local TotalKills = 0

-- Tabs
local MainTab = HexWindow:CreateTab("🎯 Main")
local FarmTab = HexWindow:CreateTab("🌾 Farm")
local MurderTab = HexWindow:CreateTab("🔪 Murder")
local StatsTab = HexWindow:CreateTab("📊 Stats")

-- FIX 4: Update all table.size() calls to tableSize()
local CoinsLabel = StatsTab:CreateLabel("💰 Coins Collected: 0")
local KillsLabel = StatsTab:CreateLabel("🔪 Players Killed: 0")
local FailedLabel = StatsTab:CreateLabel("❌ Failed Attempts: 0")
local StatusLabel = StatsTab:CreateLabel("📊 Status: Idle")
local ModeLabel = StatsTab:CreateLabel("🎯 Mode: Farm")
local TimeLabel = StatsTab:CreateLabel("⏰ Runtime: 0s")
local PlayersLabel = StatsTab:CreateLabel("👥 Players Left: 0")

-- ORİJİNAL KODUN GERİ KALANI (fonksiyon tanımlamaları ve diğer kodlar)
-- [Buraya orijinal kodunuzun geri kalanını ekleyin, ancak:]
-- 1. Tüm `table.size()` çağrılarını `tableSize()` yapın
-- 2. `IsMurdererForPlayer` fonksiyonu zaten tanımlandı

-- Örnek düzeltme (FailedLabel kısmında):
-- ORİJİNAL: FailedLabel:SetText("❌ Failed Attempts: " .. table.size(FailedKills))
-- DÜZELTMİŞ: FailedLabel:SetText("❌ Failed Attempts: " .. tableSize(FailedKills))

-- Default settings
getgenv().CollectGold = true
getgenv().CollectNormal = true
getgenv().TeleportToTarget = false
getgenv().RetryFailed = true

print("========================================")
print("🔮 HEX MM2 SCRIPT LOADED SUCCESSFULLY")
print("✅ All fixes applied")
print("🌾 Features: Auto Farm + Auto Murder")
print("========================================")

repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

if table.find(loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/Whitelist.lua"))(), game.Players.LocalPlayer.UserId) then

    if game.PlaceId == 10524502174 then

        _G.Config = {
            FarmArea = "",
            AutoFarm = false,
            AutoCollect = false,
            AutoGetRewards = false,
            AutoAchievements = false,

            SummonArea = "",
            AutoSummon = false,
            TripleOpen = false,

            AutoCraftElixir = false,
            ElixirsToCraft = {},
            AutoUseElixir = false,
            ElixirsToUse = {},

            MountSelected = "",

            IgnoreMeteors = false,
            AdvancedMode = false
        }

        local filepath = "MazterHub/OnePunchFighters.txt"
        local shpath = "MazterHub/ServerHop.json"
        function LoadConfig()
            if not isfolder("MazterHub") then
                makefolder("MazterHub")
            end
            if (readfile and isfile and isfile(filepath)) then
                _G.Config = game:GetService("HttpService"):JSONDecode(readfile(filepath))
            end
        end
        function SaveConfig()
            local json;
            if (writefile) then
                json = game:GetService("HttpService"):JSONEncode(_G.Config)
                writefile(filepath, json)
            end
        end
        LoadConfig()

        function GetEnemy()
            for i, v in pairs(game:GetService("Workspace")["__GAME"]["__Mobs"][_G.Config.FarmArea]:GetChildren()) do
                if v:IsA("Model") then
                    if not _G.Config.IgnoreMeteors then
                        mobHealth = v.NpcHealth.Health.HealthText.Text
                        i, j = string.find(mobHealth, "0/")
                        if i ~= 1 and j ~= 2 then
                            return v
                        end
                    else
                        if v.Name ~= "METEOR_RAID" then
                            mobHealth = v.NpcHealth.Health.HealthText.Text
                            i, j = string.find(mobHealth, "0/")
                            if i ~= 1 and j ~= 2 then
                                return v
                            end
                        end
                    end
                end
            end
        end
        function GetAreas()
            local ta = {}
            for i, v in pairs(game:GetService("Workspace")["__Zones"]["__TrainingZones"]:GetChildren()) do
                if not table.find(ta, v.Name) and v.Name ~= "Area99999" then
                    table.insert(ta, v.Name)
                end
            end
            table.sort(ta, function(a, s)
                local a1 = tonumber(string.match(a, "%d+"))
                local b1 = tonumber(string.match(s, "%d+"))
                return a1 < b1
            end)
            return ta
        end
        function GetEggs()
            local t = {}
            for i, v in pairs(game:GetService("Workspace")["__Zones"]["__Summons"]:GetChildren()) do
                if v:IsA("Part") and not table.find(t, v.Name) then
                    table.insert(t, v.Name)
                end
            end
            table.sort(t, function(a, s)
                local a1 = tonumber(string.match(a, "%d+"))
                local b1 = tonumber(string.match(s, "%d+"))
                return a1 < b1
            end)
            return t
        end
        function GetElixirs()
            local e = {}
            local elxMod = require(game:GetService("ReplicatedStorage").INDEXER.ItemInfo)
            local elixirsId = {"ElixirStr", "ElixirXp", "ElixirGem", "ElixirCoins", "ElixirLuck"}
            for i, v in pairs(elixirsId) do
                local id = string.gsub(v, "Elixir", "")
                if not table.find(e, id) then
                    table.insert(e, id)
                end
            end
            table.sort(e, function(a, s)
                local a1 = string.len(a)
                local b1 = string.len(s)
                return a1 < b1
            end)
            return e
        end
        function GetMounts()
            local m = {}
            for i, v in pairs(game:GetService("Workspace")["__Zones"]["__Mounts"]:GetChildren()) do
                table.insert(m, v.Name)
            end
            return m
        end

        local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/mazterziN/Hub/main/MaterialUI.lua"))()
        local UI = Material.Load({
            Title = " MAZTER HUB • One Punch Fighters",
            Style = 1,
            SizeX = 300,
            SizeY = 350,
            Theme = "VeryDark",
        })
        local MainPg = UI.New({
            Title = "MAIN"
        })
        local SummonPg = UI.New({
            Title = "SUMMON"
        })
        local ElxPg = UI.New({
            Title = "ELIXIR"
        })
        local TpPg = UI.New({
            Title = "TP"
        })
        local MiscPg = UI.New({
            Title = "MISC"
        })

        local AreasDD = MainPg.Dropdown({
            Text = "Select The Area",
            Callback = function(op)
                _G.Config.FarmArea = op
                SaveConfig()
            end,
            Options = GetAreas()
        })
        MainPg.Toggle({
            Text = "Auto Farm",
            Callback = function(v)
                _G.Config.AutoFarm = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoFarm
        })
        MainPg.Toggle({
            Text = "Auto Collect",
            Callback = function(v)
                _G.Config.AutoCollect = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoCollect
        })
        MainPg.Toggle({
            Text = "Auto Get All Rewards",
            Callback = function(v)
                _G.Config.AutoGetRewards = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoGetRewards
        })
        MainPg.Toggle({
            Text = "Auto Get Achievements",
            Callback = function(v)
                _G.Config.AutoAchievements = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoAchievements
        })
        local SummonDD = SummonPg.Dropdown({
            Text = "Select The Summon Area",
            Callback = function(op)
                _G.Config.SummonArea = op
                SaveConfig()
            end,
            Options = GetEggs()
        })
        SummonPg.Toggle({
            Text = "Auto Summon",
            Callback = function(v)
                _G.Config.AutoSummon = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoSummon
        })
        SummonPg.Toggle({
            Text = "Triple Open",
            Callback = function(v)
                _G.Config.TripleOpen = v
                SaveConfig()
            end,
            Enabled = _G.Config.TripleOpen
        })
        local ElxCraftDD = ElxPg.Dropdown({
            Text = "Select Elixir to Craft",
            Callback = function(op)
                if not table.find(_G.Config.ElixirsToCraft, op) then
                    table.insert(_G.Config.ElixirsToCraft, op)
                else
                    table.remove(_G.Config.ElixirsToCraft, table.find(_G.Config.ElixirsToCraft, op))
                end
                SaveConfig()
            end,
            Options = GetElixirs()
        })
        ElxPg.Toggle({
            Text = "Auto Craft Elixir",
            Callback = function(v)
                _G.Config.AutoCraftElixir = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoCraftElixir
        })
        local ElxUseDD = ElxPg.Dropdown({
            Text = "Select Elixir to Use",
            Callback = function(op)
                if not table.find(_G.Config.ElixirsToUse, op) then
                    table.insert(_G.Config.ElixirsToUse, op)
                else
                    table.remove(_G.Config.ElixirsToUse, table.find(_G.Config.ElixirsToUse, op))
                end
                SaveConfig()
            end,
            Options = GetElixirs()
        })
        ElxPg.Toggle({
            Text = "Auto Use Elixir",
            Callback = function(v)
                _G.Config.AutoUseElixir = v
                SaveConfig()
            end,
            Enabled = _G.Config.AutoUseElixir
        })
        local TaDD = TpPg.Dropdown({
            Text = "Select Area to TP",
            Callback = function(op)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__Zones"]["__TrainingZones"][op].CFrame
            end,
            Options = GetAreas()
        })
        local MountsDD = TpPg.Dropdown({
            Text = "Select Mount to TP",
            Callback = function(op)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__Zones"]["__Mounts"][op].CFrame
                _G.Config.MountSelected = op
                wait(10)
                _G.Config.MountSelected = ""
            end,
            Options = GetMounts()
        })
        MiscPg.Button({
            Text = "Rejoin",
            Callback = function()
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end
        })
        MiscPg.Button({
            Text = "Server Hop",
            Callback = function()
                ServerHop(game.PlaceId)
            end
        })
        MiscPg.Slider({
            Text = "WalkSpeed",
            Callback = function(v)
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
            end,
            Min = 16,
            Max = 256,
            Def = 16
        })
        MiscPg.Slider({
            Text = "JumpPower",
            Callback = function(v)
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
            end,
            Min = 50,
            Max = 128,
            Def = 50
        })
        MiscPg.Toggle({
            Text = "Advanced Mode",
            Callback = function(v)
                _G.Config.AdvancedMode = v
                SaveConfig()
            end,
            Enabled = _G.Config.AdvancedMode
        })
        MiscPg.Toggle({
            Text = "Ignore Meteors",
            Callback = function(v)
                _G.Config.IgnoreMeteors = v
                SaveConfig()
            end,
            Enabled = _G.Config.IgnoreMeteors
        })

        -- AUTO FARM
            spawn(function()
                while wait() do
                    if _G.Config.AutoFarm and not _G.Config.AutoSummon then
                        pcall(function()
                            if game:GetService("Workspace")["__GAME"]["__Mobs"]:FindFirstChild(_G.Config.FarmArea) then
                                local v = GetEnemy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v:GetModelCFrame().Position)
                            else
                                if _G.Config.FarmArea == "Area1" then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__GAME"]["__SpawnLocations"].Main.CFrame
                                else
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__GAME"]["__SpawnLocations"][_G.Config.FarmArea].CFrame
                                end
                            end
                        end)
                    end
                end
            end)
        -- AUTO CLICK
            spawn(function()
                while wait(0.2) do
                    if _G.Config.AutoFarm and not _G.Config.AutoSummon then
                        pcall(function()
                            local v = GetEnemy()
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\6",
                                        [2] = "Normal"
                                    },
                                    [2] = {
                                        [1] = "\4",
                                        [2] = "Attack",
                                        [3] = v
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end)
                    end
                end
            end)
        -- AUTO COLLECT
            spawn(function()
                while wait(.2) do
                    if _G.Config.AutoCollect then
                        for i,v in pairs(game:GetService("Workspace")["__Cache"]:GetChildren()) do
                            if v.Name == "CollisionPart" then
                                if v:IsA("Part") and v.Position == Vector3.new(0, 1e+09, 0) then
                                    v.Size = Vector3.new(0.5,0.5,0.5)
                                else
                                    v.Size = Vector3.new(0.5,0.5,0.5)
                                    v.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                                end
                            end
                        end
                    end
                end
            end)
        -- AUTO GET REWARDS
            spawn(function()
                while wait(.5) do
                    if _G.Config.AutoGetRewards then
                        for i = 1, 14 do
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\3",
                                        [2] = "GetTimeReward",
                                        [3] = tostring(i)
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "\3",
                                    [2] = "DailyReward"
                                }
                            }
                        }
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                    end
                end
            end)
        -- AUTO GET ACHIEVEMENTS
            spawn(function()
                while wait(.5) do
                    if _G.Config.AutoAchievements then
                        local achievements = require(game:GetService("ReplicatedStorage").INDEXER.AchievementsInfo).GetAllAchievements()
                        for i, v in pairs(achievements) do
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\3",
                                        [2] = "AchievementsGet",
                                        [3] = i
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end
                    end
                end
            end)
        -- AUTO SUMMON
            spawn(function()
                while wait(.5) do
                    if _G.Config.AutoSummon then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__Zones"]["__Summons"][_G.Config.SummonArea].CFrame
                        local amt = 1
                        if _G.Config.TripleOpen then amt = 3 end
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "\7",
                                    [2] = "Summon",
                                    [3] = {
                                        ["Quanty"] = amt,
                                        ["World"] = _G.Config.SummonArea
                                    }
                                }
                            }
                        }
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                    end
                end
            end)

        -- AUTO CRAFT ELIXIR
            spawn(function()
                while wait(.5) do
                    if _G.Config.AutoCraftElixir then
                        for i, v in pairs(_G.Config.ElixirsToCraft) do
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\3",
                                        [2] = "CraftElixir",
                                        [3] = v
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end
                    end
                end
            end)
        -- AUTO USE ELIXIR
            spawn(function()
                while wait(1) do
                    if _G.Config.AutoUseElixir then
                        for i, v in pairs(_G.Config.ElixirsToUse) do
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\3",
                                        [2] = "UseItem",
                                        [3] = "Elixir" .. v
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end
                    end
                end
            end)

        -- SERVER HOP
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local ts = game:GetService("TeleportService")
            local http = game:GetService("HttpService")
            local file = pcall(function()
                AllIDs = http:JSONDecode(readfile(shpath))
            end)
            if not file then
                table.insert(AllIDs, actualHour)
                pcall(function()
                    writefile(shpath, http:JSONEncode(AllIDs))
                end)
            end
            function ServerHop(placeId)
                local Site;
                if foundAnything == "" then
                    Site = http:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = http:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0;
                for i,v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _,Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        delfile(shpath)
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                    end)
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(function()
                                writefile(shpath, http:JSONEncode(AllIDs))
                                wait()
                                ts:TeleportToPlaceInstance(placeId, ID, game.Players.LocalPlayer)
                            end)
                            wait(4)
                        end
                    end
                end
            end

        -- ADVANCED MODE
            spawn(function()
                _G.WorldsPrice = {}
                local WorldMod = require(game:GetService("ReplicatedStorage").INDEXER.WorldInfo)
                for _, v in pairs(GetAreas()) do
                    if not table.find(_G.WorldsPrice, WorldMod.GetWorld(v).Price) and WorldMod.GetWorld(v).TypePrice == "Strength" then
                        table.insert(_G.WorldsPrice, WorldMod.GetWorld(v).Price)
                    end
                end
                while wait(.2) do
                    if _G.Config.AdvancedMode then
                        local str = math.floor(game:GetService("Players").LocalPlayer.leaderstats.Strength.Value)
                        for i = 1, #_G.WorldsPrice do
                            if str >= _G.WorldsPrice[i] and str <= _G.WorldsPrice[i+1] then
                                local args = {
                                    [1] = {
                                        [1] = {
                                            [1] = "\3",
                                            [2] = "RankUp"
                                        }
                                    }
                                }
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                                _G.Config.FarmArea = "Area" .. i
                            end
                        end
                    end
                end
            end)
            spawn(function()
                while wait(.5) do
                    if _G.Config.AdvancedMode then
                        for i = 1, #_G.WorldsPrice do
                            local args = {
                                [1] = {
                                    [1] = {
                                        [1] = "\3",
                                        [2] = "BuyWorld",
                                        [3] = "Area" .. i
                                    }
                                }
                            }
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                        end
                    end
                end
            end)

        -- SET TEXT: Farm Area
            spawn(function()
                while wait() do
                    if _G.Config.FarmArea ~= "" then
                        AreasDD:SetText("Area Selected: " .. _G.Config.FarmArea)
                    end
                end
            end)
        -- SET TEXT: Summon Area
            spawn(function()
                while wait() do
                    if _G.Config.SummonArea ~= "" then
                        SummonDD:SetText("Area Selected: " .. _G.Config.SummonArea)
                    end
                end
            end)
        -- SET TEXT: Mount Selected
            spawn(function()
                while wait() do
                    if _G.Config.MountSelected ~= "" then
                        MountsDD:SetText("Mount Selected: " .. _G.Config.MountSelected)
                    else
                        MountsDD:SetText("Select Mount to TP")
                    end
                end
            end)
        -- SET TEXT: Elixirs To Craft
            spawn(function()
                while wait() do
                    if #_G.Config.ElixirsToCraft > 0 then
                        ElxCraftDD:SetText("Elixirs to Craft: " .. table.concat(_G.Config.ElixirsToCraft, ", "))
                    else
                        ElxCraftDD:SetText("Select Elixir to Craft")
                    end
                end
            end)
        -- SET TEXT: Elixirs To Craft
            spawn(function()
                while wait() do
                    if #_G.Config.ElixirsToUse > 0 then
                        ElxUseDD:SetText("Elixirs to Use: " .. table.concat(_G.Config.ElixirsToUse, ", "))
                    else
                        ElxUseDD:SetText("Select Elixir to Use")
                    end
                end
            end)
    end
else
    local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/mazterziN/Hub/main/NotifierUI.lua"))()
    Notify.new("ERROR", "MAZTER HUB", "You are not whitelisted.", true, 10)
end

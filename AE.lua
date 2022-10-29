repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

if table.find(loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/Whitelist.lua"))(), game.Players.LocalPlayer.UserId) and game.PlaceId == 10723695195 then

    _G.Config = {

        Farm = {
            Enabled = false,
            Enemy = "Luffe",
            Area = "Ooy Piece"
        },
        Defense = {
            Enabled = false,
            ID = "Defense"
        },
        PowerArea = {
            Enabled = false,
            Multiplier = "x2",
        },

        Bosses = false,
        Click = false,
        Collect = false,
        Rankup = false,
        Aura = false,
        Weapon = false,

        Gamepasses = {
            ["Teleport"] = false,
            ["Auto Click"] = false,
            ["Fast Open"] = false
        },

        OpenFighter = false,
        TripleOpen = false,
        MapToOpen = "Ooy Piece",
        UnitsToDelete = {},

        UseBoosts = false,
        Boosts = {},

        HideName = false,
        ClaimGifts = false,

        AlwaysSet = true,
        WalkSpeed = 16,
        JumpPower = 50,
        Keybind = "Enum.KeyCode.RightAlt",

        ConfigChanges = 1.33
    }

    local hubname = " MAZTER HUB - Anime Evolution"
    local scriptpath = "MazterHub/AnimeEvolution.txt"
    local shpath = "MazterHub/ServerHop.json"

    local function MergeConfig(OldConfig, NewConfig)

        local primaryTypes = {"string", "number", "boolean"}
        local othersTypes = {"table"}

        for k, v in pairs(OldConfig) do
            for k2, v2 in pairs(NewConfig) do
                if table.find(primaryTypes, type(v)) and table.find(primaryTypes, type(v2)) then
                    if k ~= "ConfigChanges" and k == k2 and v ~= v2 then
                        NewConfig[k] = v
                    end
                end
                if table.find(othersTypes, type(v)) and table.find(othersTypes, type(v2)) then
                    for k3, v3 in pairs(v) do
                        for k4, v4 in pairs(v2) do
                            if table.find({"string"}, type(k3)) then
                                if table.find(primaryTypes, type(v3)) and table.find(primaryTypes, type(v4)) then
                                    if k3 == k4 and v3 ~= v4 then
                                        NewConfig[k][k3] = v3
                                    end
                                end
                            end
                            if table.find({"number"}, type(k3)) then
                                if table.find(primaryTypes, type(v3)) and table.find(primaryTypes, type(v4)) then
                                    NewConfig[k][k3] = v3
                                end
                            end 
                            if table.find(othersTypes, type(v3)) and table.find(othersTypes, type(v4)) then
                                for k5, v5 in pairs(v3) do
                                    for k6, v6 in pairs(v4) do
                                        if table.find({"string"}, type(k5)) then
                                            if table.find(primaryTypes, type(v5)) and table.find(primaryTypes, type(v6)) then
                                                if k5 == k6 and v5 ~= v6 then
                                                    NewConfig[k][k3][k5] = v5
                                                end
                                            end
                                        end
                                        if table.find({"number"}, type(k5)) then
                                            if table.find(primaryTypes, type(v5)) and table.find(primaryTypes, type(v6)) then
                                                NewConfig[k][k3][k5] = v5
                                            end
                                        end 
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local function LoadConfig()
        _G.AllIDs = {}
        if not isfolder("MazterHub") then
            makefolder("MazterHub")
        end
        if isfile(scriptpath) then
            local OldConfig = game:GetService("HttpService"):JSONDecode(readfile(scriptpath))
            if OldConfig["ConfigChanges"] ~= _G.Config.ConfigChanges then
                MergeConfig(OldConfig, _G.Config)
                writefile(scriptpath, game:GetService("HttpService"):JSONEncode(_G.Config))
            else
                _G.Config = OldConfig
            end
        end
        if isfile(shpath) then
            _G.AllIDs = game:GetService("HttpService"):JSONDecode(readfile(shpath))
        else
            table.insert(_G.AllIDs, os.date("!*t").hour)
            pcall(function()
                writefile(shpath, game:GetService("HttpService"):JSONEncode(_G.AllIDs))
            end)
        end
    end
    local function SaveConfig()
        if (writefile) then
            writefile(scriptpath, game:GetService("HttpService"):JSONEncode(_G.Config))
        end
    end
    LoadConfig()

    local function Click(ClickType, Target)
        if ClickType == "train" then
            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"PowerTrain", Target})
        elseif ClickType == "attack" then
            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"AttackMob", Target})
        end
    end
    local function TeleportTo(CFrame)
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame
    end
    local function Body(act, bodytype, name, parent)
        if act == "create" then
            local bv = Instance.new("Body".. bodytype)
            bv.Name = name
            bv.Parent = parent
            bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            if bv:IsA("BodyVelocity") then
                bv.Velocity = Vector3.new(0,0,0)
            end
            return bv
        elseif act == "remove" then
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for i, v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                    if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                        v:Destroy()
                    end
                end
            end
        end
    end
    local function RedeemCodes()
        local codes = {
            "Release",
            "10KVISITS",
            "100KVISITS",
            "200KVISITS",
            "1KLIKES",
            "1MVISITS",
            "500KVISITS",
            "7KFAVS",
            "4KLIKES",
            "10KLIKES",
            "5MVISITS",
            "25KFAVS",
            "12KLIKES",
            "15KLIKES"
        }
        for _, v in pairs(codes) do
            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"Codes", v})
        end
    end
    local function ServerHop(PlaceID)
        local FoundAnything = ""
        local Site;
        if FoundAnything == "" then
            Site = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. FoundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            FoundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(_G.AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(os.date("!*t").hour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile(shpath)
                                _G.AllIDs = {}
                                table.insert(_G.AllIDs, os.date("!*t").hour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(_G.AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile(shpath, game:GetService("HttpService"):JSONEncode(_G.AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    local function GetAreas(AreaType)
        local areas = require(game:GetService("ReplicatedStorage").Modules.Areas)
        local blockedids = {13, 16, 18, 21}
        local t = {}
        if AreaType == "farm" then
            local AreasCount = 0
            for i, v in pairs(areas) do
                if v["Id"] ~= 0 then
                    AreasCount += 1
                end
            end
            for i = 1, AreasCount do
                for name, v in pairs(areas) do
                    if v["Id"] == i and not table.find(blockedids, v["Id"]) then
                        table.insert(t, name)
                    end
                end
            end
        elseif AreaType == "tp" then
            for _, v in ipairs(game:GetService("Workspace")["__WORKSPACE"].Areas:GetChildren()) do
                table.insert(t, v.Name)
            end
        end
        return t
    end
    local function GetFighters(GetType, Area)
        if GetType == "mobs" then
            if game:GetService("Workspace")["__WORKSPACE"].Mobs:FindFirstChild(Area) then
                local t = {}
                for _, v in ipairs(game:GetService("Workspace")["__WORKSPACE"].Mobs[Area]:GetChildren()) do
                    if not table.find(t, v.Name) then
                        table.insert(t, v.Name)
                    end
                end
                return t
            end
        elseif GetType == "fighterspoint" then
            local t = {}
            for _, v in ipairs(game:GetService("Workspace")["__WORKSPACE"].FightersPoint[Area].Fighters:GetChildren()) do
                if not table.find(t, v.Name) then
                    table.insert(t, v.Name)
                end
            end
            return t
        end
    end
    local function GetEnemy(EnemyType)
        if EnemyType == "Farm" then
            for _, v in next, game:GetService("Workspace")["__WORKSPACE"].Mobs:FindFirstChild(_G.Config.Farm.Area):GetChildren() do
                if game:GetService("Workspace")["__WORKSPACE"].Mobs[_G.Config.Farm.Area]:FindFirstChild(_G.Config.Farm.Enemy) then
                    if v.Name == _G.Config.Farm.Enemy then
                        if v:FindFirstChild("Settings").HP.Value > 0 and v:FindFirstChild("HumanoidRootPart").Position.X ~= 0 and v:FindFirstChild("HumanoidRootPart").Position.Z ~= 0 and v:FindFirstChild("HumanoidRootPart").Position.Y > -1 then
                            return v
                        end
                    end
                else
                    return game:GetService("Workspace")["__WORKSPACE"].Areas[_G.Config.Farm.Area].Point
                end
            end
            return game:GetService("Workspace")["__WORKSPACE"].Areas[GetAreas("farm")[table.find(GetAreas("farm"), _G.Config.Farm.Area) + 1]].Point
        elseif EnemyType == "Defense" then
            if #game:GetService("Workspace")["__WORKSPACE"].Mobs:FindFirstChild(_G.Config.Defense.ID):GetChildren() > 0 then
                for _, v in next, game:GetService("Workspace")["__WORKSPACE"].Mobs:FindFirstChild(_G.Config.Defense.ID):GetChildren() do
                    if v:FindFirstChild("Settings").HP.Value > 0 then
                        return v
                    end
                end
            else
                return game:GetService("Workspace")["__CURRENTAREA"][_G.Config.Defense.ID]
            end
        elseif EnemyType == "Boss" then
            if game:GetService("ReplicatedStorage").MapInfo.Value ~= "" then
                for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Mobs[game:GetService("ReplicatedStorage").MapInfo.Value]:GetChildren()) do
                    if v:FindFirstChild("Boss") then
                        return v
                    end
                end
            end
        end
    end
    local function GetDefense(option, option2)
        local t = {}
        local defenses = {
            Defense = "Defense 1",
            Defense2 = "Defense 2",
            Defense_3 = "Defense 3"
        }
        if option == "allid" then
            for k, v in pairs(defenses) do
                table.insert(t, k)
            end
        elseif option == "allnames" then
            for k, v in pairs(defenses) do
                table.insert(t, v)
            end
        elseif option == "id" then
            for k, v in pairs(defenses) do
                if v == option2 then
                    return k
                end
            end
        elseif option == "name" then
            for k, v in pairs(defenses) do
                if k == option2 then
                    return v
                end
            end
        end
        table.sort(t, function(a, b)
            local v1 = tonumber(string.match(a, "%d+"))
            local v2 = tonumber(string.match(b, "%d+"))
            return v1 < v2
        end)
        return t
    end
    local function GetPowerArea(option)
        if option == "all" then
            local t = {}
            for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Useless:GetChildren()) do
                if v.Name == "x2Area" then
                    local i, j = string.find(v["W-1"].Gui.Title.Text, "%a%d+")
                    table.insert(t, string.sub(v["W-1"].Gui.Title.Text, i, j))
                end
            end
            return t
        else
            for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Useless:GetChildren()) do
                if v.Name == "x2Area" then
                    if string.match(v["W-1"].Gui.Title.Text, option) then
                        return v.CF
                    end
                end
            end
        end
    end
    local function HasBoost(BoostName)
        for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.BoostsFrame:GetChildren()) do
            if v:IsA("ImageLabel") and string.match(v.Name, BoostName) then
                return v.Visible
            end
        end
    end

    task.wait(5)

    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local NameCallMethod = getnamecallmethod()
        if tostring(string.lower(NameCallMethod)) == "kick" then
            return nil
        end
        return OldNameCall(Self, ...)
    end)

    -- GUI

        local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/mazterziN/Hub/main/MaterialUI.lua"))()
        local UI = Material.Load({
            Title = hubname,
            Style = 1,
            SizeX = 350,
            SizeY = 400,
            Theme = "VeryDark",
        })
        local MainPg = UI.New({
            Title = "MAIN"
        })
        local GpPg = UI.New({
            Title = "Gamepasses"
        })
        local UiPg = UI.New({
            Title = "UI"
        })
        local MiscPg = UI.New({
            Title = "MISC"
        })

        -- MAIN

            MainPg.Toggle({
                Text = "Auto Farm",
                Callback = function(v)
                    _G.Config.Farm.Enabled = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Farm.Enabled
            })
            _G.AreasDD = MainPg.Dropdown({
                Text = "Area",
                Callback = function(v)
                    _G.Config.Farm.Area = v
                    _G.EnemiesDD:SetOptions(GetFighters("mobs", v))
                    SaveConfig()
                end,
                Options = GetAreas("farm")
            })
            _G.EnemiesDD = MainPg.Dropdown({
                Text = "Enemies",
                Callback = function(v)
                    _G.Config.Farm.Enemy = v
                    SaveConfig()
                end,
                Options = GetFighters("mobs", _G.Config.Farm.Area)
            })
            MainPg.Toggle({
                Text = "Auto Defense",
                Callback = function(v)
                    _G.Config.Defense.Enabled = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Defense.Enabled
            })
            _G.DefenseDD = MainPg.Dropdown({
                Text = "Select Defense",
                Callback = function(v)
                    _G.Config.Defense.ID = GetDefense("id", v)
                    SaveConfig()
                end,
                Options = GetDefense("allnames")
            })
            MainPg.Toggle({
                Text = "Auto Power Area",
                Callback = function(v)
                    _G.Config.PowerArea.Enabled = v
                    SaveConfig()
                end,
                Enabled = _G.Config.PowerArea.Enabled
            })
            _G.PowerAreaDD = MainPg.Dropdown({
                Text = "Select Power Area",
                Callback = function(v)
                    _G.Config.PowerArea.Multiplier = v
                    SaveConfig()
                end,
                Options = GetPowerArea("all")
            })
            MainPg.Toggle({
                Text = "Auto Skill Bosses",
                Callback = function(v)
                    _G.Config.Bosses = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Bosses
            })
            MainPg.Toggle({
                Text = "Auto Click",
                Callback = function(v)
                    _G.Config.Click = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Click
            })
            MainPg.Toggle({
                Text = "Auto Collect",
                Callback = function(v)
                    _G.Config.Collect = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Collect
            })
            MainPg.Toggle({
                Text = "Auto Rank Up",
                Callback = function(v)
                    _G.Config.Rankup = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Rankup
            })
            MainPg.Toggle({
                Text = "Auto Buy Aura",
                Callback = function(v)
                    _G.Config.Aura = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Aura
            })
            MainPg.Toggle({
                Text = "Auto Buy Weapon",
                Callback = function(v)
                    _G.Config.Weapon = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Weapon
            })
            
        -- GAMEPASSES

            for k, value in pairs(_G.Config.Gamepasses) do
                GpPg.Toggle({
                    Text = k,
                    Callback = function(v)
                        _G.Config.Gamepasses[k] = v
                        SaveConfig()
                    end,
                    Enabled = _G.Config.Gamepasses[k]
                })
            end

        -- UI

            local UIS = {
                "Fuse",
                "Rank Up",
                "Stats",
                "Avatars",
                "Auras",
                "System",
                "Passive",
                "Artifacts",
                "Exchange",
                "Grimoires",
                "Backpack",
                "Weapons",
                "Settings"
            }
            table.sort(UIS, function(a, b) return a:lower() < b:lower() end)

            for _, v in pairs(UIS) do
                UiPg.Button({
                    Text = v,
                    Callback = function()
                        local ui = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Modules.Functions)
                        ui.OpenFrame("", v)
                    end
                })
            end

        -- MISC 

            local TimeLabel = MiscPg.Label({Text = ""})

            MiscPg.Button({
                Text = "Rejoin",
                Callback = function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
                end
            })
            MiscPg.Button({
                Text = "Server Hop",
                Callback = function()
                    ServerHop(game.PlaceId)
                end
            })
            MiscPg.Button({
                Text = "Redeem Codes",
                Callback = function()
                    RedeemCodes()
                end
            })
            _G.Keybind = MiscPg.Button({
                Text = "Keybind",
                Callback = function(v)
                    if not _G.SelectingKey then
                        _G.SelectingKey = true
                    end
                end
            })
            
            MiscPg.Toggle({
                Text = "Auto Open Fighters",
                Callback = function(v)
                    _G.Config.OpenFighter = v
                    SaveConfig()
                end,
                Enabled = _G.Config.OpenFighter
            })
            MiscPg.Toggle({
                Text = "Triple Open Fighters",
                Callback = function(v)
                    _G.Config.TripleOpen = v
                    SaveConfig()
                end,
                Enabled = _G.Config.TripleOpen
            })
            _G.FightersPointDD = MiscPg.Dropdown({
                Text = "Map To Open",
                Callback = function(v)
                    _G.Config.MapToOpen = v
                    _G.Config.UnitsToDelete = {}
                    _G.DeleteUnitsDD:SetOptions(GetFighters("fighterspoint", _G.Config.MapToOpen))
                    SaveConfig()
                end,
                Options = GetAreas("farm")
            })
            _G.DeleteUnitsDD = MiscPg.Dropdown({
                Text = "Delete Units",
                Callback = function(v)
                    if _G.Config.UnitsToDelete[v] then
                        _G.Config.UnitsToDelete[v] = false
                    else
                        _G.Config.UnitsToDelete[v] = true
                    end
                    for i, v in pairs(_G.Config.UnitsToDelete) do
                        print(i,v)
                    end
                    SaveConfig()
                end,
                Options = GetFighters("fighterspoint", _G.Config.MapToOpen)
            })

            MiscPg.Toggle({
                Text = "Auto Use Boosts",
                Callback = function(v)
                    _G.Config.UseBoosts = v
                    SaveConfig()
                end,
                Enabled = _G.Config.UseBoosts
            })
            _G.BoostsDD = MiscPg.Dropdown({
                Text = "Select Boosts",
                Callback = function(v)
                    if not table.find(_G.Config.Boosts, v) then
                        table.insert(_G.Config.Boosts, v)
                    else
                        table.remove(_G.Config.Boosts, table.find(_G.Config.Boosts, v))
                    end
                    SaveConfig()
                end,
                Options = {"Coins", "Power", "Damage", "Lucky"}
            })

            MiscPg.Toggle({
                Text = "Always Set",
                Callback = function(v)
                    _G.Config.AlwaysSet = v
                    SaveConfig()
                end,
                Enabled = _G.Config.AlwaysSet
            })
            MiscPg.Slider({
                Text = "Walk Speed",
                Callback = function(v)
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
                    _G.Config.WalkSpeed = v
                    SaveConfig()
                end,
                Min = 16,
                Max = 256,
                Def = _G.Config.WalkSpeed
            })
            MiscPg.Slider({
                Text = "Jump Power",
                Callback = function(v)
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
                    _G.Config.JumpPower = v
                    SaveConfig()
                end,
                Min = 50,
                Max = 200,
                Def = _G.Config.JumpPower
            })
            MiscPg.Toggle({
                Text = "Auto Claim Gifts",
                Callback = function(v)
                    _G.Config.ClaimGifts = v
                    SaveConfig()
                end,
                Enabled = _G.Config.ClaimGifts
            })
            MiscPg.Toggle({
                Text = "Hide Name",
                Callback = function(v)
                    _G.Config.HideName = v
                    SaveConfig()
                end,
                Enabled = _G.Config.HideName
            })

    -- MAIN FUNCTIONS

        function CheckBody()
            while wait() do
                pcall(function()
                    if _G.Config.Farm.Enabled or _G.Config.Defense.Enabled or _G.Config.OpenFighter or _G.Config.PowerArea.Enabled then
                        if game.Players.LocalPlayer.Character then
                            if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Body") then
                                Body("create", "Velocity", "Body", game.Players.LocalPlayer.Character.HumanoidRootPart)
                            end
                        end
                    else
                        Body("remove")
                    end
                end)
            end
        end
        function Farm()
            while wait() do
                pcall(function()
                    if _G.Config.Farm.Enabled then
                        if game.Players.LocalPlayer.Character then
                            if GetEnemy("Farm"):IsA("Model") then
                                TeleportTo(GetEnemy("Farm").HumanoidRootPart.CFrame)
                                Click("attack", GetEnemy("Farm"))
                            elseif GetEnemy("Farm"):IsA("BasePart") then
                                TeleportTo(GetEnemy("Farm").CFrame)
                            end
                        end
                    end
                end)
            end
        end
        function Defense()
            while wait() do
                pcall(function()
                    if _G.Config.Defense.Enabled and not _G.Config.Farm.Enabled then
                        if game.Players.LocalPlayer.Character then
                            if GetEnemy("Defense"):IsA("Model") then
                                TeleportTo(GetEnemy("Defense").HumanoidRootPart.CFrame)
                                Click("attack", GetEnemy("Defense"))
                            elseif GetEnemy("Defense"):IsA("BasePart") then
                                TeleportTo(GetEnemy("Defense").CFrame + Vector3.new(0,20,0))
                            end
                            for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Useless:GetChildren()) do
                                if v.Name == "Part" and v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                                if v.Name == "Model" and v:IsA("Model") then
                                    for i, v in pairs(v:GetChildren()) do
                                        if string.match(v.Name, "13_") then
                                            v.CanCollide = false
                                        end
                                    end
                                end
                            end
                        end
                    else
                        for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Useless:GetChildren()) do
                            if v.Name == "Part" and v:IsA("BasePart") then
                                v.CanCollide = true
                            end
                            if v.Name == "Model" and v:IsA("Model") then
                                for i, v in pairs(v:GetChildren()) do
                                    if string.match(v.Name, "13_") then
                                        v.CanCollide = true
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
        function PowerArea()
            while wait() do
                pcall(function()
                    if _G.Config.PowerArea.Enabled then
                        TeleportTo(GetPowerArea(_G.Config.PowerArea.Multiplier).CFrame + Vector3.new(10,3,0))
                        Click("train")
                    end
                end)
            end
        end
        function Bosses()
            while wait() do
                pcall(function()
                    if _G.Config.Bosses and not _G.Config.Defense.Enabled and not _G.Config.Farm.Enabled then
                        if game.Players.LocalPlayer.Character then
                            if GetEnemy("Boss"):IsA("Model") then
                                TeleportTo(GetEnemy("Boss").HumanoidRootPart.CFrame)
                                Click("attack", GetEnemy("Boss"))
                            elseif GetEnemy("Boss"):IsA("BasePart") then
                                TeleportTo(GetEnemy("Boss").CFrame)
                            end
                        end
                    end
                end)
            end
        end
        function Clicker()
            while wait() do
                pcall(function()
                    if _G.Config.Click then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                    end
                end)
            end
        end
        function Collect()
            while wait() do
                pcall(function()
                    if _G.Config.Collect then
                        for _, v in pairs(game:GetService("Workspace")["__DROPS"]:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.Size = Vector3.new(0.5,0.5,0.5)
                                v.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                            end
                        end
                    end
                end)
            end
        end
        function Rankup()
            while wait() do
                pcall(function()
                    if _G.Config.Rankup then
                        game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"RankUp"})
                    end
                end)
            end
        end
        function Aura()
            while wait() do
                pcall(function()
                    if _G.Config.Aura then
                        game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"Aura"})
                    end
                end)
            end
        end
        function Weapon()
            while wait() do
                pcall(function()
                    if _G.Config.Weapon then
                        game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"Weapon"})
                    end
                end)
            end
        end
        function Gamepasses()
            while wait() do
                pcall(function()
                    local Service = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
                    for k, v in pairs(_G.Config.Gamepasses) do
                        Service.PlayerData.Gamepasses[k] = v
                    end
                end)
            end
        end
        function OpenFighter()
            while wait() do
                pcall(function()
                    if _G.Config.OpenFighter then
                        TeleportTo(game.Workspace.__WORKSPACE.FightersPoint[_G.Config.MapToOpen].CF.CFrame + Vector3.new(8,3,0))
                        OpenType = "E" if _G.Config.TripleOpen then OpenType = "R" end
                        game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"BuyTier", workspace.__WORKSPACE.FightersPoint:FindFirstChild(_G.Config.MapToOpen), OpenType, _G.Config.UnitsToDelete})
                    end
                end)
            end
        end
        function UseBoosts()
            while wait(1) do
                pcall(function()
                    if _G.Config.UseBoosts then
                        for _, v in pairs(_G.Config.Boosts) do
                            if not HasBoost(v) then
                                game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"BoostUse", "x2 "..v})
                            end
                        end
                    end
                end)
            end
        end
        function HideName()
            while wait() do
                pcall(function()
                    if _G.Config.HideName then
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Character.Head:FindFirstChild("HUD") then
                            game.Players.LocalPlayer.Character.Head:FindFirstChild("HUD"):Destroy()
                        end
                    end
                end)
            end
        end
        function ClaimGifts()
            while wait(5) do
                pcall(function()
                    if _G.Config.ClaimGifts then
                        for i = 1, 10 do
                            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"Gift", "Gift_"..i})
                        end
                    end
                end)
            end
        end
        function MaxDistance()
            while wait() do
                pcall(function()
                    game:GetService("Players").LocalPlayer.PlayerGui.UI.CenterFrame.Settings.Frame.MaxDistance.Frame.TextBox.Text = 100000
                end)
            end
        end
        function RemoveErrors()
            while wait() do
                pcall(function()
                    if game:GetService("Players").LocalPlayer.PlayerGui and game:GetService("Players").LocalPlayer.PlayerGui.UI then
                        game:GetService("Players").LocalPlayer.PlayerGui.UI.Error.Visible = false
                    end
                end)
            end
        end

        task.spawn(CheckBody)
        task.spawn(Farm)
        task.spawn(Defense)
        task.spawn(PowerArea)
        task.spawn(Bosses)
        task.spawn(Clicker)
        task.spawn(Collect)
        task.spawn(Rankup)
        task.spawn(Aura)
        task.spawn(Weapon)
        task.spawn(Gamepasses)
        task.spawn(OpenFighter)
        task.spawn(UseBoosts)
        task.spawn(HideName)
        task.spawn(ClaimGifts)
        task.spawn(MaxDistance)
        task.spawn(RemoveErrors)

    -- MAIN SERVICES

        game:GetService("RunService").RenderStepped:Connect(function()

            _G.AreasDD:SetText("Area Selected: ".. _G.Config.Farm.Area)
            _G.EnemiesDD:SetText("Enemy Selected: ".. _G.Config.Farm.Enemy)

            _G.DefenseDD:SetText("Defense Selected: ".. GetDefense("name", _G.Config.Defense.ID))

            _G.PowerAreaDD:SetText("Power Area Selected: ".. _G.Config.PowerArea.Multiplier)

            local gt = math.floor(workspace.DistributedGameTime+0.5)
            local h = math.floor(gt/(60^2))%24
            local m = math.floor(gt/(60^1))%60
            local s = math.floor(gt/(60^0))%60
            TimeLabel.SetText("TIME PLAYED: "..h.."h "..m.."min "..s.."s")

            _G.FightersPointDD:SetText("Map Selected: ".. _G.Config.MapToOpen)

            local FightersCount = 0
            local FightersSelected = {}
            for k, v in pairs(_G.Config.UnitsToDelete) do
                if v == true then
                    FightersCount += 1
                    table.insert(FightersSelected, k)
                end
            end

            if FightersCount > 0 then
                _G.DeleteUnitsDD:SetText("Delete: ".. table.concat(FightersSelected, ", "))
            else
                _G.DeleteUnitsDD:SetText("Select Units to Delete")
            end

            if #_G.Config.Boosts > 1 then
                _G.BoostsDD:SetText("Boosts Selected: ".. table.concat(_G.Config.Boosts, ", "))
            elseif #_G.Config.Boosts == 1 then
                _G.BoostsDD:SetText("Boost Selected: ".. table.concat(_G.Config.Boosts, ", ")) else 
                _G.BoostsDD:SetText("Select Boosts")
            end

            if _G.Config.AlwaysSet then
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.Config.WalkSpeed
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.Config.JumpPower
                end
            end
            if not _G.SelectingKey and _G.Keybind then
                local key = string.gsub(_G.Config.Keybind, "Enum.KeyCode.", "")
                _G.Keybind:SetText("Keybind: " .. key) else _G.Keybind:SetText("Keybind: ...")
            end
        end)
        game:GetService("UserInputService").InputBegan:connect(function(input, processed)
            if input.UserInputType == Enum.UserInputType.Keyboard and _G.SelectingKey then
                local Key = string.split(tostring(input.KeyCode), ".")[3]
                local BlockedKeys = {"W", "A", "S", "D", "Space"}
                if not table.find(BlockedKeys, Key) then
                    _G.SelectingKey = false
                    _G.Config.Keybind = tostring(input.KeyCode)
                    SaveConfig()
                end
            end
            if tostring(input.KeyCode) == _G.Config.Keybind and not processed then
                if game:GetService("CoreGui"):FindFirstChild(hubname) then
                    if game:GetService("CoreGui")[hubname].Enabled then
                        game:GetService("CoreGui")[hubname].Enabled = false
                    else
                        game:GetService("CoreGui")[hubname].Enabled = true
                    end
                end
            end
        end)

else
    local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/mazterziN/Hub/main/NotifierUI.lua"))()
    Notify.new("ERROR", "MAZTER HUB", "You are not whitelisted.", true, 10)
end

repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

if loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/WL.lua"))() and game.PlaceId == 10723695195 then

    task.wait(5)

    _G.Config = {

        Farm = {
            Enabled = false,
            KillMob = true,
            Range = "Low [No Lag]",
            Mob = "Luffe",
            Area = "Ooy Piece",
            Areas = {}
        },
        Defense = {
            Enabled = false,
            IDS = {}
        },
        PowerArea = {
            Enabled = false,
            Multiplier = "x2",
        },
        Test = {
            Enabled = false,
            Name = "hero"
        },

        Bosses = false,
        Click = false,
        Collect = false,
        Rankup = false,
        Aura = false,
        Weapon = false,

        Fuse = false,
        FightersToFuse = {},

        OpenFighter = false,
        TripleOpen = false,
        MapToOpen = "Ooy Piece",
        UnitsToDelete = {},

        Infos = {
            Defense = "1"
        },

        EquipBest = false,
        EquipDelay = 10,

        UseSkills = false,
        Skills = {},
        UseBoosts = false,
        Boosts = {},

        HideName = false,
        HideRank = false,
        ClaimGifts = false,

        AlwaysSet = true,
        WalkSpeed = 16,
        JumpPower = 50,
        Keybind = "Enum.KeyCode.RightAlt",

        ConfigChanges = 1.6
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
            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"AttackMob", Target, "Left Arm"})
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
            "15KLIKES",
            "20KLIKES",
            "25KLIKES",
            "30KLIKES",
            "8MVISITS",
            "10MVISITS",
            "35KFAVS",
            "50KFAVS"
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
                    if v["Id"] == i and not v["NoBuy"] and not string.match(name, "Defense") and not string.match(name, "Dungeon") then
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
        elseif GetType == "all" then
            local t = {}
            local fgt = require(game:GetService("ReplicatedStorage").Modules.Fighters)
            for k, v in pairs(fgt) do
                if not table.find(t, k) then
                    table.insert(t, k)
                end
            end
            return t
        end
    end
    local function GetDefenses()
        local areas = require(game:GetService("ReplicatedStorage").Modules.Areas)
        local defenses = {}
        for i, v in pairs(areas) do
            if string.match(i, "Defense") then
                table.insert(defenses, i)
            end
        end
        return defenses
    end
    local function GetDefense(option)
        if option[2] == "1" then option[2] = "" end
        if option[1] == "Highest Wave" then
            local svc = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
            return svc.PlayerData["DefenseMode"..option[2]]["MaxWaveHit"]
        end
        if option[1] == "Current Wave" then
            return game:GetService("ReplicatedStorage")["DefenseMode"..option[2]].Wave.Value
        end
        if option[1] == "Status" then
            return game:GetService("ReplicatedStorage")["DefenseMode"..option[2]].WaveStatus.Value
        end
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
            table.sort(t, function(a, b)
                local v1 = tonumber(string.match(a, "%d+"))
                local v2 = tonumber(string.match(b, "%d+"))
                return v1 > v2
            end)
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
    local function GetBosses()
        local t = {}
        for i, v in pairs(game:GetService("ReplicatedStorage").Assets.Bosses:GetChildren()) do
            table.insert(t, v.Name)
        end
        return t
    end
    local function GetEnemy(EnemyType)
        if EnemyType == "Farm" then
            for _, v in next, game:GetService("Workspace")["__WORKSPACE"].Mobs:FindFirstChild(_G.Config.Farm.Area):GetChildren() do
                if game:GetService("Workspace")["__WORKSPACE"].Mobs[_G.Config.Farm.Area]:FindFirstChild(_G.Config.Farm.Mob) then
                    if v.Name == _G.Config.Farm.Mob then
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
                    if table.find(GetBosses(), v.Name) then
                        return v
                    end
                end
            end
        end
    end
    local function GetSkill(Op1, Op2)
        local skills = require(game:GetService("ReplicatedStorage").Modules.Skill)
        if Op1 == "name" then
            return skills[Op2]["Nome"]
        elseif Op1 == "id" then
            for i, v in pairs(skills) do
                if v["Nome"] == Op2 then
                    return i
                end
            end
        elseif Op1 == "all" then
            local t = {}
            for i, v in ipairs(skills) do
                table.insert(t, v["Nome"])
            end
            return t
        end
    end
    local function GetTest(option)
        local tests = {
            "Hero",
            "Magic Knight"
        }
        if option[1] == "all" then
            return tests
        end
        if option[1] == "name" then
            for i, v in pairs(tests) do
                if string.lower(string.split(v, " ")[1]) == option[2] then
                    return v
                end
            end
        end
        if option[1] == "hero" then
            if option[2] == "loc" then
                return game:GetService("Workspace")["Hero Test"].CFrame
            end
            if option[2] == "actived" then
                return game:GetService("ReplicatedStorage").HEROTEST.HEROTEST.Value
            end
        end
        if option[1] == "magic" then
            if option[2] == "loc" then
                return game:GetService("Workspace")["Magic Knight Test"].CFrame
            end
            if option[2] == "actived" then
                return game:GetService("ReplicatedStorage").MAGICTEST.MAGICTEST.Value
            end
        end
    end
    local function Search(op, texttofilter)
        local t = {}
        if op == "all" then
            for i, v in pairs(GetFighters("all")) do
                if string.match(string.lower(v), string.lower(texttofilter)) then
                    table.insert(t, v)
                end
            end
        end
        table.sort(t, function(a, b) return a:lower() < b:lower() end)
        return t
    end
    local function HasBoost(BoostName)
        for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.BoostsFrame:GetChildren()) do
            if v:IsA("ImageLabel") and string.match(v.Name, BoostName) then
                return v.Visible
            end
        end
    end
    local function CanFuse(Fighter)
        if Fighter.Frame.ImageColor3 == Color3.fromRGB(47, 193, 31) then
            return false
        else
            return true
        end
    end
    local function GetFightersToFuse(FighterName)
        local t = {}
        local a = 0
        for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.CenterFrame.Backpack.Frame:GetChildren()) do
            if v:IsA("ImageLabel") and v.Frame.ViewportFrame:FindFirstChildWhichIsA("Model").Name == FighterName and CanFuse(v) and a < 10 then
                t[v.Name] = true
                a += 1
            end
        end
        if a == 10 then
            return t
        else
            return {}
        end
    end
    local function Fusion(Fighters)
        game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"Fuse", Fighters})
    end

    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local NameCallMethod = getnamecallmethod()
        if tostring(string.lower(NameCallMethod)) == "kick" then
            return nil
        end
        return OldNameCall(Self, ...)
    end)

    -- GUI

        local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/MaterialLibrary.lua"))()
        local UI = Material.Load({
            Title = hubname,
            Style = 1,
            SizeX = 550,
            SizeY = 400,
            Theme = "VeryDark",
        })
        local MainPg = UI.New({
            Title = "MAIN"
        })
        local FgtPg = UI.New({
            Title = "FIGHTERS"
        })
        local UiPg = UI.New({
            Title = "UI"
        })
        local InfosPg = UI.New({
            Title = "INFOS"
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
            MainPg.Toggle({
                Text = "Kill Selected Mob",
                Callback = function(v)
                    _G.Config.Farm.KillMob = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Farm.KillMob
            })
            _G.RangeDD = MainPg.Dropdown({
                Text = "Kill Aura Range",
                Callback = function(v)
                    _G.Config.Farm.Range = v
                    SaveConfig()
                end,
                Options = {
                    "High [Very Lag]",
                    "Low [No Lag]"
                }
            })
            _G.AreasDD = MainPg.Dropdown({
                Text = "Area",
                Callback = function(v)
                    if _G.Config.Farm.KillMob then
                        _G.Config.Farm.Area = v
                        _G.Config.Farm.Mob = ""
                        _G.MobsDD:SetOptions(GetFighters("mobs", v))
                    else
                        if not table.find(_G.Config.Farm.Areas, v) then
                            table.insert(_G.Config.Farm.Areas, v)
                        else
                            table.remove(_G.Config.Farm.Areas, table.find(_G.Config.Farm.Areas, v))
                        end
                        _G.Config.Farm.Mob = ""
                        _G.MobsDD:SetOptions(GetFighters("mobs", _G.Config.Farm.Area))
                    end
                    SaveConfig()
                end,
                Options = GetAreas("farm")
            })
            _G.MobsDD = MainPg.Dropdown({
                Text = "Mobs",
                Callback = function(v)
                    _G.Config.Farm.Mob = v
                    SaveConfig()
                end,
                Options = GetFighters("mobs", _G.Config.Farm.Area)
            })
            MainPg.Button({
                Text = "Set Current Area",
                Callback = function()
                    pcall(function()
                        local Service = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
                        _G.Config.Farm.Area = tostring(Service.CurrentArea)
                        _G.Config.Farm.Mob = ""
                        _G.MobsDD:SetOptions(GetFighters("mobs", tostring(Service.CurrentArea)))
                        SaveConfig()
                    end)
                end
            })
            MainPg.Button({
                Text = "Set Avatar",
                Callback = function()
                    pcall(function()
                        if _G.Config.Farm.Mob ~= "" then
                            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"CharacterChange", _G.Config.Farm.Mob})
                        end
                    end)
                end
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
                    if not table.find(_G.Config.Defense.IDS, v) then
                        table.insert(_G.Config.Defense.IDS, v)
                    else
                        table.remove(_G.Config.Defense.IDS, table.find(_G.Config.Defense.IDS, v))
                    end
                    SaveConfig()
                end,
                Options = GetDefenses()
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
                Text = "Auto Test",
                Callback = function(v)
                    _G.Config.Test.Enabled = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Test.Enabled
            })
            _G.TestDD = MainPg.Dropdown({
                Text = "Select Test",
                Callback = function(v)
                    _G.Config.Test.Name = string.lower(string.split(v, " ")[1])
                    SaveConfig()
                end,
                Options = GetTest({"all"})
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

        -- FIGHTERS

            FgtPg.Toggle({
                Text = "Auto Open Fighters",
                Callback = function(v)
                    _G.Config.OpenFighter = v
                    SaveConfig()
                end,
                Enabled = _G.Config.OpenFighter
            })
            FgtPg.Toggle({
                Text = "Triple Open Fighters",
                Callback = function(v)
                    _G.Config.TripleOpen = v
                    SaveConfig()
                end,
                Enabled = _G.Config.TripleOpen
            })
            FgtPg.Button({
                Text = "Set Current Map",
                Callback = function()
                    pcall(function()
                        local Service = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
                        _G.Config.MapToOpen = tostring(Service.CurrentArea)
                        _G.Config.UnitsToDelete = {}
                        _G.DeleteUnitsDD:SetOptions(GetFighters("fighterspoint", tostring(Service.CurrentArea)))
                        SaveConfig()
                    end)
                end
            })
            _G.FightersPointDD = FgtPg.Dropdown({
                Text = "Map To Open",
                Callback = function(v)
                    _G.Config.MapToOpen = v
                    _G.Config.UnitsToDelete = {}
                    _G.DeleteUnitsDD:SetOptions(GetFighters("fighterspoint", _G.Config.MapToOpen))
                    SaveConfig()
                end,
                Options = GetAreas("farm")
            })
            _G.DeleteUnitsDD = FgtPg.Dropdown({
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
            FgtPg.Toggle({
                Text = "Auto Fuse",
                Callback = function(v)
                    _G.Config.Fuse = v
                    SaveConfig()
                end,
                Enabled = _G.Config.Fuse
            })
            FgtPg.TextField({
                Text = "Search Fighter",
                Callback = function(v)
                    _G.FuseDD:SetOptions(Search("all", v))
                end
            })
            _G.FuseDD = FgtPg.Dropdown({
                Text = "Fighters To Fuse",
                Callback = function(op)
                    if not table.find(_G.Config.FightersToFuse, op) then
                        table.insert(_G.Config.FightersToFuse, op)
                    else
                        table.remove(_G.Config.FightersToFuse, table.find(_G.Config.FightersToFuse, op))
                    end
                    SaveConfig()
                end,
                Options = GetFighters("all")
            })

        -- UI

            local UIS = {
                "Fuse",
                "Rank Up",
                "Avatars",
                "Auras",
                "Passive",
                "Artifacts",
                "Exchange",
                "Grimoires",
                "Weapons"
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

        -- INFOS

            _G.Infos = {}
            _G.Infos["Defense"] = InfosPg.Dropdown({
                Text = "Defense",
                Callback = function(v)
                    local def = string.match(v, "%d+")
                    if def == nil then def = "1" end
                    _G.Config.Infos.Defense = def
                    SaveConfig()
                end,
                Options = GetDefenses()
            })
            _G.DefenseLabels = {}
            _G.DefenseLabels["Highest Wave"] = InfosPg.Label({Text = ""})
            _G.DefenseLabels["Current Wave"] = InfosPg.Label({Text = ""})
            _G.DefenseLabels["Status"] = InfosPg.Label({Text = ""})

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
                Text = "Auto Equip Best",
                Callback = function(v)
                    _G.Config.EquipBest = v
                    SaveConfig()
                end,
                Enabled = _G.Config.EquipBest
            })
            MiscPg.Slider({
                Text = "Equip Delay [In Seconds]",
                Callback = function(v)
                    _G.Config.EquipDelay= v
                    SaveConfig()
                end,
                Min = 10,
                Max = 30,
                Def = _G.Config.EquipDelay
            })
            MiscPg.Toggle({
                Text = "Auto Use Skills",
                Callback = function(v)
                    _G.Config.UseSkills = v
                    SaveConfig()
                end,
                Enabled = _G.Config.UseSkills
            })
            _G.SkillsDD = MiscPg.Dropdown({
                Text = "Select Skills",
                Callback = function(v)
                    if not table.find(_G.Config.Skills, v) then
                        table.insert(_G.Config.Skills, v)
                    else
                        table.remove(_G.Config.Skills, table.find(_G.Config.Skills, v))
                    end
                    SaveConfig()
                end,
                Options = GetSkill("all")
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
            MiscPg.Toggle({
                Text = "Hide Rank",
                Callback = function(v)
                    _G.Config.HideRank = v
                    SaveConfig()
                end,
                Enabled = _G.Config.HideRank
            })

    -- MAIN FUNCTIONS

        function CheckBody()
            while wait() do
                pcall(function()
                    if _G.Config.OpenFighter or _G.Config.PowerArea.Enabled or _G.Config.Test.Enabled and GetTest({_G.Config.Test.Name, "actived"}) then
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
                        if not _G.Config.Farm.KillMob then
                            for i, v in pairs(workspace.__WORKSPACE.Mobs:GetChildren()) do
                                if table.find(_G.Config.Farm.Areas, v.Name) then
                                    for i2, v2 in pairs(v:GetChildren()) do 
                                        Click("attack", v2)
                                    end
                                end
                            end
                        else
                            if _G.Config.Farm.Mob ~= "" then
                                for i, v in pairs(workspace.__WORKSPACE.Mobs[_G.Config.Farm.Area]:GetChildren()) do
                                    if v.Name == _G.Config.Farm.Mob then
                                        Click("attack", v)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
        function Defense()
            while wait() do
                pcall(function()
                    if _G.Config.Defense.Enabled then
                        for i, v in pairs(workspace.__WORKSPACE.Mobs:GetChildren()) do
                            if table.find(_G.Config.Defense.IDS, v.Name) then
                                for i2, v2 in pairs(v:GetChildren()) do 
                                    Click("attack", v2)
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
                    if _G.Config.PowerArea.Enabled and (not _G.Config.Test.Enabled or _G.Config.Test.Enabled and not GetTest({_G.Config.Test.Name, "actived"})) then
                        TeleportTo(GetPowerArea(_G.Config.PowerArea.Multiplier).CFrame + Vector3.new(10,3,0))
                        Click("train")
                    end
                end)
            end
        end
        function Test()
            while wait() do
                pcall(function()
                    if _G.Config.Test.Enabled and GetTest({_G.Config.Test.Name, "actived"}) and not _G.Config.OpenFighter then
                        TeleportTo(GetTest({_G.Config.Test.Name, "loc"}) + Vector3.new(0, -5, 10))
                        Click("train")
                    end
                end)
            end
        end
        function SkillBosses()
            while wait() do
                pcall(function()
                    if _G.Config.Bosses then
                        if game:GetService("ReplicatedStorage").MapInfo.Value ~= "" then
                            for i, v in pairs(game:GetService("Workspace")["__WORKSPACE"].Mobs[game:GetService("ReplicatedStorage").MapInfo.Value]:GetChildren()) do
                                if table.find(GetBosses(), v.Name) then
                                    Click("attack", v)
                                end
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
                                v.CanCollide = false
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
        function Fuse()
            while wait() do
                pcall(function()
                    if _G.Config.Fuse and #_G.Config.FightersToFuse > 0 then
                        for i, v in pairs(_G.Config.FightersToFuse) do
                            Fusion(GetFightersToFuse(v))
                        end
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
        function EquipBest()
            while wait(_G.Config.EquipDelay) do
                pcall(function()
                    if _G.Config.EquipBest then
                        local svc = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
                        local fgt = require(game:GetService("ReplicatedStorage").Modules.Fighters)
                        local fighters = {}
                        svc.CallEvent:Fire({"FighterRefesh"})
                        for i, v in pairs(svc.PlayerData.Fighters) do
                            if v["Equipped"] then
                                game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"EquipFighter", v["ID"], "FastMode"})
                            end
                            table.insert(fighters, {v["FuseBoost"] or fgt[v["Name"]]["Power"], v["ID"]})
                        end
                        table.sort(fighters, function(p10, p11)
                            return p11[1] < p10[1]
                        end)
                        local MaxEquip = tonumber(string.match(string.match(game:GetService("Players").LocalPlayer.PlayerGui.UI.CenterFrame.Backpack.MaxEquip.TextLabel.Text, "/%d+"), "%d+"))
                        if MaxEquip > #fighters then MaxEquip = #fighters end
                        for i = 1, MaxEquip do
                            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"EquipFighter", fighters[i][2], true})
                        end
                        svc.CallEvent:Fire({"FighterRefesh"})
                    end
                end)
            end
        end
        function UseSkills()
            while wait() do
                pcall(function()
                    if _G.Config.UseSkills then
                        for i, v in pairs(_G.Config.Skills) do
                            game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"SkillUse", GetSkill("id", v)})
                        end
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
                        game.Players.LocalPlayer.Character.Head.HUD.Frame.PlayerName:Destroy()
                    end
                end)
            end
        end
        function HideRank()
            while wait() do
                pcall(function()
                    if _G.Config.HideRank then
                        if game.Players.LocalPlayer.Character.Head.HUD.Frame.RankName then
                            game.Players.LocalPlayer.Character.Head.HUD.Frame.RankName:Destroy()
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
        function Settings()
            while wait() do
                pcall(function()
                    local delay;
                    if _G.Config.Farm.Range == "High [Very Lag]" then delay = 100000 else delay = 400 end
                    if game:GetService("Players").LocalPlayer.PlayerGui.UI.CenterFrame.Settings.Frame.MaxDistance.Frame.TextBox.Text ~= delay then
                        game:GetService("Players").LocalPlayer.PlayerGui.UI.CenterFrame.Settings.Frame.MaxDistance.Frame.TextBox.Text = delay
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.UI.Error.Visible then
                        game:GetService("Players").LocalPlayer.PlayerGui.UI.Error.Visible = false
                    end
                    if game:GetService("Workspace")["__ANIMATION"].Camera then
                        game:GetService("Workspace")["__ANIMATION"].Camera:Destroy()
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Animation then
                        game:GetService("Players").LocalPlayer.PlayerGui.Animation:Destroy()
                    end
                end)
            end
        end

        task.spawn(CheckBody)
        task.spawn(Farm)
        task.spawn(Defense)
        task.spawn(PowerArea)
        task.spawn(Test)
        task.spawn(SkillBosses)
        task.spawn(Clicker)
        task.spawn(Collect)
        task.spawn(Rankup)
        task.spawn(Aura)
        task.spawn(Weapon)
        task.spawn(Fuse)
        task.spawn(OpenFighter)
        task.spawn(EquipBest)
        task.spawn(UseSkills)
        task.spawn(UseBoosts)
        task.spawn(HideName)
        task.spawn(HideRank)
        task.spawn(ClaimGifts)
        task.spawn(Settings)

    -- MAIN SERVICES

        game:GetService("RunService").RenderStepped:Connect(function()

            do -- MAIN

                if _G.Config.Farm.KillMob then
                    _G.AreasDD:SetText("Area Selected: ".. _G.Config.Farm.Area)
                elseif not _G.Config.Farm.KillMob then
                    if #_G.Config.Farm.Areas > 0 then
                        _G.AreasDD:SetText("Areas Selected: ".. table.concat(_G.Config.Farm.Areas, ", ")) else
                        _G.AreasDD:SetText("Select Area")
                    end
                end
                if _G.Config.Farm.Mob ~= "" then
                    _G.MobsDD:SetText("Mob Selected: ".. _G.Config.Farm.Mob) else
                    _G.MobsDD:SetText("Select Mob")
                end
                _G.RangeDD:SetText("Kill Aura Range: ".. _G.Config.Farm.Range)
                if #_G.Config.Defense.IDS > 1 then
                    _G.DefenseDD:SetText("Defenses Selected: ".. table.concat(_G.Config.Defense.IDS, ", ")) elseif #_G.Config.Defense.IDS == 1 then
                    _G.DefenseDD:SetText("Defense Selected: ".. table.concat(_G.Config.Defense.IDS, ", ")) else
                    _G.DefenseDD:SetText("Select Defenses")
                end
                _G.PowerAreaDD:SetText("Power Area Selected: ".. _G.Config.PowerArea.Multiplier)
                _G.TestDD:SetText("Test Selected: ".. GetTest({"name", _G.Config.Test.Name}))
                
            end

            do -- GAMEPASS

                pcall(function()
                    local Gamepasses = {"Teleport", "Auto Click", "Magnet", "Fast Open"}
                    local Service = require(game:GetService("Players").LocalPlayer.PlayerGui.UI.Client.Services)
                    for i, v in pairs(Gamepasses) do
                        Service.PlayerData.Gamepasses[v] = true
                    end
                end)

            end

            do -- FIGHTERS

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

                if #_G.Config.FightersToFuse > 0 then
                    _G.FuseDD:SetText("To Fuse: ".. table.concat(_G.Config.FightersToFuse, ", ")) else
                    _G.FuseDD:SetText("Select Fighters To Fuse")
                end

            end

            do -- INFOS
                _G.Infos["Defense"]:SetText("Defense Selected: ".. _G.Config.Infos.Defense)
                for i, v in pairs(_G.DefenseLabels) do
                    _G.DefenseLabels[i].SetText(i..": ".. GetDefense({i, _G.Config.Infos.Defense}))
                end
            end

            do -- MISC

                local gt = math.floor(workspace.DistributedGameTime+0.5)
                local h = math.floor(gt/(60^2))%24
                local m = math.floor(gt/(60^1))%60
                local s = math.floor(gt/(60^0))%60
                TimeLabel.SetText("TIME PLAYED: "..h.."h "..m.."min "..s.."s")

                if #_G.Config.Skills > 1 then
                    _G.SkillsDD:SetText("Skills Selected: ".. table.concat(_G.Config.Skills, ", "))
                elseif #_G.Config.Skills == 1 then
                    _G.SkillsDD:SetText("Skill Selected: ".. table.concat(_G.Config.Skills, ", ")) else 
                    _G.SkillsDD:SetText("Select Skills")
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
    local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/Notifier.lua"))()
    Notify.new("ERROR", "MAZTER HUB", "You are not whitelisted.", true, 10) 
end

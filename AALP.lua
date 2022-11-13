if game.PlaceId == 8349889591 then

    local AutoBuff = false
    local UnitsToBuff = {}

    local AutoUpgrade = false
    local ErwinUntilBuff = false
    local UnitsToUpgrade = {}

    local AutoSell = false
    local UnitsToSell = {}
    local SelectedWave = 15
    local SellInWave = false

    local SelectingKey = false
    local BlockedKeys = {"W", "A", "S", "D", "Space"}
    local Keybind = Enum.KeyCode.RightAlt
    local ReturnToLobby = true

    function UnitsInGame()
        local uig = {}
        local u = require(game:GetService("ReplicatedStorage").src.Data.Units)
        for i, v in pairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
            local uid = v["_stats"].id.Value
            if not table.find(uig, uid) then
                if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                    if u[uid]["cost"] and u[uid]["cost"] ~= 1 then
                        table.insert(uig, uid)
                    end
                end
            end
        end
        return uig
    end

    -- GUI
        local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/KamaadiN/DataStore/main/MaterialLibrary.lua"))()
        local UI = Material.Load({
            Title = " MAZTER HUB - Anime Adventures",
            Style = 1,
            SizeX = 300,
            SizeY = 325,
            Theme = "VeryDark",
        })

        local BuffPg = UI.New({
            Title = "BUFF"
        })
        local UpPg = UI.New({
            Title = "UPGRADE"
        })
        local SellPg = UI.New({
            Title = "SELL"
        })
        local MiscPg = UI.New({
            Title = "MISC"
        })

        BuffPg.Toggle({
            Text = "Auto Buff",
            Callback = function(v)
                AutoBuff = v
            end,
            Enabled = false
        })
        local BuffDD = BuffPg.Dropdown({
            Text = "Units",
            Callback = function(v)
                if not table.find(UnitsToBuff, v) then
                    table.insert(UnitsToBuff, v)
                else
                    table.remove(UnitsToBuff, table.find(UnitsToBuff, v))
                end
            end,
            Options = {"erwin", "kisuke_evolved", "gojo_evolved"}
        })

        UpPg.Toggle({
            Text = "Auto Upgrade",
            Callback = function(v)
                AutoUpgrade = v
            end,
            Enabled = false
        })
        UpPg.Toggle({
            Text = "Erwin until Buff",
            Callback = function(v)
                ErwinUntilBuff = v
            end,
            Enabled = false
        })
        local UpDD = UpPg.Dropdown({
            Text = "Units",
            Callback = function(op)
                if not table.find(UnitsToUpgrade, op) then
                    table.insert(UnitsToUpgrade, op)
                else
                    table.remove(UnitsToUpgrade, table.find(UnitsToUpgrade, op))
                end
            end,
            Options = UnitsInGame()
        })
        UpPg.Button({
            Text = "Refresh Units",
            Callback = function()
                UpDD:SetOptions(UnitsInGame())
            end
        })

        SellPg.Toggle({
            Text = "Auto Sell",
            Callback = function(v)
                AutoSell = v
            end,
            Enabled = false
        })
        SellPg.Toggle({
            Text = "Sell in Selected Wave",
            Callback = function(v)
                SellInWave = v
            end,
            Enabled = false
        })
        local SellDD = SellPg.Dropdown({
            Text = "Units",
            Callback = function(op)
                if not table.find(UnitsToSell, op) then
                    table.insert(UnitsToSell, op)
                else
                    table.remove(UnitsToSell, table.find(UnitsToSell, op))
                end
            end,
            Options = UnitsInGame()
        })
        SellPg.Button({
            Text = "Refresh Units",
            Callback = function()
                SellDD:SetOptions(UnitsInGame())
            end
        })
        SellPg.Slider({
            Text = "Wave",
            Callback = function(v)
                SelectedWave = v
            end,
            Min = 0,
            Max = 50,
            Def = 15
        })
        SellPg.Button({
            Text = "Sell All Units",
            Callback = function()
                UnitsInGame = {}
                for i, v in pairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    if not table.find(UnitsInGame, v.Name) then
                        if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                            if v.Name ~= "aot_generic" then
                                table.insert(UnitsInGame, v.Name)
                            end
                        end
                    end
                end
                for i, v in next, game:GetService("Workspace")["_UNITS"]:GetChildren() do
                    if table.find(UnitsInGame, v.Name) then
                        if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                            if v.Name ~= "bulma" or v.Name ~= "bulma:shiny" or v.Name ~= "aot_generic" then
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                            end
                        end
                    end
                end
            end
        })

        MiscPg.Button({
            Text = "Return to Lobby",
            Callback = function()
                game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        })
        MiscPg.Button({
            Text = "Remove Barriers",
            Callback = function()
                game:GetService("Workspace")["_barrier"]:Destroy()
            end
        })
        local PanelKeybind = MiscPg.Button({
            Text = "Keybind",
            Callback = function(v)
                if not SelectingKey then
                    SelectingKey = true
                end
            end
        })
        MiscPg.Toggle({
            Text = "Auto Return to Lobby",
            Callback = function(v)
                ReturnToLobby = v
            end,
            Enabled = ReturnToLobby
        })

    -- AUTO BUFF
        spawn(function()
            while wait() do
                if AutoBuff then
                    pcall(function()
                        for i, v in next, game:GetService("Workspace")["_UNITS"]:GetChildren() do
                            if v["_stats"] and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                                if v["_stats"].id.Value == "erwin" then
                                    if v:FindFirstChild("_stats").upgrade.Value >= 3 and v:FindFirstChild("_buffs")["damage_buff__erwin"].Value == 0 then
                                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    end
                                elseif v["_stats"].id.Value == "kisuke_evolved" then
                                    if v:FindFirstChild("_stats").upgrade.Value >= 6 and v:FindFirstChild("_buffs")["attack_cooldown_buff"].Value == 0 and v:FindFirstChild("_buffs")["range_buff"].Value == 0 then
                                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    end
                                elseif v["_stats"].id.Value == "gojo_evolved" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    -- AUTO UPGRADE
        spawn(function()
            while wait() do
                if AutoUpgrade then
                    pcall(function()
                        game:GetService("Players").LocalPlayer.PlayerGui.MessageGui.Enabled = false
                        for i, v in next, game:GetService("Workspace")["_UNITS"]:GetChildren() do
                            if v["_stats"] and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                                if v:FindFirstChild("_stats") and v["_stats"]:FindFirstChild("id") then
                                    if table.find(UnitsToUpgrade, v["_stats"].id.Value) then
                                        if ErwinUntilBuff then
                                            if v["_stats"].id.Value == "erwin" and v["_stats"].upgrade.Value < 3 then
                                                game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                                            elseif v["_stats"].id.Value ~= "erwin" then
                                                game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                                            end
                                        else
                                            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
    -- AUTO SELL
        spawn(function()
            while wait() do
                if AutoSell then
                    pcall(function()
                        for i, v in next, game:GetService("Workspace")["_UNITS"]:GetChildren() do
                            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                                if table.find(UnitsToSell, v["_stats"].id.Value) then
                                    if SellInWave then
                                        if game:GetService("Workspace")["_wave_num"].Value == SelectedWave then
                                            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                                        end
                                    else
                                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
    -- AUTO RETURN TO LOBBY
        spawn(function()
            while wait() do
                if ReturnToLobby then
                    if game:GetService("Workspace")["_DATA"].GameFinished.Value == true then
                        task.wait(2)
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.teleport_back_to_lobby:InvokeServer()
                    end
                end
            end
        end)

    -- SET TEXT
        game:GetService("RunService").RenderStepped:Connect(function()
            if #UnitsToBuff > 0 then
                BuffDD:SetText("Units: ".. table.concat(UnitsToBuff, ", "))
            else
                BuffDD:SetText("Units")
            end
            if #UnitsToUpgrade > 0 then
                UpDD:SetText("Units: ".. table.concat(UnitsToUpgrade, ", "))
            else
                UpDD:SetText("Units")
            end
            if #UnitsToSell > 0 then
                SellDD:SetText("Units: ".. table.concat(UnitsToSell, ", "))
            else
                SellDD:SetText("Units")
            end
            if not SelectingKey then
                local key = string.gsub(tostring(Keybind), "Enum.KeyCode.", "")
                PanelKeybind:SetText("Keybind: " .. key) else PanelKeybind:SetText("Keybind: ...")
            end
        end)
    -- KEYBIND
        game:GetService("UserInputService").InputBegan:connect(function(input, processed)
            if input.UserInputType == Enum.UserInputType.Keyboard and SelectingKey then
                local key = string.split(tostring(input.KeyCode), ".")[3]
                if not table.find(BlockedKeys, key) then
                    SelectingKey = false
                    Keybind = input.KeyCode
                end
            end
            if input.KeyCode == Keybind and not processed then
                if game:GetService("CoreGui"):FindFirstChild(" MAZTER HUB - Anime Adventures") then
                    if game:GetService("CoreGui")[" MAZTER HUB - Anime Adventures"].Enabled then
                        game:GetService("CoreGui")[" MAZTER HUB - Anime Adventures"].Enabled = false
                    else
                        game:GetService("CoreGui")[" MAZTER HUB - Anime Adventures"].Enabled = true
                    end
                end
            end
        end)
end

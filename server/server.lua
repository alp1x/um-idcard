local QBCore = exports['qb-core']:GetCoreObject()

local function ShowId(source, nui)
    local src = source
    local found = false
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local info = {
        ['name'] = Player.PlayerData.charinfo.firstname,
        ['lastname'] = Player.PlayerData.charinfo.lastname,
        ['gender'] = Player.PlayerData.charinfo.gender,
        ['dob'] = Player.PlayerData.charinfo.birthdate,
        ['nationality'] = Player.PlayerData.charinfo.nationality,
    }
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('QBCore:Notify', src, "You showed your idcard")
            TriggerClientEvent('qb-idcard:client:openNui', v, info, nui)
            found = true
            break
        end
    end
    if nui == 'policecard' then
        TriggerClientEvent('qb-idcard:client:policebadgeanim', src)
    end
    if not found then
        TriggerClientEvent('qb-idcard:client:openNui', src, info, nui)
    end
end

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    ShowId(source, 'idcard')
end)

QBCore.Functions.CreateUseableItem("driver_license", function(source,item)
    ShowId(source, 'driverlicense')
end)

QBCore.Functions.CreateUseableItem("weaponlicense", function(source,item)
    ShowId(source, 'weaponlicense')
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source,item)
    ShowId(source, 'lawyerpass')
end)

QBCore.Functions.CreateUseableItem("policecard", function(source,item)
    ShowId(source, 'policecard')
end)

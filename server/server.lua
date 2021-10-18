local QBCore = exports['qb-core']:GetCoreObject()

local ShowId = function(source, item, nui)
    local found = false
    local character = QBCore.Functions.GetPlayer(source)
    local PlayerPed = GetPlayerPed(source)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local info = {
        ['name'] = item.info.firstname,
        ['lastname'] = item.info.lastname,
        ['gender'] = item.info.gender,
        ['dob'] = item.info.birthdate,
        ['nationality'] = item.info.nationality,
        ['type'] = item.info.type
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('QBCore:Notify', source, "You showed your id to " .. v, "info")
            TriggerClientEvent('qb-idcard:client:open', v, info, nui)
            found = true
            break
        end
    end
    if not found then
        TriggerClientEvent('qb-idcard:client:open', source, info, nui)
    end
end

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    ShowId(source, item, 'idcard')
end)

QBCore.Functions.CreateUseableItem("driver_license", function(source,item)
    ShowId(source, item, 'driverlicense')
end)

QBCore.Functions.CreateUseableItem("weaponlicense", function(source,item)
    ShowId(source, item, 'weaponlicense')
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source,item)
    ShowId(source, item, 'lawyerpass')
end)

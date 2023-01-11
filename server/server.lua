local QBCore = exports['qb-core']:GetCoreObject()

local ShowId = function(source, item, nui)
    local src = source
    local found = false
    local character = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local info = {
        ['name'] = item.info.firstname,
        ['lastname'] = item.info.lastname,
        ['gender'] = item.info.gender,
        ['dob'] = item.info.birthdate,
        ['nationality'] = item.info.nationality,
        ['citizenid'] = item.info.citizenid,
        ['type'] = item.info.type,
        ['date'] = item.info.date,
        ['image'] = item.info.image,
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 then --and PlayerPed ~= TargetPed
            TriggerClientEvent('qb-idcard:client:open', v, info, nui)
            found = true
        end
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

QBCore.Functions.CreateUseableItem("policecard", function(source,item)
    ShowId(source, item, 'policecard')
end)

QBCore.Functions.CreateUseableItem("emscard", function(source,item)
    ShowId(source, item, 'emscard')
end)

QBCore.Functions.CreateUseableItem("governmentcard", function(source,item)
    ShowId(source, item, 'governmentcard')
end)

QBCore.Functions.CreateUseableItem("judgecard", function(source,item)
    ShowId(source, item, 'judgecard')
end)

QBCore.Functions.CreateUseableItem("newsidcard", function(source,item)
    ShowId(source, item, 'newsidcard')
end)

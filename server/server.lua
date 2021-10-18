local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    TriggerEvent('qb-idcard:server:showid',source, item, 'idcard')
end)

QBCore.Functions.CreateUseableItem("driver_license", function(source,item)
    TriggerEvent('qb-idcard:server:showid',source, item, 'driverlicense')
end)

QBCore.Functions.CreateUseableItem("weaponlicense", function(source,item)
    TriggerEvent('qb-idcard:server:showid',source, item, 'weaponlicense')
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source,item)
    TriggerEvent('qb-idcard:server:showid', source, item, 'lawyerpass')
end)


RegisterServerEvent('qb-idcard:server:showid')
AddEventHandler('qb-idcard:server:showid',function(source, item, nui)
    local found = false
    local character = QBCore.Functions.GetPlayer(source)
    local PlayerPed = GetPlayerPed(source)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        local info = {}
        if dist < 3.0 and PlayerPed ~= TargetPed then
            info = {
                ['name'] = item.info.firstname,
                ['lastname'] = item.info.lastname,
                ['gender'] = item.info.gender,
                ['dob'] = item.info.birthdate,
                ['nationality'] = item.info.nationality,
                ['type'] = item.info.type,
                ['fingerprint'] = item.info.fingerprint,
            }
            TriggerClientEvent('QBCore:Notify', source, "You showed your id to " .. v, "info")
            TriggerClientEvent('qb-idcard:client:open', v, info, nui)
            found = true
            break
        end
    end
    if not found then
        local info = {
            ['name'] = item.info.firstname,
            ['lastname'] = item.info.lastname,
            ['gender'] = item.info.gender,
            ['dob'] = item.info.birthdate,
            ['nationality'] = item.info.nationality,
            ['type'] = item.info.type,
            ['fingerprint'] = item.info.fingerprint,
        }
        TriggerClientEvent('qb-idcard:client:open', source, info, nui)
        TriggerClientEvent('QBCore:Notify', source, "There is no-one to show your id to.", "error")
    end
end)

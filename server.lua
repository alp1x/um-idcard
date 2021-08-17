-- @uyuyorum qb-idcard {basic} --

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    TriggerClientEvent('qb-idcard:open', source)
end)

QBCore.Functions.CreateCallback('qb-idcard:openInformation', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local inf = {
         ['name'] = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname,
         ['gender'] = xPlayer.PlayerData.charinfo.gender,
         ['dob'] = xPlayer.PlayerData.charinfo.birthdate,
         ['nationality'] = xPlayer.PlayerData.charinfo.nationality,
         ['fingerprint'] = xPlayer.PlayerData.metadata["fingerprint"],
        }
         cb(inf)
end)

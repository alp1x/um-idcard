-- @uyuyorum qb-idcard {basic} --

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    TriggerClientEvent('qb-idcard:client:open', source)
end)

QBCore.Functions.CreateCallback('qb-idcard:server:openInformation', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local inf = {
        ['name'] = ('%s %s'):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname),
        ['gender'] = Player.PlayerData.charinfo.gender,
        ['dob'] = Player.PlayerData.charinfo.birthdate,
        ['nationality'] = Player.PlayerData.charinfo.nationality,
        ['fingerprint'] = Player.PlayerData.metadata["fingerprint"],
    }
    cb(inf)
end)

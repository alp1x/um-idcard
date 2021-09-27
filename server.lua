QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    local nui = 'idcard'
    TriggerClientEvent('qb-idcard:client:open', source, item, nui)
end)

QBCore.Functions.CreateUseableItem("driver_license", function(source,item)
    local nui = 'driverlicense'
    TriggerClientEvent('qb-idcard:client:open', source, item, nui)
end)

QBCore.Functions.CreateCallback('qb-idcard:server:openInformation', function(source, cb, item)
    local inf = {
        ['name'] = item["info"]["lastname"] .. ' ' .. item["info"]["firstname"],
        ['gender'] = item["info"]["gender"],
        ['dob'] = item["info"]["birthdate"],
        ['nationality'] = item["info"]["nationality"],
        ['type'] = item["info"]["type"],
        ['fingerprint'] = item["info"]["fingerprint"],
    }
    cb(inf)
end)

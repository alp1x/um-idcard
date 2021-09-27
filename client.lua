RegisterNetEvent('qb-idcard:client:open')
AddEventHandler('qb-idcard:client:open', function(item,nui)
    QBCore.Functions.TriggerCallback('qb-idcard:server:openInformation', function(inf)
        SetNuiFocus(true,false)
            SendNUIMessage({
            nui = nui,
            information = inf
        })
     end, item)
end)

RegisterNUICallback("escape", function()
    SetNuiFocus(false)
end)
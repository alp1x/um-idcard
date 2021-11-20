
RegisterNetEvent('qb-idcard:client:open', function(info,nui)
    SetNuiFocusKeepInput(true)
    SetNuiFocus(true,false)
    SendNUIMessage({nui = nui,information = info})
end)

RegisterNUICallback("escape", function()
    SetNuiFocus(false)
end)

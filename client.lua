-- @uyuyorum qb-idcard {basic} --
IDCardOpen = false

RegisterNetEvent('qb-idcard:client:open')
AddEventHandler('qb-idcard:open', function()
    OpenScreen()
end)

RegisterNetEvent('qb-idcard:client:close')
AddEventHandler('qb-idcard:client:close', function()
    CloseScreen()
end)

RegisterNUICallback("escape", function(data, cb)
    CloseScreen()
end)

function OpenScreen()
    QBCore.Functions.TriggerCallback('qb-idcard:server:openInformation', function(inf)
        SendNUIMessage({
            status = "open",
            information = inf
        })
        IDCardOpen = true
    end)
end

function CloseScreen()
    SendNUIMessage({
        action = "close"
    })
    IDCardOpen = false
end
-- @uyuyorum qb-idcard {basic} --
    local open = false
    RegisterNetEvent('qb-idcard:open')
    AddEventHandler('qb-idcard:open', function(item)
        OpenScreen(item)
        open = true
    end)

    function OpenScreen(item)
    QBCore.Functions.TriggerCallback('qb-idcard:openInformation', function(inf)
        SendNUIMessage({
            status = "open",
            information = inf
        })
    end, item)
    end

    Citizen.CreateThread(function()
        while true do
            Wait(5)
            if open == true then
            if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
                SendNUIMessage({
                    action = "close"
                })
                open = false
            end
        end
        end
    end)

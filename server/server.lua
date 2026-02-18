---@param src integer
---@param item Item
function SendIDCardData(src, item)
    local metadata = item?.info or item.metadata

    if not (metadata and next(metadata) and metadata?.cardtype) then
        lib.notify(src, {
            title = locale('renew.title'),
            description = locale('renew.description'),
            icon = 'id-card',
            iconColor = 'yellow'
        })
        return DeleteAndRenewLicense(src, item)
    end

    local mugshot = metadata.mugShot

    local isBase64 = mugshot and mugshot:find('^data:image')

    if not mugshot or mugshot == 'none' or isBase64 then
        lib.notify(src, {
            title = locale('update_mugshot.title'),
            description = locale('update_mugshot.description'),
            icon = 'camera',
            iconColor = 'yellow'
        })
        return UpdateMugShot(src, item)
    end

    local closestPlayer = lib.getClosestPlayer(GetEntityCoords(GetPlayerPed(src)), 2, src)

    if closestPlayer then
        lib.notify(src, {
            title = locale('show_idcard.title'),
            description = locale('show_idcard.description'),
            icon = 'id-card',
            iconColor = 'green'
        })
    end

    TriggerClientEvent('um-idcard:client:sendData', closestPlayer or src, metadata)
end

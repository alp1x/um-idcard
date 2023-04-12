RegisterNetEvent('um-idcard:server:sendData', function(src,metadata)
    dump(print(metadata))
    if metadata.mugShot ~= 'none' then
        lib.callback('um-idcard:client:callBack:getClosestPlayer', src, function(player)
            if player ~= 0 then
                TriggerClientEvent('um-idcard:client:notifyOx', src, {
                    title = 'You showed your idcard', 
                    desc = 'You are showing your ID Card to the closest player',
                    icon = 'id-card', 
                    iconColor = 'green'
                }) 
                src = player 
            end
            TriggerClientEvent('um-idcard:client:sendData', src, metadata)
        end)
    else
        NewMetaDataLicense(src,metadata.cardtype,metadata.citizenid or metadata.identifier)
    end
end)


for k,_ in pairs(Config.Licenses) do
    CreateRegisterItem(k)
end


RegisterCommand('kartver', function(source)
    exports['um-idcard']:CreateMetaLicense(source,{'id_card'})
end)

function dump(o, indent)
    if indent == nil then
       indent = 0
    end

    if type(o) == 'table' then
       local s = ''
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. string.rep(' ', indent) .. '['..k..'] = ' .. dump(v, indent + 2) .. '\n'
       end
       return s
    else
       return tostring(o)
    end
 end
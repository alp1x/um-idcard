if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

local dataPlayer,playerMugShots = {},{}

--- Get player mugshot
---@param src number Source number
---@param identifier string ESX identifier
---@return string | nil
local function getPlayerMugShot(src, identifier)
    if playerMugShots[identifier] then
        return playerMugShots[identifier]
    end
    local mugShot = MySQL.scalar.await('SELECT mugshot FROM users WHERE identifier = ?', {identifier})
    if not mugShot then
        local newMugShotBase64 = lib.callback.await('um-idcard:client:callBack:getMugShot', src)
        if newMugShotBase64 then
            local updateResult = MySQL.update.await('UPDATE users SET mugshot = ? WHERE identifier = ?', {newMugShotBase64, identifier})
            if updateResult then
                TriggerClientEvent('um-idcard:client:notifyOx', src, {
                    title = 'Your mugshot is now ready',
                    desc = 'Your photo has been taken and is now ready to be used',
                    icon = 'camera',
                    iconColor = 'purple'
                })
                mugShot = newMugShotBase64
            end
        end
    end
    if mugShot then
        playerMugShots[identifier] = mugShot
    end
    return mugShot
end


--- Get player data
---@param source number Source number
---@param itemName string Item name
---@return table
local function getDataPlayer(source, itemName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    ---@warning I'm not sure here xPlayer.variables
    local pDataVariable = xPlayer.variables
     dataPlayer = {
        firstName = pDataVariable.firstName,
        lastName = pDataVariable.lastName,
        sex = pDataVariable.sex,
        dob = pDataVariable.dateofbirth,
        nationality = 'Los Santos',
        cardtype = itemName,
        mugShot = getPlayerMugShot(src,xPlayer.getIdentifier()),
    }
    return dataPlayer
end

-- Event

RegisterNetEvent('um-idcard:server:sendData', function(src,itemName)
    local getData = getDataPlayer(src,itemName)
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
        TriggerClientEvent('um-idcard:client:sendData', src, getData)
    end)
end)

for k,_ in pairs(Config.Licenses) do
    ESX.RegisterUsableItem(k, function(source,item)
        TriggerEvent('um-idcard:server:sendData', source, item)
    end)
end
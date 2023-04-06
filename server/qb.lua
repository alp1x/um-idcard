if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

local dataPlayer,playerMugShots = {},{}

-- Functions

--- Get player mugshot
---@param src number Source number
---@param citizenid string QBCore citizenid
---@return string | nil
local function getPlayerMugShot(src, citizenid)
    if playerMugShots[citizenid] then
        return playerMugShots[citizenid]
    end
    local mugShot = MySQL.scalar.await('SELECT mugshot FROM players WHERE citizenid = ?', {citizenid})
    if not mugShot then
        local newMugShotBase64 = lib.callback.await('um-idcard:client:callBack:getMugShot', src)
        if newMugShotBase64 then
            local updateResult = MySQL.update.await('UPDATE players SET mugshot = ? WHERE citizenid = ?', {newMugShotBase64, citizenid})
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
        playerMugShots[citizenid] = mugShot
    end
    return mugShot
end

--- Convert sex number to string M or F
---@param sexString number | string 
---@return string
local function getStringSex(sexString)
    if sexString ~= 1 then
        sexString = 'M'
    else
        sexString = 'F'
    end
    return sexString
end

--- Get player data
---@param source number Source number
---@param itemName string Item name
---@return table
local function getDataPlayer(source, itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pData = Player.PlayerData
     dataPlayer = {
        firstName = pData.charinfo.firstname,
        lastName = pData.charinfo.lastname,
        sex = getStringSex(pData.charinfo.gender),
        dob = pData.charinfo.birthdate,
        nationality = pData.charinfo.nationality,
        cardtype = itemName,
        mugShot = getPlayerMugShot(src,pData.citizenid),
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
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.name)
   end)
end
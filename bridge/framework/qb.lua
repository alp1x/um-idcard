if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

local metadata = {}


--- Convert sex number to string M or F
---@param sexString number | string 
---@return string
local function GetStringSex(sexString)
    if sexString ~= 1 then
        sexString = 'M'
    else
        sexString = 'F'
    end
    return sexString
end

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
    local Player = QBCore.Functions.GetPlayer(src)

    if type(itemTable) == "string" then
        itemTable = {itemTable}
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                citizenid = Player.PlayerData.citizenid,
                firstName = Player.PlayerData.charinfo.firstname,
                lastName = Player.PlayerData.charinfo.lastname,
                dob = Player.PlayerData.charinfo.birthdate,
                sex =  GetStringSex(Player.PlayerData.charinfo.gender),
                nationality = Player.PlayerData.charinfo.nationality,
                mugShot = 'none',
            }
            Player.Functions.AddItem(v, 1, false, metadata)
        end
    else
        print("Invalid parameter type")
    end
end

exports('CreateMetaLicense', CreateMetaLicense)


--- Get player mugshot
---@param src number Source number
---@param citizenid string QBCore citizenid
---@return string | nil
function GetPlayerMugShot(src, citizenid)
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

    return mugShot
end

--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.info)
   end)
end
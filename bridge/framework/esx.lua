if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports['es_extended']:getSharedObject()

local hasQs = GetResourceState('qs-inventory') == 'started'

local metadata = {}

--- Get badge for license
---@param src number Source number
---@param itemName string
---@return string | table
local function GetBadge(src, itemName)
    if not Config.Licenses[itemName].badge then return 'none' end
    local xPlayer = ESX.GetPlayerFromId(src)
    local badgeTable = {
        img = Config.Licenses[itemName].badge,
        grade = xPlayer.getJob().grade_label
    }
    return badgeTable
end

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
    local xPlayer = ESX.GetPlayerFromId(src)

    if type(itemTable) == 'string' then
        itemTable = { itemTable }
    end

    if type(itemTable) == 'table' then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                identifier = xPlayer.getIdentifier(),
                firstname = xPlayer.variables.firstName,
                lastname = xPlayer.variables.lastName,
                birthdate = xPlayer.variables.dateofbirth,
                sex = xPlayer.variables.sex,
                nationality = 'Los Santos',
                mugShot = 'none',
                badge = GetBadge(src, v)
            }
            if hasQs then return exports['qs-inventory']:AddItem(src, v, 1, false, metadata) end
            exports.ox_inventory:AddItem(src, v, 1, metadata)
        end
    else
        print('Invalid parameter type')
    end
end

exports('CreateMetaLicense', CreateMetaLicense)


--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
    if hasQs then
        ESX.RegisterUsableItem(k, function(source, item)
            TriggerEvent('um-idcard:server:sendData', source, item.info)
        end)
        return
    end
    ESX.RegisterUsableItem(k, function(source, _, item)
        TriggerEvent('um-idcard:server:sendData', source, item.metadata)
    end)
end

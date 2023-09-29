if GetResourceState('qbx_core') ~= 'started' then return end

local metadata = {}

--- Convert sex number to string M or F
---@param sex number
---@return string
local function GetStringSex(sex)
    return sex == 1 and 'F' or 'M'
end

--- Get badge for license
---@param src number Source number
---@param itemName string
---@return string | table
local function GetBadge(src, itemName)
    if not Config.Licenses[itemName].badge then return 'none' end

    local player = exports.qbx_core:GetPlayer(src)
    return {
        img = Config.Licenses[itemName].badge,
        grade = player.PlayerData.job.grade.name
    }
end

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
    local player = exports.qbx_core:GetPlayer(src)

    if type(itemTable) == "string" then
        itemTable = {itemTable}
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                citizenid = player.PlayerData.citizenid,
                firstname = player.PlayerData.charinfo.firstname,
                lastname = player.PlayerData.charinfo.lastname,
                birthdate = player.PlayerData.charinfo.birthdate,
                sex =  GetStringSex(player.PlayerData.charinfo.gender),
                nationality = player.PlayerData.charinfo.nationality,
                mugShot = 'none',
                badge = GetBadge(src, v)
            }
            player.Functions.AddItem(v, 1, false, metadata)
        end
    else
        print("Invalid parameter type")
    end
end

exports('CreateMetaLicense', CreateMetaLicense)

--- Get metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function GetMetaLicense(src, itemTable)
    local player = exports.qbx_core:GetPlayer(src)

    if type(itemTable) == "string" then
        itemTable = {itemTable}
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                citizenid = player.PlayerData.citizenid,
                firstname = player.PlayerData.charinfo.firstname,
                lastname = player.PlayerData.charinfo.lastname,
                birthdate = player.PlayerData.charinfo.birthdate,
                sex =  GetStringSex(player.PlayerData.charinfo.gender),
                nationality = player.PlayerData.charinfo.nationality,
                mugShot = 'none',
                badge = GetBadge(src,v)
            }
            return metadata
        end
    else
        print("Invalid parameter type")
    end
end

exports('GetMetaLicense', GetMetaLicense)

--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
    exports.qbx_core:CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.info or item.metadata)
    end)
end
if GetResourceState('qbx-core') ~= 'started' then return end

QBCore = exports['qbx-core']:GetCoreObject()

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

--- Get badge for license
---@param src number Source number
---@param itemName string
---@return string | table
local function GetBadge(src,itemName)
    if not Config.Licenses[itemName].badge then return 'none' end
    local Player = QBCore.Functions.GetPlayer(src)
    local badgeTable = {
        img = Config.Licenses[itemName].badge,
        grade = Player.PlayerData.job.grade.name
    }
    return badgeTable
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
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.lastname,
                birthdate = Player.PlayerData.charinfo.birthdate,
                sex =  GetStringSex(Player.PlayerData.charinfo.gender),
                nationality = Player.PlayerData.charinfo.nationality,
                mugShot = 'none',
                badge = GetBadge(src,v)
            }
            Player.Functions.AddItem(v, 1, false, metadata)
        end
    else
        print("Invalid parameter type")
    end
end

exports('CreateMetaLicense', CreateMetaLicense)


--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.info or item.metadata)
   end)
end
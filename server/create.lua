local config = require('config')

---@return string | table
local function getBadge(src, itemName)
    local license = config.licenses[itemName]
    if not license or not license.badge then return 'none' end
    local badge = license.badge
    return {
        img = badge,
        grade = getGradeName(src)
    }
end

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
    local metadata = {}

    if type(itemTable) == "string" then
        itemTable = { itemTable }
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                mugShot = 'none',
                badge = getBadge(src, v)
            }
            lib.table.merge(metadata, getPlayerLicenseData(src))
            addItemInventory(src, v, metadata)
        end
    end
end

exports('CreateMetaLicense', CreateMetaLicense)

function DeleteAndRenewLicense(src, item)
    removeItemInventory(src, item.name, item.slot)
    return CreateMetaLicense(src, item.name)
end

CreateThread(function()
    for k, _ in pairs(config.licenses) do
        registerItemCreate(k)
    end
end)

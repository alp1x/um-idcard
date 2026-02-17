local config = require('config')
local saveBase64AsPng = config.mugshotsUpload == 'local' and require('server.upload.local') or nil
local resourcePath = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/web/assets/mugshots'


---@param url string
---@return boolean
local function IsAllowedMugshotUrl(url)
    if type(url) ~= 'string' or url == '' or not url:find('^https://') then return false end
    local allowed = { 'https://r2.fivemanage.com', 'https://fivemanage.com' }
    for i = 1, #allowed do
        local origin = allowed[i]
        if origin and #url >= #origin and url:sub(1, #origin) == origin then return true end
    end
    return false
end

---@param src integer
---@param identifier string
---@param itemName string
---@return string|nil mugShotUrl
local function resolveMugShot(src, identifier, itemName)
    local result = lib.callback.await('um-idcard:client:callBack:getMugShot', src)
    if not result then return nil end

    if config.mugshotsUpload == 'fivemanage' and result.url then
        if not IsAllowedMugshotUrl(result.url) then return nil end
        return result.url
    end

    if config.mugshotsUpload == 'local' and result.base64 and saveBase64AsPng then
        local imageName = ('%s_%s'):format(identifier, itemName)
        if saveBase64AsPng(result.base64, imageName) then
            return ('%s/%s.png'):format(resourcePath, imageName)
        end
    end

    return nil
end

function UpdateMugShot(src, item)
    if not item or not item.slot then return end
    local metadata = item.metadata or item.info

    local identifier = metadata.citizenid or metadata.identifier or tostring(src)
    local mugShot = resolveMugShot(src, identifier, item.name)
    if not mugShot then return end
    setMetaDataInventory(src, item, mugShot)
end

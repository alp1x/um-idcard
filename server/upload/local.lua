local uploadType = require('config').mugshotsUpload

if uploadType ~= 'local' then return end

-- https://github.com/Byte-Labs-Studio/bl_idcard/blob/main/server/decoder.lua
local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local resourcePath = GetResourcePath(cache.resource)
local imagePath = '/web/assets/mugshots'

local MAX_DECODED_BYTES = 20 * 1024 -- 20KB (client'tan gelen base64 güvenlik limiti)
local PNG_SIG = '\x89PNG\r\n\x1a\n'

local function base64Decode(data)
    data = data:gsub('[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        return string.char(tonumber(x, 2))
    end))
end


---@param base64String string
---@return string|nil decodedData
local function validateAndDecode(base64String)
    if type(base64String) ~= 'string' or base64String == '' then return nil end
    local base64Data = base64String:gsub("^data:image/png;base64,", "")
    if #base64Data > (MAX_DECODED_BYTES * 4 / 3) + 64 then return nil end
    local decoded = base64Decode(base64Data)
    if #decoded > MAX_DECODED_BYTES then return nil end
    if decoded:sub(1, #PNG_SIG) ~= PNG_SIG then return nil end
    return decoded
end

local function saveBase64AsPng(base64String, imageName)
    local decodedData = validateAndDecode(base64String)
    if not decodedData then return false end

    imageName = imageName:gsub('[/\\%.%:%*%?%"%<%>%|]', '_')

    local updatedPath = resourcePath:match("resources/.*")
    if not updatedPath then return false end
    local file = io.open(('%s/%s/%s.png'):format(updatedPath, imagePath, imageName), "wb")
    if file then
        file:write(decodedData)
        file:close()
        return true
    end
    return false
end

return saveBase64AsPng

local uploadType = require('config').mugshotsUpload

if uploadType ~= 'fivemanage' then return end

local TOKEN = GetConvar("fivemanage:key", "")

if TOKEN == '' then
    warn('Fivemanage token is not set in server.cfg (set fivemanage:key "YOUR_TOKEN")')
    return
end

local PRESIGNED_URL = 'https://api.fivemanage.com/api/v3/file/presigned-url'

---@return string|nil presignedUrl
local function GetPresignedUrl()
    local statusCode, response = PerformHttpRequestAwait(PRESIGNED_URL, 'GET', '', { ['Authorization'] = TOKEN })

    if statusCode ~= 200 then
        warn(('Failed to get presigned URL (status: %s)'):format(statusCode))
        return nil
    end

    local data = json.decode(response --[[@as string]])
    local presignedUrl = data?.data?.presignedUrl
    if not presignedUrl then
        warn('Invalid presigned URL response')
        return nil
    end

    return presignedUrl
end


lib.callback.register('um-idcard:server:getPresignedUrl', function(source)
    return GetPresignedUrl()
end)

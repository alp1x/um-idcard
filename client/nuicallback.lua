local config = require('config')

-- NUI Callbacks
RegisterNUICallback('close', function(_, cb)
    cb(1)
    nuiFocus(false)
end)

RegisterNUICallback('jsReady', function(_, cb)
    local langConvar = GetConvar('ox:locale', 'en')
    local locale = lib.loadJson(('locales/%s'):format(langConvar))
    cb({ configData = config, localeData = locale })
end)

RegisterNUICallback('requestPresignedUrl', function(_, cb)
    local url = lib.callback.await('um-idcard:server:getPresignedUrl')
    cb({ url = url })
end)

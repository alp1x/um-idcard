local openID,dataReady = false,false

-- Functions

-- The state of the nui focus and openID control
---@param bool boolean 
local function nuiFocus(bool)
    SetNuiFocusKeepInput(bool)
    SetNuiFocus(bool,false)
    openID = bool
end

-- Send config data to the nui
local function sendConfigData()
    SendNUIMessage({type = 'configData', configData = Config})
end

-- Events
RegisterNetEvent('um-idcard:client:sendData', function(playerData)
    if not openID and not dataReady then
        nuiFocus(true)
        SendNUIMessage({type = 'playerData', playerData = playerData})
    end
end)

RegisterNetEvent('um-idcard:client:notifyOx', function(data)
    lib.notify({title = data.title, description = data.desc, icon = data.icon, iconColor = data.iconColor})
end)

-- Client Callback Register
lib.callback.register('um-idcard:client:callBack:getClosestPlayer', function()
    local ClosestPlayer = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0, false)
    return GetPlayerServerId(ClosestPlayer)
end)

lib.callback.register('um-idcard:client:callBack:getMugShot', function()
    local MugShot = exports['MugShotBase64']:GetMugShotBase64(cache.ped, false)
    return MugShot
end)

--- Nui Callback
RegisterNUICallback('closeIdCard', function(_,cb)
    cb(1)
    nuiFocus(false)
end)

-- Loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() sendConfigData() end)

RegisterNetEvent('esx:playerLoaded', function() sendConfigData() end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end 
        dataReady = true
        SetTimeout(2000, function()
            sendConfigData()
            print('Config ready')
            dataReady = false
        end)
end)

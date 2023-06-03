local openID,dataReady = false,false
local animDict,anim = 'paper_1_rcm_alt1-9','player_one_dual-9'

-- Functions

-- The state of the nui focus and openID control
---@param bool boolean 
local function nuiFocus(bool)
    SetNuiFocusKeepInput(bool)
    SetNuiFocus(bool,false)
    openID = bool
end

--- Load animation dictionary
---@param dict string Animation dictionary
local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
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

RegisterNetEvent('um-idcard:client:startAnim', function(cardType)
    if not cardType or cardType == nil then return print('No Card Type') end
    if not Config.Licenses[cardType].prop or Config.Licenses[cardType].prop == nil then return print('Card Type: '..cardType..' No Prop') end
    local prop = Config.Licenses[cardType].prop
    if prop then
        local playerCoords = GetEntityCoords(cache.ped)
        local createProp = CreateObject(GetHashKey(prop), playerCoords.x, playerCoords.y, playerCoords.z + 0.2, true, true, true)
        loadAnimDict(animDict)
        AttachEntityToEntity(createProp, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1000, 0.0200, -0.0300, -90.000, 170.000, 78.999, true, true, false, true, 1, true)
        TaskPlayAnim(cache.ped, animDict, anim, 3.0, -1, -1, 50, -1, false, false, false)
        SetModelAsNoLongerNeeded(createProp)
        SetTimeout(3500, function()
            DeleteEntity(createProp)
            ClearPedTasks(cache.ped)
        end)
    end
end)

RegisterNetEvent('um-idcard:client:notifyOx', function(data)
    lib.notify({title = data.title, description = data.desc, icon = data.icon, iconColor = data.iconColor})
end)

-- Client Callback Register
lib.callback.register('um-idcard:client:callBack:getClosestPlayer', function()
    return GetPlayerServerId(lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0, false))
end)

lib.callback.register('um-idcard:client:callBack:getMugShot', function()
    return exports['MugShotBase64']:GetMugShotBase64(cache.ped, false)
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

local uploadPromise = nil

-- { type, id } — type: 'd' = drawable, 'p' = prop
local CLEAR_LIST = {
    { 'd', 1 },  -- mask
    { 'd', 9 },  -- armor
    { 'd', 10 }, -- decals
    { 'p', 0 },  -- hat
    { 'p', 1 },  -- glasses
}

local function clearAndSave(ped)
    local saved = {}
    for i = 1, #CLEAR_LIST do
        local t, id = CLEAR_LIST[i][1], CLEAR_LIST[i][2]
        if t == 'd' then
            saved[i] = { t, id, GetPedDrawableVariation(ped, id), GetPedTextureVariation(ped, id) }
            SetPedComponentVariation(ped, id, 0, 0, 2)
        else
            local d = GetPedPropIndex(ped, id)
            saved[i] = { t, id, d, d >= 0 and GetPedPropTextureIndex(ped, id) or 0 }
            ClearPedProp(ped, id)
        end
    end
    return saved
end

local function restore(ped, saved)
    for i = 1, #saved do
        local t, id, d, tx = saved[i][1], saved[i][2], saved[i][3], saved[i][4]
        if t == 'd' and d ~= 0 then
            SetPedComponentVariation(ped, id, d, tx, 2)
        elseif t == 'p' and d >= 0 then
            SetPedPropIndex(ped, id, d, tx, false)
        end
    end
end

-- https://github.com/Byte-Labs-Studio/bl_idcard/blob/main/client/utils.lua#L22
local function captureMugshot()
    if uploadPromise then return nil end

    local ped = cache.ped
    local saved = clearAndSave(ped)

    local headShotHandle = RegisterPedheadshot_3(ped) or RegisterPedheadshot(ped)
    if not lib.waitFor(function()
            if IsPedheadshotReady(headShotHandle) and IsPedheadshotValid(headShotHandle) then return true end
        end, 'couldn\'t load mugshot', 10000) then
        UnregisterPedheadshot(headShotHandle)
        restore(ped, saved)
        return nil
    end

    local txd = GetPedheadshotTxdString(headShotHandle)
    UnregisterPedheadshot(headShotHandle)
    restore(ped, saved)

    SendNUIMessage({ type = 'convertImage', txd = txd })

    uploadPromise = promise.new()
    SetTimeout(15000, function()
        if not uploadPromise then return end
        uploadPromise:resolve(nil)
        uploadPromise = nil
    end)

    local result = Citizen.Await(uploadPromise)

    return result
end

RegisterNUICallback('convertImageSuccess', function(data, cb)
    cb(1)
    if not uploadPromise then return end
    uploadPromise:resolve(data)
    uploadPromise = nil
end)

lib.callback.register('um-idcard:client:callBack:getMugShot', function()
    return captureMugshot()
end)

local QBCore = exports['qb-core']:GetCoreObject()
local openid = false
local inventorykey = 37
local mobilekey = 301

RegisterNetEvent('qb-idcard:client:open', function(info,nui)
    if not openid then
        SetNuiFocusKeepInput(true)
        SetNuiFocus(true)
        SendNUIMessage({nui = nui, information = info, action = "open"})
        openid = true
        TriggerEvent('QBCore:Notify', "You showed your "..nui)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if nui == 'policecard' then
                TriggerEvent('qb-idcard:client:policebadgeanim') 
            else
                TriggerEvent('qb-idcard:client:idbadgeanim') 
            end
        end
        CreateThread(function()
            while openid do
                DisableControlAction(0, 177, true) -- disable escape
                DisableControlAction(0, 200, true) -- disable escape
                DisableControlAction(0, 202, true) -- disable escape
                DisableControlAction(0, 322, true) -- disable escape
                DisableControlAction(0, inventorykey, true) -- TAB -- inventory key
                DisableControlAction(0, mobilekey, true) -- TAB -- mobile key
                if IsDisabledControlJustPressed(0, inventorykey) or IsDisabledControlJustPressed(0, mobilekey) then
                    SendNUIMessage({nui = nui, information = info, action = "close"})
                end
                Wait(0)
            end
        end)
    end
end)

RegisterNetEvent('qb-idcard:client:policebadgeanim', function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    local propname = "prop_fib_badge"
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(propname), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    loadAnimDict("paper_1_rcm_alt1-9")
    AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.01, -0.06, -310.0, 10.0, 150.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "paper_1_rcm_alt1-9", "player_one_dual-9", 3.0, -1, -1, 50, 0, false, false, false)
    Wait(3200)
    DeleteEntity(prop)
    ClearPedTasks(ped)
end)

RegisterNetEvent('qb-idcard:client:idbadgeanim', function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    local propname = "prop_franklin_dl"
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(propname), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    loadAnimDict("paper_1_rcm_alt1-8")
    AttachEntityToEntity(prop, ped, boneIndex, 0.1000, 0.0200, -0.0300, -90.000, 170.000, 78.999, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "paper_1_rcm_alt1-8", "player_one_dual-8", 3.0, -1, -1, 50, 0, false, false, false)
    while openid do
        Wait(100)
    end
    DeleteEntity(prop)
    ClearPedTasks(ped)
end)

RegisterNUICallback("escape", function()
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false)
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    Wait(100)
    openid = false
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

if GetResourceState('qb-core') ~= 'started' then return end

local qb_core = exports['qb-core']:GetCoreObject()

function getPlayerFramework(src)
    local Player = qb_core.Functions.GetPlayer(src)
    if not Player then return end
    return Player
end

function getGradeName(src)
    local Player = getPlayerFramework(src)
    if not Player then return end
    return Player.PlayerData.job.grade.name
end

function getPlayerLicenseData(src)
    local Player = getPlayerFramework(src)
    if not Player then return end
    local playerData = Player.PlayerData
    return {
        citizenid = playerData.citizenid,
        firstname = playerData.charinfo.firstname,
        lastname = playerData.charinfo.lastname,
        birthdate = playerData.charinfo.birthdate,
        sex = playerData.charinfo.gender == 1 and 'F' or 'M',
        nationality = playerData.charinfo.nationality,
    }
end

function registerItemCreate(itemName)
    qb_core.Functions.CreateUseableItem(itemName, function(source, item)
        SendIDCardData(source, item)
    end)
end

if GetResourceState('qbx_core') ~= 'started' then return end

local qbx_core = exports.qbx_core

function getPlayerFramework(src)
    local Player = qbx_core:GetPlayer(src)
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
    qbx_core:CreateUseableItem(itemName, function(source, item)
        SendIDCardData(source, item)
    end)
end

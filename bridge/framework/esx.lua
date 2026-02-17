if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

local hasQs = GetResourceState('qs-inventory') == 'started'

function getPlayerFramework(src)
    local Player = ESX.GetPlayerFromId(src)
    if not Player then return end
    return Player
end

function getGradeName(src)
    local Player = getPlayerFramework(src)
    if not Player then return end
    return Player.getJob().grade_label
end

function getPlayerLicenseData(src)
    local Player = getPlayerFramework(src)
    if not Player then return end
    return {
        citizenid = Player.getIdentifier(),
        firstname = Player.variables.firstName,
        lastname = Player.variables.lastName,
        birthdate = Player.variables.dateofbirth,
        sex = Player.variables.sex,
        nationality = 'Los Santos',
    }
end

function registerItemCreate(itemName)
    if hasQs then
        ESX.RegisterUsableItem(itemName, function(source, item)
            SendIDCardData(source, item)
        end)
        return
    end
    ESX.RegisterUsableItem(itemName, function(source, _, item)
        SendIDCardData(source, item)
    end)
end

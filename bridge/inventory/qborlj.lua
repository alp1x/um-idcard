if GetResourceState('qb-inventory') ~= 'started' or GetResourceState('lj-inventory') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function NewMetaDataLicense(src, itemName, cidorIdentifier)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local newMetaDataItem = Player.Functions.GetItemByName(itemName)
    if newMetaDataItem then
        Player.PlayerData.items[newMetaDataItem.slot].info.mugShot = GetPlayerMugShot(src, cidorIdentifier)
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end


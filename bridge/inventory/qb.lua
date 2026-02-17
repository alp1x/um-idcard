if GetResourceState('qb-inventory') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local qb_inventory = exports['qb-inventory']

function setMetaDataInventory(src, item, mugShot)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local items = Player.PlayerData.items
    items[item.slot].info.mugShot = mugShot
    qb_inventory:SetInventory(src, items)
end

function addItemInventory(src, itemName, metadata)
    qb_inventory:AddItem(src, itemName, 1, false, metadata)
end

function removeItemInventory(src, itemName, slot)
    if slot then
        qb_inventory:RemoveItem(src, itemName, 1, slot)
        return
    end
    local item = qb_inventory:GetItemByName(src, itemName)
    if not item then return end
    qb_inventory:RemoveItem(src, itemName, 1, item.slot)
end

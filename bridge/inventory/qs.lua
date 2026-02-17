if GetResourceState('qs-inventory') ~= 'started' then return end

local Inventory = exports['qs-inventory']

function setMetaDataInventory(src, item, mugShot)
    local items = Inventory:GetInventory(src)
    local info = items[item.slot].info

    info.mugShot = mugShot
    Inventory:SetItemMetadata(src, item.slot, info)
end

function addItemInventory(src, itemName, metadata)
    Inventory:AddItem(src, itemName, 1, false, metadata)
end

function removeItemInventory(src, itemName, slot)
    if slot then
        Inventory:RemoveItem(src, itemName, 1, slot)
        return
    end
    local item = Inventory:GetItemByName(src, itemName)
    if not item then return end
    Inventory:RemoveItem(src, itemName, 1, item.slot)
end

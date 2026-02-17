if GetResourceState('ox_inventory') ~= 'started' then return end

local ox_inventory = exports.ox_inventory

function setMetaDataInventory(src, item, mugShot)
    item.metadata.mugShot = mugShot
    ox_inventory:SetMetadata(src, item.slot, item.metadata)
end

function addItemInventory(src, itemName, metadata)
    ox_inventory:AddItem(src, itemName, 1, metadata)
end

function removeItemInventory(src, itemName, slot)
    if slot then
        ox_inventory:RemoveItem(src, itemName, 1, nil, slot)
        return
    end
    local item = ox_inventory:GetSlotWithItem(src, itemName)
    if not item then return end
    ox_inventory:RemoveItem(src, itemName, 1, nil, item.slot)
end

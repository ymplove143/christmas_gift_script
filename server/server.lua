QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('ymp-christmasgift:server:gotGift', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local giftType = Config.Gifts[math.ceil(math.random(0,2))]
    -- TriggerClientEvent("QBCore:Notify", source, giftType, "error")
    Player.Functions.AddItem(giftType, 1)
    -- Player.Functions.RemoveItem('fishbait',1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giftType], 'add')
    TriggerClientEvent('ymp-christmasgift:client:giftcooldown',source,item)    
end)
RegisterNetEvent('ymp-christmasgift:server:gotMoney', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.GiftMoney)
    TriggerClientEvent("QBCore:Notify", source, "You Got Money From Santa", "success")
       
end)
RegisterNetEvent('ymp-christmasgift:server:openedSmallGift', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    for i=0,2,1 do
        local giftType = Config.SmallGiftItems[math.ceil(math.random(0,5))]
        Player.Functions.AddItem(giftType, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giftType], 'add')
        TriggerClientEvent("QBCore:Notify", source, giftType, "success")
    end
    Player.Functions.RemoveItem('smallgift',1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['smallgift'], 'remove')      
end)
RegisterNetEvent('ymp-christmasgift:server:openedMediumGift', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    for i=0,3,1 do
        local giftType = Config.MediumGiftItems[math.ceil(math.random(0,7))]
        Player.Functions.AddItem(giftType, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giftType], 'add')
        TriggerClientEvent("QBCore:Notify", source, giftType, "success")
    end
    Player.Functions.RemoveItem('mediumgift',1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mediumgift'], 'remove')      
end)
RegisterNetEvent('ymp-christmasgift:server:openedBigGift', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    for i=0,3,1 do
        local giftType = Config.BigGiftItems[math.ceil(math.random(0,7))]
        Player.Functions.AddItem(giftType, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giftType], 'add')
        TriggerClientEvent("QBCore:Notify", source, giftType, "success")
    end
    Player.Functions.RemoveItem('biggift',1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['biggift'], 'remove')      
end)



QBCore.Functions.CreateUseableItem('smallgift', function(source,item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("smallgift") then
        TriggerClientEvent("ymp-christmasgift:client:openedSmallGift",source,item)
    else
        TriggerClientEvent("QBCore:Notify", source, "Get Ready to get banned", "error")
    end
end)
QBCore.Functions.CreateUseableItem('mediumgift', function(source,item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("mediumgift") then
        TriggerClientEvent("ymp-christmasgift:client:openedMediumGift",source,item)
    else
        TriggerClientEvent("QBCore:Notify", source, "Get Ready to get banned", "error")
    end
end)
QBCore.Functions.CreateUseableItem('biggift', function(source,item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("biggift") then
        TriggerClientEvent("ymp-christmasgift:client:openedBigGift",source,item)
    else
        TriggerClientEvent("QBCore:Notify", source, "Get Ready to get banned", "error")
    end
end)

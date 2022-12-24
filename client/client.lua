local QBCore = exports['qb-core']:GetCoreObject()
local insideGiftZone = false
local fishCaught = 10
local canfising = false
local GiftCooldown = false
CreateThread(function()
    local ChristmasBlip = AddBlipForCoord(Blips["christmasgiftstore"]["coords"]["x"], Blips["christmasgiftstore"]["coords"]["y"], Blips["christmasgiftstore"]["coords"]["z"])
            SetBlipSprite(ChristmasBlip,Blips["christmasgiftstore"]["blipsprite"] )
            SetBlipScale(ChristmasBlip, 0.6)
            SetBlipDisplay(ChristmasBlip, 4)
            SetBlipColour(ChristmasBlip,Blips["christmasgiftstore"]["blipcolor"] )
            SetBlipAsShortRange(ChristmasBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Blips["christmasgiftstore"]["label"])
            EndTextCommandSetBlipName(ChristmasBlip)

    RequestModel(GetHashKey('u_m_m_jesus_01'))
    while not HasModelLoaded(GetHashKey('u_m_m_jesus_01')) do
        Wait(1)
    end
    created_ped = CreatePed(5, GetHashKey('u_m_m_jesus_01') , 227.2, -911.02, 29.7, 44.65, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_LEANING', 0, true)
    exports['qb-target']:AddTargetEntity(created_ped, {
                options = {
                    {
                        label = "Enjoy Christmas Gift",
                        icon = "fas fa-gift",
                        event = "ymp-christmasgift:client:gotGift"
                    },
                },
                distance = 1.0
    })

end)

CreateThread(function()
    if Config.WanttoGiveMoney then
        local giftZone = PolyZone:Create({
            vector2(220.01417541504, -872.69494628906),
            vector2(243.63349914551, -889.68975830078),
            vector2(238.42460632324, -895.14483642578),
            vector2(222.4499206543, -919.09613037109),
            vector2(213.65930175781, -925.9619140625),
            vector2(197.65145874023, -918.8291015625),
            vector2(204.48867797852, -908.87365722656)
          }, {
            name="giftZone",
            minZ = 30.492084503174,
            maxZ = 35.655696868896
          })
        giftZone:onPlayerInOut(function(isPointInside)
            insideGiftZone = isPointInside
            if insideGiftZone then
                QBCore.Functions.Notify("You are enjoying chirstmas", 'success')
            else
                QBCore.Functions.Notify("Thanks For coming")
            end
        end)
        
        while true do
            if insideGiftZone then
                TriggerServerEvent("ymp-christmasgift:server:gotMoney")
            end
            Wait(Config.GiftMoneyTime*10000)
        end
    end
end)

RegisterNetEvent('ymp-christmasgift:client:giftcooldown', function()
    GiftCooldown = true
    local timer = Config.GiftCooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            GiftCooldown = false
        end
    end
end)



RegisterNetEvent('ymp-christmasgift:client:gotGift', function()
    if GiftCooldown then
        QBCore.Functions.Notify("You Already Received Gift Please Come After Some Time", 'success')
    else
        TriggerEvent('animations:client:EmoteCommandStart', {Config.GiftTakingEmotion})
        QBCore.Functions.Progressbar("opening_gift", "You Got a Gift", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("ymp-christmasgift:server:gotGift")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
        end)
        QBCore.Functions.Notify("you Received Gift From God", 'success')
    end
    
end)
RegisterNetEvent('ymp-christmasgift:client:openedSmallGift', function()
    local hash = GetHashKey('box1')
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    RequestModel(hash)
    local gift = CreateObject(hash, x,y,z-1, true, false, false)
    PlaceObjectOnGroundProperly(gift) 
    SetEntityAsMissionEntity(gift, true)
    FreezeEntityPosition(gift, true)
    TriggerEvent('animations:client:EmoteCommandStart', {Config.GiftOpeningEmotion})
    QBCore.Functions.Progressbar("opening_gift", "Opening Gift", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("ymp-christmasgift:server:openedSmallGift")
        TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
        Wait(1000)
        DeleteObject(gift)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        DeleteObject(gift)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
    
end)
RegisterNetEvent('ymp-christmasgift:client:openedMediumGift', function()
    local hash = GetHashKey('box1')
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    RequestModel(hash)
    local gift = CreateObject(hash, pos.x, pos.y-1, pos.z-1, true, false, false)
    PlaceObjectOnGroundProperly(gift) 
    SetEntityAsMissionEntity(gift, true)
    FreezeEntityPosition(gift, true)
    TriggerEvent('animations:client:EmoteCommandStart', {Config.GiftOpeningEmotion})
    QBCore.Functions.Progressbar("opening_gift", "Opening Gift", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("ymp-christmasgift:server:openedMediumGift")
        TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
        Wait(1000)
        DeleteObject(gift)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        DeleteObject(gift)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
    
end)
RegisterNetEvent('ymp-christmasgift:client:openedBigGift', function()
    local hash = GetHashKey('box1')
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    RequestModel(hash)
    local gift = CreateObject(hash, pos.x, pos.y-1, pos.z-1, true, false, false)
    PlaceObjectOnGroundProperly(gift) 
    SetEntityAsMissionEntity(gift, true)
    FreezeEntityPosition(gift, true)
    TriggerEvent('animations:client:EmoteCommandStart', {Config.GiftOpeningEmotion})
    QBCore.Functions.Progressbar("opening_gift", "Opening Gift", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("ymp-christmasgift:server:openedBigGift")
        TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
        Wait(1000)
        DeleteObject(gift)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        DeleteObject(gift)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
    
end)

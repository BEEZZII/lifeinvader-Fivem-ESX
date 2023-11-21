ESX = nil
local display = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('LifeInvader:Message')
AddEventHandler('LifeInvader:Message', function(name, message)
    TriggerClientEvent()
end)

Citizen.CreateThread(function()
    blip = AddBlipForCoord(Config.Coords.x, Config.Coords.y, Config.Coords.z)
        SetBlipSprite(blip, 459)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 38)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("LifeInvader")
        EndTextCommandSetBlipName(blip)
    
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoord = GetEntityCoords(playerPed, true)
        DrawMarker(21, Config.Coords.x, Config.Coords.y, Config.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 100, false, true, 2, false, false, false)

        if Vdist(playerCoord, Config.Coords.x, Config.Coords.y, Config.Coords.z) < 2 * 0.4 then
            ESX.ShowHelpNotification("Drücke [E] um Werbung zu schalten.", true, true, 5)
            if IsControlPressed(0, 51) then
                SetDisplay(true)
            end
        end
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("ttt", function(data)
    SetDisplay(false)
    ESX.TriggerServerCallback('LifeInvader:GetMoney', function(result)
        if result == 1 then
            TriggerServerEvent('LifeInvader:RemoveMoney', data.amount)
        elseif result == 0 then
            TriggerEvent('LifeInvader:notification', "~r~LIFEINVADER\nDu hast nicht genug Geld.")
        end
    end)
    
end)

RegisterNetEvent('LifeInvader:aaaa')
AddEventHandler('LifeInvader:aaaa', function(text, name)
    Notification("~w~"..text, "~r~LIFEINVADER", "~g~"..name, 'CHAR_LIFEINVADER', 1, true, 2)
end)


RegisterNetEvent('LifeInvader:notification')
AddEventHandler('LifeInvader:notification', function(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end)

function Notification(message, sender, subject, textureDict, iconType, saveToBrief, color)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    ThefeedNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, saveToBrief)
end
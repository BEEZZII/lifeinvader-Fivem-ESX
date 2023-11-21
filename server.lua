ESX = nil
MySQL = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('LifeInvader:RemoveMoney')
AddEventHandler('LifeInvader:RemoveMoney', function(text)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.Price

    local first = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.getIdentifier()})
    local last = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.getIdentifier()})
    local name = first .." ".. last
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)

        local first = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.getIdentifier()})
        local last = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.getIdentifier()})
        local name = first .." ".. last

        TriggerClientEvent('LifeInvader:aaaa', -1, text, name)
    else
        TriggerClientEvent('LifeInvader:notification', xPlayer, '~r~LIFEINVADER\nDu hast nicht genug Geld.')
    end
end)



ESX.RegisterServerCallback('LifeInvader:GetMoney', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    local price = Config.Price

    if xPlayer.getMoney() >= price then
        cb(1)
    else
        cb(0)
    end
end)
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("rentalpapers", function(source, item, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
end)

RegisterServerEvent('qb-rental:server:rentalpapers', function(plate, model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {
        description = string.format('First Name: %s  \nLast Name: %s  \nPlate: %s  \nModel: %s',
        Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname, plate, model)
    }
    exports.ox_inventory:AddItem(source, 'rentalpapers', 1, info)
end)


RegisterServerEvent('qb-rental:server:removepapers', function(plate, model)
    local src = source
    exports.ox_inventory:RemoveItem(src, 'rentalpapers', 1, info)
end)

QBCore.Functions.CreateCallback('qb-rental:server:CashCheck',function(source, cb, money)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= money then
        cb(true)
        Player.Functions.RemoveMoney('cash', money, "Rental Car Purchased")
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-rentals:server:getPilotLicenseStatus', function(source, cb, licenseType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]
    print(json.encode(licenseTable))

    if licenseTable.pilot then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-rentals:server:getDriverLicenseStatus', function(source, cb, licenseType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]

    if licenseTable.driver then
        cb(true)
    else
        cb(false)
    end
end)

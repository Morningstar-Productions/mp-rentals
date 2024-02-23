local Utils = require 'modules.utils'

RegisterServerEvent('mp-rentals:server:rentalpapers', function(plate, model)
    local metadata = {
        description = ('Proof of purchase. Use to get extra rental keys.  \n  \nName: %s  \nPlate: %s  \nModel: %s'):format(Renewed.getCharName(source), plate, model),
        plate = plate,
        model = model
    }
    exports.ox_inventory:AddItem(source, 'rentalpapers', 1, metadata)
end)

lib.callback.register('mp-rentals:server:CashCheck',function(source, money)
    local cash = Renewed.getMoney(source, 'cash')

    if cash >= money then Renewed.removeMoney(source, money, 'cash', "Rental Car Purchased") return true end
    return false
end)

---@todo Research other license tables for other frameworks
lib.callback.register('mp-rentals:server:getLicenseStatus', function(source, licenseType)
    local Player = exports.qbx_core:GetPlayer(source) -- Find other tables
    local licenseTable = Player.PlayerData.metadata.licences

    if Config.Debug then print(json.encode(licenseTable)) return end

    return licenseTable[licenseType]
end)

lib.callback.register('mp-rentals:server:SpawnVehicleSpawnerVehicle', function(source, model, coords, warp)
    local netId = Utils.SpawnVehicle(source, model, coords, warp)
    if netId then return netId end
    local veh = NetworkGetEntityFromNetworkId(netId)

    if not veh or not NetworkGetNetworkIdFromEntity(veh) then print('Server:90 | ISSUE HERE', veh, NetworkGetNetworkIdFromEntity(veh)) end

    SetEntityHeading(veh, Config.Locations.vehicle.spawnpoint.w)
    SetVehicleEngineOn(veh, true, true, false)
    SetVehicleDirtLevel(veh, 0.0)

    return netId
end)

local svConfig = require 'config.server'

lib.callback.register('mp-rentals:server:rentalpapers', function(source, plate, model)
    local metadata = {
        description = ('Proof of purchase. Use to get extra rental keys.  \n  \nName: %s  \nPlate: %s  \nModel: %s'):format(Renewed.getCharName(source), plate, model),
        plate = plate,
        model = model
    }

    svConfig.addKey(source, plate)
    if exports.ox_inventory:AddItem(source, 'rentalpapers', 1, metadata) then
        return true
    end

    return false
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

    return licenseTable[licenseType]
end)

lib.callback.register('mp-rentals:server:SpawnVehicleSpawnerVehicle', function(_, model, coords, warp)
    local netId, vehicle = qbx.spawnVehicle({
        model = model,
        spawnSource = coords,
        warp = warp
    })

    if netId then return netId end
    if not vehicle or not vehicle == 0 then return end

    SetEntityHeading(vehicle, coords.w)
    SetVehicleEngineOn(vehicle, false, false, true)
    SetVehicleDirtLevel(vehicle, 0.0)

    return netId
end)

lib.callback.register('mp-rentals:server:getPedLocations', function(_)
    return svConfig.pedLocations
end)
local svConfig = require 'config.server'
local Utils = require 'modules.utils'

lib.callback.register('mp-rentals:server:rentalpapers', function(source, plate, model, netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local metadata = {
        description = ('Proof of purchase. Use to get extra rental keys.  \n  \nName: %s  \nPlate: %s  \nModel: %s'):format(Renewed.getCharName(source), plate, model),
        plate = plate,
        model = model
    }

    svConfig.addKey(source, plate, vehicle)
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
    if GetResourceState('qbx_core'):match('started') then
        local Player = exports.qbx_core:GetPlayer(source) -- Find other tables
        local licenseTable = Player.PlayerData.metadata.licences

        return licenseTable[licenseType]
    end

    if GetResourceState('es_extended'):match('started') then
        return true
    end

    if GetResourceState('ox_core'):match('started') then
        return true
    end
end)

lib.callback.register('mp-rentals:server:SpawnVehicleSpawnerVehicle', function(_, model, coords, warp)
    if GetResourceState('qbx_core'):match('started') then
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
    else
        --[[ Borrowed Logic from Old Rentals / Old QBox Core ]]--

        model = type(model) == 'string' and joaat(model) or model

        if not CreateVehicleServerSetter then
            error('^1CreateVehicleServerSetter is not available on your artifact, please use artifact 5904 or above to be able to use this^0')
            return
        end

        local tempVehicle = CreateVehicle(model, 0, 0, 0, 0, true, true)
        while not DoesEntityExist(tempVehicle) do
            Wait(0)
        end

        local vehicleType = GetVehicleType(tempVehicle)
        DeleteEntity(tempVehicle)

        local ped = GetPlayerPed(source)
        if not coords then
            coords = Utils.GetCoordsFromEntity(ped)
        end

        local veh = CreateVehicleServerSetter(model, vehicleType, coords.x, coords.y, coords.z, coords.w)
        while not DoesEntityExist(veh) do
            Wait(0)
        end

        while GetVehicleNumberPlateText(veh) == "" do
            Wait(0)
        end

        if warp then SetPedIntoVehicle(ped, veh, -1) end
        return NetworkGetNetworkIdFromEntity(veh)
    end
end)

lib.callback.register('mp-rentals:server:getPedLocations', function(_)
    return svConfig.pedLocations
end)
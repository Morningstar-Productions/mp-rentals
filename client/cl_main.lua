local MPc = require 'modules.client'
local config = require 'config.client'

------------
-- Events --
------------

local function spawnVehicleInfo(model, coords, fuel)
    local netId = lib.callback.await('mp-rentals:server:SpawnVehicleSpawnerVehicle', false, model, coords, false)
    if not netId then return end
    local veh = NetToVeh(netId)

    local vehLabel = GetDisplayNameFromVehicleModel(model)
    local vehicleLabel = GetLabelText(vehLabel)
    local plate = qbx.getVehiclePlate(veh)

    if config.fuelExport ~= '' then
        exports[config.fuelExport]:SetFuel(veh, fuel, nil)
    else
        Entity(veh).state.fuel = fuel
    end

    if not plate then return end

    SetVehicleNumberPlateText(veh, plate)
    Entity(veh).state:set('vehicleLock', { lock = 0 }, true)

    local givePapers = lib.callback.await('mp-rentals:server:rentalpapers', false, plate, vehicleLabel)
    if not givePapers then return end
end

local function spawnVehicle(data)
    local money = data.money
    local model = data.model
    local fuel = data.fuel
    local menu = data.menuType
    local label = locale('error.not_enough_space', menu:sub(1, 1):upper() .. menu:sub(2))

    local nearestRentPoint
    local nearestSpawnpoint
    local pedPos = GetEntityCoords(cache.ped)

    for _, spawn in pairs(config.vehSpawnLocations[menu]) do
        local distance = #(pedPos - vec3(spawn.xyz))
        if not nearestRentPoint or distance < nearestRentPoint then
            nearestRentPoint = distance
            nearestSpawnpoint = spawn
        end
    end

    if nearestSpawnpoint then
        if menu == 'vehicle' then
            local spawnVeh = nearestSpawnpoint.vehicle
            if IsAnyVehicleNearPoint(spawnVeh.x, spawnVeh.y, spawnVeh.z, 2.0) then
                MPc.Notify(label, 'error', 4500)
                return
            end
        elseif menu == 'aircraft' then
            local spawnAir = nearestSpawnpoint.aircraft
            if IsAnyVehicleNearPoint(spawnAir.x, spawnAir.y, spawnAir.z, 15.0) then
                MPc.Notify(label, 'error', 4500)
                return
            end
        elseif menu == 'boat' then
            local spawnBoat = nearestSpawnpoint.boat
            if IsAnyVehicleNearPoint(spawnBoat.x, spawnBoat.y, spawnBoat.z, 10.0) then
                MPc.Notify(label, 'error', 4500)
                return
            end
        end
    end

    local alert = lib.alertDialog({
        header = 'You are about to rent a vehicle',
        content = 'You are about to rent a vehicle for ' .. money .. '.  \n Are you sure you want to rent this vehicle?',
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Rent',
        }
    })

    if alert == 'confirm' then
        lib.callback('mp-rentals:server:CashCheck', false, function(money)
            if money then
                if nearestSpawnpoint then
                    if menu == 'vehicle' then
                        spawnVehicleInfo(model, nearestSpawnpoint.vehicle, fuel)
                    elseif menu == 'aircraft' then
                        spawnVehicleInfo(model, nearestSpawnpoint.aircraft, fuel)
                    elseif menu == 'boat' then
                        spawnVehicleInfo(model, nearestSpawnpoint.boat, fuel)
                    end
                end
            else
                MPc.Notify(locale('not_enough_money'), 'error', 4500)
            end
        end, money)
    else
        MPc.Notify(locale('next_time'), 'error', 4500)
    end
end
exports('spawnVehicle', spawnVehicle)

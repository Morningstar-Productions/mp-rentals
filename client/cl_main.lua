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

--- Spawns a vehicle at the nearest spawn point
-- @param table data The data containing information about the vehicle, menu, and other configurations
local function spawnVehicle(data)
    local money = data.money
    local model = data.model
    local fuel = data.fuel
    local menu = data.menuType
    local label = locale('not_enough_space', menu:sub(1, 1):upper() .. menu:sub(2))

    local nearestDistance = nil
    local nearestSpawnpoint = nil
    local pedPos = GetEntityCoords(cache.ped)

    -- Iterate through each spawn location to find the nearest one
    for _, spawn in pairs(config.vehSpawnLocations[menu]) do
        local distance = #(pedPos - vec3(spawn.xyz))
        if not nearestDistance or distance < nearestDistance then
            nearestDistance = distance
            nearestSpawnpoint = spawn
        end
    end

    if nearestSpawnpoint then
        local vehicleCheckRadius = menu == 'vehicle' and 2.0 or menu == 'aircraft' and 1.5 or 10.0
        if IsAnyVehicleNearPoint(nearestSpawnpoint.x, nearestSpawnpoint.y, nearestSpawnpoint.z, vehicleCheckRadius) then
            MPc.Notify(label, 'error', 4500)
            return
        end
    end

    local alert = lib.alertDialog({
        header = 'You are about to purchase a vehicle',
        content = 'You are about to purchase a vehicle for ' .. money .. '.  \n Are you sure you want to rent this vehicle?',
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Rent',
        }
    })

    if alert == 'confirm' then
        lib.callback('mp-rentals:server:CashCheck', false, function(hasMoney)
            if hasMoney then
                spawnVehicleInfo(model, nearestSpawnpoint, fuel)
            else
                MPc.Notify(locale('not_enough_money'), 'error', 4500)
            end
        end, money)
    else
        MPc.Notify(locale('next_time'), 'error', 4500)
    end
end
exports('spawnVehicle', spawnVehicle)

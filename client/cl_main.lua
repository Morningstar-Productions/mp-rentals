lib.locale()
local MPc = require 'modules.client'
local Utils = require 'modules.utils'

------------
-- Events --
------------

local function spawnVehicle(data)
    local money = data.money
    local model = data.model
    local fuel = data.fuel
    local menu = data.menuType

    local label = locale("error.not_enough_space", menu:sub(1,1):upper()..menu:sub(2))
    if menu == "vehicle" then
        local spawnVeh = Config.Locations.vehicle.spawn
        if IsAnyVehicleNearPoint(spawnVeh.x, spawnVeh.y, spawnVeh.z, 2.0) then
            MPc.Notify(label, "error", 4500)
            return
        end
    elseif menu == "aircraft" then
        local spawnAir = Config.Locations.aircraft.spawn
        if IsAnyVehicleNearPoint(spawnAir.x, spawnAir.y, spawnAir.z, 15.0) then 
            MPc.Notify(label, "error", 4500)
            return
        end
    elseif menu == "boat" then
        local spawnBoat = Config.Locations.boat.spawn
        if IsAnyVehicleNearPoint(spawnBoat.x, spawnBoat.y, spawnBoat.z, 10.0) then 
            MPc.Notify(label, "error", 4500)
            return
        end
    end

    local alert = lib.alertDialog({
        header = 'You are about to purchase a vehicle',
        content = 'You are about to purchase a vehicle for ' .. money .. ".  \n Are you sure you want to rent this vehicle?",
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Rent',
        }
    })

    if alert == 'confirm' then
        lib.callback("mp-rentals:server:CashCheck", false, function(money)
            if money then
                if menu == "vehicle" then
                    local netId = lib.callback.await('mp-rentals:server:SpawnVehicleSpawnerVehicle', false, model, Config.Locations.vehicle.spawn, false)
                    if not netId then return end
                    local veh = NetToVeh(netId)

                    local vehLabel = GetDisplayNameFromVehicleModel(model)
                    local vehicleLabel = GetLabelText(vehLabel)
                    local plate = Utils.GetPlate(veh)

                    if Config.FuelExport then
                        exports[Config.FuelExport]:SetFuel(veh, fuel, nil)
                    else
                        Entity(veh).state.fuel = fuel
                    end
                    SetVehicleNumberPlateText(veh, plate)
                    Utils.GiveKeys(plate)
                    TriggerServerEvent('mp-rentals:server:rentalpapers', plate, vehicleLabel)
                elseif menu == "aircraft" then
                    local netId = lib.callback.await('mp-rentals:server:SpawnVehicleSpawnerVehicle', false, model, Config.Locations.vehicle.spawn, false)
                    if not netId then return end
                    local veh = NetToVeh(netId)

                    local vehLabel = GetDisplayNameFromVehicleModel(model)
                    local vehicleLabel = GetLabelText(vehLabel)
                    local plate = Utils.GetPlate(veh)

                    if Config.FuelExport then
                        exports[Config.FuelExport]:SetFuel(veh, fuel, nil)
                    else
                        Entity(veh).state.fuel = fuel
                    end
                    SetVehicleNumberPlateText(veh, plate)
                    Utils.GiveKeys(plate)
                    TriggerServerEvent('mp-rentals:server:rentalpapers', plate, vehicleLabel)
                elseif menu == "boat" then
                    local netId = lib.callback.await('mp-rentals:server:SpawnVehicleSpawnerVehicle', false, model, Config.Locations.vehicle.spawn, false)
                    if not netId then return end
                    local veh = NetToVeh(netId)

                    local vehLabel = GetDisplayNameFromVehicleModel(model)
                    local vehicleLabel = GetLabelText(vehLabel)
                    local plate = Utils.GetPlate(veh)

                    if Config.FuelExport then
                        exports[Config.FuelExport]:SetFuel(veh, fuel, nil)
                    else
                        Entity(veh).state.fuel = fuel
                    end
                    SetVehicleNumberPlateText(veh, plate)
                    Utils.GiveKeys(plate)
                    TriggerServerEvent('mp-rentals:server:rentalpapers', plate, vehicleLabel)
                end 
            else
                MPc.Notify(locale("not_enough_money"), "error", 4500)
            end
        end, money)
    else
        MPc.notify(locale('next_time'), 'error', 4500)
    end
end exports('spawnVehicle', spawnVehicle)
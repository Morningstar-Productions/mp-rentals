lib.locale()
local MPc = require 'modules.client'
local Utils = require 'modules.utils'
local menu

------------
-- Events --
------------

RegisterNetEvent('mp-rentals:client:LicenseCheck', function(data)
    local license = data.LicenseType
    if license == "driver" then
        local hasLicense = lib.callback.await("mp-rentals:server:getDriverLicenseStatus", false)
        if hasLicense  then
            TriggerEvent('mp-rentals:client:openMenu', data)
            MenuType = "vehicle"
        else
            MPc.Notify(locale('no_driver_license'), "error", 4500)
        end
    elseif license == "pilot" then
        local hasLicense = lib.callback.await("mp-rentals:server:getPilotLicenseStatus", false)
        if hasLicense  then
            TriggerEvent('mp-rentals:client:openMenu', data)
            MenuType = "aircraft"
        else
            MPc.Notify(locale('no_pilot_license'), "error", 4500)
        end
    end
end)

RegisterNetEvent('mp-rentals:client:openMenu', function(data)
    menu = data.MenuType
    local vehMenu = {}

    if menu == "vehicle" then
        for i = 1, #Config.Vehicles.land do
            local name = Config.Vehicles.land[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = Config.Vehicles.land[i].icon,
                arrow = true,
                event = "mp-rentals:client:spawncar",
                image = Config.Vehicles.land[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.land[i].money}
                },
                progress = Config.Vehicles.land[i].fuel,
                args = {
                    model = Config.Vehicles.land[i].model,
                    money = Config.Vehicles.land[i].money,
                    fuel = Config.Vehicles.land[i].fuel
                }
            }
        end
    elseif menu == "aircraft" then
        for i = 1, #Config.Vehicles.air do
            local name = Config.Vehicles.air[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = Config.Vehicles.air[i].icon,
                arrow = true,
                event = "mp-rentals:client:spawncar",
                image = Config.Vehicles.air[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.air[i].money}
                },
                args = {
                    model = Config.Vehicles.air[i].model,
                    money = Config.Vehicles.air[i].money,
                    fuel = Config.Vehicles.air[i].fuel
                }
            }
        end
    elseif menu == "boat" then
        for i = 1, #Config.Vehicles.sea do
            local name = Config.Vehicles.sea[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = Config.Vehicles.sea[i].icon,
                arrow = true,
                event = "mp-rentals:client:spawncar",
                image = Config.Vehicles.sea[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.sea[i].money}
                },
                args = {
                    model = Config.Vehicles.sea[i].model,
                    money = Config.Vehicles.sea[i].money,
                    fuel = Config.Vehicles.sea[i].fuel
                }
            }
        end
    end
    lib.registerContext({
        id = "rental_veh_menu",
        title = "Rental Vehicles",
        hasSearch = Config.OxQW,
        options = vehMenu
    })
    lib.showContext('rental_veh_menu')
end)

RegisterNetEvent('mp-rentals:client:spawncar', function(data)
    local money = data.money
    local model = data.model
    local fuel = data.fuel

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
end)

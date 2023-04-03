QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false

-- Vehicle Rentals

RegisterNetEvent('qb-rental:client:LicenseCheck', function(data)
    license = data.LicenseType
    if license == "driver" then
        QBCore.Functions.TriggerCallback("qb-rentals:server:getDriverLicenseStatus", function(hasLicense)
            if hasLicense  then
                TriggerEvent('qb-rental:client:openMenu', data)
                MenuType = "vehicle"
            else
                QBCore.Functions.Notify(Lang:t("error.no_driver_license"), "error", 4500)
            end
        end)
    elseif license == "pilot" then
        QBCore.Functions.TriggerCallback("qb-rentals:server:getPilotLicenseStatus", function(hasLicense)
            if hasLicense  then
                TriggerEvent('qb-rental:client:openMenu', data)
                MenuType = "aircraft"
            else
                QBCore.Functions.Notify(Lang:t("error.no_pilot_license"), "error", 4500)
            end
        end)
    end
end)

RegisterNetEvent('qb-rental:client:openMenu', function(data)
    menu = data.MenuType

    local vehMenu = {}

    if menu == "vehicle" then
        for k=1, #Config.Vehicles.land do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.land[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.land[k].model:sub(1,1):upper()..Config.Vehicles.land[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                title = name,
                description = "Rent Vehicle",
                icon = Config.Vehicles.land[k].icon,
                arrow = true,
                event = "qb-rental:client:spawncar",
                image = Config.Vehicles.land[k].image,
                metadata = {
                    {label = 'Price', value = "$" .. Config.Vehicles.land[k].money}
                },
                args = {
                    model = Config.Vehicles.land[k].model,
                    money = Config.Vehicles.land[k].money,
                }
            }
        end
    elseif menu == "aircraft" then
        for k=1, #Config.Vehicles.air do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.air[k].model]
            local name = veh and ('%s'):format(veh.name) or Config.Vehicles.air[k].model:sub(1,1):upper()..Config.Vehicles.air[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                title = name,
                description = "Rent Vehicle",
                icon = Config.Vehicles.air[k].icon,
                arrow = true,
                event = "qb-rental:client:spawncar",
                image = Config.Vehicles.air[k].image,
                metadata = {
                    {label = 'Price', value = "$" .. Config.Vehicles.air[k].money}
                },
                args = {
                    model = Config.Vehicles.air[k].model,
                    money = Config.Vehicles.air[k].money,
                }
            }
        end
    elseif menu == "boat" then
        for k=1, #Config.Vehicles.sea do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.sea[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.sea[k].model:sub(1,1):upper()..Config.Vehicles.sea[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                title = name,
                description = "Rent Vehicle",
                icon = Config.Vehicles.sea[k].icon,
                arrow = true,
                event = "qb-rental:client:spawncar",
                image = Config.Vehicles.sea[k].image,
                metadata = {
                    {label = 'Price', value = "$" .. Config.Vehicles.sea[k].money}
                },
                args = {
                    model = Config.Vehicles.sea[k].model,
                    money = Config.Vehicles.sea[k].money,
                }
            }
        end
    end
    lib.registerContext({
        id = "rental_veh_menu",
        title = "Rental Vehicles",
        hasSearch = true,
        options = vehMenu
    })
    lib.showContext('rental_veh_menu')
end)

RegisterNetEvent('qb-rental:client:spawncar', function(data)
    local player = PlayerPedId()
    local money = data.money
    local model = data.model
    local label = Lang:t("error.not_enough_space", {vehicle = menu:sub(1,1):upper()..menu:sub(2)})
    if menu == "vehicle" then
        if IsAnyVehicleNearPoint(Config.Locations.vehicle.spawnpoint.x, Config.Locations.vehicle.spawnpoint.y, Config.Locations.vehicle.spawnpoint.z, 2.0) then
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end
    elseif menu == "aircraft" then
        if IsAnyVehicleNearPoint(Config.Locations.aircraft.spawnpoint.x, Config.Locations.aircraft.spawnpoint.y, Config.Locations.aircraft.spawnpoint.z, 15.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end 
    elseif menu == "boat" then
        if IsAnyVehicleNearPoint(Config.Locations.boat.spawnpoint.x, Config.Locations.boat.spawnpoint.y, Config.Locations.boat.spawnpoint.z, 10.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end  
    end

    QBCore.Functions.TriggerCallback("qb-rental:server:CashCheck",function(money)
        if money then
            if menu == "vehicle" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.vehicle.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                    print()
                end, Config.Locations.vehicle.spawnpoint, true)
            elseif menu == "aircraft" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.aircraft.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.aircraft.spawnpoint, true)
            elseif menu == "boat" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.boat.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.boat.spawnpoint, true)
            end 
            Wait(1000)
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('qb-rental:server:rentalpapers', plate, vehicleLabel)
        else
            QBCore.Functions.Notify(Lang:t("error.not_enough_money"), "error", 4500)
        end
    end, money)
end)

RegisterNetEvent('qb-rental:client:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify(Lang:t("task.veh_returned"), 'success')
        TriggerServerEvent('qb-rental:server:removepapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), "error")
    end
    SpawnVehicle = false
end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.Blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.65)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    end
end)
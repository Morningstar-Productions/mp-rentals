local Utils = require 'modules.utils'

--------------
-- Functons --
--------------

-- Borrowed from qbx_core (Standalone)
Utils.EntityStateHandler('initVehicle', function(entity, _, value)
    if not value then return end

    for i = -1, 0 do
        local ped = GetPedInVehicleSeat(entity, i)

        if ped ~= cache.ped and ped > 0 and NetworkGetEntityOwner(ped) == cache.playerId then
            DeleteEntity(ped)
        end
    end

    if NetworkGetEntityOwner(entity) ~= cache.playerId then return end
    SetVehicleNeedsToBeHotwired(entity, false)
    SetVehRadioStation(entity, 'OFF')
    SetVehicleFuelLevel(entity, 100.0)
    SetVehicleDirtLevel(entity, 0.0)
    Entity(entity).state:set('initVehicle', nil, true)
end)

local function CreatePeds()
    local landcoords = Config.Locations.vehicle.ped
    local aircoords = Config.Locations.aircraft.ped
    local boatcoords = Config.Locations.boat.ped

    Renewed.addPed({
        model = `a_m_y_business_03`, -- The ped to be spawned
        dist = 25, -- Distance of when the ped should be loaded in
        coords = vec3(landcoords.x, landcoords.y, landcoords.z), -- The coords for the ped
        heading = landcoords.w, -- Heading of the ped
        scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want the ped to play a scenario
        freeze = true, -- use this if the ped should be frozen
        invincible = true, -- use this if the ped should be invincible 
        tempevents = true,-- use this if the ped should block temporary events
        id = 'rentals_land_vehicles', -- Unique ID for the ped

        -- Normal ox Target stuff --
        target = {
            {
                name = 'rentals_land_vehicles',
                event = "mp-rentals:client:LicenseCheck",
                icon = "fas fa-car",
                label = "Rent Vehicle",
                LicenseType = "driver",
                MenuType = "vehicle",
                distance = 2.5,
            },
        }
    })

    Renewed.addPed({
        model = `s_m_y_airworker`, -- The ped to be spawned
        dist = 25, -- Distance of when the ped should be loaded in
        coords = vec3(aircoords.x, aircoords.y, aircoords.z), -- The coords for the ped
        heading = aircoords.w, -- Heading of the ped
        scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want the ped to play a scenario
        freeze = true, -- use this if the ped should be frozen
        invincible = true, -- use this if the ped should be invincible 
        tempevents = true,-- use this if the ped should block temporary events
        id = 'rentals_air_vehicles', -- Unique ID for the ped

        -- Normal ox Target stuff --
        target = {
            {
                name = 'rentals_air_vehicles',
                event = "mp-rentals:client:LicenseCheck",
                icon = "fas fa-car",
                label = "Rent Vehicle",
                LicenseType = "pilot",
                MenuType = "aircraft",
                distance = 2.5,
            },
        }
    })

    Renewed.addPed({
        model = `mp_m_boatstaff_01`, -- The ped to be spawned
        dist = 25, -- Distance of when the ped should be loaded in
        coords = vec3(boatcoords.x, boatcoords.y, boatcoords.z), -- The coords for the ped
        heading = boatcoords.w, -- Heading of the ped
        scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want the ped to play a scenario
        freeze = true, -- use this if the ped should be frozen
        invincible = true, -- use this if the ped should be invincible 
        tempevents = true,-- use this if the ped should block temporary events
        id = 'rentals_air_vehicles', -- Unique ID for the ped

        -- Normal ox Target stuff --
        target = {
            {
                name = 'rentals_air_vehicles',
                event = "mp-rentals:client:LicenseCheck",
                icon = "fas fa-car",
                label = "Rent Vehicle",
                LicenseType = "pilot",
                MenuType = "aircraft",
                distance = 2.5,
            },
        }
    })
end

local function CreateRentalBlips()
    for _, blip in pairs(Config.VehBlips) do
        Utils.createBlips(blip.title, vec3(blip.coords.x, blip.coords.y, blip.coords.z), blip.id, blip.scale or 0.65, blip.color)
    end
end

local function playerLoad()
    CreateRentalBlips()
    CreatePeds()
end

AddEventHandler('Renewed-Lib:client:PlayerLoaded', playerLoad)

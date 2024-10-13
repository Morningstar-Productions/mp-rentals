local Utils = require 'modules.utils'
local MPc = require 'modules.client'
local config = require 'config.client'

--------------
-- Functons --
--------------

local function checkLicenseData(data)
    local license = data.licenseType

    local hasLicense = lib.callback.await("mp-rentals:server:getLicenseStatus", false, license)

    if hasLicense then
        MPc.openVehicleMenu(data)
    else
        MPc.Notify(locale('no_driver_license'), "error", 4500)
    end
end

local function CreatePeds()
    local pedInfo = lib.callback.await('mp-rentals:server:getPedLocations', false)

    local landcoords = pedInfo.vehicle
    local aircoords = pedInfo.aircraft
    local boatcoords = pedInfo.boat

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
                icon = "fas fa-car",
                label = "Rent Vehicle",
                onSelect = function()
                    local data = { licenseType = 'driver', menuType = 'vehicle' }
                    checkLicenseData(data)
                end,
                canInteract = function(_, distance)
                    return distance < 2.5 and config.useTarget
                end,
            },
        },

        interact = {
            distance = 3.0,
            interactDst = 1.5,
            options = {
                {
                    label = 'Rent Vehicle',
                    action = function()
                        local data = { licenseType = 'driver', menuType = 'vehicle' }
                        checkLicenseData(data)
                    end,
                    canInteract = function()
                        return not config.useTarget
                    end
                }
            }
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
                icon = "fas fa-car",
                label = "Rent Vehicle",
                onSelect = function()
                    local data = { licenseType = 'pilot', menuType = 'aircraft' }
                    checkLicenseData(data)
                end,
                canInteract = function(_, distance)
                    return distance < 2.5 and config.useTarget
                end,
            },
        },

        interact = {
            distance = 3.0,
            interactDst = 1.5,
            options = {
                {
                    label = 'Rent Vehicle',
                    action = function()
                        local data = { licenseType = 'pilot', menuType = 'aircraft' }
                        checkLicenseData(data)
                    end,
                    canInteract = function()
                        return not config.useTarget
                    end
                }
            }
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
        id = 'rentals_boat_vehicles', -- Unique ID for the ped

        -- Normal ox Target stuff --
        target = {
            {
                name = 'rentals_air_vehicles',
                icon = "fas fa-car",
                label = "Rent Vehicle",
                onSelect = function()
                    local data = { menuType = 'boat' }
                    MPc.openVehicleMenu(data)
                end,
                canInteract = function(_, distance)
                    return distance < 2.5 and config.useTarget
                end,
            },
        },

        interact = {
            distance = 3.0,
            interactDst = 1.5,
            options = {
                {
                    label = 'Rent Vehicle',
                    action = function()
                        local data = { menuType = 'boat' }
                        checkLicenseData(data)
                    end,
                    canInteract = function()
                        return not config.useTarget
                    end
                }
            }
        }
    })
end

local function CreateRentalBlips()
    for _, blip in pairs(config.vehBlips) do
        Utils.createBlips(blip.title, vec3(blip.coords.x, blip.coords.y, blip.coords.z), blip.id, blip.scale or 0.65, blip.color)
    end
end

local function UseRentalPapers(data, slot)
    local metadata = slot.metadata

    exports.ox_inventory:useItem(data, function(data)
        if data then
            metadata = data.metadata
            local hasKeys = lib.callback.await('mp-rentals:server:GiveRentalPaperKeys', false, metadata)
            if hasKeys then return print('success') end
        end
    end)
end
exports('rentalpapers', UseRentalPapers)

local function playerLoad()
    CreateRentalBlips()
    CreatePeds()
end

CreateThread(playerLoad)

CreateThread(function()
    local model = joaat(`a_m_y_business_03`)
    lib.requestModel(model)
    local coords = Config.Locations.vehicle.ped
    local Land = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, false, false)

    TaskStartScenarioInPlace(Land, 'WORLD_HUMAN_CLIPBOARD', 1, false)
	FreezeEntityPosition(Land, true)
	SetEntityInvincible(Land, true)
	SetBlockingOfNonTemporaryEvents(Land, true)

    local options = {
        {
            event = "mp-rentals:client:LicenseCheck",
            icon = "fas fa-car",
            label = "Rent Vehicle",
            LicenseType = "driver",
            MenuType = "vehicle",
            distance = 2.5,
        },
        {
            event = "mp-rentals:client:return",
            icon = "fas fa-circle",
            label = 'Return Vehicle',
            distance = 2.5,
        }
    }
    exports.ox_target:addLocalEntity(Land, options)
end)

CreateThread(function()
    local model = joaat(`s_m_y_airworker`)
    lib.requestModel(model)
    local coords = Config.Locations.aircraft.ped
    local Air = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, false, false)

    TaskStartScenarioInPlace(Air, 'WORLD_HUMAN_CLIPBOARD', 1, false)
	FreezeEntityPosition(Air, true)
	SetEntityInvincible(Air, true)
	SetBlockingOfNonTemporaryEvents(Air, true)

    local options = {
        {
            type = "client",
            event = "mp-rentals:client:LicenseCheck",
            icon = "fas fa-car",
            label = "Rent Vehicle",
            LicenseType = "pilot",
            MenuType = "aircraft",
            distance = 2.5,
        },
        {
            type = "client",
            event = "mp-rentals:client:return",
            icon = "fas fa-circle",
            label = 'Return Vehicle',
            distance = 2.5,
        }
    }
    exports.ox_target:addLocalEntity(Air, options)
end)

CreateThread(function()
    local model = joaat(`mp_m_boatstaff_01`)
    lib.requestModel(model)
    local coords = Config.Locations.aircraft.ped
    local Sea = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, false, false)

    TaskStartScenarioInPlace(Sea, 'WORLD_HUMAN_CLIPBOARD', 1, false)
	FreezeEntityPosition(Sea, true)
	SetEntityInvincible(Sea, true)
	SetBlockingOfNonTemporaryEvents(Sea, true)

    local options = {
        {
            type = "client",
            event = "mp-rentals:client:openMenu",
            icon = "fas fa-car",
            label = "Rent Vehicle",
            MenuType = "boat",
            distance = 2.5,
        },
        {
            type = "client",
            event = "mp-rentals:client:return",
            icon = "fas fa-circle",
            label = 'Return Vehicle',
            distance = 2.5,
        }
    }
    exports.ox_target:addLocalEntity(Sea, options)
end)

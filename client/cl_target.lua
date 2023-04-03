local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    QBCore.Functions.LoadModel(`a_m_y_business_03`)
    local Land = CreatePed(0, `a_m_y_business_03`, 109.55, -1089.71, 29.3 - 1.0, 351.28, false, false)
    TaskStartScenarioInPlace(Land, 'WORLD_HUMAN_CLIPBOARD', true)
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
    QBCore.Functions.LoadModel(`s_m_y_airworker`)
    local Air = CreatePed(0, `s_m_y_airworker`, -1686.57, -3149.22, 13.99 - 1.0, 240.88, false, false)
    TaskStartScenarioInPlace(Air, 'WORLD_HUMAN_CLIPBOARD', true)
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
    QBCore.Functions.LoadModel(`mp_m_boatstaff_01`)
    local Sea = CreatePed(0, `mp_m_boatstaff_01`, -753.5, -1512.27, 5.02 - 1.0, 25.61, false, false)
    TaskStartScenarioInPlace(Sea, 'WORLD_HUMAN_CLIPBOARD', true)
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
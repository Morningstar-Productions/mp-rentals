local MPc = {}
local config = require 'config.client'

---@param text string
---@param textType string
---@param duration number
function MPc.Notify(text, textType, duration)
    lib.notify({
        description = text,
        type = textType,
        duration = duration
    })
end

function MPc.openVehicleMenu(data)
    local menu = data.menuType
    local vehMenu = {}

    if menu == "vehicle" then
        for i = 1, #config.rentalVehicles.land do
            local name = config.rentalVehicles.land[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = config.rentalVehicles.land[i].icon,
                arrow = true,
                onSelect = function()
                    local vehData = {
                        model = config.rentalVehicles.land[i].model,
                        money = config.rentalVehicles.land[i].money,
                        fuel = config.rentalVehicles.land[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = ('https://docs.fivem.net/vehicles/%s.webp'):format(config.rentalVehicles.land[i].model),
                metadata = {
                    {label = locale('price_label'), value = "$" .. config.rentalVehicles.land[i].money}
                },
                progress = config.rentalVehicles.land[i].fuel,
            }
        end
    elseif menu == "aircraft" then
        for i = 1, #config.rentalVehicles.air do
            local name = config.rentalVehicles.air[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = config.rentalVehicles.air[i].icon,
                arrow = true,
                onSelect = function()
                    local vehData = {
                        model = config.rentalVehicles.air[i].model,
                        money = config.rentalVehicles.air[i].money,
                        fuel = config.rentalVehicles.air[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = ('https://docs.fivem.net/vehicles/%s.webp'):format(config.rentalVehicles.air[i].model),
                metadata = {
                    {label = locale('price_label'), value = "$" .. config.rentalVehicles.air[i].money}
                },
                progress = config.rentalVehicles.air[i].fuel,
            }
        end
    elseif menu == "boat" then
        for i = 1, #config.rentalVehicles.sea do
            local name = config.rentalVehicles.sea[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = config.rentalVehicles.sea[i].icon,
                arrow = true,
                onSelect = function()
                    local vehData = {
                        model = config.rentalVehicles.sea[i].model,
                        money = config.rentalVehicles.sea[i].money,
                        fuel = config.rentalVehicles.sea[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = ('https://docs.fivem.net/vehicles/%s.webp'):format(config.rentalVehicles.sea[i].model),
                metadata = {
                    {label = locale('price_label'), value = "$" .. config.rentalVehicles.sea[i].money}
                },
                progress = config.rentalVehicles.sea[i].fuel,
            }
        end
    end

    lib.registerContext({
        id = "rental_veh_menu",
        title = "Rental Vehicles",
        hasSearch = config.useOxQwade,
        options = vehMenu
    })
    lib.showContext('rental_veh_menu')
end

return MPc

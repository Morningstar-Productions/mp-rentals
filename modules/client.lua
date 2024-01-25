local MPc = {}

---@param text string
---@param textType string
---@param duration number
function MPc.Notify(text, textType, duration)
    if GetResourceState('qb-core'):match('started') then
        exports['qb-core']:GetCoreObject().Functions.Notify(text, textType, duration)
    else
        lib.notify({
            description = text,
            type = textType,
            duration = duration
        })
    end
end

function MPc.openVehicleMenu(data)
    local menu = data.menuType
    local vehMenu = {}

    if menu == "vehicle" then
        for i = 1, #Config.Vehicles.land do
            local name = Config.Vehicles.land[i].name
            vehMenu[#vehMenu+1] = {
                title = name,
                description = locale('rent_veh_label'),
                icon = Config.Vehicles.land[i].icon,
                arrow = true,
                onSelect = function()
                    local vehData = {
                        model = Config.Vehicles.land[i].model,
                        money = Config.Vehicles.land[i].money,
                        fuel = Config.Vehicles.land[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = Config.Vehicles.land[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.land[i].money}
                },
                progress = Config.Vehicles.land[i].fuel,
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
                onSelect = function()
                    local vehData = {
                        model = Config.Vehicles.air[i].model,
                        money = Config.Vehicles.air[i].money,
                        fuel = Config.Vehicles.air[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = Config.Vehicles.air[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.air[i].money}
                },
                progress = Config.Vehicles.air[i].fuel,
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
                onSelect = function()
                    local vehData = {
                        model = Config.Vehicles.sea[i].model,
                        money = Config.Vehicles.sea[i].money,
                        fuel = Config.Vehicles.sea[i].fuel,
                        menuType = menu,
                    }
                    exports['mp-rentals']:spawnVehicle(vehData)
                end,
                image = Config.Vehicles.sea[i].image,
                metadata = {
                    {label = locale('price_label'), value = "$" .. Config.Vehicles.sea[i].money}
                },
                progress = Config.Vehicles.sea[i].fuel,
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
end

return MPc
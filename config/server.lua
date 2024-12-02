return {
    pedLocations = {
        vehicle = vec4(109.55, -1089.71, 28.3, 351.28),

        aircraft = vec4(-1686.57, -3149.22, 12.99, 240.88),

        boat = vec4(-753.5, -1512.27, 4.02, 25.61),
    },

    addKey = function(source, plate, vehicle)
        if GetResourceState('qbx_vehiclekeys'):match('started') then
            return exports.qbx_vehiclekeys:GiveKey(source, vehicle)
        end

        if GetResourceState('Renewed-Vehiclekeys'):match('started') then
            return exports['Renewed-Vehiclekeys']:addKey(source, plate)
        end
    end
}
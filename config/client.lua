return {
    fuelExport = 'cdn-fuel',

    useTarget = false,
    useFilter = true, -- Using Variation of ox_lib using Search

    vehBlips = {
        { title = locale("land_veh"), color = 50, id = 56,  coords = vec3(109.55, -1089.71, 29.3) },
        { title = locale("air_veh"),  color = 32, id = 578, coords = vec3(-1673.39, -3158.45, 13.99) },
        { title = locale("sea_veh"),  color = 42, id = 410, coords = vec3(-753.55, -1512.24, 5.02) },
    },

    vehSpawnLocations = {
        vehicle = {
            vec4(111.37, -1081.11, 29.19, 341.23),
        },

        aircraft = {
            vec4(-1673.4, -3158.47, 13.99, 331.49),
        },

        boat = {
            vec4(-794.95, -1506.27, 2.08, 107.79),
        },
    },

    rentalVehicles = {
        land = {
            [1] = {
                name = 'Boat Trailer',
                model = 'boattrailer',
                icon = 'fas fa-car',
                money = 500,
                --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085004964348305468/image.png',
                fuel = math.random(55, 77),
            },
        },
        air = {
            [1] = {
                name = 'Frogger',
                model = 'frogger2',
                icon = 'fas fa-helicopter',
                money = 9500,
                --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085005742123274240/image.png',
                fuel = math.random(75, 100)
            },
        },
        sea = {
            [1] = {
                name = 'Dinghy',
                model = 'dinghy3',
                icon = 'fas fa-anchor',
                money = 7500,
                --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085062044476256326/image.png',
                fuel = math.random(75, 100),
            },
        }
    }
}

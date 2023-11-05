Config = {}

Config.FuelExport = 'cdn-fuel'

Config.OxQW = true

---@todo More than one spawn location
Config.Locations = {
    vehicle = {
        spawn = vector4(111.37, -1081.11, 29.19, 341.23),
        ped = vec4(109.55, -1089.71, 28.3, 351.28),
    },

    aircraft = {
        spawn = vector4(-1673.4, -3158.47, 13.99, 331.49),
        ped = vec4(-1686.57, -3149.22, 12.99, 240.88),
    },

    boat = {
        spawn = vector4(-794.95, -1506.27, 1.08, 107.79),
        ped = vec4(-753.5, -1512.27, 4.02, 25.61),
    },
}

Config.VehBlips = {
    { title = locale("land_veh"), color = 50, id = 56, coords = vec3(109.55, -1089.71, 29.3)},
    { title = locale("air_veh"), color = 32, id = 578, coords = vec3(-1673.39, -3158.45, 13.99)},
    { title = locale("sea_veh"), color = 42, id = 410, co0rds = vec3(-753.55, -1512.24, 5.02)},
}

Config.Vehicles = {
    land = {
        [1] = {
            name = 'Boat Trailer',
            model = 'boattrailer',
            icon = 'fas fa-car',
            money = 500,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085004964348305468/image.png',
            fuel = math.random(55, 77),
        },
        [2] = {
            name = 'Bison',
            model = 'bison',
            icon = 'fas fa-truck-pickup',
            money = 500,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029459079594034/image.png',
            fuel = math.random(55, 77),
        },
        [3] = {
            name = 'Enus',
            model = 'cog55',
            icon = 'fas fa-car',
            money = 750,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029458530148482/image.png',
            fuel = math.random(55, 77),
        },
        [4] = {
            name = 'Futo',
            model = 'futo',
            icon = 'fas fa-car',
            money = 600,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074259279478835/image.png',
            fuel = math.random(55, 77),
        },
        [5] = {
            name = 'Buccaneer',
            model = 'buccaneer',
            icon = 'fas fa-car',
            money = 625,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003990053437580/image.png',
            fuel = math.random(55, 77),
        },
        [6] = {
            name = 'Moped',
            model = 'faggio',
            icon = 'fas fa-motorcycle',
            money = 750,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085004704473432105/image.png',
            fuel = math.random(55, 77),
        },
        [7] = {
            name = 'Sanchez',
            model = 'sanchez',
            icon = 'fas fa-motorcycle',
            money = 10000,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003681331675196/image.png',
            fuel = math.random(55, 77),
        },
        [8] = {
            name = 'Coach',
            model = 'bus',
            icon = 'fas fa-bus',
            money = 800,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074724880781353/image.png',
            fuel = math.random(55, 77),
        },
        [9] = {
            name = 'Shuttle Bus',
            model = 'rentalbus',
            icon = 'fas fa-van-shuttle',
            money = 800,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003215730393158/image.png',
            fuel = math.random(55, 77),
        },
        [10] = {
            name = 'Tour Bus',
            model = 'tourbus',
            icon = 'fas fa-car',
            money = 800,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029457590620190/image.png', -- Image of the vehicle 
            fuel = math.random(55, 77),
        },
        [11] = {
            name = 'Taco Truck',
            model = 'taco2',
            icon = 'fas fa-truck',
            money = 800,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071122141425706/image.png',
            fuel = math.random(55, 77),
        },
        [12] = {
            name = 'Limo',
            model = 'stretch',
            icon = 'fas fa-car',
            money = 1500,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
            fuel = math.random(55, 77),
        },
        [13] = {
            name = 'Hearse',
            model = 'romero',
            icon = 'fas fa-car',
            money = 1500,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
            fuel = math.random(55, 77),
        },
        [14] = {
            name = 'Clown Car',
            model = 'speedo2',
            icon = 'fas fa-van-shuttle',
            money = 5000,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
            fuel = math.random(55, 77),
        },
        [15] = {
            name = 'Festival Bus',
            model = 'pbus2',
            icon = 'fas fa-bus',
            money = 10000,
            --image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
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
        [2] = {
            name = 'Swift',
            model = 'swift',
            icon = 'fas fa-helicopter',
            money = 11000,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085005985451606047/image.png',
            fuel = math.random(75, 100)
        },
    },
    sea = {
        [1] = {
            name = 'Seashark',
            model = 'seashark3',
            icon = 'fas fa-anchor',
            money = 5000,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085061655139987507/image.png',
            fuel = math.random(75, 100),
        },
        [2] = {
            name = 'Dinghy',
            model = 'dinghy3',
            icon = 'fas fa-anchor',
            money = 7500,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085062044476256326/image.png',
            fuel = math.random(75, 100),
        },
        [3] = {
            name = 'Longfin',
            model = 'longfin',
            icon = 'fas fa-anchor',
            money = 11000,
            --image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085062458798002186/image.png',
            fuel = math.random(75, 100),
        },
    }
}

Renewed = exports['Renewed-Lib']:getLib()
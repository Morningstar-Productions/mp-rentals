Config = {}

Config.FuelExport = 'cdn-fuel'

Config.OxQW = true

Config.Locations = {
    vehicle = {
        spawnpoint = vector4(111.37, -1081.11, 29.19, 341.23),
        ped = vec4(109.55, -1089.71, 28.3, 351.28),
    },

    aircraft = {
        spawnpoint = vector4(-1673.4, -3158.47, 13.99, 331.49),
        ped = vec4(-1686.57, -3149.22, 12.99, 240.88),
    },

    boat = {
        spawnpoint = vector4(-794.95, -1506.27, 1.08, 107.79),
        ped = vec4(-753.5, -1512.27, 4.02, 25.61),
    },
}

Config.VehBlips = {
    {title= Lang:t("info.land_veh"), colour= 50, id= 56, x= 109.55, y= -1089.71, z= 29.3},
    --{title= Lang:t("info.air_veh"), colour= 32, id= 578, x= -1673.39, y= -3158.45, z= 13.99},
    --{title= Lang:t("info.sea_veh"), colour= 42, id= 410, x= -753.55, y= -1512.24, z= 5.02}, 
}

Config.Vehicles = {
    land = {
        [1] = {
            model = 'futo',
            icon = 'fas fa-car',
            money = 600,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085004964348305468/image.png'
        },
        [2] = {
            model = 'bison',
            icon = 'fas fa-truck-pickup',
            money = 800,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029459079594034/image.png',
        },
        [3] = {
            model = 'sanchez',
            icon = 'fas fa-motorcycle',
            money = 750,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029458530148482/image.png',
        },
        [4] = {
            model = 'stretch',
            icon = 'fas fa-car',
            money = 2500,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074259279478835/image.png',
        },
        [5] = {
            model = 'asea',
            icon = 'fas fa-car',
            money = 450,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003990053437580/image.png'
        },
        [6] = {
            model = 'moonbeam',
            icon = 'fas fa-van-shuttle',
            money = 900,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085004704473432105/image.png'
        },
        [7] = {
            model = 'asterope',
            icon = 'fas fa-car',
            money = 500,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003681331675196/image.png'
        },
        [8] = {
            model = 'faggio3',
            icon = 'fas fa-motorcycle',
            money = 100,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074724880781353/image.png',
        },
        [9] = {
            model = 'rumpo',
            icon = 'fas fa-van-shuttle',
            money = 200,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085003215730393158/image.png'
        },
        [10] = {
            model = 'sultan',
            icon = 'fas fa-car',
            money = 500,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029457590620190/image.png', -- Image of the vehicle 
        },
        [11] = {
            model = 'bmx',
            icon = 'fas fa-bicycle',
            money = 50,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071122141425706/image.png',
        },
        [12] = {
            model = 'tribike',
            icon = 'fas fa-bicycle',
            money = 75,
            image = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
        }
    },
    air = {
        [1] = {
            model = 'frogger2',
            icon = 'fas fa-helicopter',
            money = 9500,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085005742123274240/image.png'
        },
        [2] = {
            model = 'swift',
            icon = 'fas fa-helicopter',
            money = 11000,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085005985451606047/image.png'
        },
    },
    sea = {
        [1] = {
            model = 'seashark3',
            icon = 'fas fa-anchor',
            money = 5000,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085061655139987507/image.png'
        },
        [2] = {
            model = 'dinghy3',
            icon = 'fas fa-anchor',
            money = 7500,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085062044476256326/image.png'
        },
        [3] = {
            model = 'longfin',
            icon = 'fas fa-anchor',
            money = 11000,
            image = 'https://cdn.discordapp.com/attachments/996342018127175751/1085062458798002186/image.png'
        },
    }
}
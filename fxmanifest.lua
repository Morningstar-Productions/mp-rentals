fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'mp-rentals'
author 'xViperAG#0113'
version '2.7.0'
repository 'https://github.com/Morningstar-Development/mp-rentals'
description 'Rental Script for QBCore using ox_lib and ox_inventory'

dependencies { 'ox_lib', 'ox_inventory', 'ox_target', 'Renewed-Lib' }

ox_lib 'locale'

shared_scripts { '@ox_lib/init.lua', '@Renewed-Lib/init.lua', '@qbx_core/modules/lib.lua', 'config.lua' }
client_script { 'client/cl_*.lua' }
server_script { 'server/sv_*.lua' }

files { 'modules/*.lua', 'locales/*.json', 'config/*.lua' }
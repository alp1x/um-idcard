fx_version 'cerulean'
game 'gta5'

name 'um-idcard'
author 'uyuyorum {um}'
version '2.1.0'
license 'GPL-3.0 license'
repository 'https://github.com/alp1x/um-idcard'
description 'FiveM Identity Card for QBCore and ESX and QBox'

shared_scripts {
	'@ox_lib/init.lua',
}

ox_lib 'locale'

ui_page 'web/index.html'

files {
	'config.lua',
	'web/index.html',
	'web/assets/**',
	'web/dist/**',
	'locales/*.json',
}


client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'bridge/**',
	'server/*.lua',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
nui_callback_strict_mode 'true'


dependencies {
	'ox_lib'
}

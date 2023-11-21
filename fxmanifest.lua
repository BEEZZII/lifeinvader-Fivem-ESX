fx_version 'cerulean'
game 'gta5'
author 'Gabaa, Procx, Bezzi'
description 'LifeInvader für VirtualV'

ui_page "html/index.html"

files {
	"html/*",
}

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua'
}
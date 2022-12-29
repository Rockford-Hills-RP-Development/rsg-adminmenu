fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description "rsg-adminmenu"

ui_page 'html/index.html'

shared_scripts {
    '@rsg-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'shared/config.lua'
}

client_scripts {
    '@menuv/menuv.lua',
    'client/main.lua',
    'client/noclip.lua',
}

files {
    'html/index.html',
    'html/index.js'
}

server_script 'server/main.lua'
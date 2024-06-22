fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rex-postal'
version '1.0.3'

shared_scripts {
    '@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'locales/en.lua', -- preferred language
    'config.lua',
}

client_scripts {
    'client/client.lua',
    'client/npcs.lua',
}

server_scripts {
    'server/server.lua',
    'server/versionchecker.lua',
    '@oxmysql/lib/MySQL.lua'
}

dependencies {
    'rsg-core',
    'rsg-target',
    'rsg-telegram',
    'ox_lib',
}

escrow_ignore {
    'config.lua',
    'README.md',
    'rex-postal.sql',
    'locales',
    'installation'
}

lua54 'yes'

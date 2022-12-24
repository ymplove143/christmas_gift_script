fx_version "cerulean"
game { "gta5" }

shared_script 'config.lua'

client_scripts {
  -- 'game/build/client.js',
  'client/client.lua',
  -- 'client/ped.lua'
  '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}



provide 'ymp-christmasgift'
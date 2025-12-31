fx_version 'adamant'

game 'gta5'

author 'jOta'
description 'Elite'
version '1.1'

games {'gta5'}

client_scripts {
	"cfg.lua",
	'cl.lua',
	"cl_U.lua",
	"_instance/cl.lua",
	--"_garage/cl.lua",
}

shared_script 'translation.lua'

server_scripts{
	'@mysql-async/lib/MySQL.lua',
	"cfg.lua",
	"sv_U.lua",
	'sv.lua',
	"_instance/sv.lua",
	--"_garage/sv.lua",
}

files {
	"ui/*.*"
}

ui_page 'ui/index.html'


--[[files {
    "interiorproxies.meta"
}
    
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta']]
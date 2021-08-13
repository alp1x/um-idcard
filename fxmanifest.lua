fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'


shared_script { 
	'@qb-core/import.lua'
}

client_script {
	'client.lua'
}

server_script {
	'server.lua'
}

files {
	'html/index.html',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png'
}

dependencies {
	'qb-core'
}
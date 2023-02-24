# qb-idcard
[![umstore](https://cdn.discordapp.com/attachments/715130970294059088/1044857362617470986/Baslksz-3.png)](https://uyuyorumstore.com)
[![Donate](https://cdn.discordapp.com/attachments/715130970294059088/1044848075996405820/coffee.png)](https://www.buymeacoffee.com/umcof)
[![License MIT](https://cdn.discordapp.com/attachments/715130970294059088/1044845854508449822/license.png)](https://choosealicense.com/licenses/mit/)
[![Discord](https://cdn.discordapp.com/attachments/715130970294059088/1044855172494532628/discord.png)](https://discord.gg/cf6wkBFeYV)


Simple id card you can use for **[qb-core](https://github.com/qbcore-framework/qb-core)**


<p align="left">
  <img width="160" height="90" src="https://i.ibb.co/bvckB2p/Ba-l-ks-z-2.png">
<img width="160" height="90" src="https://i.ibb.co/K0HGGRD/Ba-l-ks-z-3.png">
<img width="160" height="90" src="https://i.ibb.co/M5mJjH3/Ba-l-ks-z-4.png">
<img width="160" height="90" src="https://i.ibb.co/zh1NLjR/Ba-l-ks-z-5.png">
<img width="160" height="90" src="https://i.ibb.co/vzzw9h1/Ba-l-ks-z-6.png">
</p>

## How to use
### Let's delete the default CreateUseableItem codes
+ qb-inventory > server > main.lua > Find and Delete 
 ```lua
CreateUsableItem("driver_license", function(source, item)
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local players = QBCore.Functions.GetPlayers()
	for _, v in pairs(players) do
		local targetPed = GetPlayerPed(v)
		local dist = #(playerCoords - GetEntityCoords(targetPed))
		if dist < 3.0 then
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>First Name:</strong> {1} <br><strong>Last Name:</strong> {2} <br><strong>Birth Date:</strong> {3} <br><strong>Licenses:</strong> {4}</div></div>',
					args = {
						"Drivers License",
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						item.info.type
					}
				}
			)
		end
	end
end)

CreateUsableItem("id_card", function(source, item)
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local players = QBCore.Functions.GetPlayers()
	for _, v in pairs(players) do
		local targetPed = GetPlayerPed(v)
		local dist = #(playerCoords - GetEntityCoords(targetPed))
		if dist < 3.0 then
			local gender = "Man"
			if item.info.gender == 1 then
				gender = "Woman"
			end
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>Civ ID:</strong> {1} <br><strong>First Name:</strong> {2} <br><strong>Last Name:</strong> {3} <br><strong>Birthdate:</strong> {4} <br><strong>Gender:</strong> {5} <br><strong>Nationality:</strong> {6}</div></div>',
					args = {
						"ID Card",
						item.info.citizenid,
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						gender,
						item.info.nationality
					}
				}
			)
		end
	end
end)

```
#### qb-core > shared > items.lua > add item policecard

### inventory > server > main.lua > find QBCore.Commands.Add("giveitem" and add
```lua
	elseif itemData["name"] == "weaponlicense" then
		info.firstname = Player.PlayerData.charinfo.firstname
		info.lastname = Player.PlayerData.charinfo.lastname
		info.birthdate = Player.PlayerData.charinfo.birthdate
	elseif itemData["name"] == "lawyerpass" then
		info.firstname = Player.PlayerData.charinfo.firstname
		info.lastname = Player.PlayerData.charinfo.lastname
		info.birthdate = Player.PlayerData.charinfo.birthdate
	elseif itemData["name"] == "policecard" then
		info.firstname = Player.PlayerData.charinfo.firstname
		info.lastname = Player.PlayerData.charinfo.lastname
		info.birthdate = Player.PlayerData.charinfo.birthdate
		info.gender = Player.PlayerData.charinfo.gender
		info.nationality = Player.PlayerData.charinfo.nationality
```

+ server.cfg ```ensure qb-idcard or [qb] folder```
+ use item {show nui}
+ hide nui key {config.js}

## Changelog (v3.6)
+ now works with ox_inventory
+ more stable

## Changelog (v3.5)
+ Vue.js
+ Auto close config.js
+ Close key config.js
+ CSS cleaned
+ More flexible now


## License
[MIT](https://choosealicense.com/licenses/mit/)

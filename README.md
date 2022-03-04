# qb-idcard
[![Github Alp1x](https://img.shields.io/badge/Github-alp1x-pink?style=for-the-badge&logo=github)](https://github.com/alp1x/)
[![Donate Tebex](https://img.shields.io/badge/Coffee-Donate-%23FFDD00?style=for-the-badge&logo=buymeacoffee)](https://uyuyorum.tebex.io/package/4721743)
[![License MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge&logo=opensourceinitiative)](https://choosealicense.com/licenses/mit/)


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
QBCore.Functions.CreateUseableItem("driver_license", function(source, item)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local PlayerPed = GetPlayerPed(source)
		local TargetPed = GetPlayerPed(v)
		local dist = #(GetEntityCoords(PlayerPed) - GetEntityCoords(TargetPed))
		if dist < 3.0 then
			local gender = "Man"
			if item.info.gender == 1 then
				gender = "Woman"
			end
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>First Name:</strong> {1} <br><strong>Last Name:</strong> {2} <br><strong>Birth Date:</strong> {3} <br><strong>Gender:</strong> {4}<br><strong>Licenses:</strong> {5}</div></div>',
					args = {
						"Drivers License",
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						gender,
						item.info.type
					}
				}
			)
		end
	end
end)

QBCore.Functions.CreateUseableItem("id_card", function(source, item)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local PlayerPed = GetPlayerPed(source)
		local TargetPed = GetPlayerPed(v)
		local dist = #(GetEntityCoords(PlayerPed) - GetEntityCoords(TargetPed))
		if dist < 3.0 then
			local gender = "Man"
			if item.info.gender == 1 then
				gender = "Woman"
			end
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>Civ ID:</strong> {1} <br><strong>First Name:</strong> {2} <br><strong>Last Name:</strong> {3} <br><strong>Birthdate:</strong> {4} <br><strong>Gender:</strong> {5} <br><strong>Nationality:</strong> {6}<br><strong>Fingerprint:</strong> {7}</div></div>',
					args = {
						"ID Card",
						item.info.citizenid,
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						gender,
						item.info.nationality,
						item.info.fingerprint
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
+ hide nui key {backspace}

## Changelog (v3)
+ Added config.js and language setting
+ More flexible now
+ Added police card and badge prop,animation


## License
[MIT](https://choosealicense.com/licenses/mit/)

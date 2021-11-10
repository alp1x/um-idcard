# qb-idcard
[![Github Alp1x](https://img.shields.io/badge/Github-alp1x-pink?style=for-the-badge&logo=github)](https://github.com/alp1x/)
[![Donate Tebex](https://img.shields.io/badge/Coffee-Donate-%23FFDD00?style=for-the-badge&logo=buymeacoffee)](https://uyuyorum.tebex.io/package/4721743)
[![License MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge&logo=opensourceinitiative)](https://choosealicense.com/licenses/mit/)


Simple id card you can use for **[qb-core](https://github.com/qbcore-framework/qb-core)**

**[PSD](https://mega.nz/file/Bj4SVRLJ#d9ocP5SA5SvEAv9Sn_PzoO3anBescvsRQ9OF0DmqcSE)**

<p align="left">
  <img width="160" height="100" src="https://i.hizliresim.com/favgirt.png">
<img width="160" height="100" src="https://i.hizliresim.com/eu17qfv.png">
<img width="160" height="100" src="https://i.hizliresim.com/9dihzzm.png">
<img width="160" height="100" src="https://i.hizliresim.com/jbm0m4s.png">
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


+ server.cfg ```ensure qb-idcard or [qb] folder```
+ use item {show nui}
+ hide nui key {backspace}

## License
[MIT](https://choosealicense.com/licenses/mit/)

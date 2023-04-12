# um-idcard | old (~~qb-idcard~~)
[![umstore](https://cdn.discordapp.com/attachments/715130970294059088/1044857362617470986/Baslksz-3.png)](https://uyuyorumstore.com)
[![Donate](https://cdn.discordapp.com/attachments/715130970294059088/1044848075996405820/coffee.png)](https://www.buymeacoffee.com/umcof)
[![License MIT](https://cdn.discordapp.com/attachments/715130970294059088/1044845854508449822/license.png)](https://choosealicense.com/licenses/gpl-3.0/)
[![Discord](https://cdn.discordapp.com/attachments/715130970294059088/1044855172494532628/discord.png)](https://discord.gg/cf6wkBFeYV)


<p align="center">
<img width="210" height="130" src="https://cdn.discordapp.com/attachments/1016069609897595011/1093324949227327529/identity.png">
<img width="210" height="130" src="https://cdn.discordapp.com/attachments/1016069609897595011/1093324948942106674/driverlicense.png">
<img width="210" height="130" src="https://cdn.discordapp.com/attachments/1016069609897595011/1093324949466394684/lawyerpass.png">
<img width="210" height="130" src="https://cdn.discordapp.com/attachments/1016069609897595011/1093324949692878869/weapon_license.png">
</p>
 <p><b>qb-idcard</b> has been updated and renamed as <b>um-idcard</b>, and it is now compatible with <b>ESX</b> and </b><b>QBCore</b> and <b>Qbox</b></p> 


### Setup
* If you don't have them, download the requirements
* Make sure you have the items in **Config.Licenses**, otherwise add them.
* After ox_lib and MugShotBase64 ```ensure um-idcard or [um] folder```
* [QBCore Starter Setup](https://github.com/alp1x/um-idcard#qbcore-starter-setup)
* ESX Starter Setup

### Usage
* Just use the item
* If there is someone near you, it will be visible to them, otherwise only you will see it.
* It takes a mugshot of you on the first use of the item and saves it in metadata.

### How to create a custom identity card?
* **https://alp1x.github.io/um-idcard-maker/**

### How can I add an identity card with metadata? (for server)
```lua 
exports['um-idcard']:CreateMetaLicense(source, string or table)

exports['um-idcard']:CreateMetaLicense(source, 'id_card')
exports['um-idcard']:CreateMetaLicense(source, {'id_card','driver_license','weaponlicense','lawyerpass'})
```

### Requirements
* **[ox_lib](https://github.com/overextended/ox_lib/releases)**
* **[MugShotBase64](https://github.com/BaziForYou/MugShotBase64)**

## QBCore Starter Setup
#### qb-inventory or lj-inventory delete this
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2439
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2462

#### qb-inventory or lj-inventory remove the info. and just add these
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2366
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2373
```lua 
#2366 exports['um-idcard']:CreateMetaLicense(source, 'id_card')
#2373 exports['um-idcard']:CreateMetaLicense(source, 'driver_license')
```

#### qb-multicharacter replace this
* https://github.com/qbcore-framework/qb-multicharacter/blob/main/server/main.lua#L120
* https://github.com/qbcore-framework/qb-multicharacter/blob/main/server/main.lua#L126
```lua 
exports['um-idcard']:CreateMetaLicense(src, {'id_card','driver_license'})
```

#### qb-cityhall replace this

## ESX Starter Setup

## License
[GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)

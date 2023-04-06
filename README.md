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
* First, import the SQL file that is compatible with your framework.
* If you don't have them, download the requirements
* Make sure you have the items in **Config.Licenses**, otherwise add them.
* After ox_lib and MugShotBase64 ```ensure um-idcard or [um] folder```
#### qb-inventory or lj-inventory delete this
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2439
* https://github.com/qbcore-framework/qb-inventory/blob/main/server/main.lua#L2462

### Usage
* Just use the item
* If there is someone near you, it will be visible to them, otherwise only you will see it.
* It takes a mugshot of you on the first use of the item and saves it in SQL, and then it continuously retrieves it from the cache instead of SQL.


### Custom Card Maker
* **https://alp1x.github.io/um-idcard-maker/**
### Requirements
* **[ox_lib](https://github.com/overextended/ox_lib/releases)**
* **[MugShotBase64](https://github.com/BaziForYou/MugShotBase64)**

### Todo
* Card animations
* Police badge and other badges
* Get licenses driver,weapon etc
* [Some fixes](https://github.com/alp1x/um-idcard/blob/main/client/main.lua#L44)

## License
[GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)

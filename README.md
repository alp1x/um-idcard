<img src="https://r2.fivemanage.com/xAGbYdcTtNkthvTNfzai9/um-idcard.png">

# um-idcard
<sup><b>qb-idcard</b> has been updated and renamed as <b>um-idcard</b>, and it is now compatible with <b>Qbox</b> and </b><b>ESX</b> and <b>QBCore</b></sup> 

### Setup
* Make sure you have the items in **Config.Licenses**, otherwise add them. *(id_card/driver_license etc)*
* `ensure um-idcard`

### Upload Mugshots
There are two ways to do this: the first is **local**, i.e., **web/assets/mugshot**; the second is via the **[Fivemanage](https://fivemanage.com/)** path.
1. **Local (default)**
* No extra configuration is required; the user's mugshot is saved as a .png file in web/assets/mugshot, 
but you won't see it immediately. The script needs to be restarted because a new file is being added.

2. **Fivemanage (recommended / free 30GB bandwidth)**
* open config.lua and mugshotsUpload value replace to **fivemanage**
```lua
 mugshotsUpload = 'fivemanage'
```
* Log in to **[Fivemanage](https://app.fivemanage.com/login)**
* Create a token from the Dashboard
* and add it into server.cfg **``set fivemanage:key "YOUR_TOKEN"``**

### Compatibility (cityhall/giveitem etc.)
* You don't need to do anything for this, **just use the item.**

### Usage
* Just use the item
* If there is someone near you, it will be visible to them, otherwise only you will see it.
* It takes a mugshot of you on the first use of the item and saves it in metadata.

### How to create a custom identity card?
* **[um-idcard-maker](https://alp1x.github.io/um-idcard-maker/)**

### Optional
* **[um-idcard-menu](https://github.com/alp1x/um-idcard-menu)**

### Alternatives
* **[bl_idcard](https://github.com/Byte-Labs-Studio/bl_idcard)**
* **[five-idcard](https://github.com/cinquina/five-idcard)**

## Contributors 
<a href="https://github.com/alp1x/um-idcard/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=alp1x/um-idcard" />
</a>

## License
[GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)

## Star History
[![Star History Chart](https://api.star-history.com/svg?repos=alp1x/um-idcard&type=Date)](https://star-history.com/#alp1x/um-idcard&Date)

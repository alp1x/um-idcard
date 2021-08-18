# Important Replace to Fingerprint
**qb-inventory > app.js > replace line 321**
```javascript
$(".item-info-description").html('<p><strong>CSN: </strong><span>' + itemData.info.citizenid + '</span></p><p><strong>First Name: </strong><span>' + itemData.info.firstname + '</span></p><p><strong>Last Name: </strong><span>' + itemData.info.lastname + '</span></p><p><strong>Birth Date: </strong><span>' + itemData.info.birthdate + '</span></p><p><strong>Gender: </strong><span>' + gender + '</span></p><p><strong>Nationality: </strong><span>' + itemData.info.nationality + '</span></p>' + '</span></p><p><strong>Fingerprint: </strong><span>' + itemData.info.fingerprint + '</span></p>');
```
**qb-multicharacter > server > main.lua > add line 54**
```
info.fingerprint = Player.PlayerData.metadata["fingerprint"]
```

## Dependencies
* [qb-core](https://github.com/qbcore-framework/qb-core)

## Features
+ simple id card
+ use item and exit with backspace
+ thanks for the design, Buzzee

![Image](https://i.hizliresim.com/cbm8p7a.png)
![Image](https://i.hizliresim.com/s0n20b6.png)



# you can use this instead of loop
    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://qb-idcard/escape', JSON.stringify({}));
        }
    }


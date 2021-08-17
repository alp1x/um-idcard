# qb-idcard
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


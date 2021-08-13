# qb-idcard
###### Dependencies
[qb-core](https://github.com/qbcore-framework/qb-core)

+ simple id card
+ use item and exit with backspace
+ thanks for the design, Buzzee

![Image](https://i.hizliresim.com/i3ou4d3.png)
![Image](https://i.hizliresim.com/ey48nby.png)
![Image](https://i.hizliresim.com/6xgo0v0.png)


# you can use this instead of loop
    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://qb-idcard/escape', JSON.stringify({}));
        }
    }


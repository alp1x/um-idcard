# qb-idcard
###### Dependencies
[qb-core](https://github.com/qbcore-framework/qb-core)

+ simple id card
+ use item and exit with backspace

![Image](https://i.hizliresim.com/g7hgc3j.png)
![Image](https://i.hizliresim.com/gasbean.png)


# you can use this instead of loop
    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://qb-idcard/escape', JSON.stringify({}));
        }
    }


# کانفیگ کردن vim

### زمانی که در محیط vim قرار داریم برای کپی کردن بخشی از متن به طوری که بتونیم متن کپی شده رو توی محیط دیگه این هم paste کنیم با yankyank این مشگل ما حل نمیشه و برای این کار ما دو راه داریم راه اول بیایم زماین که ماوس رو میخوایم بکشیم روی متن دکمه shift رو هم نگه داریم و راه دوم اینه که قطعه کد پایین رو توی vimrc. قرار بدیم

```
set mouse=v
```

## برای کانفیگ کردن اول از همه باید اخرین ورژن از node.js رو نصب کنید به همراه vim-plug بعد میرین توی مسیر home سیستم خودتون توی للینوکس و یک فایل به اسم .vimrc میسازین و بعد محتوای فایل vimrc رو داخل اون کپی کنید و در اخر دستور  PlugInstall رو اجرا کنیدو منتظر بمانید که تنظیمات به صورت کامل نصب بشن برای 

#### اول از همه باید نیازمندی های زیر رو داخل سیستم خودتون داشته باشین با اخرین ورژن خودشون 

vim > 8 

node > 10 && npm

git

#### بعد باید با دستور پایین vim-plug رو نصب کنید برای لینوکس دستور پایین رو باید بزنید
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### بعد از این کار الان vimrc رو ببرین به مسیر home سیستم به و vimrc. تغییر نام بدید
```
cd ~
mv vimrc .vimrc
```
#### تنظیمات vim شما داخل .vimrc قرار داره

#### الان توی ترمینال vim رو باز کنید و دستور های پایین رو بزنید وقتی vim رو باز کردید با زدن ; + shift میرین توی مود command و بعد به ترتیب دو دستور PlugInstall: و CocInstall: رو بزنید ولی به احتمال زیاد دستور دوم برای شما خود به خود اجرا بشه اگر شد کاری بهش نداشته باشید تا نصب هارو انجام بده
```
vim 
:PlugInstall
:CocInstall
```

### برای نصب کردن plugin برای خود vim میتونین از لینک پایین استافده کنید و پلاگین خودتون رو سرچ کنید

[vimawesome](https://vimawesome.com/)

#### برای نصب کردن پلاگین برای coc هم از لینک پایین استفاده کنید با coc میتونی extension برای محیط خودتون نصب کنید مثلا برای php یا laravel یا go یا rust یا هر زبان دیگه ای که میخواین کار کنین مثلا برای نصب کردن prettier میتونین کامند زییر توی مود کامند اجرا کنید که برای شما نصب کنه 
```
:CocInstall coc-prettier
```

[list extension for coc](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions)


### اگر میخواین که از کانفیگ من استفاده کنید محتویات فایل CocConfig.txt رو کپی کنید و بعد توی vim برین تو تنظیمات coc با اجرا دستور CocConfig: و اونجا قرار بدید


### برای اپدیت کردن همه پلاگین ها PlugUpdate: و برای اپدیت کردن همه extension ها CocUpdate: رو بزنید 


#### اگر میخواین پلاگین رو پاک کنید اول توی vimrc. اون پلاگین رو پاک کنید بعد دستور % source: رو اجرا کنید بعد دستور PlugClean: و بعد y و enter کنید تا پاک شه برای پاک کردن extension هم کافیه دستور CocUninstall: و اون extension خاص رو اجرا کنید 

### در اخر هم برای این که ایکون ها برای شما اعمال بشن شما فایلی که داخل پوشه icons هست رو کپی کنید توی مسیر پایین
```
cp -r icons/icons ~/.fonts
```

### References
[blog](https://marioyepes.com/vim-setup-for-modern-web-development/)

[vim-plug](https://github.com/junegunn/vim-plug)

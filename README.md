# deployAnything

Find this line in your <code>init.sqf</code>:
```sqf
call compile preprocessFileLineNumbers "scripts\traders\server_traders.sqf";
```

Place these two lines before it:
```sqf
call compile preprocessFileLineNumbers "scripts\clickActions\init.sqf";
call compile preprocessFileLineNumbers "scripts\deployAnything\init.sqf";
```

Temp install instructions:
Download this file: https://github.com/oiad/modPack/blob/master/DayZ_Epoch_11.Chernarus/dayz_code/compile/ui_selectSlot.sqf
Put it in your dayz_code\compile folder.
In your dayz_code\init\compiles.sqf find this line:
```sqf

fnc_usec_selfactions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
```
Add this line after it:
```sqf
player_selectSlot = compile preprocessFileLineNumbers "dayz_code\compile\ui_selectSlot.sqf";
```
MORE TO COME

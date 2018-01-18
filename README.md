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

MORE TO COME.
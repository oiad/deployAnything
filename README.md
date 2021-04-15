# deployAnything for Epoch 1.0.7

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

# Index:

* [Mission folder install](https://github.com/oiad/deployAnything#mission-folder-install)
* [BattlEye filter install](https://github.com/oiad/deployAnything#battleye-filter-install)
* [Old Releases](https://github.com/oiad/deployAnything#old-releases)

# Install:

* If you have not installed the Click Actions visit this  
https://github.com/AirwavesMan/epoch-right-click-actions


# Mission folder install

	Find this line in your <code>init.sqf</code>:

	Place this line at the very bottom of the init.sqf:

	```sqf
	call compile preprocessFileLineNumbers "scripts\deployAnything\init.sqf";
	```
	
# BattlEye filter install:

**Battleye scripts.txt:**

1. In your config\<yourServerName>\Battleye\scripts.txt around line 2: <code>5 addAction</code> add this to the end of it:

	```sqf
	!="hIndex call getActionId) < 0) then {\n[_forEachIndex,player addaction[\"<t color='#33b5e5'>\" + format[\"Pack %1\",(_forEachIndex cal"
	```

	So it will then look like this for example:

	```sqf
	5 addAction !="hIndex call getActionId) < 0) then {\n[_forEachIndex,player addaction[\"<t color='#33b5e5'>\" + format[\"Pack %1\",(_forEachIndex cal"
	```

2. In your config\<yourServerName>\Battleye\scripts.txt around line 22: <code>1 compile</code> add this to the end of it:

	```sqf
	!"call compile preprocessFileLineNumbers \"scripts\\deployAnything\\config.sqf"
	```

	So it will then look like this for example:

	```sqf
	1 compile <CUT> !"call compile preprocessFileLineNumbers \"scripts\\deployAnything\\config.sqf"
	```
	
3. In your config\<yourServerName>\Battleye\scripts.txt around line 40: <code>1 execVM</code> add this to the end of it:

	```sqf
	!"execVM 'scripts\\deployAnything\\deploy.sqf';"
	```

	So it will then look like this for example:

	```sqf
	1 execVM <CUT> !"execVM 'scripts\\deployAnything\\deploy.sqf';"
	```	
	
4. In your config\<yourServerName>\Battleye\scripts.txt around line 22: <code>1 compile</code> add this to the end of it:

	```sqf
	!="turn = \"CfgMagazines\";\n};\n_return\n};\n\n\ngetActionId = {\ncall compile format[\"\n    if (isNil 'DZE_ACTION_DEPLOYABLE_PACK_%1') then"
	```

	So it will then look like this for example:

	```sqf
	1 compile <CUT> !="turn = \"CfgMagazines\";\n};\n_return\n};\n\n\ngetActionId = {\ncall compile format[\"\n    if (isNil 'DZE_ACTION_DEPLOYABLE_PACK_%1') then"
	```
	
5. In your config\<yourServerName>\Battleye\scripts.txt around line 2: <code>1 compile</code> add this to the end of it:

	```sqf
	!="oopDone = true;\n_isAnimationCompleted = true;\n};\n{\nif (call compile (_x select 0)) exitWith {\n_exitWith = _x select 1;\n};\n} forE"
	```

	So it will then look like this for example:

	```sqf
	1 compile !="oopDone = true;\n_isAnimationCompleted = true;\n};\n{\nif (call compile (_x select 0)) exitWith {\n_exitWith = _x select 1;\n};\n} forE"
	```

6. In your config\<yourServerName>\Battleye\scripts.txt around line 47: <code>5 hint</code> add this to the end of it:

	```sqf
	!="(_exitWith != \"nil\" && {_exitWith != \"admin\"}) exitWith {\ntaskHint [_exitWith, DZE_COLOR_DANGER, \"taskFailed\"];\n};\n\nDZE_DEPLOYIN"
	```

	So it will then look like this for example:

	```sqf
	5 hint <CUT> !="(_exitWith != \"nil\" && {_exitWith != \"admin\"}) exitWith {\ntaskHint [_exitWith, DZE_COLOR_DANGER, \"taskFailed\"];\n};\n\nDZE_DEPLOYIN"
	```	
	
7. In your config\<yourServerName>\Battleye\scripts.txt around line 11: <code>5 attachTo</code> add this to the end of it:

	```sqf
	!="OCKED\";\n_object setVariable[\"ObjectUID\",\"1\",true];\n\n_object attachTo [player,_offset];\n_object setDir _dir;\n_position = getPosAT"
	```

	So it will then look like this for example:

	```sqf
	5 attachTo <CUT> !="OCKED\";\n_object setVariable[\"ObjectUID\",\"1\",true];\n\n_object attachTo [player,_offset];\n_object setDir _dir;\n_position = getPosAT"
	```

8. In your config\<yourServerName>\Battleye\scripts.txt around line 18: <code>5 clearMagazineCargo</code> add this to the end of it:

	```sqf
	!="etClearCargo) then {\nclearWeaponCargoGlobal _tmpbuilt;\nclearMagazineCargoGlobal _tmpbuilt;\n};\nif (_index call getDeployableClear"
	```

	So it will then look like this for example:

	```sqf
	5 clearMagazineCargo !="etClearCargo) then {\nclearWeaponCargoGlobal _tmpbuilt;\nclearMagazineCargoGlobal _tmpbuilt;\n};\nif (_index call getDeployableClear"
	```

9. In your config\<yourServerName>\Battleye\scripts.txt around line 19: <code>5 clearWeaponCargo</code> add this to the end of it:

	```sqf
	!="_obj_Publish\";\n};\nif (_index call getClearCargo) then {\nclearWeaponCargoGlobal _tmpbuilt;\nclearMagazineCargoGlobal _tmpbuilt;\n};"
	```

	So it will then look like this for example:

	```sqf
	5 clearWeaponCargo <CUT> !="_obj_Publish\";\n};\nif (_index call getClearCargo) then {\nclearWeaponCargoGlobal _tmpbuilt;\nclearMagazineCargoGlobal _tmpbuilt;\n};"
	```
	
10. In your config\<yourServerName>\Battleye\scripts.txt around line 54: <code>1 nearestObject</code> add this to the end of it:

	```sqf
	!="};\n};\ncase \"workshop\": {\n_distance = 3;\n_isNear = count (nearestObjects [player, [\"Wooden_shed_DZ\",\"WoodShack_DZ\",\"WorkBench_DZ\""
	```

	So it will then look like this for example:

	```sqf
	1 nearestObject <CUT> !="};\n};\ncase \"workshop\": {\n_distance = 3;\n_isNear = count (nearestObjects [player, [\"Wooden_shed_DZ\",\"WoodShack_DZ\",\"WorkBench_DZ\""
	```	
	
11. In your config\<yourServerName>\Battleye\scripts.txt around line 55: <code>1 nearObjects</code> add this to the end of it:

	```sqf
	!="ance = 3;\n_isNear = {inflamed _x} count (getPosATL player nearObjects _distance);\nif (_isNear == 0) then {\n_abort = true;\n_reaso"
	```

	So it will then look like this for example:

	```sqf
	1 nearObjects <CUT> !="ance = 3;\n_isNear = {inflamed _x} count (getPosATL player nearObjects _distance);\nif (_isNear == 0) then {\n_abort = true;\n_reaso"
	```
	
12. In your config\<yourServerName>\Battleye\scripts.txt around line 80: <code>5 setVehicle</code> add this to the end of it:

	```sqf
	!="cle [_classname, _location, [], 0, \"CAN_COLLIDE\"];\n_object setVehicleLock \"LOCKED\";\n_object setVariable[\"ObjectUID\",\"1\",true];\n\n"
	```

	So it will then look like this for example:

	```sqf
	5 setVehicle !="cle [_classname, _location, [], 0, \"CAN_COLLIDE\"];\n_object setVehicleLock \"LOCKED\";\n_object setVariable[\"ObjectUID\",\"1\",true];\n\n"
	```

13. In your config\<yourServerName>\Battleye\scripts.txt around line 84: <code>1 systemChat</code> add this to the end of it:

	```sqf
	!=";\n\nif (_havePad) exitWith {\ndayz_actionInProgress = false;\nsystemChat \"You already have a heli pad!\";\n};\n\n_missing = \"\";\n_hasreq"
	```

	So it will then look like this for example:

	```sqf
	1 systemChat <CUT> !=";\n\nif (_havePad) exitWith {\ndayz_actionInProgress = false;\nsystemChat \"You already have a heli pad!\";\n};\n\n_missing = \"\";\n_hasreq"
	```
	
14. In your config\<yourServerName>\Battleye\scripts.txt around line 4: <code>5 addMagazine</code> add this to the end of it:

	```sqf
	!="sClass(configFile >> \"CfgMagazines\" >> _x)) then {\nplayer addMagazine _x;\n};\n} forEach (_deployable call getDeployableParts);\n\ni"
	```

	So it will then look like this for example:

	```sqf
	5 addMagazine <CUT> !="sClass(configFile >> \"CfgMagazines\" >> _x)) then {\nplayer addMagazine _x;\n};\n} forEach (_deployable call getDeployableParts);\n\ni"
	```	
	
15. In your config\<yourServerName>\Battleye\scripts.txt around line 5: <code>5 addWeapon</code> add this to the end of it:

	```sqf
	!=" (isClass(configFile >> \"CfgWeapons\" >> _x)) then {\nplayer addWeapon _x;\n};\nif (isClass(configFile >> \"CfgMagazines\" >> _x)) the"
	```

	So it will then look like this for example:

	```sqf
	5 addWeapon <CUT> !=" (isClass(configFile >> \"CfgWeapons\" >> _x)) then {\nplayer addWeapon _x;\n};\nif (isClass(configFile >> \"CfgMagazines\" >> _x)) the"
	```
	
16. In your config\<yourServerName>\Battleye\scripts.txt around line 47: <code>5 hint</code> add this to the end of it:

	```sqf
	!="(_exitWith != \"nil\" && {_exitWith != \"admin\"}) exitWith {\ntaskHint [_exitWith, DZE_COLOR_DANGER, \"taskFailed\"];\n};\n\n_cursorTarge"
	```

	So it will then look like this for example:

	```sqf
	5 hint <CUT> !="(_exitWith != \"nil\" && {_exitWith != \"admin\"}) exitWith {\ntaskHint [_exitWith, DZE_COLOR_DANGER, \"taskFailed\"];\n};\n\n_cursorTarge"
	```
	
**Battleye createvehicle.txt:**

1. In your config\<yourServerName>\Battleye\createvehicle.txt around line 2 find: <code>5 !(^DZ_|^z_|^pz_|^WeaponHolder|Box|dog|PZombie_VB|^Smoke|^Chem|^._40mm|_DZ$|^Trap)</code> add this to the end of the line:

	```sqf
	!=MMT_Civ
	```

	So it will then look like this for example:

	```sqf
	5 !(^DZ_|^z_|^pz_|^WeaponHolder|Box|dog|PZombie_VB|^Smoke|^Chem|^._40mm|_DZ$|^Trap) <CUT> !=MMT_Civ	
	```
	
	You have to add every vehicle or buildable you want to build with Deploy Anything.
	
	
# Old Releases:	

**** *Epoch 1.0.6.2* ****
**[>> Download <<](https://github.com/oiad/deployAnything/archive/refs/tags/Epoch_1.0.6.2.zip)**




private["_isPackingLocked","_lastPackTime","_exitWith","_deployable","_cursorTarget","_deployableName"];

_exitWith = "nil";
_deployable = (_this select 3) select 0;
_cursorTarget = (_this select 3) select 1;
_lastPackTime = _cursorTarget getVariable["lastPackTime",diag_tickTime - 11];
_isPackingLocked = diag_tickTime - _lastPackTime < 10;
_deployableName = _deployable call getDeployableDisplay;

{
	if (_x select 0) exitWith {_exitWith = (_x select 1);};
} forEach [
	[(dayz_playerUID in DZE_DEPLOYABLE_ADMINS),"admin"],
	[!(call fnc_can_do),format[localize "STR_CL_DA_PACK_FAIL", _deployableName]],
	[(player getVariable["inCombat",false]),format[localize "STR_CL_DA_PACK_COMBAT", _deployableName]],
	[(damage cursorTarget > (_deployable call getDamageLimit)),format[localize "STR_CL_DA_PACK_DAMAGE", _deployableName,(_deployable call getDamageLimit) * 100]],      
	[_isPackingLocked,format[localize "STR_CL_DA_PACK_INUSE", _deployableName]],
	[DZE_PACKING, (localize "STR_CL_DA_FAIL_PACKING")],
	[DZE_DEPLOYING, (localize "STR_CL_DA_FAIL_BUILDING")]
];

if (_exitWith != "nil" && {_exitWith != "admin"}) exitWith {
	taskHint [_exitWith, DZE_COLOR_DANGER, "taskFailed"];
};

_cursorTarget setVariable["lastPackTime",diag_tickTime,true];
DZE_PACKING = true;

_exitWith = [
	["dayz_playerUID in DZE_DEPLOYABLE_ADMINS","admin"],
	["r_interrupt",format[localize "STR_CL_DA_PACK_INTERRUPTED",_deployableName]],
	["(player getVariable['inCombat',false])",format[localize "STR_CL_DA_PACK_COMBAT",_deployableName]]
] call fnc_bike_crafting_animation;

if (_exitWith != "nil" && {_exitWith != "admin"}) exitWith {
	DZE_PACKING = false;
	taskHint [_exitWith, DZE_COLOR_DANGER, "taskFailed"];
};

{
	if (isClass(configFile >> "CfgWeapons" >> _x)) then {
		player addWeapon _x;
	};
	if (isClass(configFile >> "CfgMagazines" >> _x)) then {
		player addMagazine _x;
	};
} forEach (_deployable call getDeployableParts);

if (_deployable call getPermanent) then {
	PVDZ_obj_Destroy = [_cursorTarget getVariable["ObjectID","0"],_cursorTarget getVariable["ObjectUID","0"],player,_cursorTarget,dayz_authKey];
	publicVariableServer "PVDZ_obj_Destroy";
} else {
	deleteVehicle _cursorTarget;
};

player removeAction (_deployable call getActionId);
[_deployable,-1] call setActionId;
DZE_PACKING = false;

taskHint [format[localize "STR_CL_DA_PACKED",_deployableName,(_deployable call getDeployableKitDisplay)], DZE_COLOR_PRIMARY, "taskDone"];

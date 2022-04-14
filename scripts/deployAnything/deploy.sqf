private["_exitWith","_position","_display","_object","_handle","_deployableName"];

_exitWith = "nil";

disableSerialization;
_display = findDisplay 106;

if (!(isNull _display)) then {
	_display closeDisplay 0;
};

_deployableName = _this call getDeployableDisplay;

{
	if (_x select 0) exitWith {_exitWith = (_x select 1);};
} forEach [
	[!([player,_this] call getHasDeployableParts),format[localize "STR_CL_DA_FAIL_NEED", str (_this call getDeployableParts), _deployableName]],
	[!(call fnc_can_do),format[localize "STR_CL_DA_PACK_FAIL", _deployableName]],
	[(player getVariable["inCombat",false]), format[localize "STR_CL_DA_PACK_COMBAT", (_this call getDeployableDisplay)]],
	[DZE_DEPLOYING, (localize "STR_CL_DA_FAIL_BUILDING")],
	[DZE_PACKING, (localize "STR_CL_DA_FAIL_PACKING")]
];

if (_exitWith != "nil" && {_exitWith != "admin"}) exitWith {
	taskHint [_exitWith, DZE_COLOR_DANGER, "taskFailed"];
};

DZE_DEPLOYING = true;
DZE_DEPLOYING_SUCCESSFUL = false;
_handle = (_this call getDeployableClass) spawn player_deploy;
waitUntil {scriptDone _handle;};

DZE_DEPLOYING = false;
if (!DZE_DEPLOYING_SUCCESSFUL) then {
	taskHint [localize "STR_CL_DA_FAIL_DEPLOYING", DZE_COLOR_DANGER, "taskFailed"];
} else {
	taskHint [format[localize "STR_CL_DA_DEPLOY_OK", _deployableName], DZE_COLOR_PRIMARY, "taskDone"];

	uiSleep 10;
	if (!(_this call getPermanent)) then {
		(localize "STR_CL_DA_DEPLOY_PERM_NO") call dayz_rollingMessages;
	} else {
		(localize "STR_CL_DA_DEPLOY_PERM_OK") call dayz_rollingMessages;
	};
};

call compile preprocessFileLineNumbers "scripts\deployAnything\config.sqf";
call compile preprocessFileLineNumbers "scripts\deployAnything\wrapper.sqf";
call compile preprocessFileLineNumbers "scripts\deployAnything\functions.sqf";

local _DZE_DEPLOYABLE_VERSION = "4.0.0";

diag_log format["Deploy Anything: Loading version %1 for Epoch 1.0.7.1",_DZE_DEPLOYABLE_VERSION];

player_deploy = compile preprocessFileLineNumbers "scripts\deployAnything\player_deploy.sqf";

DZE_DEPLOYABLES = [];
{
	private["_class","_distance","_deployables","_packDist","_packOthers","_clearCargo","_clearAmmo","_permanent","_damage","_needNear","_parts","_requirePlot","_enableSim","_road","_condition"];
	_class       = _x select 0;
	_distance    = _x select 1;
	_packDist    = _x select 2;
	_damage      = _x select 3;
	_packOthers  = _x select 4;
	_clearCargo  = _x select 5;
	_clearAmmo   = _x select 6;
	_permanent   = _x select 7;
	_requirePlot = _x select 8;
	_enableSim   = _x select 9;
	_road        = _x select 10;
	_deployables = _x select 11;
	_needNear    = _x select 12;
	_parts       = _x select 13;
	_condition   = _x select 14;
	{
		DZE_DEPLOYABLES set [count DZE_DEPLOYABLES,[_class,_distance,_packDist,_damage,_packOthers,_clearCargo,_clearAmmo,_permanent,_requirePlot,_enableSim,_road,_x,_needNear,_parts,_condition]];
	} forEach _deployables;
} forEach DZE_DEPLOYABLES_CONFIG;

if (isServer) exitWith {
	diag_log "Deploy Anything: Adding deployables to safe vehicle list...";
	{
		local _classname = _forEachIndex call getDeployableClass;
		DZE_safeVehicle = DZE_safeVehicle + [_classname];
		if (_forEachIndex call getPermanent && (!(_classname isKindof "AllVehicles") || (_classname isKindOf "StaticWeapon"))) then {
			DayZ_SafeObjects set [count DayZ_SafeObjects,_classname];
		};
	} forEach DZE_DEPLOYABLES;
};

[] spawn {
	if (!isDedicated && {isNil "DZE_CLICK_ACTIONS"}) exitWith {
		diag_log "Deploy Anything: ERROR -- Click Actions Handler missing!";
	};

	{
		DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [[(_forEachIndex call getDeployableKitClass),format[localize "STR_CL_DA_DEPLOY",(_forEachIndex call getDeployableDisplay)],format["%1 execVM 'scripts\deployAnything\deploy.sqf';",_forEachIndex],(_forEachIndex call getDeployableCondition)]];
	} forEach DZE_DEPLOYABLES;
	DZE_DEPLOYING = false;
	DZE_PACKING = false;

	DZE_COLOR_PRIMARY = [(51/255),(181/255),(229/255),1];
	DZE_COLOR_SUCCESS = [(153/255),(204/255),0,1];
	DZE_COLOR_DANGER = [1,(68/255),(68/255),1];

	diag_log "Deploy Anything: Waiting for player to login...";
	
	waitUntil{!isNil "Dayz_loginCompleted"};
	
	diag_log "Deploy Anything: Player logged in and is playing. Starting pack loop...";

	while {true} do {
		if (!isNull player) then {				
			{
				local _cursorTarget = cursorTarget;
	
				if (!isNull _cursorTarget) then {
					local _hasAccess = [];
					local _isPermanent = _forEachIndex call getPermanent;
					
					if (_isPermanent) then {
						_hasAccess = [player, _cursorTarget] call FNC_check_access;	
					};					
				
					if ((_forEachIndex call getDeployablePackAny) && 
						{typeOf _cursorTarget == (_forEachIndex call getDeployableClass)} && 
						{call fnc_can_do} &&
						{(player distance _cursorTarget) < (_forEachIndex call getDeployablePackDistance)} &&						
						{_forEachIndex call getDeployablePackOthers ||
						(!_isPermanent && {(_cursorTarget call fnc_get_temp_deployable_id) == call fnc_temp_deployable_id}) ||				
						(_isPermanent && {(_hasAccess select 0) || (_hasAccess select 2) || (_hasAccess select 3)})}) then {
						
						if ((_forEachIndex call getActionId) < 0) then {
							[_forEachIndex,player addaction["<t color='#33b5e5'>" + format[localize "STR_CL_DA_PACK",(_forEachIndex call getDeployableDisplay)] + "</t>","scripts\deployAnything\pack.sqf",[_forEachIndex,_cursorTarget],0,false,true]] call setActionId;
						};
					} else {
						player removeAction (_forEachIndex call getActionId);
						[_forEachIndex,-1] call setActionId;
					};
				};
			} forEach DZE_DEPLOYABLES;
		};
		uiSleep 1;
	};
};

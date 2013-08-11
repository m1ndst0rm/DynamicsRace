private ["_dialog","_teamList","_selectedTeamIndex","_teamId","_spotlist","_selectedRoleIndex","_spotType"];
disableSerialization;
_dialog = findDisplay 4010;

_teamList = _dialog displayCtrl 4011;
_selectedTeamIndex = Lbselection _teamList select 0;
if(isNil {_selectedTeamIndex}) then {_selectedTeamIndex = 0;};
_teamId = lbData[4011,_selectedTeamIndex];

_spotlist = _dialog displayCtrl 4013;
_selectedRoleIndex = Lbselection _spotlist select 0;
if(isNil {_selectedRoleIndex}) then {_selectedRoleIndex = 0;};
_spotType = lbData[4013,_selectedRoleIndex];

[[player, parseNumber _teamId, _spotType],"DYN_fnc_ProcessTeamSpotChoose", false] call BIS_fnc_MP;
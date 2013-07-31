/* DYN_RACE_CreateExplosion: Call to trigger one or more explosions on the map
* Function creates one or more explosions on the map but takes multiple triggers into account (prevents multiple trigger hits from creating multiple explosions so 10 players don't trigger 10 explosions and create frame drops).
*
* Example: ["marker_1"] call DYN_RACE_CreateExplosion;
* Example: ["marker_1", "marker_2", ...] call DYN_RACE_CreateExplosion;
* params:
* string : _markername
*/
if (!isServer) exitWith {};
"DYN_RACE_Explosion" call DYN_RACE_Debug;

_markers = [];
_i= 0; for "_i" from 0 to (count _this - 1) do
{
	_markers set [count _markers, (_this select _i)];
};
//	"Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10" "Bo_Mk82","Bo_GBU12_LGB"]
_ammo = ["HelicopterExploBig","HelicopterExploBig","HelicopterExploBig"]; //M_Mo_82mm_AT_LG,"Sh_120_HE""Sh_120_HE"

_count = 0;

_explosions_to_create = [];

{
	_explosion_marker_name = _x;
	if !(_explosion_marker_name in DYN_RACE_EXPLOSIONS) then
	{
		DYN_RACE_EXPLOSIONS set [count DYN_RACE_EXPLOSIONS, _explosion_marker_name];
		_explosions_to_create set [count _explosions_to_create, _explosion_marker_name];
	};
} forEach _markers; 

for "_i" from 0 to (count _ammo - 1) do
{
	{
		_explosion_marker_name = _x;
		
		for "_j" from 0 to 1 do {
			switch (_j) do
			{ 
				case 0: {if (random 1 == 1) then {_xVel = -1*_xVel }};
				case 1: {if (random 1 == 1) then {_yVel = -1*_yVel }};
			}; 
		}; 
		_chosen = (_ammo select _i);
		_xVel = random 10;
		_yVel = random 10;
		_zVel = random 20;
		_xCoord = random 15;
		_yCoord = random 15;
		_zCoord = random 5;
		_bomb = _chosen createVehicle getMarkerPos _explosion_marker_name;
		_bomb setPos [(getPos _bomb select 0)+_xCoord,(getPos _bomb select 1)+_yCoord, _zCoord*_i];
		_bomb setVelocity [_xVel,_yVel,_zVel-50];
	} forEach _explosions_to_create;
	sleep 1;
};


//Wait for all explosion to be done and then remove them;
sleep 15;
DYN_RACE_EXPLOSIONS = DYN_RACE_EXPLOSIONS - _explosions_to_create;
/* DYN_RACE_FindLocalPlayer: Get local player by net_id.
* 
* Params:
* _player_net_id: netId of the player.
*
* Returns:
* player: returns a local player object
*/
DYN_RACE_FindLocalPlayer =
{
	_player_net_id = _this select 0;
	_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
	_player = objNull;
	{
		_unit = _x;
		_unit_id = [_unit] call DYN_RACE_GetObjectID ;
		
		if(_unit_id == _player_net_id) then
		{
			//diag_log format["Found:%1--%2", _player_net_id, _unit_id];
			_player = _unit;
		};
		
	}forEach _units;
	
	_player;
};
/* DYN_fnc_GetRacerFinishedTime: Returns finish time of a player
*
* Params
* DYN_RACER: _racer or player
* 
* Returns:
* int _finish_time: Finish time in seconds
*/
private ["_player","_finish_time","_racer","_laptimes"];
_finish_time = -1;
_racer = _this select 0;
_player = _racer;
if(typeName _racer == "ARRAY") then
{
	_player = _racer select 1;
};

_laptimes = _player getVariable ["lapTimes", []];
if(count _laptimes == DYN_RACE_LAPS) then
{
	diag_log _laptimes;
	_finish_time = _laptimes select (DYN_RACE_LAPS - 1);
};

_finish_time;
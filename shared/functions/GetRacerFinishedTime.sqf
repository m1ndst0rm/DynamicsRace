/* DYN_RACE_GetRacerFinishedTime: Returns finish time of a player
*
* Params
* DYN_RACER: _player
* 
* Returns:
* int _finish_time: Finish time in seconds
*/
DYN_RACE_GetRacerFinishedTime = 
{
	_finish_time = -1;
	_racer = _this select 0;
	_laptimes = _racer select 6;
	if(count _laptimes == DYN_RACE_LAPS) then
	{
		_finish_time = _laptimes select (DYN_RACE_LAPS - 1);
	};
	
	_finish_time;
};
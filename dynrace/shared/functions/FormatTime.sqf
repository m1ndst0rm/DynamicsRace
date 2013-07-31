/* DYN_RACE_FormatTime: Format time to human readable format
*
* Params:
* _time: time in seconds
*
* Returns:
* string _formatted_time: String in mm:ss format.
*/
_time = _this select 0;
_finish_time_minutes = floor(_time / 60);
_finish_time_seconds = floor(_time) - (60 * _finish_time_minutes);
if(_finish_time_seconds < 10) then
{
	_finish_time_seconds = format ["0%1", _finish_time_seconds];
};
_formatted_time = format ["%1:%2", _finish_time_minutes, _finish_time_seconds];
_formatted_time;
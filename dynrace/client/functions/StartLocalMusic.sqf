/* DYN_fnc_StartLocalMusic: Starts a local song (so a trigger can start a sound/sound without all the clients hearing it)
*
* Example: [thislist, "music_name"] call DYN_fnc_StartLocalMusic;
* Example 2: [[player]], "music_name"] call DYN_fnc_StartLocalMusic;
*/
private ["_playerList","_musicName","_object","_player"];
"DYN_fnc_StartLocalMusic" call BIS_fnc_log;
_playerList = _this select 0;
{
	//_x setcaptive true;
} forEach _playerList;

_musicName = _this select 1;
{
	_object = _x;
	_player = driver _object;
	if(_player == player) then
	{
		playMusic _musicName;
	};
} forEach _playerList;

_playerList spawn 
{
	sleep 5;
	{
		//_x setcaptive false;
	} forEach _this;
};
/* DYN_RACE_StartLocalMusic: Starts a local song (so a trigger can start a sound/sound without all the clients hearing it)
*
* Example: [thislist, "music_name"] call DYN_RACE_StartLocalMusic;
* Example 2: [[player]], "music_name"] call DYN_RACE_StartLocalMusic;
*/
"DYN_RACE_StartLocalMusic" call DYN_RACE_Debug;
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
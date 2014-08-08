/*
	Author: M1nd0

	Description:
	Local script used to make a player finish, stop his vehicle and enable spectator mode.

	Parameter(s):
	_this: List of players (array)
	Returns:
*/
private ["_vehicle","_speed","_diff","_vel","_dir"];
_players = _this select 0;
_intensity = _this select 1;
if(player in _players) then
{
	addCamShake [_intensity,1,8]; 
};
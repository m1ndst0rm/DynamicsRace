/* BIS_fnc_log: Display debug when debug mode is enabled
* Displays debug when DYN_DEBUG_ENABLED = true;
*
* Example: ["Test"] call BIS_fnc_log;
*/
if(DYN_DEBUG_ENABLED) then
{
	diag_log _this select 0;
};
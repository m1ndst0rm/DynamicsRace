DYN_RACE_JIPPLAYER = (DYN_RACE_STATE != "IDLE");

[] execVM "dynrace\client\ui\onEachFrame.sqf";

[] spawn 
{
	// Wait for join in progress
	waitUntil {!isNil {player}};
	waitUntil {!isNull player};
	
	//Move to unique group so player has own waypoint
	player setVariable ["JIPPLAYER", DYN_RACE_JIPPLAYER, true];

	DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = DYN_RACE_MUST_STAY_ON_ROAD;
	DYN_PLAYER_VEHICLE_FLIPPED = false;
	DYN_PLAYER_VEHICLE_RESET_TIME = 0;
	DYN_PLAYER_ON_ROAD = true;
	DYN_RACE_LAST_WARNING = 0;
	DYN_RACE_PLAYER_FINISHED = false;
	DYN_RACE_TURBO_ENABLED = false;
	DYN_RACE_SPEC_ENABLED = false;
	DYN_VOTEDIALOG_OPEN = false;
	DYN_RACE_ELAPSED_TIME = 0;

	"DYN_RACE_TEAMS" addPublicVariableEventHandler { [] spawn DYN_fnc_OnTeamsChanged;};
	"DYN_RACE_DISPLAYMESSAGE" addPublicVariableEventHandler { [] spawn DYN_fnc_OnDisplayMessageChanged;};
	
	player allowDamage false;
	removeAllItems player;
	removeAllWeapons player;
	removeAllContainers player;
	//removeAllAssignedItems player;
	
	waitUntil {!(isNull (findDisplay 46))};
	
	(finddisplay 46) displayRemoveAllEventHandlers "keydown";
	(finddisplay 46) displayRemoveAllEventHandlers "keyup";
	(finddisplay 46) displayRemoveAllEventHandlers "MouseButtonDown";
	
	DYN_RACE_HANLDER_VOTE = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 47) then {[] call DYN_fnc_VoteDialog;};"];
	DYN_RACE_HANDLER_HELP = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 35) then { [] call DYN_fnc_DisplayHelp; };"];
	
	if(DYN_RACE_JIPPLAYER && DYN_RACE_STATE != "IDLE" && DYN_RACE_STATE != "FINISHED") then
	{
		waitUntil {(DYN_RACE_STATE == "ONGOING")};
		[] call DYN_fnc_EnableSpectator;
	};
	
	titleCut ["", "BLACK IN", 1];
		
	["Dynamics Race","by M1nd0"] spawn BIS_fnc_infoText;
	
	if(DYN_RACE_STATE == "IDLE") then
	{
		sleep 5;
		if(profileNamespace getVariable ["DYN_RACE_firstVisit", true]) then
		{
			[] call DYN_fnc_DisplayHelp;
			profileNamespace setVariable ["DYN_RACE_firstVisit", false];
			saveProfileNamespace;
		};
	};
};
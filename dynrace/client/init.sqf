if (isNil {player} || isNull player) then
{
	DYN_RACE_JIPPLAYER = true;
}
else
{
	DYN_RACE_JIPPLAYER = false;
};

[] execVM "dynrace\client\ui\onEachFrame.sqf";

[] spawn 
{
	// Wait for join in progress
	waitUntil {!isNil {player}};
	waitUntil {!isNull player};
	
	//Hide displays we don't need
	
	//Task info	
	//disableSerialization;
	//((findDisplay 49) displayctrl 103) ctrlSetFade 1; 
	//((findDisplay 49) displayctrl 104) ctrlSetFade 1; 
	//((findDisplay 49) displayctrl 103) ctrlCommit 1;
	//((findDisplay 49) displayctrl 104) ctrlCommit 1;
	
	//Stance
	//((findDisplay 49) displayctrl 188) ctrlSetFade 0; 
	//((findDisplay 49) displayctrl 188) ctrlCommit 1;
	
	
	player setVariable ["JIPPLAYER", DYN_RACE_JIPPLAYER, true];

	DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = DYN_RACE_MUST_STAY_ON_ROAD;
	DYN_PLAYER_VEHICLE_FLIPPED = false;
	DYN_PLAYER_VEHICLE_RESET_TIME = 0;
	DYN_PLAYER_ON_ROAD = true;
	DYN_RACE_LAST_WARNING = 0;
	DYN_RACE_PLAYER_FINISHED = false;
	DYN_RACE_TURBO_ENABLED = false;
	DYN_RACE_SPEC_ENABLED = false;
	DYN_RACE_VOTEDIALOG_OPEN = false;
	//enableRadio false;

	"DYN_RACE_TEAMS" addPublicVariableEventHandler { [] spawn DYN_RACE_OnTeamsChanged;};
	"DYN_RACE_DISPLAYMESSAGE" addPublicVariableEventHandler { [] spawn DYN_RACE_OnDisplayMessageChanged;};
	
	player allowDamage false;
	removeAllItems player;
	removeAllWeapons player;
	
	waitUntil {!(isNull (findDisplay 46))};
	
	(finddisplay 46) displayRemoveAllEventHandlers "keydown";
	(finddisplay 46) displayRemoveAllEventHandlers "keyup";
	
	DYN_RACE_HANLDER_RESET = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 19) then {[] call DYN_RACE_ResetVehicle;};"];
	DYN_RACE_HANLDER_VOTE = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 47) then {[] call DYN_RACE_VoteDialog;};"];
	DYN_RACE_HANDLER_HELP = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 35) then { [] call DYN_RACE_DisplayHelp; };"];
	
	if(DYN_RACE_JIPPLAYER && DYN_RACE_STATE != "IDLE" && DYN_RACE_STATE != "FINISHED") then
	{
		waitUntil {(DYN_RACE_STATE == "ONGOING")};
		[] spawn DYN_RACE_SPEC_EnableSpectator;
	};
	
	titleCut ["", "BLACK IN", 1];
	
	["Dynamics Race","by M1nd0"] spawn BIS_fnc_infoText;
	
	if(DYN_RACE_STATE == "IDLE") then
	{
		sleep 5;
		if!(DYN_RACE_DEBUG_ENABLED) then
		{
			[] call DYN_RACE_DisplayHelp;
		};
	};
};
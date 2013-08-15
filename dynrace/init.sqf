/*
	File: dynrace.sqf
	Author: M1nd0 (joopselen@gmail.com)
	
	Description:
	Race mode for arma 3.
	
	Usage:
	Place in init:
	call compile preprocessFile "dynrace\init.sqf";
*/
"Initializing Dynamics Racing Script" call BIS_fnc_log;

if!(isDedicated) then
{
	waitUntil{!(isNil "BIS_fnc_init")};
	titleCut ["", "BLACK OUT", 1];
};

//Read config values
for "_i" from (0) to ((count paramsArray) - 1) do
{
	missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
};

DYN_ENABLE_AI = (DYN_ENABLE_AIPARAM == 1);

//Always enable AI if singleplayer
if!(isMultiplayer) then
{
	DYN_ENABLE_AI = true;
};

//#REGION External
[] execVM "dynrace\addons\KRON_Strings.sqf";
DYN_fnc_InTrigger = BIS_fnc_inTrigger;//compileFinal preprocessFileLineNumbers "dynrace\addons\fn_inTrigger.sqf";
//#ENDREGION

//TODO: Create functions here and compilefinal them
//#REGION Shared Functions

DYN_fnc_CreateExplosion = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateExplosion.sqf";
DYN_fnc_CreateFire = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateFire.sqf";
DYN_fnc_CreateSmoke = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateSmoke.sqf";
DYN_fnc_CreateSmokeScreen = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateSmokeScreen.sqf";
DYN_fnc_FormatTime = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\FormatTime.sqf";
DYN_fnc_GetAvailableRacers = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetAvailableRacers.sqf";
DYN_fnc_GetFinishArray = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetFinishArray.sqf";
DYN_fnc_GetFinishedPlayers = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetFinishedPlayers.sqf";
DYN_fnc_GetRacerFinishedTime = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetRacerFinishedTime.sqf";
DYN_fnc_GetTeamName = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetTeamName.sqf";
DYN_fnc_GetVehiclesFromconfig = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetVehiclesFromconfig.sqf";
DYN_fnc_GunLock = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GunLock.sqf";
DYN_fnc_GunUnLock = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GunUnLock.sqf";
DYN_fnc_LoadCheckPoints = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\LoadCheckPoints.sqf";
DYN_fnc_LoadStartPositions = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\LoadStartPositions.sqf";
DYN_fnc_NearestFriendlyRacer = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\NearestFriendlyRacer.sqf";
DYN_fnc_NearestRacer = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\NearestRacer.sqf";
DYN_fnc_OnChatChange = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnChatChange.sqf";
DYN_fnc_OnDisplayMessageChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnDisplayMessageChanged.sqf";
DYN_fnc_OnRacersChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnRacersChanged.sqf";
DYN_fnc_OnRaceStateChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnRaceStateChanged.sqf";
//DYN_fnc_OnVehicleHit = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnVehicleHit.sqf";
DYN_fnc_ResupplyVehicle = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\ResupplyVehicle.sqf";
DYN_fnc_SetVehicleDamageHandler = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\SetVehicleDamageHandler.sqf";
DYN_fnc_StartRace = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\StartRace.sqf";
DYN_fnc_StopRace = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\StopRace.sqf";

//#ENDREGION Shared Functions

//#REGION Client Functions
if !(isDedicated) then
{
	DYN_fnc_AddTeamMarkers = compileFinal preprocessFileLineNumbers "dynrace\client\functions\AddTeamMarkers.sqf";
	DYN_fnc_DisplayHelp = compileFinal preprocessFileLineNumbers "dynrace\client\functions\DisplayHelp.sqf";
	DYN_fnc_Finished = compileFinal preprocessFileLineNumbers "dynrace\client\functions\Finished.sqf";
	DYN_fnc_InitRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\InitRaceOnClient.sqf";
	DYN_fnc_OnTeamsChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\OnTeamsChanged.sqf";
	DYN_fnc_ResetVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ResetVehicle.sqf";
	DYN_fnc_SetAsCopVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SetAsCopVehicle.sqf";
	DYN_fnc_SpawnLocalRaceChecks = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalRaceChecks.sqf";
	DYN_fnc_SpawnLocalTimer = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalTimer.sqf";
	DYN_fnc_SpawnLocalWeaponDir = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalWeaponDir.sqf";
	DYN_fnc_StartLocalMusic = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StartLocalMusic.sqf";
	DYN_fnc_StartRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StartRaceOnClient.sqf";
	DYN_fnc_StopRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StopRaceOnClient.sqf";
	DYN_fnc_TurboKeyPress = compileFinal preprocessFileLineNumbers "dynrace\client\functions\TurboKeyPress.sqf";
	DYN_fnc_TurboKeyRelease = compileFinal preprocessFileLineNumbers "dynrace\client\functions\TurboKeyRelease.sqf";
	DYN_fnc_TurboSpawnThread = compileFinal preprocessFileLineNumbers "dynrace\client\functions\TurboSpawnThread.sqf";
	
	
	DYN_fnc_ComActionDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\ActionDialogInit.sqf";
	DYN_fnc_ComBoostAlly = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\BoostAlly.sqf";
	DYN_fnc_ComBtnAction = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\BtnAction.sqf";
	DYN_fnc_ComBtnMap = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\BtnMap.sqf";
	DYN_fnc_ComDeployAction = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\DeployAction.sqf";
	DYN_fnc_ComDisplayActions = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\DisplayActions.sqf";
	DYN_fnc_ComInitialiseCommander = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\InitialiseCommander.sqf";
	DYN_fnc_ComMapClick = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\MapClick.sqf";
	DYN_fnc_ComRepairAlly = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\RepairAlly.sqf";
	DYN_fnc_ComResupply = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\Resupply.sqf";
	DYN_fnc_ComSelectAction = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SelectAction.sqf";
	DYN_fnc_ComSelectedActionChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SelectedActionChanged.sqf";
	DYN_fnc_ComSpawnSmoke = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SpawnSmoke.sqf";
	DYN_fnc_ComSpawnUnit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SpawnUnit.sqf";
	DYN_fnc_ComSpawnVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SpawnVehicle.sqf";
	DYN_fnc_ComStartRaceAsCommander = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\StartRaceAsCommander.sqf";
	//dyn_race_com_spawnexplosions
	
	DYN_fnc_EnableSpectator = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\EnableSpectator.sqf";
	DYN_fnc_DisableSpectator = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\DisableSpectator.sqf";
	DYN_fnc_SwitchFreeLook = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\SwitchFreeLook.sqf";
	DYN_fnc_SwitchPlayer = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\SwitchPlayer.sqf";
	
	DYN_fnc_GetAvailableVehiclesFromConfig = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\GetAvailableVehiclesFromConfig.sqf";
	DYN_fnc_DisableClose = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\DisableClose.sqf";
	
	DYN_fnc_TeamSelectionDialog = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialog.sqf"; 
	DYN_fnc_TeamSelectionDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogInit.sqf"; 
	DYN_fnc_TeamSelectionDialogJoinButton = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogJoinButton.sqf"; 
	DYN_fnc_TeamSelectionDialogRemoveJoinButton = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogRemoveJoinButton.sqf"; 
	DYN_fnc_TeamSelectionDialogRoleSelectionChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogRoleSelectionChanged.sqf"; 
	DYN_fnc_TeamSelectionDialogTeamSelectionChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogTeamSelectionChanged.sqf"; 
	
	DYN_fnc_VoteDialog = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialog.sqf";
	DYN_fnc_VoteDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogInit.sqf";
	DYN_fnc_VoteDialogVoteButton = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogVoteButton.sqf";
	DYN_fnc_VoteDialogSelectChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogSelectChanged.sqf";
	
	DYN_fnc_WinnerDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\WinnerDialogInit.sqf";
	//#ENDREGION Client Functions
};

//#REGION Server Functions
//TODO: IF isserver check

DYN_fnc_CreateTeams = compileFinal preprocessFileLineNumbers "dynrace\server\functions\CreateTeams.sqf";
DYN_fnc_DamageEnabled = compileFinal preprocessFileLineNumbers "dynrace\server\functions\DamageEnabled.sqf";
DYN_fnc_InitRace = compileFinal preprocessFileLineNumbers "dynrace\server\functions\InitRace.sqf";
DYN_fnc_OnPlayerDisconnect = compileFinal preprocessFileLineNumbers "dynrace\server\functions\OnPlayerDisconnect.sqf";
DYN_fnc_PlayerFinished = compileFinal preprocessFileLineNumbers "dynrace\server\functions\PlayerFinished.sqf";
DYN_fnc_PrepareRace = compileFinal preprocessFileLineNumbers "dynrace\server\functions\PrepareRace.sqf";
DYN_fnc_ProcessClientVote = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessClientVote.sqf";
DYN_fnc_ProcessVotes = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessVotes.sqf";
DYN_fnc_ProcessTeamSpotChoose = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessTeamSpotChoose.sqf";
DYN_fnc_SpawnServerRaceChecks = compileFinal preprocessFileLineNumbers "dynrace\server\functions\SpawnServerRaceChecks.sqf";
DYN_fnc_SpawnVehicleMove = compileFinal preprocessFileLineNumbers "dynrace\server\functions\SpawnVehicleMove.sqf";
DYN_fnc_StartRaceOnServer = compileFinal preprocessFileLineNumbers "dynrace\server\functions\StartRaceOnServer.sqf";
DYN_fnc_StopRaceOnServer = compileFinal preprocessFileLineNumbers "dynrace\server\functions\StopRaceOnServer.sqf";

//#ENDREGION Server Functions

[] call DYN_fnc_LoadCheckPoints;
[] call DYN_fnc_LoadStartPositions;

if(isNil {DYN_RACE_LAPS}) then
{
	DYN_RACE_LAPS = 1;
};
if(isNil {DYN_DEBUG_ENABLED}) then
{
	DYN_DEBUG_ENABLED = false;
};
if(DYN_DEBUG_ENABLED) then
{
	//TODO: Enable when cpp function loading is enabled 
	//1 call BIS_fnc_recompile;
};
DYN_RACE_INITPREPDONE = false;
DYN_RACE_TYPES = [["SINGLE","Normal race","Normal race where every player is on their own.", 2],
["DUAL","Driver & Gunner race","This race consist of teams of 2 players, a driver and a gunner. The gunner can shoot only shoot in front of the vehicle and will either damage or slow down oponents depening on the damage setting.", 4],
["TEAM","Driver & Commander race","In this race each team consists of a driver and a commander. The driver must race and the commander can help out his racer or obstruct other players with various actions.", 4],
["TEAM3","Driver, Gunner & Commander race","In this race each team consists of a driver, a gunner and a commander.", 6],
["COPS&ROBBERS","Cops & Robbers","In this race the robbers are tring to escape with an armed vehicle. Police must force them to stop and arrest the robbers.", 4],
["COPS&ROBBERS&COMMANDER","Cops & Robbers+","In this race the robbers are tring to escape with an armed vehicle. Police must force them to stop and arrest the robbers. The police are assisted by a commander whom can can help the cops and obstruct the robbers.", 5],
["CAT&MOUSE","Cat & Mouse","This race consists of teams of 2 players, a slower vehicle and a faster vehicle. The slower vehicle is the mouse and must finish first. Cat's must prevent oponents from finishing.", 4],
["CAT&MOUSE&COMMANDER","Cat & Mouse+","This race is the same as cat and mouse, with the difference that each team also has a commander.", 6]/*,
["HELICHASE","Helicopter chase","In this race 2/3 of the players becomes either a driver or a gunner and they must flee from 1/3 of the players which fly helicopters!", 2]*/];

DYN_RACE_CATROBBERSCOLOR = ["Sign_Arrow_Large_F", "Sign_Arrow_Large_Blue_F", "Sign_Arrow_Large_Green_F", "Sign_Arrow_Large_Yellow_F", "Sign_Arrow_Large_Pink_F", "Sign_Arrow_Large_Cyan_F"];
DYN_RACE_CATROBBERSTEAMNAMES = ["RED TEAM","BLUE TEAM","GREEN TEAM","YELLOW TEAM","PINK TEAM","CYAN TEAM"];
DYN_RACE_CATROBBERSCOLORCODES = [[0.878,0.106,0.106,1],[0.133,0.106,0.878,1],[0.106,0.878,0.118,1],[0.945,0.98,0.243,1],[0.98,0.243,0.969,1],[0.243,0.98,0.929,1]];

if(isNil {DYN_RACE_MUST_STAY_ON_ROAD}) then
{
	DYN_RACE_MUST_STAY_ON_ROAD = false;
};
if(isNil {DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT}) then
{
	DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT = 10;
};
if(isNil {DYN_RACE_DAMAGE_MULTIPLIER}) then
{
	DYN_RACE_DAMAGE_MULTIPLIER = 1; //Broken if not 1
};

//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}, waitForScriptDone]  Important Note: USE calls instead of spawns if waitForScriptDone, else it wont wait because of the spawn
DYN_RACE_DEFAULT_COMMANDER_ACTIONS = [
["spawnSmoke",[],"BOTH","Spawn smoke","Spawn smoke which lasts for 15 seconds.",10,{[_this,15] call DYN_fnc_ComSpawnSmoke;}, false],
["repairAlly",["TEAM","TEAM3","CAT&MOUSE","COPS&ROBBERS"],"ENABLED","Repair ally","Repairs a friendly vehicle.",20,{[_this, 100] call DYN_fnc_ComRepairAlly;}, false],
["boostAlly",["TEAM","TEAM3","CAT&MOUSE","COPS&ROBBERS"],"BOTH","Boost ally","Gives an ally a short speed boost.",20,{[_this, 2/*Duration*/,1/*Intesity*/] call DYN_fnc_ComBoostAlly;}, false],
["resupplyAlly",["TEAM","TEAM3","CAT&MOUSE","COPS&ROBBERS"],"ENABLED","Resupply ally","Resupplies an ally vehicle with ammo.",40,{[_this] call DYN_fnc_ComResupply;}, false],
["spawnRifleMan",[],"BOTH","Spawn Rifleman","Spawn (and control) a rifleman for 15 seconds.",20,{[_this,"I_soldier_F",15] call DYN_fnc_ComSpawnUnit;}, true],
["spawnATSoldier",[],"BOTH","Spawn AT Soldier","Spawn (and control) a anti-tank soldier for 20 seconds.",30,{[_this,"I_Soldier_AA_F",20,"secundary"] call DYN_fnc_ComSpawnUnit;}, true],
["spawnOffRoad",[],"BOTH","Spawn Offroad","Spawn (and control) a offroad vehicle for 20 seconds.",40,{[_this, DYN_RACE_OFFROAD_CLASS,20, "DRIVER"] call DYN_fnc_ComSpawnVehicle;}, true],
/*["spawnExplosions",[],"BOTH","Spawn explosions","Spawn a set of explosions (5 explosions in 10 seconds within a radius of 50 meter).",20,{[_this,5,10,50] call DYN_RACE_COM_SpawnExplosions;}, false],*/
["spawnHMG",[],"BOTH","Spawn Ifrit HMG","Spawn (and control  a ifrit with a heavy machine gun for 30 seconds. (Gunner position)",60,{[_this,"O_MRAP_02_hmg_F",30, "GUNNER"] call DYN_fnc_ComSpawnVehicle;}, true],
["spawnGMG",[],"BOTH","Spawn Ifrit GMG","Spawn (and control) a ifrit with a grenade launcher for 30 seconds. (Gunner position)",80,{[_this,"O_MRAP_02_gmg_F",30, "GUNNER"] call DYN_fnc_ComSpawnVehicle;}, true],
["spawnAH",[],"BOTH","Spawn AH-9 Pawnee","Spawn (and control) a AH-9 pawnee (littlebird) for 30 seconds.",100,{[_this,"B_Heli_Light_01_armed_F",30, "DRIVER"] call DYN_fnc_ComSpawnVehicle;}, true],
["spawnMi",[],"BOTH","Spawn Mi-48 Kajman","Spawn (and control) a Mi-48 Kajman for 30 seconds.",120,{[_this,"O_Heli_Attack_02_F",30, "DRIVER"] call DYN_fnc_ComSpawnVehicle;}, true]
];

if(isNil {DYN_RACE_COMMANDER_ACTIONS}) then
{
	DYN_RACE_COMMANDER_ACTIONS = [];
};
DYN_RACE_COMMANDER_ACTIONS = DYN_RACE_DEFAULT_COMMANDER_ACTIONS + DYN_RACE_COMMANDER_ACTIONS;

DYN_RACE_OFFROAD_CLASS = "C_Offroad_01_F";
DYN_RACE_MOUSE_CLASS = "B_MRAP_01_F";
DYN_RACE_ROBBER_CLASS = "B_MRAP_01_hmg_F";
DYN_RACE_CHOPPER_CLASS = "O_Heli_Attack_02_F";
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_SINGLE}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_SINGLE = ["C_Offroad_01_F","B_Quadbike_01_F","B_MRAP_01_F", "I_MRAP_03_F"]; //["Car", true] call DYN_fnc_GetVehiclesFromconfig; <--disabled for the moment because of to-long-vehicles. They instantly explode upon spawn because of to short distance between startpositions
};
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_DUAL}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_DUAL = ["Car", false] call DYN_fnc_GetVehiclesFromconfig;//["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
};

//Time for other players to finish when 1 player finishes.
DYN_RACE_TIMETOFINISH = 60;
enableSaving [false, false];

if(isNil {DYN_RACE_STATE}) then
{
	DYN_RACE_STATE = "IDLE";
};
"DYN_RACE_STATE" addPublicVariableEventHandler { [] spawn DYN_fnc_OnRaceStateChanged;};

if (isNil {DYN_RACE_RACERS}) then
{
	DYN_RACE_RACERS = []; //[playerName, netId player, netId vehicle, playerAllowDamage, vehicleAllowDamage, vehicleEnableSimulation, laptimes[lap,time]];
};

if(isNil {DYN_RACE_TEAMS}) then
{
	DYN_RACE_TEAMS = [];
};

//Cops & Robbers var
//Below this speed a robber can be caught
if(isNil {DYN_RACE_ROBBER_SPEEDLIMIT}) then
{
	DYN_RACE_ROBBER_SPEEDLIMIT = 10;
};
//If robbers is below speed & cops is in this vicinity
if(isNil {DYN_RACE_ROBBER_DISTANCELIMIT}) then
{
	DYN_RACE_ROBBER_DISTANCELIMIT = 15;
};
//For how low robbers needs to be belowspeed & in vicinity
if(isNil {DYN_RACE_ROBBER_TIMELIMIT}) then
{
	DYN_RACE_ROBBER_TIMELIMIT = 5;
};

"DYN_RACE_RACERS" addPublicVariableEventHandler { [] spawn DYN_fnc_OnRacersChanged;};
"DYN_RACE_CHAT" addPublicVariableEventHandler { [] spawn DYN_fnc_OnChatChange;};

if(isServer) then
{
	[] execVM "dynrace\server\init.sqf";
};

if!(isDedicated) then
{
	[] execVM "dynrace\client\init.sqf";
};

"Dynamics Racing Script initialized." call BIS_fnc_log;
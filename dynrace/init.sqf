/*
	File: dynrace.sqf
	Author: M1nd0 (joopselen@gmail.com)
	
	Description:
	Race mode for arma 3.
	
	Usage:
	Place in init:
	call compile preprocessFile "dynrace\init.sqf";
*/
diag_log "Initializing Dynamics Racing Script";

if!(isDedicated) then
{
	waitUntil{!(isNil "BIS_fnc_init")};
	titleCut ["", "BLACK OUT", 1];
};

//#REGION External
[] execVM "dynrace\addons\KRON_Strings.sqf";
DYN_RACE_InTrigger = compileFinal preprocessFileLineNumbers "dynrace\addons\fn_inTrigger.sqf";
//#ENDREGION

//TODO: Create functions here and compilefinal them
//#REGION Shared Functions

DYN_RACE_CreateExplosion = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateExplosion.sqf";
DYN_RACE_CreateFire = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateFire.sqf";
DYN_RACE_CreateSmoke = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateSmoke.sqf";
DYN_RACE_CreateSmokeScreen = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\CreateSmokeScreen.sqf";
DYN_RACE_Debug = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\Debug.sqf";
DYN_RACE_FormatTime = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\FormatTime.sqf";
DYN_RACE_GenerateWinnerString = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GenerateWinnerString.sqf";
DYN_RACE_GetFinishArray = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetFinishArray.sqf";
DYN_RACE_GetFinishedPlayers = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetFinishedPlayers.sqf";
DYN_RACE_GetRacerFinishedTime = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetRacerFinishedTime.sqf";
DYN_RACE_GetTeamName = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GetTeamName.sqf";
DYN_RACE_GunLock = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GunLock.sqf";
DYN_RACE_GunUnLock = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\GunUnLock.sqf";
DYN_RACE_LoadCheckPoints = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\LoadCheckPoints.sqf";
DYN_RACE_LoadStartPositions = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\LoadStartPositions.sqf";
DYN_RACE_NearestFriendlyRacer = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\NearestFriendlyRacer.sqf";
DYN_RACE_NearestRacer = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\NearestRacer.sqf";
DYN_RACE_OnChatChange = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnChatChange.sqf";
DYN_RACE_OnDisplayMessageChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnDisplayMessageChanged.sqf";
DYN_RACE_OnRacersChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnRacersChanged.sqf";
DYN_RACE_OnRaceStateChanged = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnRaceStateChanged.sqf";
DYN_RACE_OnVehicleHit = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\OnVehicleHit.sqf";
DYN_RACE_ResupplyVehicle = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\ResupplyVehicle.sqf";
DYN_RACE_StartRace = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\StartRace.sqf";
DYN_RACE_StopRace = compileFinal preprocessFileLineNumbers "dynrace\shared\functions\StopRace.sqf";

//Old
//[] execVM "dynrace\shared\functions\FindLocalPlayer.sqf";
//[] execVM "dynrace\shared\functions\FindLocalVehicle.sqf";
//[] execVM "dynrace\shared\functions\GetObjectID.sqf";
//#ENDREGION Shared Functions

//#REGION Client Functions
if !(isDedicated) then
{
	DYN_RACE_DisplayHelp = compileFinal preprocessFileLineNumbers "dynrace\client\functions\DisplayHelp.sqf";
	DYN_RACE_Finished = compileFinal preprocessFileLineNumbers "dynrace\client\functions\Finished.sqf";
	DYN_RACE_InitRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\InitRaceOnClient.sqf";
	DYN_RACE_OnTeamsChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\OnTeamsChanged.sqf";
	DYN_RACE_ResetVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ResetVehicle.sqf";
	DYN_RACE_SetAsCopVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SetAsCopVehicle.sqf";
	DYN_RACE_SpawnLocalRaceChecks = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalRaceChecks.sqf";
	DYN_RACE_SpawnLocalTimer = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalTimer.sqf";
	DYN_RACE_SpawnLocalWeaponDir = compileFinal preprocessFileLineNumbers "dynrace\client\functions\SpawnLocalWeaponDir.sqf";
	DYN_RACE_StartLocalMusic = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StartLocalMusic.sqf";
	DYN_RACE_StartRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StartRaceOnClient.sqf";
	DYN_RACE_StopRaceOnClient = compileFinal preprocessFileLineNumbers "dynrace\client\functions\StopRaceOnClient.sqf";
	DYN_RACE_TURBO_SCRIPT = compileFinal preprocessFileLineNumbers "dynrace\client\functions\Turbo.sqf";
	DYN_RACE_TurboStart = compileFinal preprocessFileLineNumbers "dynrace\client\functions\TurboStart.sqf";
	DYN_RACE_TurboStop = compileFinal preprocessFileLineNumbers "dynrace\client\functions\TurboStop.sqf";
	
	
	DYN_RACE_COM_BtnAction = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\BtnAction.sqf";
	DYN_RACE_COM_BtnMap = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\BtnMap.sqf";
	DYN_RACE_COM_InitialiseCommander = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\InitialiseCommander.sqf";
	DYN_RACE_COM_StartRaceAsCommander = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\StartRaceAsCommander.sqf";
	DYN_RACE_COM_SpawnUnit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SpawnUnit.sqf";
	DYN_RACE_COM_SpawnVehicle = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\SpawnVehicle.sqf";
	DYN_RACE_COM_MapClick = compileFinal preprocessFileLineNumbers "dynrace\client\functions\commander\MapClick.sqf";
	
	
	DYN_RACE_SPEC_EnableSpectator = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\EnableSpectator.sqf";
	DYN_RACE_SPEC_DisableSpectator = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\DisableSpectator.sqf";
	DYN_RACE_SPEC_SwitchFreeLook = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\SwitchFreeLook.sqf";
	DYN_RACE_SPEC_SwitchPlayer = compileFinal preprocessFileLineNumbers "dynrace\client\functions\spectator\SwitchPlayer.sqf";
	
	DYN_RACE_GetAvailableVehiclesFromConfig = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\GetAvailableVehiclesFromConfig.sqf";
	DYN_RACE_DisableClose = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\DisableClose.sqf";
	
	DYN_RACE_TeamSelectionDialog = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialog.sqf"; 
	DYN_RACE_TeamSelectionDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogInit.sqf"; 
	DYN_RACE_TeamSelectionDialogJoinButton = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogJoinButton.sqf"; 
	DYN_RACE_TeamSelectionDialogRoleSelectionChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogRoleSelectionChanged.sqf"; 
	DYN_RACE_TeamSelectionDialogTeamSelectionChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\TeamSelectionDialogTeamSelectionChanged.sqf"; 
	
	DYN_RACE_VoteDialog = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialog.sqf";
	DYN_RACE_VoteDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogInit.sqf";
	DYN_RACE_VoteDialogVoteButton = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogVoteButton.sqf";
	DYN_RACE_VoteDialogSelectChanged = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\VoteDialogSelectChanged.sqf";
	
	DYN_RACE_WinnerDialogInit = compileFinal preprocessFileLineNumbers "dynrace\client\functions\ui\WinnerDialogInit.sqf";
	//#ENDREGION Client Functions
};

//#REGION Server Functions
//TODO: IF isserver check

DYN_RACE_CreateTeams = compileFinal preprocessFileLineNumbers "dynrace\server\functions\CreateTeams.sqf";
DYN_RACE_DamageEnabled = compileFinal preprocessFileLineNumbers "dynrace\server\functions\DamageEnabled.sqf";
DYN_RACE_InitRace = compileFinal preprocessFileLineNumbers "dynrace\server\functions\InitRace.sqf";
DYN_RACE_OnPlayerDisconnect = compileFinal preprocessFileLineNumbers "dynrace\server\functions\OnPlayerDisconnect.sqf";
DYN_RACE_PlayerFinished = compileFinal preprocessFileLineNumbers "dynrace\server\functions\PlayerFinished.sqf";
DYN_RACE_PrepareRace = compileFinal preprocessFileLineNumbers "dynrace\server\functions\PrepareRace.sqf";
DYN_RACE_ProcessClientVote = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessClientVote.sqf";
DYN_RACE_ProcessVotes = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessVotes.sqf";
DYN_RACE_ProcessTeamSpotChoose = compileFinal preprocessFileLineNumbers "dynrace\server\functions\ProcessTeamSpotChoose.sqf";
DYN_RACE_VehicleDamageHandler = compileFinal preprocessFileLineNumbers "dynrace\server\functions\SetVehicleDamageHandler.sqf";
DYN_RACE_SpawnServerRaceChecks = compileFinal preprocessFileLineNumbers "dynrace\server\functions\SpawnServerRaceChecks.sqf";
DYN_RACE_SpawnVehicleMove = compileFinal preprocessFileLineNumbers "dynrace\server\functions\SpawnVehicleMove.sqf";
DYN_RACE_StartRaceOnServer = compileFinal preprocessFileLineNumbers "dynrace\server\functions\StartRaceOnServer.sqf";
DYN_RACE_StopRaceOnServer = compileFinal preprocessFileLineNumbers "dynrace\server\functions\StopRaceOnServer.sqf";

//#ENDREGION Server Functions

[] call DYN_RACE_LoadCheckPoints;
[] call DYN_RACE_LoadStartPositions;

if(isNil {DYN_RACE_LAPS}) then
{
	DYN_RACE_LAPS = 1;
};
if(isNil {DYN_RACE_DEBUG_ENABLED}) then
{
	DYN_RACE_DEBUG_ENABLED = false;
};

DYN_RACE_TYPES = [["SINGLE","Normal race","Normal race where everyone is on their own. Damage can be enabled or disabled (voted)."],
["DUAL","2 player race (Driver & Gunner)","This race consist of teams of 2 players, a driver and a gunner. The gunner can shoot only shoot in front of the vehicle and will either damage or slow down oponents depening on the damage setting."],
/*["TEAM","2 player race (Driver & Commander)","In this race each team consists of a driver and a commander. The driver must race and the commander can help out his racer or obstruct other players with various actions."],
["TEAM3","3 player race (Driver, Gunner & Commander)","In this race each team consists of a driver, a gunner and a commander. "],*/
["COPS&ROBBERS","Cops & Robbers","In this race the robbers are tring to escape with an armed vehicle. Police must force them to stop and arrest the robbers."],
/*["COPS&ROBBERS&COMMANDER","Cops & Robbers+","In this race the robbers are tring to escape with an armed vehicle. Police must force them to stop and arrest the robbers. The police are assisted by a commander whom can can help the cops and obstruct the robbers."],*/
["CAT&MOUSE","Cat & Mouse","In this race consists of teams of 2 players, a slower vehicle and a faster vehicle. The slower vehicle is the mouse and must finish first. Cat's must prevent oponents from finishing."]/*,
["CAT&MOUSE&COMMANDER","Cat & Mouse+","In this race consists of teams of 2 players, a slower vehicle and a faster vehicle. The slower vehicle is the mouse and must finish first. Cat's must prevent oponents from finishing. Each team also has a commander whom can help out the mouse or obstruct other player's."],
["HELICHASE","Helicopter chase","In this race 2/3 of the players becomes either a driver or a gunner and they must flee from 1/3 of the players which fly helicopters!"]*/];

if(isNil {DYN_RACE_MUST_STAY_ON_ROAD}) then
{
	DYN_RACE_MUST_STAY_ON_ROAD = false;
};
if(isNil {DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT}) then
{
	DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT = 10;
};

//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}]
DYN_RACE_DEFAULT_COMMANDER_ACTIONS = [
["spawnSmoke",[],"BOTH","Spawn smoke","Spawn smoke which lasts for 15 seconds.",5,{[_this,15] spawn DYN_RACE_COM_SpawnSmoke;}],
["repairAlly",["CAT&MOUSE","COPS&ROBBERS"],"ENABLED","Repair ally","Repairs a friendly vehicle.",10,{[_this, 100] spawn DYN_RACE_COM_RepairAlly;}],
["boostAlly",["CAT&MOUSE","COPS&ROBBERS"],"BOTH","Boost ally","Gives an ally a short speed boost.",10,{[_this, 2/*Duration*/,1/*Intesity*/] spawn DYN_RACE_COM_BoostAlly;}],
["resupplyAlly",["CAT&MOUSE","COPS&ROBBERS"],"BOTH","Resupply ally","Resupplies an ally vehicle with ammo.",10,{[_this] spawn DYN_RACE_COM_Resupply;}],
["spawnRifleMan",[],"BOTH","Spawn Rifleman","Spawn (and control) a rifleman for 15 seconds.",10,{[_this,"I_soldier_F",15] spawn DYN_RACE_COM_SpawnUnit;}],
["spawnATSoldier",[],"BOTH","Spawn AT Soldier","Spawn (and control) a anti-tank soldier for 20 seconds.",20,{[_this,"I_Soldier_AA_F",20] spawn DYN_RACE_COM_SpawnUnit;}],
["spawnOffRoad",[],"BOTH","Spawn Offroad","Spawn (and control) a offroad vehicle for 20 seconds.",20,{[_this,"O_MRAP_02_hmg_F",20] spawn DYN_RACE_COM_SpawnVehicle;}],
["spawnExplosions",[],"BOTH","Spawn explosions","Spawn a set of explosions (5 explosions in 10 seconds within a radius of 50 meter).",20,{[_this,5,10,50] spawn DYN_RACE_COM_SpawnExplosions;}],
["spawnHMG",[],"BOTH","Spawn Ifrit HMG","Spawn (and control) a ifrit with a heavy machine gun for 30 seconds.",45,{[_this,"O_MRAP_02_hmg_F",30] spawn DYN_RACE_COM_SpawnVehicle;}],
["spawnGMG",[],"BOTH","Spawn Ifrit GMG","Spawn (and control) a ifrit with a grenade launcher for 30 seconds.",45,{[_this,"O_MRAP_02_gmg_F",30] spawn DYN_RACE_COM_SpawnVehicle;}],
["spawnAH",[],"BOTH","Spawn AH-9 Pawnee","Spawn (and control) a AH-9 pawnee (littlebird) for 30 seconds.",60,{[_this,"B_Heli_Light_01_armed_F",30] spawn DYN_RACE_COM_SpawnVehicle;}],
["spawnMi",[],"BOTH","Spawn Mi-48 Kajman","Spawn (and control) a Mi-48 Kajman for 30 seconds.",70,{[_this,"O_Heli_Attack_02_F",30] spawn DYN_RACE_COM_SpawnVehicle;}]
];

if(isNil {DYN_RACE_COMMANDER_ACTIONS}) then
{
	DYN_RACE_COMMANDER_ACTIONS = [];
};
DYN_RACE_COMMANDER_ACTIONS = DYN_RACE_DEFAULT_COMMANDER_ACTIONS + DYN_RACE_COMMANDER_ACTIONS;

DYN_RACE_OFFROAD_CLASS = "C_Offroad_01_F";
DYN_RACE_ROBBER_CLASS = "B_MRAP_01_hmg_F";
DYN_RACE_CHOPPER_CLASS = "O_Heli_Attack_02_F";
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_SINGLE}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_SINGLE = ["C_Offroad_01_F","B_Quadbike_01_F","B_Hunter_F","B_MRAP_01_F", "I_MRAP_03_F"];
};
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_DUAL}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_DUAL = ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
};

//Time for other players to finish when 1 player finishes.
DYN_RACE_TIMETOFINISH = 60;
enableSaving [false, false];

if(isNil {DYN_RACE_STATE}) then
{
	DYN_RACE_STATE = "IDLE";
};
"DYN_RACE_STATE" addPublicVariableEventHandler { [] spawn DYN_RACE_OnRaceStateChanged;};

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

"DYN_RACE_RACERS" addPublicVariableEventHandler { [] spawn DYN_RACE_OnRacersChanged;};
"DYN_RACE_CHAT" addPublicVariableEventHandler { [] spawn DYN_RACE_OnChatChange;};

if(isServer) then
{
	[] execVM "dynrace\server\init.sqf";
};

if!(isDedicated) then
{
	[] execVM "dynrace\client\init.sqf";
};

diag_log "Dynamics Racing Script initialized.";
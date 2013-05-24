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

[] execVM "dynrace\addons\KRON_Strings.sqf";

//TODO: Create functions here and compilefinal them
//#REGION Shared Functions
[] execVM "dynrace\shared\functions\Debug.sqf";
[] execVM "dynrace\shared\functions\FindLocalPlayer.sqf";
[] execVM "dynrace\shared\functions\FindLocalVehicle.sqf";
[] execVM "dynrace\shared\functions\FinishLineTrigger.sqf";
[] execVM "dynrace\shared\functions\FormatTime.sqf";
[] execVM "dynrace\shared\functions\GenerateWinnerString.sqf";
[] execVM "dynrace\shared\functions\GetFinishedPlayers.sqf";
[] execVM "dynrace\shared\functions\GetRacerFinishedTime.sqf";
[] execVM "dynrace\shared\functions\GetObjectID.sqf";
[] execVM "dynrace\shared\functions\OnRacersChanged.sqf";
[] execVM "dynrace\shared\functions\OnRaceStateChanged.sqf";
[] execVM "dynrace\shared\functions\StartRace.sqf";
[] execVM "dynrace\shared\functions\StopRace.sqf";
[] execVM "dynrace\shared\functions\CreateExplosion.sqf";
[] execVM "dynrace\shared\functions\CreateFire.sqf";
[] execVM "dynrace\shared\functions\CreateSmoke.sqf";
[] execVM "dynrace\shared\functions\LoadCheckPoints.sqf";
[] execVM "dynrace\shared\functions\LoadStartPositions.sqf";
//#ENDREGION Shared Functions

//#REGION Client Functions
if !(isDedicated) then
{
	[] execVM "dynrace\client\functions\DisableSpectator.sqf";
	[] execVM "dynrace\client\functions\EnableSpectator.sqf";
	[] execVM "dynrace\client\functions\ResetVehicle.sqf";
	[] execVM "dynrace\client\functions\SpawnLocalRaceChecks.sqf";
	[] execVM "dynrace\client\functions\SpawnLocalTimer.sqf";
	[] execVM "dynrace\client\functions\SpawnLocalWeaponDir.sqf";
	[] execVM "dynrace\client\functions\StartLocalMusic.sqf";
	[] execVM "dynrace\client\functions\StartRaceOnClient.sqf";
	[] execVM "dynrace\client\functions\StopRaceOnClient.sqf";
	[] execVM "dynrace\client\functions\Turbo.sqf";
	[] execVM "dynrace\client\functions\OnVehicleHit.sqf";
	[] execVM "dynrace\client\functions\OnChatChange.sqf";
	
	[] execVM "dynrace\client\functions\ui\GetAvailableVehiclesFromConfig.sqf";
	[] execVM "dynrace\client\functions\ui\StartDialog.sqf";
	[] execVM "dynrace\client\functions\ui\StartDialogInit.sqf";
	[] execVM "dynrace\client\functions\ui\StartDialogStartButton.sqf";
	//#ENDREGION Client Functions
};

//#REGION Server Functions
[] execVM "dynrace\server\functions\DamageEnabled.sqf";
[] execVM "dynrace\server\functions\InitRace.sqf";
[] execVM "dynrace\server\functions\OnPlayerDisconnect.sqf";
[] execVM "dynrace\server\functions\SetVehicleDamageHandler.sqf";
[] execVM "dynrace\server\functions\SpawnVehicleMove.sqf";
[] execVM "dynrace\server\functions\StartRaceOnServer.sqf";
[] execVM "dynrace\server\functions\StopRaceOnServer.sqf";
[] execVM "dynrace\server\functions\ProcessClientVote.sqf";
[] execVM "dynrace\server\functions\ProcessVotesAndStartRace.sqf";
//#ENDREGION Server Functions

if(isNil {DYN_RACE_LAPS}) then
{
	DYN_RACE_LAPS = 1;
};
if(isNil {DYN_RACE_DEBUG_ENABLED}) then
{
	DYN_RACE_DEBUG_ENABLED = false;
};
if(isNil {DYN_RACE_TYPE}) then
{
	DYN_RACE_TYPE = "SINGLE";
};
if(isNil {DYN_RACE_DAMAGE_ENABLED}) then
{
	DYN_RACE_DAMAGE_ENABLED = false;
};
if(isNil {DYN_RACE_MUST_STAY_ON_ROAD}) then
{
	DYN_RACE_MUST_STAY_ON_ROAD = true;
};
if(isNil {DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT}) then
{
	DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT = 10;
};
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_SINGLE}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_SINGLE = ["c_offroad","B_Quadbike_F","B_Hunter_F","O_Ifrit_F"];
};
if(isNil {DYN_RACE_AVAILABLE_VEHICLES_DUAL}) then
{
	DYN_RACE_AVAILABLE_VEHICLES_DUAL = ["B_Hunter_HMG_F","B_Hunter_RCWS_F","O_Ifrit_MG_F","O_Ifrit_GMG_F"];
};

if(DYN_RACE_TYPE == "SINGLE") then
{
	DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_SINGLE;
}
else
{
	DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_DUAL;
};


//Time for other players to finish when 1 player finished.
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
DYN_RACE_FINISHTIME = -1;

diag_log "Dynamics Racing Script initialized.";
//Server init
[] call DYN_RACE_PrepareRace;

onPlayerDisconnected "[_id,_name, _uid] spawn DYN_RACE_OnPlayerDisconnect;";

DYN_RACE_LOCK_TEAMS = false;
publicVariable "DYN_RACE_STATE";
[] call DYN_RACE_OnRaceStateChanged;
publicVariable "DYN_RACE_RACERS";
[] call DYN_RACE_OnRacersChanged;
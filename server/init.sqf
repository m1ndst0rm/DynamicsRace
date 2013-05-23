//Server init
DYN_RACE_EXPLOSIONS = [];
DYN_RACE_MAP_VEHICLES = [];
DYN_RACE_SMOKE_GRENADES = [];
DYN_RACE_FIRES = [];
DYN_RACE_VOTES = [];
onPlayerDisconnected "[_id,_name, _uid] spawn DYN_RACE_OnPlayerDisconnect;";

publicVariable "DYN_RACE_STATE";
[] call DYN_RACE_OnRaceStateChanged;
publicVariable "DYN_RACE_RACERS";
[] call DYN_RACE_OnRacersChanged;
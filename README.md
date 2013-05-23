Dynamics Race Script
================================
Author: m1ndst0rm (joopselen@gmail.com)

Description:
Advanced race script for Arma 3. With this script you can easily make your own multiplayer race missions in arma 3.
It will mainly provide 4 race types:
<<<<<<< HEAD

* Race without damage
* Race with damage 
* Race with driver & gunger without damage (only allowed to shoot in front of vehicle, hits slow down oponents)
* Race with driver & gunner with damage. 
=======
*Race without damage
*Race with damage 
*Race with driver & gunger without damage (only allowed to shoot in front of vehicle, hits slow down oponents)
*Race with driver & gunner with damage. 
>>>>>>> b9c7f33e35563ac7409c0c2d0b59fb7c7df4e666

Features
--------
- [x] Voting system for vehicle type
- [x] Vehicles must stay on road (on/off)
- [x] Vehicle reset
- [x] As many players as Arma 3 allows
- [x] Race timer
- [x] Race results
- [x] X seconds left to finish when first player finishes
- [x] Spectator mode for finished & JIP players
- [x] Checkpoint system
- [x] Smoke screen
- [x] Damange enabled/disabled
- [x] Trigger: Explosions
- [x] Trigger: Start music
- [x] Trigger: Enable/Disable must stay on road
- [x] Trigger: Spawning of traffic
- [ ] 2nd Race type: Each vehicle get's a driver and gunner.
- [ ] Vote race type
- [ ] Vote damage
- [ ] Multiple laps
- [ ] ??

Usage
-----

Place this lin in your mission's INIT.
call compile preprocessFile "dynrace\init.sqf";

Usable variables (Place in init):

* VAR_NAME (TYPE:(VALUES):DEFAULT): DESCRIPTION
* DYN_RACE_DEBUG_ENABLED (bool:false): If true function calls and other debug info will be displayed in log files.
* DYN_RACE_LAPS (int: 1): Amount of laps. 1 Means a to b race.
* DYN_RACE_MUST_STAY_ON_ROAD (bool: true): Global starting value. If true vehicles will be reset after leaving the road for 20 seconds.
* DYN_RACE_TYPE (string:RACE,DAUL:RACE): Race type. Race is normal DUAL is driver/gunner mode.
* DYN_RACE_AVAILABLE_VEHICLES_SINGLE (string:"c_offroad","B_Quadbike_F","B_Hunter_F","O_Ifrit_F"): Available race vehicles (classnames) for single race mode.
* DYN_RACE_AVAILABLE_VEHICLES_DUAL (string:"B_Hunter_HMG_F","B_Hunter_RCWS_F","O_Ifrit_MG_F","O_Ifrit_GMG_F"): Available race vehicles (classnames) for dual race mode.
* DYN_RACE_DAMAGE_ENABLED (bool:false): Wether damage should be enabled or not.

Map markers which must be placed inside your mission:

* DYN_RACE_Start_Position_X: Start positions. Atleast the same amount of start positions as players should be available.
* DYN_Checkpoint_X: Checkpoints. Start with 1 and increase to x. Last checkpoint (highest X) will be finish line.

Map triggers (see function documentation for advanced ussage):

* [thislist] call DYN_RACE_FinishLineTrigger: Trigger which acts as the finish line.
* ["marker_1", "marker_2", ...] call DYN_RACE_CreateExplosion: Create one ore multiple explosions. Explosions are globally saved to prevent multiple players from triggering multiple explosions.
* DYN_RACE_SpawnVehicleMove: See server\functions\SpawnVehicleMove.sqf for doc. Spawns traffic

Terms of Use
------------
Using or editing of this script is permitted only when credits are given. If you have "big" plans with this script I would appreciate it if you contacted me so we might be able to "improve" this version instead of creation different branches.

Made possible by / credits:
---------------------------
-BTK: BTK spectator script
-Kronzky: String functions
-Team Dynamics: Testing
-JoSchaap, JW Custom & Killzone_Kid: Testing/troubleshooting and help with scripting.
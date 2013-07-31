Dynamics Race Script
================================
Author: m1ndst0rm (joopselen@gmail.com)

Description:
Advanced race script for Arma 3. With this script you can easily make your own multiplayer race missions in arma 3.
It will mainly provide these race types:

* Race without damage
* Race with damage 
* Race with driver & gunner without damage (only allowed to shoot in front of vehicle, hits slow down oponents)
* Race with driver & gunner with damage. 
* Cops & Robbers: 1 (or more depening on player ammount) armed vehicle(s) with 2 players are robbers. Rest is police and must arrest (halt) them before robbers reach the finish.
* Cat & Mice: Teams of 2 players: Each player has a mice (slower vehicle) and a cats (faster). Cats must prevent the mice from opponent teams from finishing. If more then 12 players teams get larger.
* (WIP) driver, gunner & commander race.
* (WIP) Cops & Robbers + Commander:
* (WIP) Cat & Mice + Commander:
* (WIP) Heli chase. Teams of 2 players (driver & gunner) need to race for finish while being chased by other players in helis.

Features
--------
- [x] Voting system for vehicle type
- [x] Vote race type
- [x] Vote damage in single & dual race.
- [x] Team creation
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
- [x] Trigger: Enable or disable guns
- [x] 2nd Race type: Each vehicle get's a driver and gunner.
- [x] Multiple laps
- [ ] Commander mode: Help your team or obstruct the enemy as a commander by placing explosion, repairing vehicles, geving boos or even taking control of sertaind enemy vehicles fora while.

And more.

TODO / WIP:
- Single & Dual race: damage balance
- Cops & Robbers: arrest action / feature. 
- Cops & Robbers: global messages on arrest if more then 1 robber vehicle
- Cops & Robbers: damage test
- Commander mode: Map usage, tp and others things
- Heli chase: Everything
- Figure out what to do with vehicle desctruction
- Fix a decent vehicle reset position based. (Now if muststayonraod lastroadpos, but if not muststayonroad how to reset when we have no clue about track.

Usage
-----

Either use the provided example mission or replace it by your own version. 
Incase you add your own:

**init.sqf**:

		call compile preprocessFile "dynrace\init.sqf";

**description.ext**:

	#include "dynrace\client\ui\dynrace.hpp"
	class CfgSounds
	{
		sounds[] = {};
		class BEEP
		{
			name = "BEEP";
			sound[] = {"audio\beep.ogg", 1, 1};
			titles[] = {};
		};
		class BEEP_HIGH
		{
			name = "BEEP_HIGH";
			sound[] = {"audio\beep_high.ogg", 1, 1};
			titles[] = {};
		};
	};

	
Usable variables (Place in init):

* VAR_NAME (TYPE:(VALUES):DEFAULT): DESCRIPTION
* DYN_RACE_DEBUG_ENABLED (bool:false): If true function calls and other debug info will be displayed in log files.
* DYN_RACE_LAPS (int: 1): Amount of laps. 1 Means a to b race.
* DYN_RACE_MUST_STAY_ON_ROAD (bool: true): Global starting value. If true vehicles will be reset after leaving the road for 20 seconds.
* DYN_RACE_AVAILABLE_VEHICLES_SINGLE (string:"C_Offroad_01_F","B_Quadbike_01_F","B_Hunter_F","B_MRAP_01_F"): Available race vehicles (classnames) for single race mode.
* DYN_RACE_AVAILABLE_VEHICLES_DUAL (string:"B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"): Available race vehicles (classnames) for dual race mode.

Map markers which must be placed inside your mission:

* DYN_RACE_Start_Position_X: Start positions. Atleast the same amount of start positions as players should be available. !!!Keep in mind the distance between the start point when using larger vehicles!!!
* DYN_Checkpoint_X: Checkpoints. Start with 1 and increase to x. Do not create the finish line as a checkpoint.

Map triggers which must be placed inside your mission: (see function documentation for advanced ussage):

* Create 1 trigger which acts as the finish line named: DYN_RACE_FINISHTRIGGER. No onActs or conditions need to be set.

Option triggers:
* ["marker_1", "marker_2", ...] call DYN_RACE_CreateExplosion: Create one ore multiple explosions. Explosions are globally saved to prevent multiple players from triggering multiple explosions.
* DYN_RACE_SpawnVehicleMove: See server\functions\SpawnVehicleMove.sqf for doc. Spawns traffic

Terms of Use
------------
http://creativecommons.org/licenses/by-nc-sa/3.0/
If you are planning on modding/adding contents to this mod please contact me first. If possible I'd like to implement as many features in this mod as possible instead of creating different versions.

Made possible by / credits:
---------------------------
-BTK: BTK spectator script
-Kronzky: String functions
-Team Dynamics: Testing
-JoSchaap, JW Custom & Killzone_Kid: Testing/troubleshooting and help with scripting.
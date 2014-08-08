Dynamics Race Script
================================
Author: m1ndst0rm (joopselen@gmail.com)

Description:
Advanced race script for Arma 3. With this script you can easily make your own multilayer race missions in arma 3.
It will mainly provide these race types:

* Race without damage
* Race with damage 
* Race with driver & gunner without damage (only allowed to shoot in front of vehicle, hits slow down opponents)
* Race with driver & gunner with damage. 
* Cops & Robbers: 1 (or more depending on player amount) armed vehicle(s) with 2 players are robbers. Rest is police and must arrest (halt) them before robbers reach the finish.
* Cat & Mouse: Teams of 2 players: Each player has a mice (slower vehicle) and a cats (faster). Cats must prevent the mice from opponent teams from finishing. If more then 12 players teams get larger.
* Driver, gunner & commander race.
* Cops & Robbers + Commander: Same as cops & robbers but with commander.
* Cat & Mouse + Commander: Same as cat & mouse but with commander.
* (WIP) Heli chase: drivers must run from helies.

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
- [x] Damage enabled/disabled
- [x] Trigger: Explosions
- [x] Trigger: Start music
- [x] Trigger: Enable/Disable must stay on road
- [x] Trigger: Spawning of traffic
- [x] Trigger: Enable or disable guns
- [x] 2nd Race type: Each vehicle gets a driver and gunner.
- [x] Multiple laps
- [x] Commander mode: Help your team or obstruct the enemy as a commander by placing explosion, repairing vehicles, giving boos or even taking control of certain enemy vehicles fora while.

And more.

TODO / WIP:
- Single & Dual race: damage balance
- Cops & Robbers: Robbers screen fuzz if almost arrest?
- Heli chase: Everything
- Figure out what to do with vehicle destruction
- Fix a decent vehicle reset position based. (Now if muststayonraod lastroadpos, but if not muststayonroad how to reset when we have no clue about track.

Usage
-----

Either use the provided example mission or replace it by your own version. 
In case you add your own:

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
* DYN_RACE_LAPS (int: 1): Amount of laps. 1 Means a to b race.
* DYN_RACE_MUST_STAY_ON_ROAD (bool: true): Global starting value. If true vehicles will be reset after leaving the road for 20 seconds.
* DYN_RACE_AVAILABLE_VEHICLES_SINGLE (array:string:all vehicles without guns): Available race vehicles (classnames) for single race mode.
* DYN_RACE_AVAILABLE_VEHICLES_DUAL (array:string:all vehicles with guns): Available race vehicles (classnames) for dual race mode.

Map markers which must be placed inside your mission:

* DYN_RACE_Respawn: Respawn location for racers
* Create 1 Start position named DYN_RACE_Start_Position, further start positions will be automatically generated (64 positions)
* Alternatively you can create your own start positions: DYN_RACE_Start_Position_X:  At least the same amount of start positions as players should be available. !!!Keep in mind the distance between the start point when using larger vehicles!!!
* DYN_Checkpoint_X: Checkpoints: start with DYN_Checkpoint_1 and increment. Finish checkpoint will automatically be created. (See below: required triggers).
	-Make sure they are pointing in the right direction
	-If 1 lap (a->b race) make the first checkpoint BEHIND the start position. This is needed for player position calculation
	-If more laps the first checkpoints can simply be the "first checkpoint". The finish line will act as the position calculation point.
	-Look at checkpoints.jpg for a "how to place checkpoints".

Map triggers which must be placed inside your mission: (see function documentation for advanced usage):

* Create 1 trigger which acts as the finish line named: DYN_RACE_FINISHTRIGGER. No onActs or conditions need to be set.

Optional triggers:
* ["marker_1", "marker_2", ...] call DYN_fnc_CreateExplosion: Create one ore multiple explosions. Explosions are globally saved to prevent multiple players from triggering multiple explosions.
* DYN_fnc_SpawnVehicleMove: See server\functions\SpawnVehicleMove.sqf for doc. Spawns traffic
* Mustsayonraod: onAct: DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = false (or true)   condition: this && vehicle player in thislist

F.A.Q.
------
Q: I found a bug
A: Please post in on steam forum or the github page and describe it the best way you can

Q: Are you looking for people to help out
A: Yes. If you are an experienced scripter, modder or modeller you are welcome to join the club.


Looking for
-----------
Scripters, modders, modellers & people with decent rigs to shoot some nice fotage.

Terms of Use
------------
http://creativecommons.org/licenses/by-nc-sa/3.0/
If you are planning on modding/adding contents to this mod please contact me first. If possible I'd like to implement as many features in this mod as possible instead of creating different versions.

Made possible by / credits:
---------------------------
* Team Dynamics: Testing
* Killzone_Kid: For his help with tons of things. Without him I would have spend a lot more time creating this script.
* Kronzky: String functions
* JoSchaap, JW Custom and many others from arma3 scripting forum: Testing/troubleshooting and help with scripting.
* Chillroy: Testing
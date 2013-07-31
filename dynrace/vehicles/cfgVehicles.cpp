#define true	1
#define false	0

#define private		0
#define protected		1
#define public		2

#define TEast		0
#define TWest		1
#define TGuerrila		2
#define TCivilian		3
#define TSideUnknown		4
#define TEnemy		5
#define TFriendly		6
#define TLogic		7

enum {
	DESTRUCTENGINE = 2,
	DESTRUCTDEFAULT = 6,
	DESTRUCTWRECK = 7,
	DESTRUCTTREE = 3,
	DESTRUCTTENT = 4,
	STABILIZEDINAXISX = 1,
	STABILIZEDINAXESXYZ = 4,
	STABILIZEDINAXISY = 2,
	STABILIZEDINAXESBOTH = 3,
	DESTRUCTNO = 0,
	STABILIZEDINAXESNONE = 0,
	DESTRUCTMAN = 5,
	DESTRUCTBUILDING = 1,
};

class DefaultEventhandlers;	// External class reference

class CfgPatches {
	class A3_Soft_F_Offroad_01 {
		units[] = {"C_Offroad_01_F", "C_Offroad_01_PA_F", "C_Offroad_01_RP_F", "I_G_offroad", "c_offroad_01_armed", "I_G_offroad_armed"};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Soft_F"};
	};
};
class WeaponFireGun;	// External class reference
class WeaponCloudsGun;	// External class reference
class WeaponFireMGun;	// External class reference
class WeaponCloudsMGun;	// External class reference

class CfgVehicles {
	class LandVehicle;	// External class reference
	
	class Car : LandVehicle {
		class HitPoints;	// External class reference
		class NewTurret;	// External class reference
	};
	
	class Car_F : Car {
		class Turrets {
			class MainTurret : NewTurret {
				class ViewOptics;	// External class reference
			};
		};
		
		class HitPoints {
			class HitLFWheel;	// External class reference
			class HitLBWheel;	// External class reference
			class HitRFWheel;	// External class reference
			class HitRBWheel;	// External class reference
			class HitBody;	// External class reference
			
			class HitGlass1 {};
			class HitGlass2;	// External class reference
		};
		class EventHandlers;	// External class reference
		class AnimationSources;	// External class reference
	};
	
	class Offroad_Base : Car_F {
		mapSize = 6.12;
		_generalMacro = "Offroad_01_base_F";
		displayName = "$STR_A3_CfgVehicles_Offroad_Base0";
		nameSound = "veh_car";
		
		class Library {
			libTextDesc = "$STR_A3_CfgVehicles_Offroad_Base_Library0";
		};
		model = "\A3\soft_f\offroad\offroad";
		picture = "\A3\soft_f\offroad\Data\UI\offroad_base_CA.paa";
		Icon = "\A3\soft_f\offroad\Data\UI\map_offroad_CA.paa";
		accuracy = 0.25;	// accuracy needed to recognize type of this target
		transportSoldier = 5;
		transportMaxBackpacks = 0;
		armor = 32;
		cost = 50000;
		
		class TransportItems {
			class _xx_FirstAidKit {
				name = "FirstAidKit";
				count = 6;
			};
		};
		hiddenSelections[] = {"camo", "camo2"};
		hiddenSelectionsTextures[] = {"\A3\soft_f\offroad\data\offroad_ext_co.paa", "\A3\soft_f\offroad\data\offroad_ext_co.paa"};
		
		class AnimationSources : AnimationSources {
			class Doors {
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
			
			class Proxy {
				source = "user";
				animPeriod = 1;
				initPhase = 1;
			};
			
			class Beacons {
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
			
			class Destruct {
				source = "user";
				animPeriod = 0;
				initPhase = 1;
			};
		};
		
		class HitPoints : HitPoints {
			class HitLFWheel : HitLFWheel {
				armor = 0.125;
				passThrough = false;
			};
			
			class HitLF2Wheel : HitLBWheel {
				armor = 0.125;
				passThrough = false;
			};
			
			class HitRFWheel : HitRFWheel {
				armor = 0.125;
				passThrough = false;
			};
			
			class HitRF2Wheel : HitRBWheel {
				armor = 0.125;
				passThrough = false;
			};
			
			class HitFuel {
				armor = 0.5;
				material = -1;
				name = "palivo";
				visual = "";
				passThrough = 0.2;
			};
			
			class HitEngine {
				armor = 0.5;
				material = -1;
				name = "motor";
				visual = "";
				passThrough = 0.2;
			};
			
			class HitBody : HitBody {
				visual = "camo";
				passThrough = true;
			};
			
			class HitGlass1 : HitGlass1 {
				armor = 0.25;
			};
			
			class HitGlass2 : HitGlass2 {
				armor = 0.25;
			};
		};
		steerAheadSimul = 0.5;
		steerAheadPlan = 0.35;
		predictTurnPlan = 0.8;
		predictTurnSimul = 0.6;
		precision = 10;
		brakeDistance = 50;	// vehicle movement precision
		turnCoef = 3.5;
		driverAction = "driver_offroad01";
		cargoAction[] = {"passenger_low01", "passenger_flatground_leanleft", "passenger_flatground_leanright", "passenger_flatground_crosslegs", "passenger_flatground_leanleft"};
		getInAction = "GetInLow";
		getOutAction = "GetOutLow";
		cargoGetInAction[] = {"GetInLow"};
		cargoGetOutAction[] = {"GetOutLow"};
		fireResistance = 5;
		wheelDestroyRadiusCoef = 0.75;
		soundGetIn[] = {"A3\Sounds_F\vehicles\soft\offroad\offroad-int-openclose.wav", db0, 1};
		soundGetOut[] = {"A3\Sounds_F\vehicles\soft\offroad\offroad-int-openclose.wav", db0, 1, 40};
		soundDammage[] = {"", 0.562341, 1};
		soundEngineOnInt[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_start.wav", 1.0, 1.0};
		soundEngineOnExt[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_start.wav", 1.0, 1.0, 200};
		soundEngineOffInt[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_stop.wav", 1.0, 1.0};
		soundEngineOffExt[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_stop.wav", 1.0, 1.0, 200};
		
		class Sounds {
			class Idle_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_idle.wav", db0, 1, 100};
				frequency = "0.95	+	((rpm/	3500) factor[(100/	3500),(600/	3500)])*0.15";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(100/	3500),(200/	3500)])	*	((rpm/	3500) factor[(530/	3500),(380/	3500)]))";
			};
			
			class Engine {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_2.wav", db0, 1, 200};
				frequency = "0.9	+	((rpm/	3500) factor[(380/	3500),(840/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(380/	3500),(530/	3500)])	*	((rpm/	3500) factor[(850/	3500),(650/	3500)]))";
			};
			
			class Engine1_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_3.wav", db0, 1, 225};
				frequency = "0.9	+	((rpm/	3500) factor[(660/	3500),(1130/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(650/	3500),(840/	3500)])	*	((rpm/	3500) factor[(1130/	3500),(940/	3500)]))";
			};
			
			class Engine2_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_4.wav", db0, 1, 250};
				frequency = "0.9	+	((rpm/	3500) factor[(930/	3500),(1340/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(1000/	3500),(1130/	3500)])	*	((rpm/	3500) factor[(1340/	3500),(1200/	3500)]))";
			};
			
			class Engine3_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_6.wav", db0, 1, 275};
				frequency = "0.95	+	((rpm/	3500) factor[(1200/	3500),(1620/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(1100/	3500),(1300/	3500)])	*	((rpm/	3500) factor[(1600/	3500),(1400/	3500)]))";
			};
			
			class Engine4_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_8.wav", db0, 1, 300};
				frequency = "0.95	+	((rpm/	3500) factor[(1400/	3500),(2000/	3500)]) *0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(1300/	3500),(1600/	3500)])	*	((rpm/	3500) factor[(2000/	3500),(1700/	3500)]))";
			};
			
			class Engine5_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_9.wav", db0, 1, 325};
				frequency = "0.95	+	((rpm/	3500) factor[(1700/	3500),(2250/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(1600/	3500),(2000/	3500)])	*	((rpm/	3500) factor[(2250/	3500),(2050/	3500)]))";
			};
			
			class Engine6_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_11.wav", db0, 1, 350};
				frequency = "0.95	+	((rpm/	3500) factor[(2050/	3500),(2600/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(1900/	3500),(2250/	3500)])	*	((rpm/	3500) factor[(2600/	3500),(2400/	3500)]))";
			};
			
			class Engine7_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_12.wav", db0, 1, 375};
				frequency = "0.95	+	((rpm/	3500) factor[(2400/	3500),(3050/	3500)])*0.2";
				volume = "engineOn*camPos*(((rpm/	3500) factor[(2300/	3500),(2600/	3500)])	*	((rpm/	3500) factor[(3050/	3500),(2650/	3500)]))";
			};
			
			class Engine8_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_14.wav", db0, 1, 400};
				frequency = "0.95	+	((rpm/	3500) factor[(2650/	3500),(3500/	3500)])*0.2";
				volume = "engineOn*camPos*((rpm/	3500) factor[(2400/	3500),(3200/	3500)])";
			};
			
			class IdleThrust {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_idle_exhaust.wav", db0, 1, 200};
				frequency = "0.95	+	((rpm/	3500) factor[(100/	3500),(600/	3500)])*0.15";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(100/	3500),(200/	3500)])	*	((rpm/	3500) factor[(530/	3500),(380/	3500)]))";
			};
			
			class EngineThrust {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_2_exhaust.wav", db0, 1, 250};
				frequency = "0.9	+	((rpm/	3500) factor[(380/	3500),(840/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(380/	3500),(530/	3500)])	*	((rpm/	3500) factor[(850/	3500),(650/	3500)]))";
			};
			
			class Engine1_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_3_exhaust.wav", db0, 1, 275};
				frequency = "0.9	+	((rpm/	3500) factor[(660/	3500),(1130/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(650/	3500),(840/	3500)])	*	((rpm/	3500) factor[(1130/	3500),(940/	3500)]))";
			};
			
			class Engine2_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_4_exhaust.wav", db0, 1, 300};
				frequency = "0.9	+	((rpm/	3500) factor[(930/	3500),(1340/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1000/	3500),(1130/	3500)])	*	((rpm/	3500) factor[(1340/	3500),(1200/	3500)]))";
			};
			
			class Engine3_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_6_exhaust.wav", db0, 1, 325};
				frequency = "0.95	+	((rpm/	3500) factor[(1200/	3500),(1620/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1100/	3500),(1300/	3500)])	*	((rpm/	3500) factor[(1600/	3500),(1400/	3500)]))";
			};
			
			class Engine4_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_8_exhaust.wav", db0, 1, 350};
				frequency = "0.95	+	((rpm/	3500) factor[(1400/	3500),(2000/	3500)]) *0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1300/	3500),(1600/	3500)])	*	((rpm/	3500) factor[(2000/	3500),(1700/	3500)]))";
			};
			
			class Engine5_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_9_exhaust.wav", db0, 1, 375};
				frequency = "0.95	+	((rpm/	3500) factor[(1700/	3500),(2250/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1600/	3500),(2000/	3500)])	*	((rpm/	3500) factor[(2250/	3500),(2050/	3500)]))";
			};
			
			class Engine6_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_11_exhaust.wav", db0, 1, 400};
				frequency = "0.95	+	((rpm/	3500) factor[(2050/	3500),(2600/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1900/	3500),(2250/	3500)])	*	((rpm/	3500) factor[(2600/	3500),(2400/	3500)]))";
			};
			
			class Engine7_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_12_exhaust.wav", db0, 1, 425};
				frequency = "0.95	+	((rpm/	3500) factor[(2400/	3500),(3050/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(2300/	3500),(2600/	3500)])	*	((rpm/	3500) factor[(3050/	3500),(2650/	3500)]))";
			};
			
			class Engine8_Thrust_ext {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_ext_rpm_14_exhaust.wav", db0, 1, 450};
				frequency = "0.95	+	((rpm/	3500) factor[(2650/	3500),(3500/	3500)])*0.2";
				volume = "engineOn*camPos*(0.4+(0.6*(thrust factor[0.1,1])))*((rpm/	3500) factor[(2400/	3500),(3200/	3500)])";
			};
			
			class Idle_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_idle.wav", db-10, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(100/	3500),(600/	3500)])*0.15";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(100/	3500),(200/	3500)])	*	((rpm/	3500) factor[(530/	3500),(380/	3500)]))";
			};
			
			class Engine_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_2.wav", 0.1, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(380/	3500),(840/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(380/	3500),(530/	3500)])	*	((rpm/	3500) factor[(850/	3500),(650/	3500)]))";
			};
			
			class Engine1_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_3.wav", 0.1, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(660/	3500),(1130/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(650/	3500),(840/	3500)])	*	((rpm/	3500) factor[(1130/	3500),(940/	3500)]))";
			};
			
			class Engine2_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_4.wav", 0.1, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(930/	3500),(1340/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(1000/	3500),(1130/	3500)])	*	((rpm/	3500) factor[(1340/	3500),(1200/	3500)]))";
			};
			
			class Engine3_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_6.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1200/	3500),(1620/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(1100/	3500),(1300/	3500)])	*	((rpm/	3500) factor[(1600/	3500),(1400/	3500)]))";
			};
			
			class Engine4_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_8.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1400/	3500),(2000/	3500)]) *0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(1300/	3500),(1600/	3500)])	*	((rpm/	3500) factor[(2000/	3500),(1700/	3500)]))";
			};
			
			class Engine5_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_9.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1700/	3500),(2250/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(1600/	3500),(2000/	3500)])	*	((rpm/	3500) factor[(2250/	3500),(2050/	3500)]))";
			};
			
			class Engine6_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_11.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2050/	3500),(2600/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(1900/	3500),(2250/	3500)])	*	((rpm/	3500) factor[(2600/	3500),(2400/	3500)]))";
			};
			
			class Engine7_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_12.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2400/	3500),(3050/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(((rpm/	3500) factor[(2300/	3500),(2600/	3500)])	*	((rpm/	3500) factor[(3050/	3500),(2650/	3500)]))";
			};
			
			class Engine8_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_14.wav", 0.1, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2650/	3500),(3500/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*((rpm/	3500) factor[(2400/	3500),(3200/	3500)])";
			};
			
			class IdleThrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_idle_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(100/	3500),(600/	3500)])*0.15";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(100/	3500),(200/	3500)])	*	((rpm/	3500) factor[(530/	3500),(380/	3500)]))";
			};
			
			class EngineThrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_2_exhaust.wav", db0, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(380/	3500),(840/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(380/	3500),(530/	3500)])	*	((rpm/	3500) factor[(850/	3500),(650/	3500)]))";
			};
			
			class Engine1_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_3_exhaust.wav", db0, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(660/	3500),(1130/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(650/	3500),(840/	3500)])	*	((rpm/	3500) factor[(1130/	3500),(940/	3500)]))";
			};
			
			class Engine2_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_4_exhaust.wav", db0, 1};
				frequency = "0.9	+	((rpm/	3500) factor[(930/	3500),(1340/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1000/	3500),(1130/	3500)])	*	((rpm/	3500) factor[(1340/	3500),(1200/	3500)]))";
			};
			
			class Engine3_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_6_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1200/	3500),(1620/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1100/	3500),(1300/	3500)])	*	((rpm/	3500) factor[(1600/	3500),(1400/	3500)]))";
			};
			
			class Engine4_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_8_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1400/	3500),(2000/	3500)]) *0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1300/	3500),(1600/	3500)])	*	((rpm/	3500) factor[(2000/	3500),(1700/	3500)]))";
			};
			
			class Engine5_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_9_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(1700/	3500),(2250/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1600/	3500),(2000/	3500)])	*	((rpm/	3500) factor[(2250/	3500),(2050/	3500)]))";
			};
			
			class Engine6_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_11_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2050/	3500),(2600/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(1900/	3500),(2250/	3500)])	*	((rpm/	3500) factor[(2600/	3500),(2400/	3500)]))";
			};
			
			class Engine7_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_12_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2400/	3500),(3050/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*(((rpm/	3500) factor[(2300/	3500),(2600/	3500)])	*	((rpm/	3500) factor[(3050/	3500),(2650/	3500)]))";
			};
			
			class Engine8_Thrust_int {
				sound[] = {"A3\Sounds_F\vehicles\soft\offroad\landrover_int_rpm_14_exhaust.wav", db0, 1};
				frequency = "0.95	+	((rpm/	3500) factor[(2650/	3500),(3500/	3500)])*0.2";
				volume = "engineOn*(1-camPos)*(0.4+(0.6*(thrust factor[0.1,1])))*((rpm/	3500) factor[(2400/	3500),(3200/	3500)])";
			};
			
			class Movement {
				sound = "soundEnviron";
				frequency = "1";
				volume = "0";
			};
			
			class TiresRockOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext_tires_rock_final_2.wav", 0.1, 1.0, 120};
				frequency = "1";
				volume = "camPos*rock*(speed factor[2, 20])";
			};
			
			class TiresSandOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext-tires-sand1.wav", 0.1, 1.0, 120};
				frequency = "1";
				volume = "camPos*sand*(speed factor[2, 20])";
			};
			
			class TiresGrassOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext_tires_road_final_1.wav", 0.1, 1.0, 120};
				frequency = "1";
				volume = "camPos*grass*(speed factor[2, 20])";
			};
			
			class TiresMudOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext-tires-mud2.wav", 0.1, 1.0, 120};
				frequency = "1";
				volume = "camPos*mud*(speed factor[2, 20])";
			};
			
			class TiresGravelOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext_tires_rock_final_2.wav", db-10, 1.0, 120};
				frequency = "1";
				volume = "camPos*gravel*(speed factor[2, 20])";
			};
			
			class TiresAsphaltOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\ext_tires_road_final_1.wav", 0.281838, 1.0, 120};
				frequency = "1";
				volume = "camPos*asphalt*(speed factor[2, 20])";
			};
			
			class NoiseOut {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\noise_soft_ext_1.wav", 0.1, 1.0, 120};
				frequency = "1";
				volume = "camPos*(damper0 max 0.02)*(speed factor[0, 8])";
			};
			
			class TiresRockIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int_tires_rock_final_2.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(1-camPos)*rock*(speed factor[2, 20])";
			};
			
			class TiresSandIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int-tires-sand2.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(1-camPos)*sand*(speed factor[2, 20])";
			};
			
			class TiresGrassIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int_tires_road_final_1.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(1-camPos)*grass*(speed factor[2, 20])";
			};
			
			class TiresMudIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int-tires-mud2.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(1-camPos)*mud*(speed factor[2, 20])";
			};
			
			class TiresGravelIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int_tires_rock_final_2.wav", db-37, 1.0};
				frequency = "1";
				volume = "(1-camPos)*gravel*(speed factor[2, 20])";
			};
			
			class TiresAsphaltIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\tires\int_tires_road_final_1.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(1-camPos)*asphalt*(speed factor[2, 20])";
			};
			
			class NoiseIn {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\noise_soft_int_1.wav", 0.0177828, 1.0};
				frequency = "1";
				volume = "(damper0 max 0.03)*(speed factor[0, 8])*(1-camPos)";
			};
			
			class breaking_ext_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(LongSlipDrive Factor[-0.15, -0.3])*(Speed Factor[2, 10])";
			};
			
			class acceleration_ext_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(LongSlipDrive Factor[0.15, 0.3])*(Speed Factor[10, 0])";
			};
			
			class turn_left_ext_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(latSlipDrive Factor[0.15, 0.3])*(Speed Factor[0, 10])";
			};
			
			class turn_right_ext_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(latSlipDrive Factor[-0.15, -0.3])*(Speed Factor[0, 10])";
			};
			
			class breaking_ext_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(LongSlipDrive Factor[-0.15, -0.3])*(Speed Factor[2, 10])";
			};
			
			class acceleration_ext_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(LongSlipDrive Factor[0.15, 0.3])*(Speed Factor[10, 0])";
			};
			
			class turn_left_ext_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(latSlipDrive Factor[0.15, 0.3])*(Speed Factor[0, 10])";
			};
			
			class turn_right_ext_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02.wav", db0, 1, 100};
				frequency = 1;
				volume = "engineOn*camPos*(latSlipDrive Factor[-0.15, -0.3])*(Speed Factor[0, 10])";
			};
			
			class breaking_int_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(LongSlipDrive Factor[-0.15, -0.3])*(Speed Factor[2, 6])";
			};
			
			class acceleration_int_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(LongSlipDrive Factor[0.15, 0.3])*(Speed Factor[10, 0])";
			};
			
			class turn_left_int_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(latSlipDrive Factor[0.15, 0.3])*(Speed Factor[0, 10])";
			};
			
			class turn_right_int_road {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(latSlipDrive Factor[-0.15, -0.3])*(Speed Factor[0, 10])";
			};
			
			class breaking_int_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(LongSlipDrive Factor[-0.15, -0.3])*(Speed Factor[2, 6])";
			};
			
			class acceleration_int_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(LongSlipDrive Factor[0.15, 0.3])*(Speed Factor[10, 0])";
			};
			
			class turn_left_int_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(latSlipDrive Factor[0.15, 0.3])*(Speed Factor[0, 10])";
			};
			
			class turn_right_int_dirt {
				sound[] = {"A3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int.wav", db0, 1};
				frequency = 1;
				volume = "engineOn*(1-camPos)*(latSlipDrive Factor[-0.15, -0.3])*(Speed Factor[0, 10])";
			};
		};
		
		class RenderTargets {
			class LeftMirror {
				renderTarget = "rendertarget0";
				
				class CameraView1 {
					pointPosition = "PIP0_pos";
					pointDirection = "PIP0_dir";
					renderQuality = 2;
					renderVisionMode = 0;
					fov = 0.7;
				};
			};
			
			class IntMirror {
				renderTarget = "rendertarget1";
				
				class CameraView1 {
					pointPosition = "PIP1_pos";
					pointDirection = "PIP1_dir";
					renderQuality = 2;
					renderVisionMode = 0;
					fov = 0.7;
				};
			};
		};
		driverLeftHandAnimName = "drivewheel";
		driverRightHandAnimName = "drivewheel";
		thrustDelay = 0.1;
		brakeIdleSpeed = 0.78;
		maxSpeed = 160;	// max speed on level road, km/h
		fuelCapacity = 45;
		wheelCircumference = 2.805;
		antiRollbarForceCoef = 0;
		antiRollbarForceLimit = 40;
		antiRollbarSpeedMin = 2;
		antiRollbarSpeedMax = 50;
		idleRpm = 900;
		redRpm = 3500;
		
		class complexGearbox {
			GearboxRatios[] = {"R1", -5.367, "N", 0, "D1", 5.367, "D2", 3.67, "D3", 2.238, "D4", 1.00, "D5", 0.8};
			TransmissionRatios[] = {"High", 5.0};
			gearBoxMode = "auto";
			moveOffGear = 1;
			driveString = "D";
			neutralString = "N";
			reverseString = "R";
			gearUpMaxCoef = 0.8;
			gearDownMaxCoef = 0.5;
			gearUpMinCoef = 0.45;
			gearDownMinCoef = 0.15;
			transmissionDelay = 1;
		};
		simulation = "carx";
		dampersBumpCoef = 3.0;
		differentialType = "rear_limited";
		frontRearSplit = 0.5;
		frontBias = 1.5;
		rearBias = 1.5;
		centreBias = 1.3;
		clutchStrength = 200.0;
		enginePower = 100;
		maxOmega = 900;
		peakTorque = 900;
		dampingRateFullThrottle = 0.1;
		dampingRateZeroThrottleClutchEngaged = 0.35;
		dampingRateZeroThrottleClutchDisengaged = 0.35;
		torqueCurve[] = {{0.0, 0.0}, {0.25, 0.65}, {0.3, 0.8}, {0.5, 0.95}, {0.7, 1.0}, {0.8, 0.9}, {0.9, 0.8}, {1.0, 0.5}};
		changeGearMinEffectivity[] = {0.95, 0.15, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95};
		switchTime = 0.05;
		latency = 0.2;
		
		class Wheels {
			class LF {
				boneName = "wheel_1_1_damper";
				steering = 1;
				side = "left";
				center = "wheel_1_1_axis";
				boundary = "wheel_1_1_bound";
				width = 0.5;
				mass = 30;
				MOI = 2.8;
				dampingRate = 0.5;
				maxBrakeTorque = 6000;
				maxHandBrakeTorque = 6000;
				suspTravelDirection[] = {0, -1, 0};
				suspForceAppPointOffset = "wheel_1_1_axis";
				tireForceAppPointOffset = "wheel_1_1_axis";
				maxCompression = 0.3;
				mMaxDroop = 0.1;
				sprungMass = 300;
				springStrength = 50000;
				springDamperRate = 3400;
				longitudinalStiffnessPerUnitGravity = 10000;
				latStiffX = 25;
				latStiffY = 180;
				frictionVsSlipGraph[] = {{0, 1}, {0.5, 1.0}, {1, 1}};
			};
			
			class LR : LF {
				boneName = "wheel_1_2_damper";
				steering = 0;
				center = "wheel_1_2_axis";
				boundary = "wheel_1_2_bound";
				suspForceAppPointOffset = "wheel_1_2_axis";
				tireForceAppPointOffset = "wheel_1_2_axis";
				maxHandBrakeTorque = 0;
				frictionVsSlipGraph[] = {{0, 1}, {0.5, 0.75}, {1, 0.5}};
			};
			
			class RF : LF {
				boneName = "wheel_2_1_damper";
				center = "wheel_2_1_axis";
				boundary = "wheel_2_1_bound";
				suspForceAppPointOffset = "wheel_2_1_axis";
				tireForceAppPointOffset = "wheel_2_1_axis";
				steering = 1;
				side = "right";
				frictionVsSlipGraph[] = {{0, 1}, {0.5, 1.0}, {1, 1}};
			};
			
			class RR : RF {
				boneName = "wheel_2_2_damper";
				steering = 0;
				center = "wheel_2_2_axis";
				boundary = "wheel_2_2_bound";
				suspForceAppPointOffset = "wheel_2_2_axis";
				tireForceAppPointOffset = "wheel_2_2_axis";
				maxHandBrakeTorque = 0;
				frictionVsSlipGraph[] = {{0, 1}, {0.5, 0.75}, {1, 0.5}};
			};
		};
		
		class Exhausts {
			class Exhaust1 {
				position = "exhaust1_pos";
				direction = "exhaust1_dir";
				effect = "ExhaustEffectOffroad";
			};
			
			class Exhaust2 {
				position = "exhaust2_pos";
				direction = "exhaust2_dir";
				effect = "ExhaustEffectOffroad";
			};
		};
		
		class Damage {
			tex[] = {};
			mat[] = {"A3\soft_F\Offroad\Data\offroad_ext.rvmat", "A3\soft_F\Offroad\Data\offroad_ext_damage.rvmat", "A3\soft_F\Offroad\Data\offroad_ext_destruct.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_base.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_base_damage.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_base_destruct.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_board.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_board_damage.rvmat", "A3\soft_F\Offroad\Data\Offroad_int_board_destruct.rvmat", "A3\soft_F\Offroad\Data\Offroad_ext_plastic.rvmat", "A3\soft_F\Offroad\Data\Offroad_ext_damage.rvmat", "A3\soft_F\Offroad\Data\Offroad_ext_destruct.rvmat", "A3\data_f\glass_veh.rvmat", "A3\data_f\Glass_veh_damage.rvmat", "A3\data_f\Glass_veh_damage.rvmat", "A3\data_f\glass_veh_int.rvmat", "A3\data_f\Glass_veh_damage.rvmat", "A3\data_f\Glass_veh_damage.rvmat"};
		};
		
		class Reflectors {
			class Left {
				color[] = {0.75, 0.75, 0.85};
				ambient[] = {0.0005, 0.0005, 0.0005};
				position = "L svetlo";
				direction = "konec L svetla";
				hitpoint = "L svetlo";
				selection = "L svetlo";
				size = 1;
				innerAngle = 35;
				outerAngle = 180;
				coneFadeCoef = 40;
				intensity = 400;
				useFlare = 0;
				dayLight = 0;
				flareSize = 0.75;
				
				class Attenuation {
					start = 1;
					constant = 2.0;
					linear = 0.0;
					quadratic = 15.0;
				};
			};
			
			class Right : Left {
				position = "P svetlo";
				direction = "konec P svetla";
				hitpoint = "P svetlo";
				selection = "P svetlo";
			};
			
			class Right2 : Right {
				position = "R_light_flare";
				useFlare = 1;
			};
			
			class Left2 : Left {
				position = "L_light_flare";
				useFlare = 1;
			};
		};
		aggregateReflectors[] = {{"Left", "Right", "Left2", "Right2"}};
	};

	class DYN_OffRoad_Police : Offroad_Base
	{
		displayname = "Police car";
		
		_generalMacro = "C_Offroad_01_F";
		scope = public;
		side = TCivilian;
		faction = CIV_F;
		accuracy = 1.25;	// accuracy needed to recognize type of this target
		
		class Turrets {};
		
		class EventHandlers : EventHandlers {
			init = "(_this select 0) animate [""HidePolice"", 0];(_this select 0) setObjectTexture [0,""\A3\soft_F\Offroad_01\Data\Offroad01_ext_BASE02_CO.paa""];(_this select 0) setObjectTexture [1,""\A3\soft_F\Offroad_01\Data\Offroad01_ext_BASE03_CO.paa""]; (_this select 0) execVM ""dynrace\vehicles\scripts.sqf""";
		};
	};
};


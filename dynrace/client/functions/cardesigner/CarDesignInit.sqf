_temp = ["Land_Ancient_Wall_4m_F", "Land_Ancient_Wall_8m_F", "Land_BarGate_F", "Land_Canal_Wall_10m_F", "Land_Canal_Wall_D_center_F", "Land_Canal_Wall_D_left_F", "Land_Canal_Wall_D_right_F", "Land_Canal_Wall_Stairs_F", "Land_Canal_WallSmall_10m_F", "Land_City_4m_F", "Land_City_8m_F", "Land_City_8mD_F", "Land_City_Gate_F", "Land_City_Pillar_F", "Land_City2_4m_F", "Land_City2_8m_F", "Land_City2_8mD_F", "Land_City2_PillarD_F", "Land_CncBarrier_F", "Land_CncBarrier_stripes_F", "Land_CncBarrierMedium_F", "Land_CncBarrierMedium4_F", "Land_CncShelter_F", "Land_CncWall1_F", "Land_CncWall4_F", "Land_Concrete_SmallWall_4m_F", "Land_Concrete_SmallWall_8m_F", "Land_Crash_barrier_F", "Land_IndFnc_3_D_F", "Land_IndFnc_3_F", "Land_IndFnc_3_Hole_F", "Land_IndFnc_9_F", "Land_IndFnc_Corner_F", "Land_IndFnc_Pole_F", "Land_Mil_ConcreteWall_F", "Land_Mil_WallBig_4m_F", "Land_Mil_WallBig_Corner_F", "Land_Mil_WallBig_Gate_F", "Land_Mil_WiredFence_F", "Land_Mil_WiredFence_Gate_F", "Land_Mil_WiredFenceD_F", "Land_Mound01_8m_F", "Land_Mound02_8m_F", "Land_Net_Fence_4m_F", "Land_Net_Fence_8m_F", "Land_Net_Fence_Gate_F", "Land_Net_Fence_pole_F", "Land_Net_FenceD_8m_F", "Land_New_WiredFence_5m_F", "Land_New_WiredFence_10m_Dam_F", "Land_New_WiredFence_10m_F", "Land_New_WiredFence_pole_F", "Land_Pipe_fence_4m_F", "Land_Pipe_fence_4mNoLC_F", "Land_PipeWall_concretel_8m_F", "Land_Rampart_F", "Land_RedWhitePole_F", "Land_Slums01_8m", "Land_Slums01_pole", "Land_Slums02_4m", "Land_Slums02_pole", "Land_SportGround_fence_F", "Land_Stone_4m_F", "Land_Stone_8m_F", "Land_Stone_8mD_F", "Land_Stone_Gate_F", "Land_Stone_pillar_F", "Land_Wall_IndCnc_2deco_F", "Land_Wall_IndCnc_4_D_F", "Land_Wall_IndCnc_4_F", "Land_Wall_IndCnc_End_2_F", "Land_Wall_IndCnc_Pole_F", "Land_Wall_Tin_4", "Land_Wall_Tin_4_2", "Land_Wall_Tin_Pole", "Land_Wired_Fence_4m_F", "Land_Wired_Fence_4mD_F", "Land_Wired_Fence_8m_F", "Land_Wired_Fence_8mD_F"];
DYN_RACE_CARDESIGN_PROTECTION = [];
{
	_class =  configFile >> "CfgVehicles" >> _x;
	if(isClass _class) then
	{
		DYN_RACE_CARDESIGN_PROTECTION set [count DYN_RACE_CARDESIGN_PROTECTION, _x];
	};
} foreach _temp;

player setVariable ["inCarDesigner", true];
DYN_RACE_DESIGNER_DEFAULTPOS = [1812, 5871,0];


DYN_RACE_HANDLER_CARDESIGN_KEYDOWN = (finddisplay 46) displayAddEventHandler ["keydown", "_this call DYN_fnc_CarDesignKeyDown;"];
DYN_RACE_CARDESIGN_CAM = "camera" camCreate DYN_RACE_DESIGNER_DEFAULTPOS;
DYN_RACE_CARDESIGN_CAM cameraeffect ["internal", "back"];

DYN_RACE_CARDESIGN_CURRENTCAR = (DYN_RACE_AVAILABLE_VEHICLES_SINGLE select 0) createVehicleLocal DYN_RACE_DESIGNER_DEFAULTPOS;
[] call DYN_fnc_CarDesignLoadCar;
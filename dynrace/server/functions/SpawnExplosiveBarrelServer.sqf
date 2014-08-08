/*
	Author: KillzoneKid
	Site: http://killzonekid.com/arma-scripting-tutorials-scripting-explosive-barrels/
	
	Description:
	Spawns an explosive barrel

	Parameter(s):
	Param1: Position

	Returns:
*/
if (isServer) then {
    [[0,_this select 0]] spawn {
        Barrel_BOOM = compileFinal '
            _ex = createVehicle [
                "R_TBG32V_F",
                _this modeltoworld [0,0,0],
                [],
                0,
                "CAN_COLLIDE"
            ];
            _ex setVectorDirAndUp [[0,0,1],[0,-1,0]];
            _ex setVelocity [0,0,-1000];
            deleteVehicle _this;
        ';
        _bars = [];
        {
            _b = createVehicle [
                "Land_MetalBarrel_F",
                [0,0,0],
                [],
                0,
                "NONE"
            ];
            _b setDir (_x select 0);
            _b setPos (_x select 1);
            _b setDamage 0.99;
            _b allowDamage false;
            _b addEventHandler ["Hit", {
                _b = _this select 0;
                if (alive _b) then {_b setDamage 0.99};
            }];
            _bars set [_forEachIndex, _b];
        } forEach _this;
        sleep 1;
        {
            _x setVariable ["#PosASL", getPosASL _x];
            _x addEventHandler ["EpeContact", {
                _b = _this select 0;
                if (
                    (getPosASL _b) distance (_b getVariable "#PosASL") > 0.1
                ) then {_b call Barrel_BOOM};
            }];
            _x addEventHandler ["Killed", {_this select 0 call Barrel_BOOM}];
            _x allowDamage true;
        } count _bars;
    };
};
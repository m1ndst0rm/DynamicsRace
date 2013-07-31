_vehicle = _this; 
_lightRed = [5, 0.5, 0.5];
_lightBlue = [0.5, 0.5, 5];
	
_lightleft = "#lightpoint" createVehicle getpos _vehicle;  
_lightleft setLightColor _lightRed;
_lightleft setLightBrightness 0.4; 
_lightleft setLightAmbient _lightRed;
_lightleft lightAttachObject [_vehicle, [-3, 0.8, 0]]; 
_lightleft setLightAttenuation [3, 0, 0, 0.6];

_lightright = "#lightpoint" createVehicle getpos _vehicle;  
_lightright setLightColor _lightBlue;
_lightright setLightBrightness 0.4; 
_lightright setLightAmbient _lightBlue;
_lightright lightAttachObject [_vehicle, [3, 0.8, 0]]; 
_lightright setLightAttenuation [3, 0, 0, 0.6];

_leftRed = true; 
while{ (alive _vehicle)} do 
{ 
	if(_leftRed) then 
	{ 
		_leftRed = false; 
		_lightleft setLightColor _lightRed;
		_lightleft setLightAmbient _lightRed;
		_lightright setLightColor _lightBlue;
		_lightright setLightAmbient _lightBlue;
		//playSound "AlarmCar";
	} 
	else 
	{ 
		_leftRed = true; 
		_lightleft setLightColor _lightBlue;
		_lightleft setLightAmbient _lightBlue;
		_lightright setLightColor _lightRed;
		_lightright setLightAmbient _lightRed;
	}; 
	sleep 1; 
};
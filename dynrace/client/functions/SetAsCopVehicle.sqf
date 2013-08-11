fnCJ_PoliceBlink = {
    private ["_vehicle","_lightRed","_lightBlue","_lightleft","_lightright","_leftRed"];
    // _this select 0 : objVehicle
    // _this select 1 : blingspeed
    
    _vehicle = _this select 0;  
    _lightRed = [0.1, 0.1, 20];         //color left
    _lightBlue = [0.1, 0.1, 20];         //color right
    
    _lightleft = "#lightpoint" createVehicle getpos _vehicle;   
    sleep 0.2;
    _lightleft setLightColor _lightRed; 
    _lightleft setLightBrightness 0.2;  
    _lightleft setLightAmbient [0.1,0.1,1]; 
    _lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.54]];  //exact position of leftlight
    //helperSphere1 attachTo [_vehicle, [-0.37, 0.0, 0.54]];     //positiontest with 10cm helpersphere
    _lightleft setLightAttenuation [0.181, 0, 1000, 130]; 
    _lightleft setLightIntensity 10;
    _lightleft setLightFlareSize 0.38;
    _lightleft setLightFlareMaxDistance 150;
    _lightleft setLightUseFlare true;

    _lightright = "#lightpoint" createVehicle getpos _vehicle;   
    sleep 0.2;
    _lightright setLightColor _lightBlue; 
    _lightright setLightBrightness 0.2;  
    _lightright setLightAmbient [0.1,0.1,1]; 
    _lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.54]];  //exact position of rightlight
    //helperSphere1_1 attachTo [_vehicle, [0.37, 0.0, 0.54]]; //positiontest with 10cm helpersphere
    _lightright setLightAttenuation [0.181, 0, 1000, 130]; 
    _lightright setLightIntensity 10;
    _lightright setLightFlareSize 0.38;
    _lightright setLightFlareMaxDistance 150;
    _lightright setLightUseFlare true;
    
    _leftRed = true;  
    while{ (alive _vehicle)} do  
    {  
      if(_leftRed) then  
     {  
        _leftRed = false;  
    _lightright setLightBrightness 0.0;  
    sleep 0.05;
    _lightleft setLightBrightness 2;  
     }  
     else  
     {  
        _leftRed = true;  
    _lightleft setLightBrightness 0.0;  
    sleep 0.05;
    _lightright setLightBrightness 2;  
     };  
      sleep (_this select 1);  
    };  
    deleteVehicle _lightleft;
    deleteVehicle _lightright;
};  
if(count DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION == 0) exitWith {};
_part = DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION select 0;
DYN_RACE_CARDESIGN_CAM camSetRelPos [0, -10, 1];
DYN_RACE_CARDESIGN_CAM camSetTarget _part;
DYN_RACE_CARDESIGN_CAM camcommit 0;
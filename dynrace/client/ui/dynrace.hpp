class DYN_RscText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {1, 1, 1, 1.0};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};

class DYN_MCListBox {
	idc = -1;
	type = 102;
	style = 0;
	font = "PuristaMedium";
	x = 0;
	y = 0;
	w = .2;
	h = .4;
	// number of columns used, and their left positions 
	// if using side buttons, space has to be reserved for those,
	// at a width of roughly 120% of rowHeight
	columns[] = {}; 
	// height of each row
	sizeEx = 0.03; 
	drawSideArrows = 0; 
	
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {0.9, 0.9, 0.9, 0};
	colorscrollbar[] = {0.2, 0.2, 0.2, 1};
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.03;
	color[] = {0.7, 0.7, 0.7, 1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	idcLeft = 0;
	idcRight = 0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class DYN_RscListBox {
	style = 16;
	idc = -1;
	type = 5;
	w = 0.275;
	h = 0.04;
	font = "PuristaMedium";
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {0.9, 0.9, 0.9, 0};
	colorscrollbar[] = {0.2, 0.2, 0.2, 1};
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.03;
	color[] = {0.7, 0.7, 0.7, 1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	sizeEx = 0.023;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class DYN_RscShortcutButton {
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1, 1, 1, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
	colorBackground2[] = {1, 1, 1, 1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class TextPos {
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\onover", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\new1", 0.0, 0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape", 0.09, 1};
	action = "";
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class DYN_RscButtonMenu : DYN_RscShortcutButton {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0, 0, 0, 0.8};
	colorBackground2[] = {1, 1, 1, 0.5};
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	
	class TextPos {
		left = "0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	
	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class ShortcutPos {
		left = "(6.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};

class DYN_TeamSelectionDiag
{
	idd = 4010;
	name = "Team Selection";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn DYN_RACE_TeamSelectionDialogInit;";
	
	class controls
	{
		class TeamList : DYN_RscListBox
		{
			idc = 4011;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_RACE_TeamSelectionDialogTeamSelectionChanged;";
			
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
		
		class TeamText : DYN_RscText
		{
			idc = 4012;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Team Selection";
			sizeEx = 0.04;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2) - 0.05;
			w = 0.275 * 2; h = 0.04;
		};
		
		class TeamRoleList : DYN_RscListBox
		{
			idc = 4013;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_RACE_TeamSelectionDialogRoleChanged;";
			
			x = 0.5; y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.04 + 0.340 - 0.04;
		};
		
		class ButtonChoose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Join role";
			onButtonClick = "[] spawn DYN_RACE_TeamSelectionDialogJoinButton;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
	};
};

class DYN_Diag 
{
	idd = 4000;
	name= "Dynamics Race Vote";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn DYN_RACE_VoteDialogInit";

	class controls 
	{
		class VoteList : DYN_RscListBox
		{
			idc = 4001;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_RACE_VoteDialogSelectChanged;";
			
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
		
		class ButtonClose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Vote";
			onButtonClick = "[] spawn DYN_RACE_VoteDialogVoteButton;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
		
		class VoteText : DYN_RscText
		{
			idc = 4002;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Vote";
			sizeEx = 0.04;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2) - 0.05;
			w = 0.275 * 2; h = 0.04;
		};
		
		class VoteInfo :DYN_RscText
		{
			idc = 4003;
			style = ST_LEFT;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Click an item to get information about it.";
			sizeEx = 0.02;
			x = 0.5; y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
	};
};

class DYN_ScoreBoardDiag
{
	idd = 4020;
	name= "ScoreBoard";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn DYN_RACE_WinnerDialogInit";
	
	class controls 
	{
		class ScoreBoard : DYN_MCListBox
		{
			idc = 4021;
			text = "";
			sizeEx = 0.030;
			
			columns[] = {0.03, 0.1 ,0.8, .97}; 
			
			x = 0.5 - 0.275 - (0.275 / 2); y = 0.5 - (0.340);
			w = 0.275 * 3; h = 0.340 * 2;
		};
		
		class ScoreBoardText : DYN_RscText
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Scoreboard";
			sizeEx = 0.04;
			x = 0.5 - 0.275 - (0.275 / 2); y = 0.5 - (0.340) - 0.05;
			w = 0.275  * 3; h = 0.04;
		};
		
		class ButtonClose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Close";
			onButtonClick = "closeDialog 0";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2); y = 0.5 + (0.340);
			w = 0.20;
			h = 0.04;
		};
	};
};

class DYN_CommanderDiag
{
	idd = 4030;
	name= "ScoreBoazrd";
	movingEnable = false;
	enableSimulation = true;
	
	
	class controls 
	{
		class BtnAction1 : DYN_RscButtonMenu 
		{
			idc = 4031;
			text = "BtnAction1";
			x = 0.1; y = 0.1;
			w = 0.20;
			h = 0.04;
		};
		class BtnAction2 : DYN_RscButtonMenu 
		{
			idc = 4032;
			text = "BtnAction2";
			x = 0.1; y = 0.1 + 0.05;
			w = 0.20;
			h = 0.04;
		};
		class BtnAction3 : DYN_RscButtonMenu 
		{
			idc = 4032;
			text = "BtnAction3";
			x = 0.1; y = 0.1 + 0.1;
			w = 0.20;
			h = 0.04;
		};
	};
};

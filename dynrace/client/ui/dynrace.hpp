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

class DYN_RscStructuredText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 13;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	size = 0.03;
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
	onLoad = "[] spawn DYN_fnc_TeamSelectionDialogInit;uiNamespace setVariable ['DYN_TEAMDIAG', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['DYN_TEAMDIAG', nil]";
	
	class controls
	{
		class TeamList : DYN_RscListBox
		{
			idc = 4011;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_fnc_TeamSelectionDialogTeamSelectionChanged;";
			
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
			onLBSelChanged = "[] spawn DYN_fnc_TeamSelectionDialogRoleChanged;";
			
			x = 0.5; y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.04 + 0.340 - 0.04;
		};
		
		class ButtonChoose : DYN_RscButtonMenu 
		{
			idc = 4014;
			text = "Join role";
			onButtonClick = "[] spawn DYN_fnc_TeamSelectionDialogJoinButton;";
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
	onLoad = "[] spawn DYN_fnc_VoteDialogInit;uiNamespace setVariable ['DYN_VOTEDIAG', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['DYN_VOTEDIAG', nil]";
	
	class controls 
	{
		class VoteList : DYN_RscListBox
		{
			idc = 4001;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_fnc_VoteDialogSelectChanged;";
			
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
		
		class ButtonClose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Vote";
			onButtonClick = "[] spawn DYN_fnc_VoteDialogVoteButton;";
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
		
		class VoteInfo : DYN_RscStructuredText
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
	onLoad = "[] spawn DYN_fnc_WinnerDialogInit;uiNamespace setVariable ['DYN_SCOREBOARDDIAG', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['DYN_SCOREBOARDDIAG', nil]";
	
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
	name= "Commander diag";
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[] spawn DYN_fnc_ComActionDialogInit;uiNamespace setVariable ['DYN_COMACTIONSDIAG', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['DYN_COMACTIONSDIAG', nil]";

	class controls 
	{
		class ActionList : DYN_RscListBox
		{
			idc = 4031;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn DYN_fnc_ComSelectedActionChanged;";
			
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
		
		class ButtonClose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Select action";
			onButtonClick = "[] spawn DYN_fnc_ComSelectAction;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
		
		class ActionText : DYN_RscText
		{
			idc = 4032;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Commander Actions";
			sizeEx = 0.04;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2) - 0.05;
			w = 0.275 * 2; h = 0.04;
		};
		
		class ActionInfo : DYN_RscStructuredText
		{
			idc = 4033;
			style = ST_LEFT;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Click an action to get information about it.";
			sizeEx = 0.02;
			x = 0.5; y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
	};
};

class DYN_HELP
{
	idd = 4060;
	name= "Hepl";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['DYN_HELPDIAG', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['DYN_HELPDIAG', nil]";

	class controls 
	{
		class ButtonClose : DYN_RscButtonMenu 
		{
			idc = -1;
			text = "Close";
			onButtonClick = "(uiNamespace getVariable 'DYN_HELPDIAG') closeDisplay 0;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
		
		class ActionText : DYN_RscText
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Help";
			sizeEx = 0.04;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2) - 0.05;
			w = 0.275 * 2; h = 0.04;
		};
		
		class ActionInfo : DYN_RscStructuredText
		{
			idc = 4061;
			style = ST_LEFT;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.02;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275 * 2; h = 0.340;
		};
	};
};

class RscPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 48;//ST_PICTURE
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
};

class DYN_RscPositionText : DYN_RscText
{
	idc = -1;
	colorBackground[] = {0.2,0.2,0.2,1};
	colorText[] = {0.45, 0.45, 0.45, 1};
	text = "";
	sizeEx = 0.04;
	x = safezoneX + safezoneW - 0.29; 
	w = 0.25; h = 0.05;
	font = "puristaMedium";
	shadow = 0;
};

class DYN_RscPositionNumberText : DYN_RscText
{
	idc = -1;
	colorBackground[] = {0, 0, 0, 1};
	colorText[] = {0.45, 0.45, 0.45, 1};
	text = "";
	sizeEx = 0.04;
	x = safezoneX + safezoneW - 0.32; 
	w = 0.03; h = 0.05;
	font = "puristaMedium";
	shadow = 0;
};

class RscProgress
{
	access = 0;
	type = 8;
	style = 0;
	colorFrame[] = {1,1,1,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1.2;
	h = 0.03;
	shadow = 0;
};

class RscMapControl;

class rscTitles
{
	class DYN_COMTARGETDiag
	{
		idd = 4040;
		name= "Commander targetter";
		movingEnable = false;
		enableSimulation = true;
		duration = 9999999;
		fadeIn = 0;
		fadeOut = 0;
		controlsBackground[] = {};
      	objects[] = {};
		onLoad = "uiNamespace setVariable ['DYN_COMTARGETDIAG', _this select 0];";
		onUnLoad = "uiNamespace setVariable ['DYN_COMTARGETDIAG', nil]";
		class controls
		{
			class Picture: RscPicture
			{
				idc = 4041;
				text = "dynrace\ui\commander\Target_ca.paa";
				x = 0.475;
				y = 0.475;
				w = 0.05;
				h = 0.05;
				//colorText[] = {1,1,1,1.0};// whatever gives you a thrill 
				colorText[] = {1, 0, 0, 1};
				colorBackground[] = {0, 0, 0, 0};
			};
		};
	};
	
	class DYN_InfoDiag
	{
		idd = 4050;
		name= "Race diag";
		movingEnable = false;
		enableSimulation = true;
		duration = 9999999;
		fadeIn = 0;
		fadeOut = 0;
		onLoad = "uiNamespace setVariable ['DYN_INFODIAG', _this select 0];";
		onUnLoad = "uiNamespace setVariable ['DYN_INFODIAG', nil]";
		class controls
		{
			class CommanderInfo : DYN_RscStructuredText
			{
				idc = 4051;
				style = ST_LEFT;
				colorBackground[] = {0,0,0,0.5};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
				text = "";
				sizeEx = 0.08;
				x = safezoneX + safezoneW * 0.01; y = safezoneY + 0.2;
				w = 0.25; h = 0.2;
			};
			
			class Position : DYN_RscStructuredText
			{
				idc = 4052;
				style = ST_LEFT;
				colorBackground[] = {0,0,0,0};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
				text = "";
				sizeEx = 0.08;
				x = safezoneX + safezoneW * 0.01; y = safezoneY + 0.2;
				w = 0.3; h = 0.1;
			};
			
			class Time : DYN_RscStructuredText
			{
				idc = 4053;
				style = ST_LEFT;
				colorBackground[] = {0,0,0,0};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
				colorText[] = {0.45, 0.45, 0.45, 1};
				text = "";
				sizeEx = 0.5;
				x = safezoneX + safezoneW * 0.01; y = safezoneY + 0.3;
				w = 0.21; h = 0.03;
			};
			
			// class ProgressBar : RscProgress
			// {
				// idc = 4054;
				// colorFrame[] = {0,0,0,1};
				// colorBar[] = {0.45, 0.45, 0.45,1};
				// x = safezoneX + 1; y = safezoneY + 0.05;
				// w = safezoneW - 2 * 1;
				// h = 0.03;
			// };
			
			// class Map : RscMapControl 
			// {
				// idc = 4055;
				// x = safezoneX + 0.02 * safezoneW);
				// y = safezoneY + 1 * safezoneH;
				// w = safezoneW * 0.16;
				// h = safezoneH * 0.16;
				// type = 101; // Use 100 to hide markers
				// style = 48;
				// colorLevels[] = {0.65, 0.6, 0.55, 1};
				// colorSea[] = {0.46, 0.65, 0.74, 0.5};
				// colorForest[] = {0.02, 0.5, 0.01, 0.3};
				// colorForestBorder[] = {0.02, 0.5, 0.01, 0.27};
				// colorRocks[] = {0, 0, 0, 0.3};
				// colorCountlines[] = {0.65, 0.45, 0.27, 0.70};
				// colorMainCountlines[] = {1, 0.1, 0.1, 0.9};
				// colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
				// colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
				// colorPowerLines[] = {0.1, 0.1, 0.1, 1};
				// colorRailWay[] = {0.8, 0.2, 0, 1};
				
				// colorRocksBorder[] = {0, 0, 0, 0};
				// colorNames[] = {0.1, 0.1, 0.1, 0.9};
				// colorInactive[] = {1, 1, 1, 0.5};
				
				// colorOutside[] = {0, 0, 0, 0};
				// colorBackground[] = {1, 1, 0.85, 0.2};
				
				// colorText[] = {1, 1, 1, 0.85};

				// font = "PuristaMedium";
				// sizeEx = 0.0270000;
				// scaleMin = 1e-006;
				// scaleMax = 1000;
				// scaleDefault = 0.18;
			

				// stickX[] = {0.20, {"Gamma", 1.00, 1.50} };
				// stickY[] = {0.20, {"Gamma", 1.00, 1.50} };
				// ptsPerSquareSea = 6;
				// ptsPerSquareTxt = 8;
				// ptsPerSquareCLn = 8;
				// ptsPerSquareExp = 8;
				// ptsPerSquareCost = 8;
				// ptsPerSquareFor = "4.0f";
				// ptsPerSquareForEdge = "10.0f";
				// ptsPerSquareRoad = 2;
				// ptsPerSquareObj = 10;

				// fontLabel = "PuristaMedium";
				// sizeExLabel = 0.027000;
				// fontGrid = "PuristaMedium";
				// sizeExGrid = 0.023000;
				// fontUnits = "PuristaMedium";
				// sizeExUnits = 0.031000;
				// fontNames = "PuristaMedium";
				// sizeExNames = 0.056000;
				// fontInfo = "PuristaMedium";
				// sizeExInfo = 0.031000;
				// fontLevel = "PuristaMedium";
				// sizeExLevel = 0.021000;
				
				// maxSatelliteAlpha = 0;     // Alpha to 0 by default
				// alphaFadeStartScale = 0.1; 
				// alphaFadeEndScale = 3;   // Prevent div/0

				// showCountourInterval=0;
				// onMouseButtonClick = "";
				// onMouseButtonDblClick = "";
			
			
			// };
			
			class Position1 : DYN_RscPositionText
			{
				idc = 4060;
				y = 0;
			};
			class Position2 : DYN_RscPositionText
			{
				idc = 4061;
				y = 0.05;
			};
			class Position3 : DYN_RscPositionText
			{
				idc = 4062;
				y = 0.10;
			};
			class Position4 : DYN_RscPositionText
			{
				idc = 4063;
				y = 0.15;
			};
			class Position5 : DYN_RscPositionText
			{
				idc = 4064;
				y = 0.2;
			};
			class Position6 : DYN_RscPositionText
			{
				idc = 4065;
				y = 0.25;
			};
			
			class TextPosition1 : DYN_RscPositionNumberText
			{
				idc = 4070;
				y = 0;
				text = "1";
			};
			class TextPosition2 : DYN_RscPositionNumberText
			{
				idc = 4071;
				y = 0.05;
				text = "2";
			};
			class TextPosition3 : DYN_RscPositionNumberText
			{
				idc = 4072;
				y = 0.1;
				text = "3";
			};
			class TextPosition4 : DYN_RscPositionNumberText
			{
				idc = 4073;
				y = 0.15;
				text = "4";
			};
			class TextPosition5 : DYN_RscPositionNumberText
			{
				idc = 4074;
				y = 0.2;
				text = "5";
			};
			class TextPosition6 : DYN_RscPositionNumberText
			{
				idc = 4075;
				y = 0.25;
				text = "6";
			};
		};
	};
};
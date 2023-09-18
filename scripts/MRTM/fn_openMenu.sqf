/*
	Author: MrThomasM

	Description: Opens the settings menu.
*/

if (isNull (findDisplay 8000)) then {
	createDialog "MRTM_settingsMenu";
};
disableSerialization;

{
	ctrlSetText [(_x # 0), str (_x # 1)];
} forEach [[1400, (profileNamespace getVariable ["MRTM_inf", 2000])], [1401, (profileNamespace getVariable ["MRTM_ground", 3000])], [1402, (profileNamespace getVariable ["MRTM_air", 4000])], [1403, (profileNamespace getVariable ["MRTM_drones", 4000])], [1404, (profileNamespace getVariable ["MRTM_objects", 2000])], [1405, (profileNamespace getVariable ["MRTM_rwr1", 0.3])], [1406, (profileNamespace getVariable ["MRTM_rwr2", 0.3])], [1407, (profileNamespace getVariable ["MRTM_rwr3", 0.2])], [1408, (profileNamespace getVariable ["MRTM_rwr4", 0.3])]];

{
	slidersetRange [(_x select 0), 100, 4000];
	sliderSetPosition [(_x select 0), (_x select 1)];
	((findDisplay 8000) displayCtrl (_x select 0)) sliderSetSpeed [(_x select 0), 100, 100];
} forEach [[1125, (profileNamespace getVariable ["MRTM_inf", 2000])], [1126, (profileNamespace getVariable ["MRTM_ground", 3000])], [1127, (profileNamespace getVariable ["MRTM_air", 4000])], [1128, (profileNamespace getVariable ["MRTM_drones", 4000])], [1129, (profileNamespace getVariable ["MRTM_objects", 2000])]];

{
	slidersetRange [(_x select 0), 0.05, 2];
	sliderSetPosition [(_x select 0), (_x select 1)];
	((findDisplay 8000) displayCtrl (_x select 0)) sliderSetSpeed [(_x select 0), 0.05, 0.01];
} forEach [[1130, (profileNamespace getVariable ["MRTM_rwr1", 0.3])], [1131, (profileNamespace getVariable ["MRTM_rwr2", 0.3])], [1132, (profileNamespace getVariable ["MRTM_rwr3", 0.2])], [1133, (profileNamespace getVariable ["MRTM_rwr4", 0.3])]];

ctrlSetText [1101, (name player)];
ctrlSetText [1134, format ["Total CP earned: %1CP", (profileNamespace getVariable ["WL2_TotalEarnedCP", 0])]];
ctrlSetText [1136, format ["Win ratio: %1/%2", (profileNamespace getVariable ["WL2_gamesWon", 0]), (profileNamespace getVariable ["WL2_gamesLost", 0])]];
ctrlSetText [1138, format ["Sectors seized: %1", (profileNamespace getVariable ["WL2_sectorsSeized", 0])]];
ctrlSetText [1141, format ["Longest distance kill: %1meters", round (profileNamespace getVariable ["WL2_longestDistanceKill", 0])]];
_kills = (profileNamespace getVariable ["WL2_totalKills", 0]);
_kd = round ((profileNamespace getVariable ["WL2_totalKills", 0])/((profileNamespace getVariable ["WL2_totalDeaths", 0]) max 1));
((findDisplay 8000) displayCtrl 1143) ctrlSetStructuredText parseText format ["<t size='1'><t size='1' valign='middle' align='left'>Kills:%1</t> <t size='1' valign='middle' align='right'>K/D:%2</t></t>", _kills, _kd];

if (profileNamespace getVariable ["MRTM_syncObjects", true]) then {
	((findDisplay 8000) displayCtrl 2800) cbSetChecked true;
	ctrlEnable [1129, false];
	ctrlEnable [1404, false];
} else {
	((findDisplay 8000) displayCtrl 2800) cbSetChecked false;
	ctrlEnable [1129, true];
	ctrlEnable [1404, true];
};

if (profileNamespace getVariable ["MRTM_3rdPersonDisabled", false]) then {
	((findDisplay 8000) displayCtrl 2801) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2801) cbSetChecked false;
};

if (profileNamespace getVariable ["MRTM_muteVoiceInformer", false]) then {
	((findDisplay 8000) displayCtrl 2802) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2802) cbSetChecked false;
};

if (profileNamespace getVariable ["MRTM_playKillSound", true]) then {
	((findDisplay 8000) displayCtrl 2803) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2803) cbSetChecked false;
};

if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
	((findDisplay 8000) displayCtrl 2804) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2804) cbSetChecked false;
};

if (profileNamespace getVariable ["MRTM_smallAnnouncerText", false]) then {
	((findDisplay 8000) displayCtrl 2806) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2806) cbSetChecked false;
};

if (profileNamespace getVariable ["MRTM_spawnEmpty", false]) then {
	((findDisplay 8000) displayCtrl 2807) cbSetChecked true;
} else {
	((findDisplay 8000) displayCtrl 2807) cbSetChecked false;
};

if ((getMissionConfigValue ["MRTM_enableGroups", 1]) != 1) then {
	ctrlEnable [1605, false];
};

if ((getMissionConfigValue ["MRTM_enableEmotes", 1]) != 1) then {
	ctrlEnable [1606, false];
};
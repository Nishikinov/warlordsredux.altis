WAS_score = false;
WAS_store = false;
WAS_fired = false;

private _maxInActScore = 3;
private _minimumDistance = 25;
private _sleepDuration = 300;
private _currentPos = getPos player;

player addEventHandler ["Fired", {
	params ["_unit", "_object", "_score"];
	WAS_fired = true;
}];

while {(!BIS_WL_missionEnd) and (alive player)} do {
	sleep (if (player getVariable ["BIS_WL_incomeBlocked", false]) then {10} else {_sleepDuration});
	private _inActScore = 5;

	//Moved further than _minimumDistance in the last cycle
	private _newPos = getPos player;
    private _distanceMoved = _currentPos distance _newPos;
    if (_distanceMoved > _minimumDistance) then {
		if (_distanceMoved > 500) then {
			_inActScore = _inActScore - 2;
		} else {
			_inActScore = _inActScore - 1;
		};
	};
	_currentPos = _newPos;

	//Scored recently
	if (WAS_score) then {
		_inActScore = _inActScore - 1;
		WAS_score = false;
	};

	//Bought something recently
	if (WAS_store) then {
		_inActScore = _inActScore - 1;
		WAS_store = false;
	};

	//Fired a weapon recently
	if (WAS_fired) then {
		_inActScore = _inActScore - 1;
		WAS_fired = false;
	};

	//In a vehicle with crew from another group
	private _crewNotInGroup = (crew vehicle player) select {(group _x != group player) and (isPlayer _x)};
	if (count _crewNotInGroup > 0) then {
		_inActScore = _inActScore - 1;
	};

	//Selected sector
	private _targets = [missionNamespace getVariable "BIS_WL_currentTarget_west", missionNamespace getVariable "BIS_WL_currentTarget_east"] select {not(isNull _x)};
	if (((_targets findIf {player inArea (_x getVariable "objectAreaComplete")}) != -1)) then {
		_inActScore = 0;
	};

	if (_inActScore > _maxInActScore) then {
		hintSilent "You are too inactive to earn passive income";
		player setVariable ["BIS_WL_incomeBlocked", true, [clientOwner, 2]]; //Only server and client needs to know this
	} else {
		player setVariable ["BIS_WL_incomeBlocked", false, [clientOwner, 2]]; //Only server and client needs to know this
	};
};
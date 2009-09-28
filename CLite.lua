local zones = 
{
	["Trial of the Grand Crusader"] = true,
	["Trial of the Crusader"] = true,
	["Trial of the Champion"] = false,
	["Stockades"] = true
}

local frame CLite = CreateFrame("FRAME");

function CLite:OnEnable()
{
	CLite:RegisterEvent("ZONE_CHANGED_NEW_AREA", zoneChanged());
}

function zoneChanged()
{
	
}

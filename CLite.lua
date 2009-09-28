local zones = 
{
	["Trial of the Grand Crusader"] = true,
	["Trial of the Crusader"] = true,
	["Trial of the Champion"] = false,
	["Stormwind Stockade"] = true
}

--This function checks the current zone agaist the table of zones and decides whether or not to enable or disable
--combat logging.
local function zoneChangedUpdate()
	local CurrentZoneText = GetRealZoneText();
	DEFAULT_CHAT_FRAME:AddMessage("CLite zone changed to " .. CurrentZoneText ..".");
	
	
	
	
end

--OnEvent script handler.
local function onEvent(self, event)
	if(event == "ZONE_CHANGED_NEW_AREA")then
		zoneChangedUpdate();
	end
end



-- Create The Frame and Register Events

local CLite = CreateFrame("FRAME", "CLite_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("CLite Loaded");

CLite:SetScript("OnEvent", onEvent);
CLite:RegisterEvent("ZONE_CHANGED_NEW_AREA", "zoneChangedUpdate");

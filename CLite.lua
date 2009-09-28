local zones = 
{
	["Trial of the Grand Crusader"] = true,
	["Trial of the Crusader"] = true,
	["Trial of the Champion"] = true,
	["Stormwind Stockade"] = true,
	["Ironforge"] = true
}

--This function checks the current zone agaist the table of zones and decides whether or not to enable or disable
--combat logging.
local function zoneChangedUpdate()
	local CurrentZoneText = GetRealZoneText();
	local LoggingStatus = false;
	
	DEFAULT_CHAT_FRAME:AddMessage("CLite zone changed to " .. CurrentZoneText ..".");
	
	for key,value in pairs(zones) do
		if key == CurrentZoneText and value == true then
			DEFAULT_CHAT_FRAME:AddMessage("Zone found!");
			LoggingStatus = true;
			--enable logging
			break;
		else
			DEFAULT_CHAT_FRAME:AddMessage("Zone not found.");
			LoggingStatus = false;
			--disable logging
		end
	end
	
	if(LoggingStatus == true) then
		DEFAULT_CHAT_FRAME:AddMessage("Logging Started");
		LoggingCombat(1);
	else --LoggingStatus == false then
		DEFAULT_CHAT_FRAME:AddMessage("Logging Stopped");
		LoggingCombat();
	end
	
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

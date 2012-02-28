--------------------------------------  CONFIG  --------------------------------------
-- To enable logging in a zone change the zone key value to true.
-- To desable loggin in a zoen change the zone key value to false.
--
-- To add a new zone to the list use the format below:
-- ["NEW ZONE NAME"] = true,
-- To get the zone name run print(GetRealZoneText()); in game.
--
local zones = 
{
	-- Cataclysm Raids
	["Firelands"] = true,
	["Blackwing Descent"] = true,
	["The Bastion of Twilight"] = true,
	["Throne of the Four Winds"] = true,
	["Baradin Hold"] = true,
    ["Dragon Soul"] = true,
}
-- Set this to true to enable combat loggin in 10 player raids
local EnableTenManLogging = true;
--------------------------------------  CONFIG  --------------------------------------

local LoggingStatus = false;
local DisplayStopMessage = true;

--  When the zone changes check if it is one of the zones listed for logging.
--  Enable or Disable logging and display a message.
local function ZoneChangedUpdate()
	local RaidSize = GetNumRaidMembers();
	
	if (EnableTenManLogging == false and RaidSize <= 15) then
		return;
	end
	
	local CurrentZoneText = GetRealZoneText();
	
	for key,value in pairs(zones) do
		if (key == CurrentZoneText and value == true) then
			LoggingStatus = true;
			break;
		else
			LoggingStatus = false;
		end
	end
	
	if(LoggingStatus == true and enabled == true) then
		DEFAULT_CHAT_FRAME:AddMessage("CLite: Combat logging is running.", 0.9, 0.4, 0.3);
		LoggingCombat(1);
		DisplayStopMessage = true;
    end
	if (LoggingStatus == false or enabled == false) then
		if (DisplayStopMessage == true) then
			DEFAULT_CHAT_FRAME:AddMessage("CLite: Combat logging is stopped.", 0.9, 0.4, 0.3);
			DisplayStopMessage = false;
		end
        LoggingCombat(0);
	end
end

-- OnEvent script handler.
local function onEvent(self, event)
	if (event == "ZONE_CHANGED_NEW_AREA") then
		if(enabled) then
			ZoneChangedUpdate();
		end
	elseif (event == "ADDON_LOADED") then
		if(enabled == nil) then
			enabled = true;
		end
	elseif(event == "PLAYER_LOGIN") then
		ZoneChangedUpdate();
	end
end

-- Create frame and register for events
local CLite = CreateFrame("FRAME", "CLite_Frame", UIParent);
CLite:SetScript("OnEvent", onEvent);
CLite:RegisterEvent("ZONE_CHANGED_NEW_AREA");
CLite:RegisterEvent("ADDON_LOADED");
CLite:RegisterEvent("PLAYER_LOGIN");

-- Toggles automatic logging and enables/disables logging.
function toggleLogging()
	if(enabled == true) then
		enabled = false;
		DEFAULT_CHAT_FRAME:AddMessage("CLite: Combat logging disabled.", 1.0, 0.0, 0.0);
	else
		enabled = true;
		DEFAULT_CHAT_FRAME:AddMessage("CLite: Combat logging enabled.", 1.0, 0.0, 0.0);
	end
	ZoneChangedUpdate();
end

-- Slash command to toggle logging
SLASH_CLITETOGGLE1 = "/cl";
SlashCmdList["CLITETOGGLE"] = toggleLogging;

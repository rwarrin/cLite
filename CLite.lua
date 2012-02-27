-----------------------------------------------------------------------------------CONFIG---------------------------------------------------------------------------------------
--
--	To enable or disable logging in certain zones place either a true or false next to the zone.  If you want to add a new zone
--	to the list just write it exactly like the others already there and make sure you spell it like it's called in the game.
--
local zones = 
{
	--  10 and 25 man Raid Instances
	--  Cataclysm
	["Firelands"] = true,
	["Blackwing Descent"] = true,
	["The Bastion of Twilight"] = true,
	["Throne of the Four Winds"] = true,
	["Baradin Hold"] = true,
    ["Dragon Soul"] = true,
}
--  Set this to true if you want to log in 10 man instances too, otherwise set it to false if you only want to log 25 man instances.
local EnableTenManLogging = true;

-----------------------------------------------------------------------------------CONFIG---------------------------------------------------------------------------------------

--  This function checks the current zone agaist the table of zones and decides whether or not to enable or disable
--  combat logging.
local LoggingStatus = false;
local DisplayStopMessage = true;
	
local function zoneChangedUpdate()
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
	
	if(LoggingStatus == true) then
		DEFAULT_CHAT_FRAME:AddMessage("CLite - Combat Logging Started", 1.0, 0.0, 0.0);
		LoggingCombat(1);
		DisplayStopMessage = true;
	else --  if (LoggingStatus == false) then
		if (DisplayStopMessage == true) then
			DEFAULT_CHAT_FRAME:AddMessage("CLite - Combat Logging Stopped", 1.0, 0.0, 0.0);
			DisplayStopMessage = false;
		end
		LoggingCombat(0);
	end
end

--  OnEvent script handler.
local function onEvent(self, event)
	if (event == "ZONE_CHANGED_NEW_AREA") then
		if(enabled) then
			zoneChangedUpdate();
		end
	end
end

--  Create The Frame and Register Events
local CLite = CreateFrame("FRAME", "CLite_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("CLite Loaded");

CLite:SetScript("OnEvent", onEvent);
CLite:RegisterEvent("ZONE_CHANGED_NEW_AREA", "zoneChangedUpdate");
LoggingCombat();
zoneChangedUpdate();

-- Allows the addon to be toggled on and off in game.
local enabled = true;

-- Toggles logging on/off
function toggleLogging()
	if(enabled) then
		enabled = false;
		DEFAULT_CHAT_FRAME:AddMessage("CLite - Combat logging disabled.", 1.0, 0.0, 0.0);
	else
		enabled = true;
		DEFAULT_CHAT_FRAME:AddMessage("CLite - Combat logging enabled.", 1.0, 0.0, 0.0);
	end
	zoneChangedUpdate();
end

-- Slash command to toggle logging
SLASH_CLITETOGGLE1 = "/cl";
SlashCmdList["CLITETOGGLE"] = toggleLogging;

----------------------------------CONFIGURATION---------------------------------
-- To enable or disable logging in a zone change the zone key value to either
-- true or false.
--
-- To add a new zone to the list use the format below:
-- ["New Zone Name"] = true,

local zones = {
    -- Testing
    ["Stormwind City"] = true,
    -- Cataclysm Raids
    ["Dragon Soul"] = true,
	["The Dragon Wastes"] = true,
    ["Firelands"] = true,
    ["Baradin Hold"] = false,
}
-------------------------------------------------------------------------------

-- Check if logging should happen in new zone
local function CanLogInNewZone()
    local newZone = GetRealZoneText();
    for key,value in pairs(zones) do
        if(key == newZone and value == true and enabled == true) then
            return true;
        end
    end
    return false;
end

-- Set the status of combat logging on or off
local function SetLoggingStatus(status)
    if(status == true) then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat logging started.", 0.2, 0.8, 0.2);
        LoggingCombat(1);
    else 
        if(LoggingCombat()) then
            DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat logging stopped.", 0.9, 0.2, 0.2);
        end
        LoggingCombat(0);
    end
end

-- Update logging status
local function UpdateLoggingStatus()
    local logging = CanLogInNewZone();
    SetLoggingStatus(logging);
end

-- Handle events
local function OnEvent(self, event, ...)
    if(event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN") then
        UpdateLoggingStatus();
    end
    if(event == "ADDON_LOADED") then
        if(enabled == nil) then
            enabled = true;
        end
    end
end

-- Toggle automatic logging
local function ToggleAutomaticLogging()
    if(enabled == true) then
        enabled = false;
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging disabled.", 0.9, 0.2, 0.2);
    else
        enabled = true;
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging enabled.", 0.2, 0.8, 0.2);
    end
    UpdateLoggingStatus();
end

-- Create AddOn frame and register for events
local cLite = CreateFrame("FRAME", "cLiteFrame", UIParent);
cLite:RegisterEvent("ADDON_LOADED");
cLite:RegisterEvent("PLAYER_LOGIN");
cLite:RegisterEvent("ZONE_CHANGED_NEW_AREA");
cLite:SetScript("OnEvent", OnEvent);

-- Slash command for toggling automatic logging
SLASH_CLITETOGGLE1 = "/cl";
SlashCmdList["CLITETOGGLE"] = ToggleAutomaticLogging;

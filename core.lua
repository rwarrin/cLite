-------------------------------------------------------------------------------
-- To enable or disable logging in a zone change the zone key value to either
-- true or false.
--
-- To add a new zone to the list use the format below:
-- ["New Zone Name"] = true,

local zones = 
{
    -- Testing
    ["Stormwind City"] = true,

    -- Cataclysm Raids
    ["Dragon Soul"] = true,
}

-------------------------------------------------------------------------------

-- Create AddOn frame and register for events
local cLite = CreateFrame("FRAME", "cLiteFrame", UIParent);
cLite:RegisterEvent("ADDON_LOADED");
cLite:RegisterEvent("PLAYER_LOGIN");
cLite:RegisterEvent("ZONE_CHANGED_NEW_AREA");
cLite:SetScript("OnEvent", OnEvent);

-- Slash command for toggling automatic logging
SLASH_CLITETOGGLE1 = "/cl";
SlashCmdList["CLITETOGGLE"] = ToggleAutomaticLogging;

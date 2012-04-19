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

-- Handle events
local function OnEvent(self, event, ...)
    if(event == "ZONE_CHANGED_NEW_AREA") then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Zone changed.", 0.3, 0.7, 0.3);
    elseif(event == "ADDON_LOADED") then
        if(enabled == nil) then
            enabled = true;
        end
    elseif(event == "PLAYER_LOGIN") then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Player login.", 0.3, 0.7, 0.3);
    end
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

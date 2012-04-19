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

local debug = false;

-------------------------------------------------------------------------------

-- Check if logging should happen in new zone
local function CanLogInNewZone()
    local newZone = GetRealZoneText();
    if(debug)then DEFAULT_CHAT_FRAME:AddMessage("cLite [DEBUG]: New zone: " .. newZone .. ".", 0.3, 0.3, 0.8); end
    for key,value in pairs(zones) do
        if(key == newZone and value == true and enabled == true) then
            if(debug)then DEFAULT_CHAT_FRAME:AddMessage("cLite [DEBUG]: Logging is okay here.", 0.3, 0.3, 0.8); end
            return true;
        else
            if(debug)then DEFAULT_CHAT_FRAME:AddMessage("cLite [DEBUG]: Logging is not okay here.", 0.3, 0.3, 0.8); end
            return false;
        end
    end
end

-- Set the status of combat logging on or off
local function SetLoggingStatus(status)
    if(status == true) then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat logging started.", 0.2, 0.8, 0.2);
        LoggingCombat(1);
    else 
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat logging stopped.", 0.9, 0.3, 0.3);
        LoggingCombat(0);
    end
end

-- Update when zone changes
local function ZoneChanged()
    if(enabled == true) then
        local logging = CanLogInNewZone();
        SetLoggingStatus(logging);
    end
end

-- Handle events
local function OnEvent(self, event, ...)
    if(event == "ZONE_CHANGED_NEW_AREA") then
        ZoneChanged();
    elseif(event == "ADDON_LOADED") then
        if(enabled == nil) then
            enabled = true;
        end
    elseif(event == "PLAYER_LOGIN") then
        if(debug)then DEFAULT_CHAT_FRAME:AddMessage("cLite [DEBUG]: cLite: Player login.", 0.3, 0.3, 0.8); end
        ZoneChanged();
    end
end

-- Toggle automatic logging
local function ToggleAutomaticLogging()
    if(enabled == true) then
        enabled = false;
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging disabled.", 0.8, 0.3, 0.3);
    else
        enabled = true;
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging enabled.", 0.3, 0.8, 0.3);
    end
    local logging = CanLogInNewZone();
    SetLoggingStatus(logging);
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

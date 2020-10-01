----------------------------------CONFIGURATION---------------------------------
-- To enable or disable logging in a zone change the zone key value to either
-- true or false.
--
-- To add a new zone to the list use the format below:
-- ["New Zone Name"] = true,

local zones = {
    -- BfA Raids
    ["Uldir"] = true,
    ["Battle of Dazar'alor"] = true,
    ["Crucible of Storms"] = true,
    ["The Eternal Palace"] = true,-- Legacy Raids
	["Tomb of Sargeras"] = true,
	["The Nighthold"] = true,
	["Dragon Soul"] = true,
	["Antorus"] = true,
	["Firelands"] = true,
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

-- Display the status of combat logging
local function DisplayLoggingStatus()
    if(LoggingCombat() == 1) then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat is being logged.", 0.2, 0.8, 0.2);
    else
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Combat is not being logged.", 0.9, 0.2, 0.2);
    end
end

-- Display automatic logging status
local function DisplayAddOnStatus()
    if(enabled == true) then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging is enabled.", 0.2, 0.8, 0.2);
    else
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Automatic logging is disabled.", 0.9, 0.2, 0.2);
    end
end

-- Slash command handler
local function CLite_CommandHandler(message)
    local command = message:match("(%S*)");
    if (command == "" ) then
        ToggleAutomaticLogging();
    elseif(command == "status") then
        DisplayAddOnStatus();
    elseif(command == "logging") then
        DisplayLoggingStatus();
    elseif(command == "help") then
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Slash command help.", 0.1, 0.6, 0.8);
        DEFAULT_CHAT_FRAME:AddMessage("cLite: Usage /cl [command].", 0.1, 0.6, 0.8);
        DEFAULT_CHAT_FRAME:AddMessage("cLite: [empty] - Toggles automatic logging on and off.", 0.1, 0.6, 0.8);
        DEFAULT_CHAT_FRAME:AddMessage("cLite: [status] - Returns the state of automatic logging.", 0.1, 0.6, 0.8);
        DEFAULT_CHAT_FRAME:AddMessage("cLite: [logging] - Returns the status of combat logging.", 0.1, 0.6, 0.8);
        DEFAULT_CHAT_FRAME:AddMessage("cLite: [help] - Shows this message.", 0.1, 0.6, 0.8);
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
SlashCmdList["CLITETOGGLE"] = CLite_CommandHandler;

-- 尝试编写脚本进行上线之后调整等级，送东西等
local PLAYER_EVENT_ON_CHARACTER_CREATE = 1
local PLAYER_EVENT_ON_LOGIN = 3

local function OnCustomCreateHandle(event, player)
    player:SendBroadcastMessage("OnCustomCreateHandle")
end

local function OnCustomLoginHandle(event, player)
    player:SendBroadcastMessage("OnCustomLoginHandle")
    local _level = player:GetLevel()

    if _level == 1 then
        player:SetLevel(5)
    end
    player:SendBroadcastMessage("Play Level is: " .. _level)
end

-- 注册事件
--
RegisterPlayerEvent(PLAYER_EVENT_ON_CHARACTER_CREATE, OnCustomCreateHandle)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnCustomLoginHandle)

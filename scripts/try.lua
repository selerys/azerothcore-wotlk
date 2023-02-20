-- 尝试编写脚本进行上线之后调整等级，送东西等
local PLAYER_EVENT_ON_CHARACTER_CREATE = 1
local PLAYER_EVENT_ON_LOGIN = 3

local function OnCustomCreateHandle(event, player)
    print('OnCustomCreateHandle')
    PrintInfo(player);
end

local function OnCustomLoginHandle(event, player)
    print('OnCustomLoginHandle')
    local _level = player:GetLevel()
    print('Play Level is: ', _level)
end

-- 注册事件
--
RegisterPlayerEvent(PLAYER_EVENT_ON_CHARACTER_CREATE, OnCustomCreateHandle)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnCustomLoginHandle)

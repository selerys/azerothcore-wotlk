--[[
    创建超级炉石
]]
local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2


--
local function OnCustomItemCallingGossip(event, player, item)
    player:SendBroadcastMessage(item:GetName())
    return false
end

-- 注册物品的hello事件
RegisterItemGossipEvent(6948, GOSSIP_EVENT_ON_HELLO, OnCustomItemCallingGossip, 0)

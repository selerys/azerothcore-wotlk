--[[
    创建超级炉石
]]
local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2


--
local function OnCustomItemCallingGossip(event, player, item)
    player:SendBroadcastMessage(item:GetName())
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "头部", 1, 0)
    player:GossipMenuAddItem(1, "项链", 1, 1)
    player:GossipMenuAddItem(2, "肩膀", 1, 2)
    player:GossipMenuAddItem(3, "衬衣", 1, 3)
    player:GossipMenuAddItem(4, "胸部", 1, 4)
    player:GossipMenuAddItem(5, "腰带", 1, 5)
    player:GossipMenuAddItem(6, "腿部", 1, 6)
    player:GossipSendMenu(2593, item)
    return false
end

-- 注册物品的hello事件
RegisterItemGossipEvent(6948, GOSSIP_EVENT_ON_HELLO, OnCustomItemCallingGossip, 0)

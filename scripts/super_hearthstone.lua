--[[
    创建超级炉石
]]
local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2


--
local function OnCustomItemCallingGossip(event, player, item)
    player:SendBroadcastMessage(item:GetName())
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "哨兵岭", 1, 0)
    player:GossipMenuAddItem(0, "闪金镇", 1, 1)
    player:GossipMenuAddItem(0, "赤脊山", 1, 2)
    player:GossipSendMenu(18130, item)
    return false
end

-- 注册物品的hello事件
RegisterItemGossipEvent(6948, GOSSIP_EVENT_ON_HELLO, OnCustomItemCallingGossip, 0)

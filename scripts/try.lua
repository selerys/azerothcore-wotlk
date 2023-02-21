-- 尝试编写脚本进行上线之后调整等级，送东西等
--
local PLAYER_EVENT_ON_LOGIN = 3

-- 定义职业值
--[[
  职业的值
  1		  Warrior
  2		  Paladin
  3		  Hunter
  4		  Rogue
  5		  Priest
  6		  Death Knight
  7		  Shaman
  8		  Mage
  9		  Warlock
  11    Druid
]]
local WARRIOR         = 1
local PALADIN         = 2
local HUNTER          = 3
local ROGUE           = 4
local PRIEST          = 5
local DEATH_KNIGHT    = 6
local SHAMAN          = 7
local MAGE            = 8
local WARLOCK         = 9
local DRUID           = 11

-- 定义装备备注
local EQUIPMENT_SLOT_START        = 0
local EQUIPMENT_SLOT_HEAD         = 0
local EQUIPMENT_SLOT_NECK         = 1
local EQUIPMENT_SLOT_SHOULDERS    = 2
local EQUIPMENT_SLOT_BODY         = 3
local EQUIPMENT_SLOT_CHEST        = 4
local EQUIPMENT_SLOT_WAIST        = 5
local EQUIPMENT_SLOT_LEGS         = 6
local EQUIPMENT_SLOT_FEET         = 7
local EQUIPMENT_SLOT_WRISTS       = 8
local EQUIPMENT_SLOT_HANDS        = 9
local EQUIPMENT_SLOT_FINGER1      = 10
local EQUIPMENT_SLOT_FINGER2      = 11
local EQUIPMENT_SLOT_TRINKET1     = 12
local EQUIPMENT_SLOT_TRINKET2     = 13
local EQUIPMENT_SLOT_BACK         = 14
local EQUIPMENT_SLOT_MAINHAND     = 15
local EQUIPMENT_SLOT_OFFHAND      = 16
local EQUIPMENT_SLOT_RANGED       = 17
local EQUIPMENT_SLOT_TABARD       = 18
local EQUIPMENT_SLOT_END          = 19

-- 穿戴装备设定
local _Equipments = {
    [WARRIOR] = {
      EQUIPMENT_SLOT_HEAD         = 35068,  -- item=35068/野蛮角斗士的板甲头盔
      -- EQUIPMENT_SLOT_NECK         = 35068,  
      EQUIPMENT_SLOT_SHOULDERS    = 35070,  -- item=35070/野蛮角斗士的板甲护肩
      EQUIPMENT_SLOT_BODY         = 35066,  -- item=35066/野蛮角斗士的板甲护胸
      EQUIPMENT_SLOT_HANDS        = 35067,  -- item=35067/野蛮角斗士的板甲手套
      EQUIPMENT_SLOT_LEGS         = 35069,  -- item=35069/野蛮角斗士的板甲护腿
    }
}

-- print(_Equipments)

local function OnCustomLoginHandle(event, player)
    player:SendBroadcastMessage("OnCustomLoginHandle")
    local _level = player:GetLevel()
    local _classId = player:GetClass()

    print('_classId: ', _classId)
    print('WARRIOR: ', WARRIOR)

    -- 升级到70
    if _level == 1 then
        player:SetLevel(70)
    end

    -- 将装备传到角色身上
    if _classId == WARRIOR then
        print('THIS IS WARRIOR!')
        player:AddItem(35068, 1)
        local _head = player:GetItemByEntry(35068)
        print('EQUIPMENT_HEAD: ', _head)
        print('equippedItem: ', player:EquipItem(_head, 0))
    end

    -- 给包包

    -- 按职业给礼包
    -- 如果是战士学习几个姿态

end



local function _Switch(_choice)

    -- [[ todo 判断 _choice 是否满足条件  ]] 

    local case = {1, 2, 3, 4, 5, 6, 7, 8, 9, 11}

end

-- 每个职业都需要给一套初始装备，装备的ID根据职业ID来进行获取
-- 战士这里多一个学技能的函数

-- 注册事件
--

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnCustomLoginHandle)

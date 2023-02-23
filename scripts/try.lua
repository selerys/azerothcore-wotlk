-- 尝试编写脚本进行上线之后调整等级，送东西等
--
local PLAYER_EVENT_ON_LOGIN = 3

local LOCALE_zhCN = 4

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
local WARRIOR = 1
local PALADIN = 2
local HUNTER = 3
local ROGUE = 4
local PRIEST = 5
local DEATH_KNIGHT = 6
local SHAMAN = 7
local MAGE = 8
local WARLOCK = 9
local DRUID = 11

-- 定义装备备注
local EQUIPMENT_SLOT_START = 0
local EQUIPMENT_SLOT_HEAD = 0
local EQUIPMENT_SLOT_NECK = 1
local EQUIPMENT_SLOT_SHOULDERS = 2
local EQUIPMENT_SLOT_BODY = 3
local EQUIPMENT_SLOT_CHEST = 4
local EQUIPMENT_SLOT_WAIST = 5
local EQUIPMENT_SLOT_LEGS = 6
local EQUIPMENT_SLOT_FEET = 7
local EQUIPMENT_SLOT_WRISTS = 8
local EQUIPMENT_SLOT_HANDS = 9
local EQUIPMENT_SLOT_FINGER1 = 10
local EQUIPMENT_SLOT_FINGER2 = 11
local EQUIPMENT_SLOT_TRINKET1 = 12
local EQUIPMENT_SLOT_TRINKET2 = 13
local EQUIPMENT_SLOT_BACK = 14
local EQUIPMENT_SLOT_MAINHAND = 15
local EQUIPMENT_SLOT_OFFHAND = 16
local EQUIPMENT_SLOT_RANGED = 17
local EQUIPMENT_SLOT_TABARD = 18
local EQUIPMENT_SLOT_END = 19

-- 护甲技能
local PLATE_SPELL = 750
local MAIL_SPELL = 8737

-- 包包
local INVENTORY_SLOT_BAG_START = 19
local INVENTORY_SLOT_BAG_END = 23
local INVENTORY_SLOT_BAG = 21876 -- item=21876/原始月布包

-- 穿戴装备设定
local _Equipments = {
    [WARRIOR] = {
        [EQUIPMENT_SLOT_HEAD] = 35068, -- item=35068/野蛮角斗士的板甲头盔
        -- EQUIPMENT_SLOT_NECK         = 35068,  
        [EQUIPMENT_SLOT_SHOULDERS] = 35070, -- item=35070/野蛮角斗士的板甲护肩
        [EQUIPMENT_SLOT_BODY] = 35066, -- item=35066/野蛮角斗士的板甲护胸
        [EQUIPMENT_SLOT_HANDS] = 35067, -- item=35067/野蛮角斗士的板甲手套
        [EQUIPMENT_SLOT_LEGS] = 35069 -- item=35069/野蛮角斗士的板甲护腿
    }
}

-- 每个职业都需要给一套初始装备，装备的ID根据职业ID来进行获取
-- 战士这里多一个学技能的函数
local function _Warrior(player)
    print('THIS IS WARRIOR!')

    -- 学习技能，包括武器技能，护甲技能
    player:LearnSpell(PLATE_SPELL)

    -- 将装备穿到角色身上
    -- 循环实现
    for _slot, _equip in pairs(_Equipments[WARRIOR]) do
        -- 判断是否能穿，不能穿抛出错误
        if not player:CanEquipItem(_equip, _slot) then
            player:SendBroadcastMessage("您的角色当前无法穿戴此物品: " .. GetItemLink(_equip, LOCALE_zhCN))
            error('Item  = / ' .. _equip .. ' / can‘t equipped for WARRIOR')
        end
        player:EquipItem(_equip, _slot)
    end
    -- local _equippedItem = player:EquipItem(35068, 0)
    -- print('equippedItem?  ', _equippedItem)
end

local function _InitLoginPlayer(_classId)

    -- [[ todo 判断 _choice 是否满足条件  ]] 

    local case = {
        [1] = _Warrior

    }

    return case[_classId]

end

-- print(_Equipments)
local function _OnCustomLoginHandle(event, player)
    player:SendBroadcastMessage("OnCustomLoginHandle")
    local _level = player:GetLevel()
    local _classId = player:GetClass()

    print('_classId: ', _classId)
    print('_Equipments: ', _Equipments[_classId])

    if _level == 1 then

        -- 判断阵营之后移动
        if player:IsAlliance() then
            player:Teleport(0, -8857.735352, 596.638062, 92.02135, 0.86)
        elseif player:IsHorde() then
            -- [[ tuod 移动到奥格瑞玛 ]]
        else
            player:SendBroadcastMessage("Player faction is :")
        end

        -- 升级到70
        player:SetLevel(70)

        -- 循环给包包
        for _slot = INVENTORY_SLOT_BAG_START, INVENTORY_SLOT_BAG_END, 1 do
            player:EquipItem(INVENTORY_SLOT_BAG, _slot)
        end

        -- 初始化角色
        _InitLoginPlayer(_classId)(player)

        -- 根据职业选择Switch里面的函数方法执行
        -- if _classId == WARRIOR then
        --     print('THIS IS WARRIOR!')

        --     -- 学习技能，包括武器技能，护甲技能
        --     player:LearnSpell(PLATE_SPELL)

        --     -- 将装备穿到角色身上
        --     -- 循环实现
        --     local _equippedItem = player:EquipItem(35068, 0)
        --     print('equippedItem?  ', _equippedItem)
        -- end

    end

    -- 按职业给礼包
    -- 如果是战士学习几个姿态

end

-- 注册事件
--

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, _OnCustomLoginHandle)

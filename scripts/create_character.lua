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
local EQUIPMENT_SLOT_HEAD = 0 -- 头
local EQUIPMENT_SLOT_NECK = 1 -- 项链
local EQUIPMENT_SLOT_SHOULDERS = 2 -- 肩膀
local EQUIPMENT_SLOT_BODY = 3 -- 衬衫
local EQUIPMENT_SLOT_CHEST = 4 -- 胸
local EQUIPMENT_SLOT_WAIST = 5 -- 腰带
local EQUIPMENT_SLOT_LEGS = 6 -- 腿
local EQUIPMENT_SLOT_FEET = 7 -- 脚
local EQUIPMENT_SLOT_WRISTS = 8 -- 手腕
local EQUIPMENT_SLOT_HANDS = 9 -- 手
local EQUIPMENT_SLOT_FINGER1 = 10 -- 戒指1
local EQUIPMENT_SLOT_FINGER2 = 11 -- 戒指2
local EQUIPMENT_SLOT_TRINKET1 = 12 -- 饰品1
local EQUIPMENT_SLOT_TRINKET2 = 13 -- 饰品1
local EQUIPMENT_SLOT_BACK = 14 -- 背部
local EQUIPMENT_SLOT_MAINHAND = 15 -- 主手
local EQUIPMENT_SLOT_OFFHAND = 16 -- 副手
local EQUIPMENT_SLOT_RANGED = 17 -- 远程
local EQUIPMENT_SLOT_TABARD = 18 -- 战袍
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
        [EQUIPMENT_SLOT_NECK] = 35135, -- item=35135/护卫者的胜利坠饰
        [EQUIPMENT_SLOT_SHOULDERS] = 35070, -- item=35070/野蛮角斗士的板甲护肩
        [EQUIPMENT_SLOT_CHEST] = 35066, -- item=35066/野蛮角斗士的板甲护胸
        [EQUIPMENT_SLOT_WAIST] = 35161, -- item=35161/护卫者的板甲腰带
        [EQUIPMENT_SLOT_HANDS] = 35067, -- item=35067/野蛮角斗士的板甲手套
        [EQUIPMENT_SLOT_LEGS] = 35069, -- item=35069/野蛮角斗士的板甲护腿
        [EQUIPMENT_SLOT_FEET] = 35146, -- item=35146/护卫者的板甲护胫
        [EQUIPMENT_SLOT_WRISTS] = 35176, -- item=35176/护卫者的板甲护腕
        [EQUIPMENT_SLOT_FINGER1] = 35131, -- item=35131/护卫者的胜利指环
        [EQUIPMENT_SLOT_FINGER2] = 35131, -- item=35131/护卫者的胜利指环
        [EQUIPMENT_SLOT_TRINKET1] = 41589, -- item=41589/战斗大师的决断
        [EQUIPMENT_SLOT_TRINKET2] = 41588, -- item=35131/护卫者的胜利指环
        [EQUIPMENT_SLOT_BACK] = 41592, -- item=41592/角斗士的决心
        [EQUIPMENT_SLOT_MAINHAND] = 35015, -- item=35015/野蛮角斗士的巨剑
        -- [EQUIPMENT_SLOT_OFFHAND] = 
        [EQUIPMENT_SLOT_RANGED] = 35108, -- item=35108/野蛮角斗士的战刃

    }
}

local _Character = {}

-- 将装备穿到角色身上
-- 循环实现
function _Character:_EquipItem(player)
    for _slot, _equipId in pairs(_Equipments[WARRIOR]) do

        -- 先删掉装备再穿
        local _offItem = player:GetEquippedItemBySlot(_slot)
        if _offItem then
            print('SLOT :' .. _slot .. ' ,removed Item')
            player:RemoveItem(_offItem, 1)
        end

        -- 判断是否能穿，不能穿抛出错误
        if not player:CanEquipItem(_equipId, _slot) then
            error('Item  = [' .. _equipId .. '] can‘t equipped for WARRIOR')
        end

        -- *** 装备物品 ***
        player:EquipItem(_equipId, _slot)
    end

end

-- 职业初始化
local _Classer = {}

_Classer.Entry = {
    -- 1: WARRIOR
    [WARRIOR] = function(player)
        print('THIS IS WARRIOR!')

        -- 学习技能，包括武器技能，护甲技能
        player:LearnSpell(PLATE_SPELL)

        _Character:_EquipItem(player)
    end
}

function _Classer:Init(_classId, player)
    -- 通过ClassID自动选择职业
    self.Entry[_classId](player)

end
-- local _InitLoginPlayer = {
--     [1] = _Classer._Warrior
-- }

-- print(_Equipments)
local function _OnCustomLoginHandle(event, player)
    player:SendBroadcastMessage("OnCustomLoginHandle")
    local _level = player:GetLevel()
    local _classId = player:GetClass()

    print('_classId: ', _classId)

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

        -- *** 初始化角色 ***
        _Classer:Init(_classId, player)

    end

    -- 按职业给礼包
    -- 如果是战士学习几个姿态

end

-- 注册事件
--

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, _OnCustomLoginHandle)

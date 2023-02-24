-- 创建一个礼包，能让用户打开之后有各种必需品
--   ——装备
--   ——武器
--



SET @ITEM_ENTRY := 58805;

DELETE FROM `item_template` WHERE `entry` BETWEEN  @ITEM_ENTRY+1 AND @ITEM_ENTRY+10;
INSERT INTO `item_template` VALUES
-- 角色新建的时候的给的礼物
-- 战士的礼物
(@ITEM_ENTRY+1,15,0,-1,'包装过的礼物: 战士',24053,5,4,0,1,4,1,0,-1,-1,70,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,'',0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,'',0,0,0,0,0,12340)
;



-- 物品能开出来的东西
--
DELETE FROM `item_loot_template` WHERE `Entry` BETWEEN  @ITEM_ENTRY+1 AND @ITEM_ENTRY+10;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `MinCount`, `MaxCount`) VALUE
-- 战士礼包
-- 装备
(@ITEM_ENTRY+1,35068,1,1),
(@ITEM_ENTRY+1,35066,1,1),
(@ITEM_ENTRY+1,35067,1,1),
(@ITEM_ENTRY+1,35069,1,1),
(@ITEM_ENTRY+1,35070,1,1),
-- 武器
(@ITEM_ENTRY+1,35015,1,1),
(@ITEM_ENTRY+1,35108,1,1),
-- 坐骑
(@ITEM_ENTRY+1,43516,1,1)


-- 圣骑士礼包
;
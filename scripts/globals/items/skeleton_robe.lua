-----------------------------------------
-- ID: 11320
-- Skeleton Robe
-- Enchantment: 60Min, Costume - Skeleton
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if not target:canUseMisc(dsp.zoneMisc.COSTUME) then
        return dsp.msg.basic.CANT_BE_USED_IN_AREA
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(dsp.effect.COSTUME,564,0,3600)
end
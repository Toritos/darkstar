-----------------------------------
-- Area: Sauromugue Champaign
--  MOB: Yagudo Votary
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    dsp.regime.checkRegime(player, mob, 99, 2, dsp.regime.type.FIELDS)
end;

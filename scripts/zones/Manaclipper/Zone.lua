-----------------------------------
--
-- Zone: Manaclipper
--
-----------------------------------
local ID = require("scripts/zones/Manaclipper/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end;

function onZoneIn(player,prevZone)
    local cs = -1;
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(0,-3,-8,60);
    end
    return cs;
end;

function onTransportEvent(player,transport)
    player:startEvent(100);
end;

function onConquestUpdate(zone, updatetype)
    dsp.conq.onConquestUpdate(zone, updatetype)
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if (csid == 100) then
        player:setPos(0,0,0,0,4);
    end
end;

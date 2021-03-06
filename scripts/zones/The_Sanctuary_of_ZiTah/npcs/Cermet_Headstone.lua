-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Light Headstone)
-- !pos 235 0 280 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/titles");

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    -- HEADSTONE PILGRIMAGE
    if (player:getCurrentMission(ZILART) == HEADSTONE_PILGRIMAGE) then
        if (player:hasKeyItem(dsp.ki.LIGHT_FRAGMENT)) then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_FRAG,dsp.ki.LIGHT_FRAGMENT);
        elseif (os.time() >= npc:getLocalVar("cooldown")) then
            if (not GetMobByID(ID.mob.DOOMED_PILGRIMS):isSpawned()) then
                player:startEvent(200,dsp.ki.LIGHT_FRAGMENT);
            else
                player:messageSpecial(ID.text.SOMETHING_BETTER);
            end
        else
            player:addKeyItem(dsp.ki.LIGHT_FRAGMENT);
            if (
                player:hasKeyItem(dsp.ki.ICE_FRAGMENT) and
                player:hasKeyItem(dsp.ki.EARTH_FRAGMENT) and
                player:hasKeyItem(dsp.ki.WATER_FRAGMENT) and
                player:hasKeyItem(dsp.ki.FIRE_FRAGMENT) and
                player:hasKeyItem(dsp.ki.LIGHTNING_FRAGMENT) and
                player:hasKeyItem(dsp.ki.WIND_FRAGMENT)
            ) then
                player:messageSpecial(ID.text.FOUND_ALL_FRAGS,dsp.ki.LIGHT_FRAGMENT);
                player:addTitle(dsp.title.BEARER_OF_THE_EIGHT_PRAYERS);
                player:completeMission(ZILART,HEADSTONE_PILGRIMAGE);
                player:addMission(ZILART,THROUGH_THE_QUICKSAND_CAVES);
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED,dsp.ki.LIGHT_FRAGMENT);
            end
        end

    -- SOUL SEARCHING
    elseif (player:hasCompletedMission(ZILART,THE_CHAMBER_OF_ORACLES) and not player:hasCompletedQuest(OUTLANDS,SOUL_SEARCHING)) then
        player:addQuest(OUTLANDS,SOUL_SEARCHING);
        player:startEvent(202,dsp.ki.PRISMATIC_FRAGMENT);

    -- DEFAULT DIALOGS
    elseif (player:hasCompletedMission(ZILART,HEADSTONE_PILGRIMAGE)) then
        player:messageSpecial(ID.text.ZILART_MONUMENT);
    else
        player:messageSpecial(ID.text.CANNOT_REMOVE_FRAG);
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    -- HEADSTONE PILGRIMAGE
    if (csid == 200 and option == 1) then
        SpawnMob(ID.mob.DOOMED_PILGRIMS):updateClaim(player);

    -- SOUL SEARCHING
    elseif (csid == 202) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,13416);
        else
            player:tradeComplete();
            player:addItem(13416); -- Bat Earring
            player:messageSpecial(ID.text.ITEM_OBTAINED,13416);
            player:completeQuest(OUTLANDS,SOUL_SEARCHING);
            player:addTitle(dsp.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY);
        end
    end
end;

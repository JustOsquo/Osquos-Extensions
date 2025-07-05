--[[ CONSUMABLES ]]--

SMODS.Consumable{ --Erudition
    set = 'Spectral',
    atlas = 'qle_tarot',
    pos = {x = 0, y = 2},
    key = 'erudition',
    config = {extra = {
        count = 1,
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card and card.ability.extra.count or self.config.extra.count
        }}
    end,
    can_use = function(self,card)
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.count) then
            return true
        end
        return false
    end,
    use = function(self,card)
        local randomenhance = SMODS.poll_enhancement({
            key = 'erudition',
            mod = 1,
            guaranteed = true
        })
        local randomseal = SMODS.poll_seal({
            key = 'erudition',
            mod = 1,
            guaranteed = true
        })
        local randomedition = poll_edition('erudition', nil, false, true)

        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3,0.5)
            return true end}))

        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)

        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_ability(G.P_CENTERS[randomenhance])
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal(randomseal)
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_edition(randomedition, true)
                return true end }))
        end

        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end
}

SMODS.Consumable{ --Nescience
    set = 'Spectral',
    atlas = 'qle_tarot',
    pos = {x = 0, y = 1},
    key = 'nescience',
    config = {extra = {
        newkeys = {},
        eligibleJokers = {}
    }},
    can_use = function(self,card)
        card.ability.extra.eligibleJokers = {}
        for i = 1, #G.jokers.cards do
            if not G.jokers.cards[i].ability.eternal then
                card.ability.extra.eligibleJokers[#card.ability.extra.eligibleJokers+1] = G.jokers.cards[i]
            end
        end
        if #card.ability.extra.eligibleJokers >= 1 then
            return true
        end
        return false
    end,
    use = function(self,card)
        for i = 1, #card.ability.extra.eligibleJokers do
            local newjoker = getRandomJokerKey({}, card.ability.extra.eligibleJokers[i].config.center.rarity, 'nescience')
            card.ability.extra.newkeys[i] = newjoker
        end
        JokerConvert(card.ability.extra.eligibleJokers, card.ability.extra.newkeys)
    end
}

SMODS.Consumable{ --Twilight
    set = 'Spectral',
    atlas = 'qle_tarot',
    pos = {x = 1, y = 2},
    key = 'twilight',
    config = {extra = {
        count = 1
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'cosmic_info'}
        return {vars = {
            card and card.ability.extra.count or self.config.extra.count,
            colours = {
                HEX('4F6C74')
            }
        }}
    end,
    can_use = function(self,card)
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.count) then
            return true
        end
        return false
    end,
    use = function(self,card)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end
        }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal('osquo_ext_cosmic', nil, true)
            return true end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable{ --The Fox
    set = 'Tarot',
    atlas = 'qle_tarot',
    pos = {x = 0, y = 0},
    key = 'fox',
    config = {extra = {
        count = 1 --how many cards it can be applied to
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'amber_info'}
        return {vars = {
            card and card.ability.extra.count or self.config.extra.count
        }}
    end,
    can_use = function(self,card) --define when able to use
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.count) then
            return true
        end
        return false
    end,
    use = function(self,card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3,0.5)
            return true end}))
        tarotConvert(G.hand.highlighted, 'm_osquo_ext_amberE') --this function is haunted
    end,
}

SMODS.Consumable{ --The Garden
    set = 'Tarot',
    atlas = 'qle_tarot',
    pos = {x = 1, y = 0},
    key = 'garden',
    config = {extra = {
        count = 2
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'growth_info'}
        return {vars = {
            card and card.ability.extra.count or self.config.extra.count
        }}
    end,
    can_use = function(self,card)
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.count) then
            return true
        end
        return false
    end,
    use = function(self,card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3,0.5)
            return true end}))
        tarotConvert(G.hand.highlighted, 'm_osquo_ext_growth')
    end,
}

SMODS.Consumable{ --The Croesus
    set = 'Tarot',
    atlas = 'qle_tarot',
    pos = {x = 1, y = 1},
    key = 'croesus',
    config = {extra = {
        limit = 1,
        sellvalue = 5,
        overselect = true
    }},
    loc_vars = function(self,info_queue,card)
        local main_end
        if G.consumeables then
            if card.area == G.consumeables then
                main_end = {}
                localize{
                    type = 'other',
                    key = 'osquo_ext_overselect_c',
                    nodes = main_end
                }
            end
        end
        return {
            main_end = main_end and main_end[1],
            vars = {
                card and card.ability.extra.limit or self.config.extra.count,
                card and card.ability.extra.sellvalue or self.config.extra.count,
            }
        }
    end,
    can_use = function(self,card)
        --If using on a joker, no consumeables must be selected OR this card must be the only selected consumeable
        if #G.jokers.highlighted == card.ability.extra.limit and ((not G.consumeables.highlighted[1]) or (#G.consumeables.highlighted == 1 and G.consumeables.highlighted[1] == card)) then
            return true
        --If using on a consumeable, it must either be the only one selected OR the only other one out of two selected cards, including this one 
        elseif (#G.consumeables.highlighted == card.ability.extra.limit and G.consumeables.highlighted[1] ~= card) or (#G.consumeables.highlighted == (card.ability.extra.limit + 1) and table_contains(G.consumeables.highlighted, card)) then
            return true
        end
        return false
    end,
    use = function(self,card, area)
        --Get a list of cards that need modifying. Should always be just 1 normally, but it should be able to be compatable with more anyway
        local cardlist = {}
        if #G.jokers.highlighted == card.ability.extra.limit and ((not G.consumeables.highlighted[1]) or (#G.consumeables.highlighted == 1 and G.consumeables.highlighted[1] == card)) then
            for k, v in pairs(G.jokers.highlighted) do
                cardlist[#cardlist+1] = v
            end
        elseif (#G.consumeables.highlighted == card.ability.extra.limit and G.consumeables.highlighted[1] ~= card) or (#G.consumeables.highlighted == (card.ability.extra.limit + 1) and table_contains(G.consumeables.highlighted, card)) then
            for k, v in pairs(G.consumeables.highlighted) do
                if v ~= card then cardlist[#cardlist+1] = v end
            end
        end
        for i = 1, #cardlist do
            cardlist[i].ability.extra_value = (cardlist[i].ability.extra_value or 0) + card.ability.extra.sellvalue
            cardlist[i]:set_cost()
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                SMODS.calculate_effect({message = localize('k_val_up'), colour = G.C.MONEY}, cardlist[i])
                cardlist[i]:juice_up(0.3, 0.5)
            return true end }))
        end
        if area == G.consumeables then
            area.config.highlighted_limit = area.config.highlighted_limit - card.ability.extra.limit
        end
        delay(0.6)
    end
}

SMODS.Consumable{ --Fortitude
    set = 'Tarot',
    atlas = 'qle_tarot',
    pos = {x = 2, y = 0},
    key = 'fortitude',
    config = {extra = {
        limit = 1,
        inc = 2
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.limit,
            card.ability.extra.inc
        }}
    end,
    can_use = function(self,card)
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.limit) then
            return true
        end
        return false
    end,
    use = function(self,card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3,0.5)
            return true end}))
        ConvertCards(G.hand.highlighted, nil, nil, nil, nil, nil, card.ability.extra.inc, 'fortitude')
    end
}
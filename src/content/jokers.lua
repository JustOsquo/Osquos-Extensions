--[[ ORDINARY JOKERS ]]--

SMODS.Joker{ --Walled City
    key = 'walledcity',
    loc_txt = {set = 'Joker', loc_txt = 'j_osquo_ext_walledcity'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 7},
    rarity = 3,
    cost = 5,
    config = {extra = {
        xmulteach = 1,
        xmult = 1,
        req = 5,
    }},
    set_ability = function(self,card,initial,delay_sprites)
        card.ability.extra.req = G.GAME.starting_params.joker_slots or 5
    end,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card:gabil('xmulteach'),
            card:gabil('xmult'),
            card:gabil('req')
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    update = function(self,card,context)
        if G.jokers and G.jokers.cards then
            local count = #G.jokers.cards - card.ability.extra.req
            card.ability.extra.xmult = (card.ability.extra.xmulteach * count) + 1
            if card.ability.extra.xmult < 1 then card.ability.extra.xmult = 1 end
        else
            card.ability.extra.xmult = 1
        end
    end
}

SMODS.Joker{ --Abandoned Joker
    key = 'general',
    loc_txt = {set = 'Joker', loc_txt = 'j_osquo_ext_general'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 7, y = 6},
    rarity = 3,
    cost = 8,
    config = {extra = {
        chips = 0,
        chipsgain = 20
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card:gabil('chips'),
            card:gabil('chipsgain')
        }}
    end,
    calculate = function(self,card,context)
        if context.discard and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.chips = card:gabil('chips') + card:gabil('chipsgain')
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        elseif context.joker_main then
            return {
                chips = card:gabil('chips')
            }
        elseif context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.chips = 0
            return {
                message = localize('osquo_ext_scalereset')
            }
        end
    end
}

SMODS.Joker{ --Lottery Ticket
    key = 'lottery',
    loc_txt = {set = 'Joker', loc_txt = 'j_osquo_ext_lottery'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 7},
    rarity = 3,
    cost = 9,
    config = {extra = {
        dollars = 1 --not used since the description is long enough already and i didnt want to pad it out with variables
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card:gabil('dollars'),
        }}
    end,
    calculate = function(self,card,context)
        if context.pseudorandom_result then
            if context.result then
                local payout = context.denominator / context.numerator
                payout = round(payout)
                return {
                    dollars = payout
                }
            end
        end
    end
}

SMODS.Joker{ --Bergentrückung
    key = 'hourofneed',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_hourofneed'},
    blueprint_compat = true,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 1, y = 7},
    rarity = 3,
    cost = 10,
    config = {extra = {
        disables = 3
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card:gabil('disables')
        }}
    end,
    calculate = function(self,card,context)
        if context.hand_drawn and G.GAME.current_round.hands_left == 1 then
            if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                G.GAME.blind:disable()
                if card:gabil('disables') < 2 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true;
                                end
                            }))
                        return true
                        end
                    }))
                end
            end
        elseif context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.disables = card.ability.extra.disables - 1
            return {
                message = card.ability.extra.disables..'',
                colour = G.C.FILTER
            }
        end
    end
}

SMODS.Joker{ --Shaman
    key = 'shaman',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_shaman'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 6, y = 6},
    rarity = 1,
    cost = 5,
    config = {extra = {
        odds = 5
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'osquo_ext_shaman')
        }}
    end,
    calculate = function(self,card,context)
        if context.before then
            if #context.full_hand == 1 and context.full_hand[1]:is_suit('Clubs') then
                if context.full_hand[1]:get_id() ~= 11 then
                    if SMODS.pseudorandom_probability(card, 'osquo_ext_shaman', 1, card:gabil('odds')) then
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({func = (function()
                                SMODS.add_card{set = 'Tarot', key_apped = 'shaman'}
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                            return {
                                message = localize('k_plus_tarot'),
                                colour = G.C.SECONDARY_SET.Tarot,
                            }
                        end
                    end
                else
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({func = (function()
                            SMODS.add_card{set = 'Tarot', key_append = 'shaman'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                        return {
                            message = localize('k_plus_tarot'),
                            colour = G.C.SECONDARY_SET.Tarot,
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{ --Moneyshot
    key = 'moneyshot',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_moneyshot'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 6},
    rarity = 2,
    cost = 5,
    config = {extra = {
        dollars = 2,
        xmult = 2
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card:gabil('dollars'), --Card:gabil() test, might use this in the future might not idk
            --card.ability.extra.dollars,
            card.ability.extra.xmult
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars * -1,
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ --Scavenger
    key = 'scavenger',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_scavenger'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 6},
    rarity = 1,
    cost = 6,
    config = {extra = {
        odds = 3,
        odds_2 = 5
    }},
    loc_vars = function(self,info_queue,card)
        local a, b = SMODS.get_probability_vars(card, 1, card:gabil('odds'), 'osquo_ext_scavenger_tag')
        local c, d = SMODS.get_probability_vars(card, 1, card:gabil('odds_2'), 'osquo_ext_scavenger_rare')
        return { vars = {
            a, b,
            c, d
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_type_destroyed then
            if SMODS.pseudorandom_probability(card, 'osquo_ext_scavenger_tag', 1, card:gabil('odds')) then
                local newtag = 'tag_uncommon'
                if SMODS.pseudorandom_probability(card, 'osquo_ext_scavenger_rare', 1, card:gabil('odds_2')) then newtag = 'tag_rare' end
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        card:juice_up()
                        add_tag(Tag(newtag))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                end)}))
            end
        end
    end
}

SMODS.Joker{ --Refund Policy
    key = 'refundpolicy',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_refundpolicy'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 6},
    rarity = 1,
    cost = 6,
    config = {extra = {
        not_used_this_round = true
    }},
    calculate = function(self,card,context)
        if context.skipping_booster and card.ability.extra.not_used_this_round == true then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card:juice_up()
                    add_tag(Tag(pseudorandom_element(
                        {'tag_standard', 'tag_charm', 'tag_meteor', 'tag_ethereal'}, pseudoseed('refundpolicy')
                    )))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
            end)}))
            card.ability.extra.not_used_this_round = false
        elseif context.setting_blind then
            card.ability.extra.not_used_this_round = true
        end
    end
}

SMODS.Joker{ --Butcher
    key = 'bloodyjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bloodyjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 2, y = 6},
    rarity = 3,
    cost = 7,
    config = {extra = {
        xmult = 1,
        scale = 0.2,
        jlist = {}
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmult,
            card.ability.extra.scale
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            local mypos = nil
            for i = 1, #G.jokers.cards do --Find position of this card
                if G.jokers.cards[i] == card then mypos = i; break end
            end
            card.ability.extra.jlist = {}
            for i = 1, #G.jokers.cards do
                if i > mypos then --Only cards to the right of this one
                    if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then --If not eternal and not already being destroyed
                        card.ability.extra.jlist[#card.ability.extra.jlist+1] = G.jokers.cards[i]
                    end
                end
            end
            if #card.ability.extra.jlist > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.scale * #card.ability.extra.jlist)
                SMODS.destroy_cards(card.ability.extra.jlist)
                return {
                    extra = {focus = card, message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.xmult)}}}
                }
            end
        elseif context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ --Virtual Singer
    key = 'virtualsinger',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_virtualsinger'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 6},
    rarity = 2,
    cost = 6,
    config = {extra = {
        count = 0,
        per = 3
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            (card.ability.extra.count * card.ability.extra.per),
            card.ability.extra.per
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                mult = card.ability.extra.count * card.ability.extra.per
            }
        end
    end,
    update = function(self,card,context)
        card.ability.extra.count = 0
        if G.playing_cards and #G.playing_cards ~= 0 then
            for k, v in pairs(G.playing_cards) do
                if v:is_face() then card.ability.extra.count = card.ability.extra.count + 1 end
            end
        end
    end
}

SMODS.Joker{ --Cheshire Cat
    key = 'cheshirecat',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_cheshirecat'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 5},
    rarity = 2,
    cost = 6,
    config = {extra = {
        xmult = 3
    }},
    loc_vars = function(self,info_queue,card)
        return{ vars = {
            card.ability.extra.xmult
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local allow = true
            for k, v in pairs(context.full_hand) do
                if not v:is_face() then allow = false end
            end
            if allow == true then return { xmult = card.ability.extra.xmult} end
        end
    end
}

SMODS.Joker{ --Bargaining Joker
    key = 'bargainingjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bargainingjoker'},
    blueprint_compat = false,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 0, y = 6},
    rarity = 1,
    cost = 3,
    config = {extra = {
        osquo_ext_ignoreslice = true --marks this card to be able to ignore getting_sliced, allowing it to calculate when it is destroyed (see lovely patch)
    }},
    loc_vars = function(self,info_queue,card)
        local main_end
        if G.jokers then
            if card.edition and card.edition.negative then
                main_end = {}
                localize{
                    type = 'other',
                    key = 'osquo_ext_retain_edition',
                    nodes = main_end
                }
            end
        end
        return {
            main_end = main_end and main_end[1]
        }
    end,
    calculate = function(self,card,context)
        if context.joker_type_destroyed and context.card == card and not context.blueprint then
            if G.STAGE == G.STAGES.RUN and not G.screenwipe then --Otherwise you cant go to main menu lol
                local _card = copy_card(card, nil, nil, nil, false)
                _card:add_to_deck()
                G.jokers:emplace(_card)
                _card:start_materialize()
            end
        end
    end
}

SMODS.Joker{ --Throwaway Line
    key = 'throwawayline',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_throwawayline'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 0, y = 5},
    rarity = 2,
    cost = 5,
    config = {extra = {
        mult = 0,
        mult_ref = {
            ['High Card'] = 1,
            ['Pair'] = 2,
            ['Two Pair'] = 3,
            ['Three of a Kind'] = 6,
            ['Straight'] = 8,
            ['Flush'] = 7,
            ['Full House'] = 10,
            ['Four of a Kind'] = 12,
            ['Straight Flush'] = 14,
            ['Five of a Kind'] = 18,
            ['Flush House'] = 22,
            ['Flush Five'] = 26,
            --Some modded hands for compatability
            --Handsome Devils
            ['hnds_stone_ocean'] = 5,
            --Maximus (6 Card Hands)
            ['mxms_three_pair'] = 7,
            ['mxms_s_straight'] = 11,
            ['mxms_s_flush'] = 10,
            ['mxms_double_triple'] = 12,
            ['mxms_house_party'] = 13,
            ['mxms_f_three_pair'] = 22,
            ['mxms_f_double_triple'] = 27,
            ['mxms_f_party'] = 29,
            ['mxms_6oak'] = 30,
            ['mxms_s_straight_f'] = 32,
            ['mxms_f_6oak'] = 36,
            --Cardsauce | YOU DONT NEED YOUR PREFIX IN THE KEY!!!!
            ['csau_csau_Blackjack'] = 7,
            ['csau_csau_FlushBlackjack'] = 10,
            ['csau_csau_Fibonacci'] = 10,
            ['csau_csau_FlushFibonacci'] = 16,
            --Cryptid
            ['cry_Bulwark'] = 5, --no idea how this works with stone ocean lmaoooo
            ['cry_Clusterfuck'] = 20,
            ['cry_UltPair'] = 28,
            ['cry_WholeDeck'] = 52525252525252525252525252525, --whatever
            ['cry_None'] = -1, --Why not lmao
            --GARBSHIT (Bisexuals and Quadrants)
            ['garb_str_house'] = 16,
            ['garb_str_four'] = 20,
            ['garb_str_five'] = 22,
            ['garb_str_fl_house'] = 28,
            ['garb_str_fl_five'] = 30,
            ['garb_blush'] = 12,
            ['garb_caliginous'] = 12,
            ['garb_ashen'] = 12,
            ['garb_pale'] = 12,
            --JoyousSpring
            ['joy_eldlixir'] = 8,
            --Visibility
            ['vis_industrialization'] = 8,
            ['vis_heavyweight'] = 16,
            --Might add more in the future
            --I'll add spectrum support once all the mods that add it just use the spectrum framework, im NOT adding spectrum like 4 seperate times, man.
        },
    }},
    loc_vars = function(self,info_queue,card)
        local handname = localize(G.GAME.current_round.osquo_ext_throwawayline_hand, 'poker_hands')
            or G.GAME.current_round.osquo_ext_throwawayline_hand
        return { vars = {
            (card.ability.extra.mult_ref[G.GAME.current_round.osquo_ext_throwawayline_hand] or G.GAME.hands[G.GAME.current_round.osquo_ext_throwawayline_hand].s_mult or 0), --fallback incase the hand isnt accounted for
            handname,
            card.ability.extra.mult
        }}
    end,
    calculate = function(self,card,context)
        if context.pre_discard and not context.blueprint then
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if text == G.GAME.current_round.osquo_ext_throwawayline_hand then
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_ref[G.GAME.current_round.osquo_ext_throwawayline_hand] or G.GAME.hands[G.GAME.current_round.osquo_ext_throwawayline_hand].s_mult or 0)
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        elseif context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --Prophecy
    key = 'prophecy',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_prophecy'},
    blueprint_compat = false,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 2, y = 5},
    rarity = 1,
    cost = 5,
    config = {extra = {
        payout = 20,
        loss = 4 -- YOU CANT ESCAPE LOSS
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.payout,
            card.ability.extra.loss
        }}
    end,
    calculate = function(self,card,context)
        if context.pre_discard and not context.blueprint then
            if card.ability.extra.payout <= card.ability.extra.loss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                    return true
                    end
                }))
                return {
                    message = localize('osquo_ext_broken')
                }
            else
                card.ability.extra.payout = card.ability.extra.payout - card.ability.extra.loss
                return {
                    extra = {focus = card, message = localize('osquo_ext_downgrade'), colour = G.C.attention}
                }
            end
        end
    end,
    calc_dollar_bonus = function(self,card) --End of round money handling
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        G.jokers:remove_card(card)
                        card:remove()
                        card = nil
                        return true;
                    end
                }))
            return true
            end
        }))
        return card.ability.extra.payout
    end
}

SMODS.Joker{ --Cosmos Joker
    key = 'cosmicjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_cosmicjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 5},
    rarity = 2,
    cost = 5,
    calculate = function(self,card,context)
        if context.before and G.GAME.current_round.hands_left == 0 then
            if G.GAME.last_hand_played then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.ATTENTION})
                SMODS.smart_level_up_hand(context.blueprint_card or card,G.GAME.last_hand_played,false,1)
            end
        end
    end
}

SMODS.Joker{ --Space Station
    key = 'spacetour',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_spacetour'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 5},
    rarity = 1,
    cost = 5,
    config = {extra = {
        dollarsper = 1,
        levelreq = 2
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.dollarsper,
            card.ability.extra.levelreq
        }}
    end,
    calculate = function(self,card,context)
        if context.pre_discard then
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            local count = getHandLevel(text)
            if math.floor(count / card.ability.extra.levelreq) ~= 0 then
                return {
                    dollars = math.floor(count / card.ability.extra.levelreq) * card.ability.extra.dollarsper
                }
            end
        end
    end
}

SMODS.Joker{ --Ledger
    key = 'ledger',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_ledger'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 5, y = 5},
    rarity = 1,
    cost = 4,
    config = {extra = {
        chips = 0
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.chips
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            local sv = 0
            for i = 1, #G.jokers.cards do
                sv = sv + G.jokers.cards[i].sell_cost
            end
            card.ability.extra.chips = card.ability.extra.chips + sv
            return {
                extra = {focus = card, message = localize{type='variable',key='a_chips',vars={(card.ability.extra.chips)}}}
            }
        elseif context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{ --Volcano
    key = 'volcano',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_volcano'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 6, y = 5},
    rarity = 3,
    cost = 8,
    config = {extra = {
        xmult = 1,
        odds = 4,
        scale = 0.75
    }},
    loc_vars = function(self,info_queue,card)
        local a, b = SMODS.get_probability_vars(card, 1, card:gabil('odds'), 'osquo_ext_volcano')
        return { vars = {
            a, b,
            card.ability.extra.xmult,
            card.ability.extra.scale
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'osquo_ext_volcano', 1, card:gabil('odds')) then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.scale
                return {
                    extra = {focus = card, message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.xmult)}}}
                }
            end
        elseif context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ --"Party Tiem!"
    key = 'partytiem',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_partytiem'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 7, y = 5},
    rarity = 2,
    cost = 5,
    config = {extra = {
        scalexmult = 0.2,
        currentxmult = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.scalexmult,
            card.ability.extra.currentxmult
        }}
    end,
    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            if next(context.poker_hands['Full House']) then
                card.ability.extra.currentxmult = card.ability.extra.currentxmult + card.ability.extra.scalexmult
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex'), colour = G.C.attention}
                }
            end
        elseif context.joker_main then
            return {
                xmult = card.ability.extra.currentxmult
            }
        end
    end
}

SMODS.Joker{ --Dealmaker
    key = 'dealmaker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_dealmaker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 8, y = 5},
    rarity = 1,
    cost = 3,
    config = {extra = {
        doleach = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.doleach
        }}
    end,
    calculate = function(self,card,context)
        if context.selling_card then
            local moneydol = math.floor(context.card.sell_cost / 3) * card.ability.extra.doleach + 1
            return {
                dollars = moneydol
            }
        end
    end
}

SMODS.Joker{ --Playful Joker
    key = 'tidyjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_tidyjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 9, y = 5},
    rarity = 2,
    cost = 5,
    config = {extra = {
        basexmult = 4,
        losteach = 0.5
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.basexmult,
            card.ability.extra.losteach
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local count = 0
            for k, v in pairs(G.hand.cards) do
                count = count + 1
            end
            local calcxmult = card.ability.extra.basexmult - (count * card.ability.extra.losteach)
            if calcxmult < 1 then calcxmult = 1 end
            return {
                xmult = calcxmult
            }
        end
    end
}

SMODS.Joker{ --Hypernova
    key = 'hypernova',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_hypernova'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 9, y = 4},
    rarity = 3,
    cost = 7,
    config = {extra = {
        givexmulteach = 0.2
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmulteach
        }}
    end,
    calculate = function(self,card,context)
        if context.prescoring then
            local levels = getHandLevel(context.scoring_name)
            if levels > to_big(0) then --Like stellar nova but xmult
                mult = mod_mult(mult * (levels * card.ability.extra.givexmulteach + 1))
                update_hand_text({delay = 0}, {mult = mult})
                card_eval_status_text(context.blueprint_card or card, 'jokers', nil, percent, nil, {message = localize{type='variable',key='a_xmult',vars={(levels * card.ability.extra.givexmulteach + 1)}}, Xmult_mod = (levels * card.ability.extra.givexmulteach + 1)})
            end
        end
    end
}

SMODS.Joker{ --Uniform Joker
    key = 'uniformjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_uniformjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 8, y = 4},
    rarity = 2,
    cost = 5,
    config = {extra = {
        xmultgive = 2,
        cardlimit = 3
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmultgive,
            card.ability.extra.cardlimit
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local cards = {}
            for i = 1, #context.full_hand do
                local rank = context.full_hand[i].base.id
                local suit = context.full_hand[i].base.suit
                if not table_contains(cards, rank..suit) then
                    cards[#cards+1] = rank..suit
                end
            end
            if #cards <= card.ability.extra.cardlimit then
                return {
                    xmult = card.ability.extra.xmultgive
                }
            end
        end
    end
}

SMODS.Joker{ --Ominous Masque
    key = 'ominousmasque',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_ominousmasque'},
    blueprint_compat = true,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 9, y = 3},
    rarity = 2,
    cost = 16,
    calculate = function(self,card,context)
        if context.selling_self then
            SMODS.add_card({
                set = 'Joker',
                rarity = 0.1,
                edition = 'e_negative'
            })
        end
    end
}

SMODS.Joker{ --Hungry Hungry Joker
    key = 'hungryhungryjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_hungryhungryjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 8, y = 3},
    rarity = 1,
    cost = 6,
    config = {extra = {
        multgain = 4,
        multnow = 0,
        deathmark = 0
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.multgain,
            card.ability.extra.multnow
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            card.ability.extra.deathmark = pseudorandom_element(G.deck.cards, pseudoseed('hungryhungry'))
            card.ability.extra.deathmark:start_dissolve()
            card.ability.extra.multnow = card.ability.extra.multnow + card.ability.extra.multgain
            return {
                extra = {focus = card, message = localize{type='variable',key='a_mult',vars={(card.ability.extra.multnow)}}, colour = G.C.MULT}
            }
        elseif context.joker_main then
            return {
                mult = card.ability.extra.multnow
            }
        end
    end
}

SMODS.Joker{ --Cheerleader Joker
    key = 'cheerleaderjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_cheerleaderjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 9, y = 2},
    rarity = 1,
    cost = 3,
    config = {extra = {
        chipsgain = 3,
        chipsnow = 0,
        testtable = {}
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.chipsgain,
            card.ability.extra.chipsnow
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chipsnow
            }
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            if not context.other_card.retrigger_check_cheerleaderjoker then
                local _other_card = context.other_card -- because context.other_card doesnt exist in events
                card.ability.extra.testtable[#card.ability.extra.testtable+1] = _other_card
                _other_card.retrigger_check_cheerleaderjoker = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        _other_card.retrigger_check_cheerleaderjoker = nil
                        return true
                    end}))
            else
                card.ability.extra.chipsnow = card.ability.extra.chipsnow + card.ability.extra.chipsgain
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex'), colour = G.C.attention}
                }
            end
        elseif context.after and not context.blueprint then --noticed some weird shenanigans, hope this fixes it but its really weird and hard to test
            for i = 1, #card.ability.extra.testtable do
                card.ability.extra.testtable[i].retrigger_check_cheerleaderjoker = nil
            end
            card.ability.extra.testtable = {}
        end
    end
}

SMODS.Joker{ --Sprite
    key = 'sprite',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_sprite'},
    blueprint_compat = true,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 8, y = 2},
    rarity = 2,
    cost = 6,
    calculate = function(self,card,context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                    func = (function()
                        card:juice_up()
                        add_tag(Tag('tag_voucher'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
            end)}))
        end
    end
}

SMODS.Joker{ --Algebra
    key = 'algebra',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_algebra'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 8, y = 1},
    rarity = 2,
    cost = 6,
    config = {extra = {
        givexmult = 3
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmult
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local ace = false
            local numbered = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then ace = true end
                if context.scoring_hand[i]:get_id() < 11 and context.scoring_hand[i]:get_id() > 0 then numbered = true end
            end
            if ace == true and numbered == true then
                return {
                    xmult = card.ability.extra.givexmult
                }
            end
        end
    end
}

SMODS.Joker{ --Mathematics
    key = 'mathematics',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_mathematics_unsolved'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 8, y = 0},
    rarity = 2,
    cost = 4,
    config = {extra = {
        reqsum = 0,
        givexmult = 1,
        xmultscale = 0.75,
        solved = false,
        token_name = 'j_osquo_ext_mathematics_unsolved'
    }},
    loc_vars = function(self,info_queue,card)
        return { key = card.ability.extra.token_name, vars = {
            card.ability.extra.reqsum,
            card.ability.extra.givexmult,
            card.ability.extra.xmultscale
        }}
    end,
    set_ability = function(self,card,initial,delay_sprites)
        card.ability.extra.reqsum = pseudorandom('mathematics'..G.GAME.round_resets.ante, 11, 50)
        card.children.center:set_sprite_pos({x = 8, y = 0})
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.givexmult
            }
        elseif context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.reqsum = pseudorandom('mathematics'..G.GAME.round_resets.ante, 11, 50)
            card.ability.extra.solved = false
            card.ability.extra.token_name = 'j_osquo_ext_mathematics_unsolved'
            card.children.center:set_sprite_pos({x = 8, y = 0})
            return {
                message = localize('osquo_ext_refreshed'),
                card = card
            }
        elseif context.before and (card.ability.extra.solved == false) and not context.blueprint then
            local handsum = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() < 11 then
                    handsum = handsum + context.full_hand[i]:get_id()
                end
            end
            if handsum == card.ability.extra.reqsum then
                card.ability.extra.givexmult = card.ability.extra.givexmult + card.ability.extra.xmultscale
                card.ability.extra.solved = true
                card.ability.extra.token_name = 'j_osquo_ext_mathematics_solved'
                card.children.center:set_sprite_pos({x = 9, y = 0})
                return {
                    message = localize('osquo_ext_solved'),
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ --Compensation
    key = 'compensation',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_compensation'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 9, y = 1},
    rarity = 2,
    cost = 1,
    config = {extra = {
        givexmult = 1,
        xmultper = 1
    }},
    in_pool = function(self, args)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.rental then return true end
        end
        return false
    end,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmult,
            card.ability.extra.xmultper
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local rentals = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.rental then rentals = rentals + 1 end
            end
            return {
                xmult = 1 + (card.ability.extra.givexmult * rentals)
            }
        end
    end
}

SMODS.Joker{ --Ghost Joker
    key = 'ghostjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_ghostjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 7, y = 2},
    soul_pos = {x = 7, y = 3},
    rarity = 2,
    cost = 5,
    config = {extra = {
        odds = 4
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'osquo_ext_ghostjoker')
        }}
    end,
    calculate = function(self,card,context)
        if context.using_consumeable and context.consumeable.ability.set == 'Spectral' then
            if SMODS.pseudorandom_probability(card, 'osquo_ext_ghostjoker', 1, card:gabil('odds')) then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local _card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sixth')
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
            end
        end
    end
}

SMODS.Joker{ --Junk Joker
    key = 'pickyjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_pickyjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 7, y = 1},
    rarity = 2,
    cost = 4,
    config = {extra = {
        dollarper = 3,
        discreq = 5,
        currentdisc = 0
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.dollarper,
            card.ability.extra.discreq,
            card.ability.extra.currentdisc
        }}
    end,
    calculate = function(self,card,context)
        if context.discard then
            card.ability.extra.currentdisc = card.ability.extra.currentdisc + 1
            if card.ability.extra.currentdisc >= card.ability.extra.discreq then
                card.ability.extra.currentdisc = 0
                return {
                    dollars = card.ability.extra.dollarper
                }
            end
        end
    end
}

SMODS.Joker{ --Hermit Joker
    key = 'hermitjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_hermitjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 7, y = 0},
    rarity = 3,
    cost = 1,
    config = {extra = {
        debtreq = 3,
        xmultper = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.debtreq,
            card.ability.extra.xmultper
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local debtmult = math.floor(G.GAME.dollars / card.ability.extra.debtreq) * -1 * card.ability.extra.xmultper
            if debtmult > 1 then
                return {
                    xmult = debtmult
                }
            end
        end
    end
}

SMODS.Joker{ --Helping Hand
    key = 'helpinghand',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_helpinghand'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 6, y = 4},
    rarity = 1,
    cost = 4,
    config = {extra = {}},
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            local gibmult = 0
            if context.other_card:get_id() > 0 and context.other_card:get_id() < 11 then
                gibmult = math.ceil(context.other_card:get_id() / 2)
            elseif (context.other_card:get_id() == 11) or (context.other_card:get_id() == 12) or (context.other_card:get_id() == 13) then
                gibmult = 5
            elseif context.other_card:get_id() == 14 then
                gibmult = 6
            end
            return {
                mult = gibmult
            }
        end
    end
}

SMODS.Joker{ --Fraudulent Joker
    key = 'fraudjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_fraudjoker'},
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 6, y = 3},
    rarity = 2,
    cost = 4,
    no_pool_flag = 'osquo_ext_fraudjokerbusted',
    config = {extra = {
        odds = 5,
        givexmult = 1.5,
        xmulteach = 0.5
    }},
    loc_vars = function(self,info_queue,card)
        local a, b = SMODS.get_probability_vars(card, 1, card:gabil('odds'), 'osquo_ext_fraudjoker')
        return {vars = {
            a, b,
            card.ability.extra.givexmult,
            card.ability.extra.xmulteach
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.givexmult
            }
        elseif context.end_of_round and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'osquo_ext_fraudjoker', 1, card:gabil('odds')) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                    return true
                    end
                }))
                G.GAME.pool_flags.osquo_ext_fraudjokerbusted = true
                return {
                    message = localize('osquo_ext_fraudjokerbusted')
                }
            else
                card.ability.extra.givexmult = card.ability.extra.givexmult + card.ability.extra.xmulteach
                return {
                    message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.givexmult)}},
                }
            end
        end
    end
}

SMODS.Joker{ --Corrupt Joker
    key = 'corruptjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_corruptjoker'},
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 7, y = 4},
    rarity = 2,
    cost = 4,
    yes_pool_flag = 'osquo_ext_fraudjokerbusted',
    config = {extra = {
        xmultgain = 0.25,
        xmultloss = 1,
        xmultnow = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmultgain,
            card.ability.extra.xmultloss,
            card.ability.extra.xmultnow
        }}
    end,
    calculate = function(self,card,context)
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.xmultnow = card.ability.extra.xmultnow + card.ability.extra.xmultgain
            return {
                message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.xmultnow)}}
            }
        elseif context.buying_card and context.card.ability.set == 'Joker' and not context.blueprint then
            if (card.ability.extra.xmultnow - card.ability.extra.xmultloss) < 1 then
                card.ability.extra.xmultnow = 1
            else
                card.ability.extra.xmultnow = card.ability.extra.xmultnow - card.ability.extra.xmultloss
            end
            return {
                message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.xmultnow)}}
            }
        elseif context.joker_main then
            return {
                xmult = card.ability.extra.xmultnow
            }
        end
    end
}

SMODS.Joker{ --Joker-in-the-dell
    key = 'delljoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_delljoker'},
    blueprint_compat = false,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 6, y = 2},
    rarity = 2,
    cost = 6,
    config = {extra = {}},
    calculate = function(self,card,context)
        local eval = function() return G.GAME.current_round.hands_played == 0 end
        juice_card_until(card, eval, true)
        if context.destroy_card and context.full_hand[5] and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            if context.destroy_card == context.full_hand[5] then
                return {
                    card = card,
                    remove = true
                }
            end
        end
    end
}

SMODS.Joker{ --Ostrakon
    key = 'ostracon',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_ostracon'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 6, y = 1},
    rarity = 1,
    cost = 4,
    config = {extra = {
        odds = 2
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'osquo_ext_ostracon')
        }}
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'osquo_ext_ostracon', 1, card:gabil('odds')) then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        card:juice_up()
                        add_tag(Tag(getRandomTag({'tag_orbital'}, 'ostracon')))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                end)}))
            end
        end
    end
}

SMODS.Joker{ --Three Body Problem
    key = 'chaostheory',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_chaostheory'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 4},
    rarity = 1,
    cost = 4,
    config = {extra = {
        fella = 2, --retrigger #
        cerd = nil --card to retrigger
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.fella
        }}
    end,
    calculate = function(self,card,context)
        if context.before then
            card.ability.extra.cerd = pseudorandom_element(context.scoring_hand, pseudoseed('chaostheory')) --random card in scoring hand
        elseif context.repetition and context.cardarea == G.play then
            if context.other_card == card.ability.extra.cerd then
                return {
                    repetitions = card.ability.extra.fella,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ --Grand Finale
    key = 'grandfinale',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_grandfinale'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 4},
    rarity = 1,
    cost = 4,
    config = {extra = {
        againzo = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.againzo
        }}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then --final card in scoring hand
                return {
                    repetitions = card.ability.extra.againzo,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ --Bounty Hunter
    key = 'bountyhunter',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bountyhunter'},
    blueprint_compat = false,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    rarity = 2,
    cost = 5,
    config = { extra = {
        moneys = 8,
        potential = false
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.moneys,
            localize(G.GAME.current_round.osquo_ext_bountyhunter_card.suit, 'suits_plural'),
            localize(G.GAME.current_round.osquo_ext_bountyhunter_card.rank, 'ranks'),
            colours = {G.C.SUITS[G.GAME.current_round.osquo_ext_bountyhunter_card.suit]}
        }}
    end,
    calculate = function(self,card,context)
        if (context.hand_drawn or context.after or context.using_consumeable) and not context.open_booster and not context.blueprint then
            for k, v in ipairs(G.hand.cards) do
                if (v:get_id() == G.GAME.current_round.osquo_ext_bountyhunter_card.id and v:is_suit(G.GAME.current_round.osquo_ext_bountyhunter_card.suit)) then
                    card.ability.extra.potential = true
                    break
                else
                    card.ability.extra.potential = false
                end
            end
        end
        if context.end_of_round and not context.blueprint then card.ability.extra.potential = false end
        local eval = function(card) return card.ability.extra.potential == true end
        juice_card_until(card, eval, true)
        if context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 then
                if context.destroy_card:get_id() == G.GAME.current_round.osquo_ext_bountyhunter_card.id and context.destroy_card:is_suit(G.GAME.current_round.osquo_ext_bountyhunter_card.suit) then
                    if context.destroy_card == context.full_hand[1] then
                        return {
                            dollars = 8,
                            card = card,
                            remove = true
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{ --Scrooge Joker
    key = 'scroogejoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_scroogejoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 1},
    rarity = 2,
    cost = 5,
    config = { extra = {
        givexmult = 1.5
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmult
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_gold') then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card
                    }
                else
                    return {
                        xmult = card.ability.extra.givexmult,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Shareholder | Concept from r/Balatro, thanks u/Imperator_Subira !
    key = 'shareholder',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_shareholder'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 1, y = 0},
    rarity = 3,
    cost = 7,
    config = {extra = {
        dollarlose = 0.25,
        xmultper = 0.05,
        xmultcurrent = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.dollarlose*100,
            card.ability.extra.xmultper,
            card.ability.extra.xmultcurrent
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmultcurrent
            }
        elseif context.ending_shop and context.cardarea == G.jokers then
            local losehalf = math.floor(G.GAME.dollars*card.ability.extra.dollarlose)
            card.ability.extra.xmultcurrent = card.ability.extra.xmultcurrent + (card.ability.extra.xmultper*losehalf)
            return {
                dollars = -losehalf,
                message = localize{type='variable',key='a_xmult',vars={(card.ability.extra.xmultcurrent)}},
                colour = G.C.attention
            }
        end
    end
}

SMODS.Joker{ --Western Joker
    key = 'westernjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_westernjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 2},
    rarity = 3,
    cost = 5,
    config = {extra = {
        options = { --Weighted Table for getRandomIndexWeighted()
            {8, 'pchips'},
            {4, 'pmult'},
            {2, 'pxmult'},
            {1, 'pdollar'},
        },
        amounts = {
            pchips = 3,
            pmult = 1,
            pxmult = 0.02,
            pdollar = 1,
        },
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.amounts.pchips,
            card.ability.extra.amounts.pmult,
            card.ability.extra.amounts.pxmult,
            card.ability.extra.amounts.pdollar,
        }}
    end,
    calculate = function(self,card,context) --There was probably a better way to do this
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == 'Wild Card' then
                local chosenup = getRandomElementWeighted(card.ability.extra.options, 'westernjoker')
                if chosenup == 'pchips' then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.amounts.pchips
                    return {
                        extra = {message = localize('osquo_ext_chipsupg'), colour = G.C.CHIPS},
                        card = card
                }   
                elseif chosenup == 'pmult' then
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.amounts.pmult
                    return {
                        extra = {message = localize('osquo_ext_multupg'), colour = G.C.MULT},
                        card = card
                    }
                elseif chosenup == 'pxmult' then
                    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 1
                    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.amounts.pxmult
                    return {
                        extra = {message = localize('osquo_ext_xmultupg'), colour = G.C.MULT},
                        card = card
                    }
                elseif chosenup == 'pdollar' then
                    context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars or 0
                    context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.amounts.pdollar
                    return {
                        extra = {message = localize('osquo_ext_dollarupg'), colour = G.C.MONEY},
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Bumper
    key = 'bumperjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bumperjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 2},
    rarity = 1,
    cost = 3,
    config = {extra = {
        rscore = 1000
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.rscore
        }}
    end,
    calculate = function(self,card,context)
        if context.before then
            return {
                osquo_ext_rscore = card.ability.extra.rscore --see hookers.lua
            }
        end
    end
}

SMODS.Joker{ --Illegible Joker
    key = 'illegiblejoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_illegiblejoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 3},
    rarity = 2,
    cost = 5,
    config = {extra = {
        retrig = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.retrig,
        }}
    end,
    calculate = function(self,card,context)
        if (context.repetition and context.cardarea == G.play) or (context.repetition and context.cardarea == G.hand and not context.repetition_only) then
            if (context.other_card:get_id() < 0) or (SMODS.has_no_rank(context.other_card)) then
                return {
                    repetitions = card.ability.extra.retrig,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ --Cryptic Joker
    key = 'crypticjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_crypticjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 1},
    rarity = 2,
    cost = 6,
    config = { extra = {}},
    calculate = function(self,card,context)
        local eval = function() return G.GAME.current_round.hands_played == 0 end
        juice_card_until(card, eval, true)
        if context.after and G.GAME.current_round.hands_played == 0 then
            for k, v in ipairs(context.full_hand) do
                local rngsuit = pseudorandom_element(SMODS.Suits, pseudoseed('crypticjoker')).key --This shit is also haunted man. Wtf
                local rngrank = pseudorandom_element(SMODS.Ranks, pseudoseed('crypticjoker')).key
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    card:juice_up()
                    v:juice_up(0.3, 0.4)
                    play_sound('tarot1')
                    assert(SMODS.change_base(v, rngsuit, rngrank))
                return true end }))
            end
        end
    end
}

SMODS.Joker{ --Ritualist
    key = 'ritualist',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_ritualist'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 5, y = 0},
    rarity = 2,
    cost = 5,
    config = {extra = {
        basetrig = 1, --retriggers per unscored card played
        count = 0, --tally of unscored cards
        die = {} --table of unscored cards
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.basetrig
        }}
    end,
    calculate = function(self,card,context)
        if context.before then
            card.ability.extra.ritflag = false
            card.ability.extra.count = 0
            card.ability.extra.die = {}
            for k, v in ipairs(context.full_hand) do --for each card in full hand
                if not table_contains(context.scoring_hand, v) then --if its not in the scoring hand
                    card.ability.extra.die[#card.ability.extra.die+1] = v --then its unscoring, add it to table
                    card.ability.extra.count = card.ability.extra.count + 1 --increment
                end
            end
        elseif context.repetition and context.cardarea == G.play then
            local triggers = card.ability.extra.basetrig*card.ability.extra.count
            if context.other_card == context.scoring_hand[1] then --first scored card
                return {
                    repetitions = triggers,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        end
    end
} --I HATE CODING THIS MFING JOKER MAN

SMODS.Joker{ --Cabinet Joker
    key = 'cabinetjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_cabinetjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'cabinetjoker_animated',
    pos = {x = 0, y = 0},
    AddRunningAnimation({'j_osquo_ext_cabinetjoker',0.125,3,4,'loop',0,0,card}), --Animated waow
    rarity = 2,
    cost = 5,
    config = {extra = {
        givedollar = 4,
        bspa = 0.75, --blind size per ante
        currentscale = 1.75
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givedollar,
            card.ability.extra.bspa,
            card.ability.extra.currentscale
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() --increasing the required score
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.currentscale)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate()
                chips_UI:juice_up()
                if not silent then play_sound('chips2') end
            return true end}))
        elseif context.after then
            local checkscore = ((G.GAME.chips) + (hand_chips*mult)) --check talisman compat
            if checkscore < G.GAME.blind.chips then
                return {
                    dollars = card.ability.extra.givedollar*(G.GAME.current_round.hands_played+1),
                    card = card
                }
            end
        end
    end,
    update = function(self,card,context)
        card.ability.extra.currentscale = (card.ability.extra.bspa*(G.GAME.round_resets.ante or 1)) + 1
    end
}

SMODS.Joker{ --Temperate Joker
    key = 'temperatejoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_temperatejoker'},
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 4, y = 3},
    rarity = 1,
    cost = 4,
    config = {extra = {
        givexmult = 2,
        losexmult = 0.1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmult,
            card.ability.extra.losexmult
        }}
    end,
    calculate = function(self,card,context)
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.givexmult = card.ability.extra.givexmult - card.ability.extra.losexmult
            if card.ability.extra.givexmult >= 1 then
                return {
                    message = localize{type='variable',key='a_xmult_minus',vars={(card.ability.extra.losexmult)}},
                    colour = G.C.RED
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end}))
                        return true
                    end
                }))
                return {
                    message = localize('osquo_ext_temperategone'),
                    colour = G.C.FILTER
                }
            end
        elseif context.joker_main then
            return {
                xmult = card.ability.extra.givexmult
            }
        end
    end
}

SMODS.Joker{ --Transmutation
    key = 'transmutation',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_transmutation'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 6, y = 0},
    rarity = 3,
    cost = 8,
    config = {extra = {
        convperc = 0.20 --percentage
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.convperc*100 --convert to percentage for loc_vars
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local shift = to_big(hand_chips) * to_big(card.ability.extra.convperc)
            return {
                chips = -shift,
                mult = shift
            }
        end
    end
}

SMODS.Joker { --Buff Ace
    key = 'bufface',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bufface'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 4, y = 1},
    rarity = 3,
    cost = 6,
    config = {extra = {
        scaledchips = 0,
        scaler = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.scaledchips,
            card.ability.extra.scaler
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then --if ace
                if not context.blueprint then
                    card.ability.extra.scaledchips = card.ability.extra.scaledchips + card.ability.extra.scaler
                    message = localize('k_upgrade_ex')
                end
                return {
                    chips = card.ability.extra.scaledchips
                }
            end
        end
    end
}

SMODS.Joker{ --Lab-Grown Gem
    key = 'labgrowngem',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_labgrowngem'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 3, y = 3},
    rarity = 2,
    cost = 5,
    config = {extra = {
        each = 1,
        current = 0,
        diamond = false,
        said = false
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.each,
            card.ability.extra.current,
            card.ability.extra.diamond,
            card.ability.extra.said --handles the "Reset!" message when playing a diamond
        }}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            card.ability.extra.diamond = false
            card.ability.extra.said = false
        end
        --if context.individual and context.cardarea == G.play then
        if context.before then
            for i = 1, #context.full_hand do
                if not SMODS.has_no_suit(context.full_hand[i]) then
                    if context.full_hand[i].ability.name == 'Wild Card' then card.ability.extra.diamond = true --check if wild card is played
                    elseif context.full_hand[i].base.suit == 'Diamonds' then card.ability.extra.diamond = true --or if diamond played
                    end
                end
            end
            if card.ability.extra.diamond == true and card.ability.extra.said == false then
                card.ability.extra.current = 0
                card.ability.extra.said = true --only once per round
                return {
                    message = localize('osquo_ext_scalereset'), --"Reset!"
                    card = card
                }
            end
        end
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.diamond == false then
                card.ability.extra.current = card.ability.extra.current + card.ability.extra.each
            end
        end
    end,
    calc_dollar_bonus = function(self,card) --End of round money handling
        if card.ability.extra.diamond == false then
            local moneybonus = card.ability.extra.current
            if moneybonus > 0 then return moneybonus end
        end
    end
}

SMODS.Joker{ --Stellar Nursery
    key = 'stellarnursery',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_stellarnursery'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 3},
    rarity = 2,
    cost = 4,
    config = {extra = {
        multeach = 2
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.multeach
        }}
    end,
    calculate = function(self,card,context)
        if context.prescoring then --Context added in lovely patch
            local thishand = context.scoring_name --This poker hand
            local levels = getHandLevel(thishand, true, true) * card.ability.extra.multeach --See extraFuncs.lua
            if levels > to_big(0) then
                mult = mod_mult(mult + levels) --Very archaic mult-adding since the normal return{mult} doesnt work here
                update_hand_text({delay = 0}, {mult = mult})
                card_eval_status_text(context.blueprint_card or card, 'jokers', nil, percent, nil, {message = localize{type='variable',key='a_mult',vars={levels}}, mult_mod = levels})
            end
        end
    end
}

SMODS.Joker{ --Background Check
    key = 'backgroundcheck',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_backgroundcheck'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x=1,y=3},
    rarity = 2,
    cost = 5,
    config = {extra = {
        xmulteach = 0.04,
    }},
    pixel_size = {h = 95 / 1.05},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmulteach,
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and not SMODS.has_no_suit(context.other_card) then
            local mysuit = context.other_card.base.suit
            local alike = 0
            for i = 1, #context.scoring_hand do --for every card in scoring hand
                if not SMODS.has_no_suit(context.scoring_hand[i]) then
                    if SMODS.has_any_suit(context.other_card) then mysuit = context.scoring_hand[i].base.suit end
                    if not SMODS.has_any_suit(context.scoring_hand[i]) then
                        if context.scoring_hand[i].base.suit == mysuit then alike = alike + 1 end
                    elseif SMODS.has_any_suit(context.scoring_hand[i]) then
                        alike = alike + 1
                    end
                end
            end
            return {
                xmult = 1 + alike*card.ability.extra.xmulteach
            }
        end
    end
}

SMODS.Joker{ --Amber Resin
    key = 'sweetresin',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_sweetresin'},
    blueprint_compat = true,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = {x = 4, y = 0},
    rarity = 2,
    cost = 3,
    config = {extra = {
        converts = 3
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'amber_info'}
        return { vars = {
            card.ability.extra.converts
        }}
    end,
    calculate = function(self,card,context)
        if context.before and card.ability.extra.converts > 0 then
            local check = false
            eligibleCards = {}
            for k, v in ipairs(context.scoring_hand) do
                if not SMODS.has_enhancement(v, 'm_osquo_ext_amberE') then
                    check = true
                    eligibleCards[#eligibleCards+1] = v
                end
            end
            local toconvert = pseudorandom_element(eligibleCards, pseudoseed('sweetresin'))
            if toconvert then
                toconvert:set_ability(G.P_CENTERS.m_osquo_ext_amberE, nil, true) --Set enhancement to amber
                G.E_MANAGER:add_event(Event({
                    func = function()
                        toconvert:juice_up() --JUUUUIICEEE
                        return true
                    end}))
                if check then SMODS.calculate_effect({message = localize('osquo_ext_amberconvert'), colour = G.C.ATTENTION}, card) end
            end
        end
        if context.after then
            card.ability.extra.converts = card.ability.extra.converts - 1
            if card.ability.extra.converts > 0 then
                message = localize('osquo_ext_minusone')
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                    return true
                    end
                }))
                return {
                    message = localize('osquo_ext_sweetresinlicked')
                }
            end
        end
    end
}

SMODS.Joker{ --Idolatry
    key = 'idolatry',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_idolatry'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 3},
    rarity = 1,
    cost = 5,
    config = {extra = {
        retrig = 2
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.retrig,
            localize(G.GAME.current_round.osquo_ext_idolatry_card.rank, 'ranks'),
        }}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == G.GAME.current_round.osquo_ext_idolatry_card.id then
                return {
                    repetitions = card.ability.extra.retrig,
                    message = localize('k_again_ex'),
                    card = card

                }
            end
        end
    end
}

SMODS.Joker{ --Stargazer
    key = 'stargazer',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_stargazer'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 2},
    rarity = 1,
    cost = 3,
    config = {extra = { --Most of these are unused i think
        handstolevel = 1,
        reqplanets = 1,
        usedplanets = 0,
        debugvalue = 0
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.handstolevel,
            card.ability.extra.reqplanets,
            card.ability.extra.usedplanets,
            card.ability.extra.debugvalue
        }}
    end,
    calculate = function(self,card,context)
        card.ability.extra.debugvalue = card.ability.extra.debugvalue + 1
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then --When using a planet card
            card.ability.extra.debugvalue = card.ability.extra.debugvalue + 1
            local text,disp_text = chooserandomhand({}, stargazer, false) --Get a random visible poker hand
            --upgrade it
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
            level_up_hand(context.blueprint_card or card, text, nil, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    end
}

SMODS.Joker{ --Earl
    key = 'earl',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_earl'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 2},
    rarity = 1,
    cost = 2,
    config = {extra = {
        giveMult = 4
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.giveMult
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_mult') then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = self
                    }
                else
                    return {
                        mult = card.ability.extra.giveMult,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Count
    key = 'count',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_count'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 1},
    rarity = 1,
    cost = 2,
    config = {extra = {
        giveChips = 30
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.giveChips
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_bonus') then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = self
                    }
                else
                    return {
                        chips = card.ability.extra.giveChips,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Knave
    key = 'knave',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_knave'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 0},
    rarity = 2,
    cost = 5,
    config = {extra = {
        givepchips = 125
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givepchips
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == 11 then --If jack
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card
                    }
                else
                    return {
                        chips = card.ability.extra.givepchips,
                        card = card --still dont know what this does | Upate: it tells the code this function returns to what card to put the juiceup and message on
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --The Harmony
    key = 'theharmony',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_theharmony'}, --WHY WONT IT FING WORK THERES NOTHING WRONG WITH IT???? Update: typo'd text as taxt fml
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 2},
    rarity = 2,
    cost = 5,
    config = {extra = {giveXmult = 2}},
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.giveXmult
            }
        }
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            local suits = {
            ['Hearts'] = 0,
            ['Diamonds'] = 0,
            ['Spades'] = 0,
            ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do --for every card in scoring hand
                if context.scoring_hand[i].ability.name ~= 'Wild Card' and not SMODS.has_no_suit(context.scoring_hand[i]) then --if not a wild card, check suit and add 1 to the suit count
                    if context.scoring_hand[i]:is_suit('Hearts', true) then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true)  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true)  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true)  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' and not SMODS.has_no_suit(context.scoring_hand[i]) then --if it's a wild card, add 1 to every suit count
                    suits["Hearts"] = suits["Hearts"] + 1
                    suits["Diamonds"] = suits["Diamonds"] + 1
                    suits["Spades"] = suits["Spades"] + 1
                    suits["Clubs"] = suits["Clubs"] + 1
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_no_suit(context.scoring_hand[i]) then
                    -- no suit lmao
                end
            end
            if suits['Hearts'] == suits['Diamonds'] and suits['Diamonds'] == suits['Spades'] and suits['Spades'] == suits['Clubs'] then --if all suit counts are co-equal
                return {
                    xmult = card.ability.extra.giveXmult
                }
            end
        end
    end
}

SMODS.Joker{ --Empowered Opal
    key = 'empoweredopal',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_empoweredopal'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'empoweredopal_animated', --Define correct atlas
    pos = {x = 0, y = 0}, --Starting frame of animation
    AddRunningAnimation({'j_osquo_ext_empoweredopal',0.125,5,5,'loop',0,0,card}), --thanks @bepisfever for the animateObjects code, if you want to use it i made an ELI5 on it's discord post (or check this mod's  animateObjects.lua file where i copied it to)
    rarity = 2,
    cost = 6,
    enhancement_gate = 'm_wild', --Can only appear if you have any wild cards in your deck
    config = {extra = {givexmult = 1, xmultmod = 0.05}},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.givexmult, card.ability.extra.xmultmod}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then --When scored
            if context.other_card.ability.name == 'Wild Card' and not context.blueprint then --If scored card is wild, but not if this is a blueprint (to prevent weird double-scaling)
                card.ability.extra.givexmult = card.ability.extra.givexmult + card.ability.extra.xmultmod
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex'), colour = G.C.MULT},
                    card = card
                }
            end
        elseif context.joker_main then --Here comes the Xmult
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.givexmult}},
                Xmult_mod = card.ability.extra.givexmult
            }
        end
    end
}

SMODS.Joker{ --Giant Joker
    key = 'giantjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_giantjoker'},
    blueprint_compat = false, --Because otherwise it'd get real weird with the way hand size actually works, see chicot hand size bug
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 2, y = 2},
    rarity = 3,
    cost = 10,
    config = {extra = {hsize = 0, hmod = 1, neededhands = 9, playedhands = 0}}, --defining config
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.hsize, card.ability.extra.hmod, card.ability.extra.neededhands, card.ability.extra.playedhands}} --I should really space these out better for readability lmao
    end,
    calculate = function(self,card,context)
        if context.after and not context.blueprint then --Even though it's incompatable, duping it with blueprint still increments its counter more than it should for some reason
            card.ability.extra.playedhands = card.ability.extra.playedhands + 1 --Congratulation you played a hand
            if card.ability.extra.playedhands >= card.ability.extra.neededhands then --If enough hands played
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true end }))
                card.ability.extra.hsize = card.ability.extra.hsize + card.ability.extra.hmod --rahhhh +1 hand size
                G.hand:change_size(card.ability.extra.hmod) --add hand size
                card.ability.extra.playedhands = 0 --Reset hand tally
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                }
            end
        end
    end,
    add_to_deck = function(self,card,from_debuff) --when acquired (doesnt do anything unless you copy one thats already been scaled since it starts at 0)
        G.hand:change_size(card.ability.extra.hsize)
    end,
    remove_from_deck = function(self,card,from_debuff) --When destroyed
        G.hand:change_size(-card.ability.extra.hsize)
    end
}

SMODS.Joker{ --Seelie
    key = 'seelie',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_seelie'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 1},
    rarity = 1,
    cost = 4,
    config = {extra = {}},
    calculate = function(self, card, context)
        local purples = {} --I think these are unused lol
        local blues = {}
        if context.individual and context.cardarea == G.play then --Scored cards
            if context.other_card.seal == 'Purple' then --Check seal
               if  #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then --If you have space
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1 --idk lmao
                    G.E_MANAGER:add_event(Event({ --Makes a random tarot
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'seelie')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    return {
                        message = localize('osquo_ext_1tarot'), --Tarot!
                        card = card
                    }
                end
            elseif context.other_card.seal == 'Blue' then --All ditto but with blue seal and planets
                if  #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'seelie')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    return {
                        message = localize('osquo_ext_1planet'),
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Reaper
    key = 'reaper',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_reaper'},
    blueprint_compat = false, --I think it gets copied anyway for some reason but copying it does literally nothing so whatever lmao
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 0},
    rarity = 3,
    cost = 8,
    config = { extra = {}},
    calculate = function(self, card, context)
        local eval = function() return G.GAME.current_round.hands_played == 0 end
        juice_card_until(card, eval, true)
        local handlist = G.hand.cards --shorthand
        if context.before and G.GAME.current_round.hands_played == 0 and not context.blueprint then --Before scoring, only if it's not been used already
            if #handlist >= 2 then
                local rightmost = handlist[#handlist] --#x = length of x
                local leftmost = handlist[1]
                local affected = {rightmost, leftmost} --shorthand
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() --Animation to flip the cards so it doesnt look like shit (copied from vanilla death tarot wtf is this code man im amazed this works)
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true end }))
                for i=1, #affected do
                    local percent = 1.15 - (i-0.999)/(#affected - 0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() affected[i]:flip();play_sound('card1', percent);affected[i]:juice_up(0.3, 0.3);return true end }))
                end
                delay(0.2)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() --SAY THE LINE, BART!!!
                    copy_card(rightmost, leftmost) --CONVERT THE LEFT CARD INTO THE RIGHT CARD
                    return true end }))
                for i=1, #affected do --Flip them back
                    local percent = 0.85 + (i-0.999)/(#affected-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() affected[i]:flip();play_sound('tarot2', percent, 0.6);affected[i]:juice_up(0.3, 0.3);return true end }))
                end
                delay(0.25)
            end
        end
    end
}

--[[ LEGENDARY JOKERS ]]--

SMODS.Joker{ --Stanczyk
    key = 'bubbleuniverse',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bubbleuniverse'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 4},
    soul_pos = {x = 3, y = 4},
    rarity = 4,
    cost = 20,
    config = {extra = {odds = 9}},
    loc_vars = function(self, info_queue, card)
        return {vars = {
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'osquo_ext_bubbleuniverse')
        }}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then --when selecting blind
            if SMODS.pseudorandom_probability(card, 'osquo_ext_bubbleuniverse', 1, card:gabil('odds')) then --1 in 9 normally
                local eligibleJokers = {} --defining eligible jokers
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].edition then
                        if not G.jokers.cards[i].edition.negative then eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] end --check if it's edition is negative, if not its eligible
                    else
                        eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] end --if it has no edition its eligible
                end
                if #eligibleJokers == 0 then return end --dont bother
                local chosencard = pseudorandom_element(eligibleJokers, pseudoseed('bubbleuniverse')) --choose a random eligible joker
                chosencard:set_edition('e_negative', true)
                chosencard:set_eternal(true) --make it negative and eternal
            end
        end
    end
}

SMODS.Joker{ --Nichola
    key = 'nichola',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_nichola'},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false, --i dont think legendaries can be perishable anyway but just in case
    atlas = 'Jokers',
    pos = {x = 0, y = 4},
    soul_pos = {x = 1, y = 4},
    rarity = 4,
    cost = 20,
    config = {extra = {
        givehsize = 1, reqcards = 3, current = 0, progress = 0
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givehsize,
            card.ability.extra.reqcards,
            card.ability.extra.current,
            card.ability.extra.progress
        }}
    end,
    calculate = function(self,card,context)
        if context.playing_card_added and not self.getting_sliced and (not context.blueprint) and context.cards and context.cards[1] then
            card.ability.extra.progress = card.ability.extra.progress + #context.cards
            if card.ability.extra.progress >= card.ability.extra.reqcards then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true end }))
                    card.ability.extra.progress = card.ability.extra.progress - card.ability.extra.reqcards
                    card.ability.extra.current = card.ability.extra.current + card.ability.extra.givehsize
                    G.hand:change_size(card.ability.extra.givehsize)
                    return {
                        message = localize('osquo_ext_1handsize'),
                        card = card
                    }
            end
        end
    end,
    add_to_deck = function(self,card,from_debuff) --when acquired (doesnt do anything unless you copy one thats already been scaled since it starts at 0)
        G.hand:change_size(card.ability.extra.current)
    end,
    remove_from_deck = function(self,card,from_debuff) --When destroyed
        G.hand:change_size(-card.ability.extra.current)
    end
}

SMODS.Joker{ --Osquo
    key = 'osquo',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_osquo'},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Jokers',
    pos = {x = 8, y = 6},
    soul_pos = {x = 9, y = 6},
    rarity = 4,
    cost = 20,
    config = {extra = {
        again = 1,
        scaler = 1,
        spentrq = 100,
        tracked = 0,
        reqscale = 100
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.again,
            card.ability.extra.scaler,
            card.ability.extra.spentrq,
            card.ability.extra.tracked
        }}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') then
                return {
                    repetitions = card.ability.extra.again,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        elseif context.osquo_ext and context.osquo_ext.money_altered and context.osquo_ext.alter < 0 and (not G.GAME.osquo_ext_using_consumeable)
        and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.PLAY_TAROT)
        and not context.blueprint then
                local spent = context.osquo_ext.alter * -1
                card.ability.extra.tracked = card.ability.extra.tracked + spent
                if card.ability.extra.tracked >= card.ability.extra.spentrq then
                    card.ability.extra.tracked = card.ability.extra.tracked - card.ability.extra.spentrq
                    card.ability.extra.again = card.ability.extra.again + card.ability.extra.scaler
                    card.ability.extra.spentrq = card.ability.extra.spentrq + card.ability.extra.reqscale
                    return {
                        message = localize('k_upgrade_ex')
                    }
                end
        end
    end
}
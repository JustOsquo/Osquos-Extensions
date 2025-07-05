local jd_def = JokerDisplay.Definitions

jd_def['j_osquo_ext_moneyshot'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'xmult', retrigger_type = 'exp'}
        }}
    },
    reminder_text = {
        {text = '-$'},
        {ref_table = 'card.ability.extra', ref_value = 'dollars', retrigger_type = 'mult'}
    },
    reminder_text_config = {colour = G.C.MONEY}
}
jd_def['j_osquo_ext_scavenger'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = '), '},
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds_2'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
        card.joker_display_values.odds_2 = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds_2}}
    end
}
jd_def['j_osquo_ext_refundpolicy'] = {
    reminder_text = {
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'active'},
        {text = ')'}
    },
    calc_function = function(card)
        card.joker_display_values.active = (card.ability.extra.not_used_this_round and localize('k_active')) or
            localize('osquo_ext_inactive')
    end
}
jd_def['j_osquo_ext_bloodyjoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'xmult', retrigger = 'exp'}
        }}
    }
}
jd_def['j_osquo_ext_virtualsinger'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'mult', retrigger = 'mult'}
    },
    text_config = {colour = G.C.MULT},
    calc_function = function(card)
        local count = 0
        if G.playing_cards and #G.playing_cards ~= 0 then
            for k, v in pairs(G.playing_cards) do
                if v:is_face() then count = count + 1 end
            end
        end
        card.joker_display_values.mult = count * card.ability.extra.per
    end
}
jd_def['j_osquo_ext_cheshirecat'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'xmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local face = true
        if hand[1] then
            for k, v in pairs(hand) do
                if not v:is_face() then face = false end
            end
        else face = false end
        if face == true then card.joker_display_values.xmult = 3 else card.joker_display_values.xmult = 1 end
    end
}
jd_def['j_osquo_ext_throwawayline'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.ability.extra', ref_value = 'mult', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.MULT},
    reminder_text = {
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'handname', colour = G.C.ORANGE},
        {text = ')'}
    },
    calc_function = function(card)
        card.joker_display_values.handname = localize(G.GAME.current_round.osquo_ext_throwawayline_hand, 'poker_hands')
            or G.GAME.current_round.osquo_ext_throwawayline_hand
    end
}
jd_def['j_osquo_ext_prophecy'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.ability.extra', ref_value = 'payout'}
    },
    text_config = {colour = G.C.GOLD}
}
jd_def['j_osquo_ext_cosmicjoker'] = {
    reminder_text = {
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'active'},
        {text = ')'}
    },
    calc_function = function(card)
        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_left <= 1 and
            localize('jdis_active') or localize('jdis_inactive)')
    end
}
jd_def['j_osquo_ext_spacetour'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.joker_display_values', ref_value = 'muns', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.GOLD},
    calc_function = function(card)
        local text, poker_hands, _ = JokerDisplay.evaluate_hand()
        local munshold = 0
        if poker_hands[text] and text ~= 'Unknown' then
            local count = getHandLevel(text)
            if math.floor(count / card.ability.extra.levelreq) ~= 0 then
                munshold = math.floor(count / card.ability.extra.levelreq) * card.ability.extra.dollarsper
            end
        end
        munshold = G.GAME.current_round.discards_left > 0 and munshold or 0
        card.joker_display_values.muns = munshold
    end
}
jd_def['j_osquo_ext_ledger'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.ability.extra', ref_value = 'chips', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.CHIPS}
}
jd_def['j_osquo_ext_volcano'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'xmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end

}
jd_def['j_osquo_ext_partytiem'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local text, poker_hands, _ = JokerDisplay.evaluate_hand()
        local xmult = card.ability.extra.currentxmult
        xmult = card.ability.extra.currentxmult
        card.joker_display_values.givexmult = xmult
    end
}
jd_def['j_osquo_ext_tidyjoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = #G.hand.cards - #G.hand.highlighted
        if card.ability.extra.basexmult - (card.ability.extra.losteach * count) >= 1 then
            card.joker_display_values.givexmult = card.ability.extra.basexmult - (card.ability.extra.losteach * count)
        else card.joker_display_values.givexmult = 1 end
    end
}
jd_def['j_osquo_ext_hypernova'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local text, poker_hands, _ = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' and poker_hands[text] then count = (getHandLevel(text, false, true) + 1) * card.ability.extra.givexmulteach else count = 0 end
        card.joker_display_values.givexmult = count + 1
    end
}
jd_def['j_osquo_ext_uniformjoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local cards = {}
        for i = 1, #G.play.cards do
            local rank = G.play.cards[i].base.id
            local suit = G.play.cards[i].base.suit
            if not table_contains(cards, rank..suit) then
                cards[#cards+1] = rank..suit
            end
        end
        if #cards <= card.ability.extra.cardlimit then
            card.joker_display_values.givexmult = card.ability.extra.xmultgive
        else card.joker_display_values.givexmult = 1 end
    end
}
jd_def['j_osquo_ext_hungryhungryjoker'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.ability.extra', ref_value = 'multnow', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.MULT}
}
jd_def['j_osquo_ext_cheerleaderjoker'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.ability.extra', ref_value = 'chipsnow', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.CHIPS}
}
jd_def['j_osquo_ext_algebra'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    reminder_text = {
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'localized_text_ace', colour = G.C.ORANGE},
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'localized_text_numbered', colour = G.C.ORANGE},
        {text = ')'}
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local ace = false
        local numbered = false
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i]:get_id() == 14 then ace = true end
                if scoring_hand[i]:get_id() < 11 and scoring_hand[i]:get_id() > 0 then numbered = true end
            end
        end

        local is_algebra_hand = (ace == true) and (numbered == true)
        card.joker_display_values.givexmult = is_algebra_hand and card.ability.extra.givexmult or 1
        card.joker_display_values.localized_text_ace = localize('osquo_ext_ace')
        card.joker_display_values.localized_text_numbered = localize('osquo_ext_numbered')
    end
}
jd_def['j_osquo_ext_mathematics'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    reminder_text = {
        {ref_table = 'card.joker_display_values', ref_value = 'currsum'},
        {text = '/'},
        {ref_table = 'card.ability.extra', ref_value = 'reqsum', colour = G.C.GREEN}
    },
    calc_function = function(card)
        local text, _, _ = JokerDisplay.evaluate_hand()
        local cursum = 0
        if text ~= 'Unknown' and card.ability.extra.solved == false then
            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i]:get_id() < 11 then
                    cursum = cursum + G.hand.highlighted[i]:get_id()
                end
            end
        end

        if card.ability.extra.solved == false then
            card.joker_display_values.currsum = cursum
            card.joker_display_values.color = G.C.ORANGE
        else
            card.joker_display_values.currsum = card.ability.extra.reqsum
            card.joker_display_values.color = G.C.GREEN
        end
    end,
    style_function = function(card,text,reminder_text,extra)
        if reminder_text and reminder_text.children[1] then
            reminder_text.children[1].config.colour = card.joker_display_values.color or G.C.ORANGE
        end
        return false
    end
}
jd_def['j_osquo_ext_compensation'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'xmultnow', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local rentals = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.rental then rentals = rentals + 1 end
        end
        card.joker_display_values.xmultnow = rentals * card.ability.extra.xmultper + 1
    end
}
jd_def['j_osquo_ext_ghostjoker'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end
}
jd_def['j_osquo_ext_pickyjoker'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.joker_display_values', ref_value = 'muns', retrigger_type = mult}
    },
    text_config = {colour = G.C.GOLD},
    calc_function = function(card)
        local hand = G.hand.highlighted
        local num = #hand
        local munshold = math.floor((num + card.ability.extra.currentdisc) / card.ability.extra.discreq) * card.ability.extra.dollarper
        card.joker_display_values.muns = munshold
    end
}
jd_def['j_osquo_ext_hermitjoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'xmultnow', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local debtmult = math.floor(G.GAME.dollars / card.ability.extra.debtreq) * -1 * card.ability.extra.xmultper
        if debtmult > 1 then
            card.joker_display_values.xmultnow = debtmult
        else
            card.joker_display_values.xmultnow = 1
        end
    end
}
jd_def['j_osquo_ext_helpinghand'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.MULT},
    calc_function = function(card)
        local gibmult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        for i = 1, #scoring_hand do
            if scoring_hand[i]:get_id() > 0 and scoring_hand[i]:get_id() < 11 then
                gibmult = gibmult + math.ceil(scoring_hand[i]:get_id() / 2)
            elseif (scoring_hand[i]:get_id() == 11) or (scoring_hand[i]:get_id() == 12) or (scoring_hand[i]:get_id() == 13) then
                gibmult = gibmult + 5
            elseif scoring_hand[i]:get_id() == 14 then
                gibmult = gibmult + 6
            end
        end
        card.joker_display_values.total = gibmult
    end
}
jd_def['j_osquo_ext_fraudjoker'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end
}
jd_def['j_osquo_ext_corruptjoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'xmultnow', retrigger_type = 'exp'}
        }}
    }
}
jd_def['j_osquo_ext_ostracon'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end
}
jd_def['j_osquo_ext_grandfinale'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        local last_card = scoring_hand and scoring_hand[#scoring_hand]
        return last_card and playing_card == last_card and joker_card.ability.extra.againzo * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
jd_def['j_osquo_ext_bountyhunter'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.joker_display_values', ref_value = 'muns', retrigger_type = mult}
    },
    text_config = {colour = G.C.GOLD},
    calc_function = function(card)
        local muns2 = 0
        if #G.hand.highlighted == 1 then
            if G.hand.highlighted[1]:get_id() == G.GAME.current_round.osquo_ext_bountyhunter_card.id and G.hand.highlighted[1]:is_suit(G.GAME.current_round.osquo_ext_bountyhunter_card.suit) then
                muns2 = 8
            end
        end
        card.joker_display_values.muns = muns2
    end
}
jd_def['j_osquo_ext_scroogejoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.has_enhancement(playing_card, 'm_gold') then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.total = card.ability.extra.givexmult ^ count
    end
}
jd_def['j_osquo_ext_shareholder'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'xmultcurrent', retrigger_type = 'exp'}
        }}
    }
}
jd_def['j_osquo_ext_bumperjoker'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.ability.extra', ref_value = 'rscore', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.GREEN}
}
jd_def['j_osquo_ext_illegiblejoker'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        return ((playing_card:get_id() < 0) or (SMODS.has_no_rank(playing_card))) and joker_card.ability.extra.retrig * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
jd_def['j_osquo_ext_ritualist'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return scoring_hand[1] and playing_card == scoring_hand[1] and joker_card.ability.extra.basetrig * (#G.play - #scoring_hand)
    end
}
jd_def['j_osquo_ext_cabinetjoker'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.joker_display_values', ref_value = 'muns', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.GOLD},
    calc_function = function(card)
        local muns2 = 0
        if G.GAME.current_round.hands_left > 1 and G.GAME.blind.in_blind then
            muns2 = card.ability.extra.givedollar * (G.GAME.current_round.hands_played + 1)
        end
        card.joker_display_values.muns = muns2
    end
}
jd_def['j_osquo_ext_temperatejoker'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    }
}
jd_def['j_osquo_ext_bufface'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.CHIPS},
    reminder_text = {
        {text = '(Aces)'},
    },
    calc_function = function(card)
        local total2 = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local starting = card.ability.extra.scaledchips
        local scaler = card.ability.extra.scaler
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and scoring_card:get_id() == 14 then
                    local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    for i = 1, retriggers do
                        starting = starting + scaler
                        total2 = total2 + starting
                    end
                end
            end
        end
        card.joker_display_values.total = total2
    end
}
jd_def['j_osquo_ext_labgrowngem'] = {
    text = {
        {text = '+$'},
        {ref_table = 'card.ability.extra', ref_value = 'current', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.GOLD}
}
jd_def['j_osquo_ext_stellarnursery'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.MULT},
    calc_function = function(card)
        local text, _, _ = JokerDisplay.evaluate_hand()
        local total2 = getHandLevel(text, true, true) * card.ability.extra.multeach
        card.joker_display_values.total = total2
    end
}
jd_def['j_osquo_ext_backgroundcheck'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local total2 = 1
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                local mysuit = scoring_card.base.suit
                local alike = 0
                if not SMODS.has_no_suit(scoring_card) then
                    for i = 1, #scoring_hand do --for every card in scoring hand
                        if not SMODS.has_no_suit(scoring_hand[i]) then --Check if it has a suit
                            if SMODS.has_any_suit(scoring_card) then mysuit = scoring_hand[i].base.suit end
                            if not SMODS.has_any_suit(scoring_hand[i]) then
                                if scoring_hand[i].base.suit == mysuit then alike = alike + JokerDisplay.calculate_card_triggers(scoring_hand[i], scoring_hand) end
                            elseif SMODS.has_any_suit(scoring_hand[i]) then
                                alike = alike + JokerDisplay.calculate_card_triggers(scoring_hand[i], scoring_hand)
                            end
                        end
                    end
                end
            total2 = total2 * (card.ability.extra.xmulteach * alike + 1)
            end
        end
        card.joker_display_values.total = total2
    end
}
jd_def['j_osquo_ext_idolatry'] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return playing_card:get_id() == G.GAME.current_round.osquo_ext_idolatry_card.id and joker_card.ability.extra.retrig * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
jd_def['j_osquo_ext_earl'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'counted', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.MULT},
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.has_enhancement(playing_card, 'm_mult') then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.counted = card.ability.extra.giveMult * count
    end
}
jd_def['j_osquo_ext_count'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'counted', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.CHIPS},
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.has_enhancement(playing_card, 'm_bonus') then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.counted = card.ability.extra.giveChips * count
    end
}
jd_def['j_osquo_ext_knave'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.CHIPS},
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:get_id() == 11 then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.total = card.ability.extra.givepchips * count
    end
}
jd_def['j_osquo_ext_theharmony'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.joker_display_values', ref_value = 'total', retrigger_type = 'exp'}
        }}
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #scoring_hand do --for every card in scoring hand
                if scoring_hand[i].ability.name ~= 'Wild Card' and not SMODS.has_no_suit(scoring_hand[i]) then --if not a wild card, check suit and add 1 to the suit count
                    if scoring_hand[i]:is_suit('Hearts', true) then suits["Hearts"] = suits["Hearts"] + 1
                    elseif scoring_hand[i]:is_suit('Diamonds', true)  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif scoring_hand[i]:is_suit('Spades', true)  then suits["Spades"] = suits["Spades"] + 1
                    elseif scoring_hand[i]:is_suit('Clubs', true)  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #scoring_hand do
                if scoring_hand[i].ability.name == 'Wild Card' and not SMODS.has_no_suit(scoring_hand[i]) then --if it's a wild card, add 1 to every suit count
                    suits["Hearts"] = suits["Hearts"] + 1
                    suits["Diamonds"] = suits["Diamonds"] + 1
                    suits["Spades"] = suits["Spades"] + 1
                    suits["Clubs"] = suits["Clubs"] + 1
                end
            end
            for i = 1, #scoring_hand do
                if SMODS.has_no_suit(scoring_hand[i]) then
                    -- no suit lmao
                end
            end
            if suits['Hearts'] == suits['Diamonds'] and suits['Diamonds'] == suits['Spades'] and suits['Spades'] == suits['Clubs'] then --if all suit counts are co-equal
                count = count + 1
            end
            end
        end
        card.joker_display_values.total = card.ability.extra.giveXmult ^ count
    end
}
jd_def['j_osquo_ext_empoweredopal'] = {
    text = {
        {border_nodes = {
            {text = 'X'},
            {ref_table = 'card.ability.extra', ref_value = 'givexmult', retrigger_type = 'exp'}
        }}
    }
}
jd_def['j_osquo_ext_seelie'] = {
    text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'countpurp', retrigger_type = 'mult'}
    },
    text_config = {colour = G.C.SECONDARY_SET.Tarot},
    reminder_text = {
        {text = '+'},
        {ref_table = 'card.joker_display_values', ref_value = 'countblu', retrigger_type = 'mult'}
    },
    reminder_text_config = {colour = G.C.SECONDARY_SET.Planet, scale = 0.4},
    calc_function = function(card)
        local countpurp = 0
        local countblu = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card.seal == 'Purple' then
                    countpurp = countpurp + 1
                elseif scoring_card.seal == 'Blue' then
                    countblu = countblu + 1
                end
            end
        end
        card.joker_display_values.countpurp = countpurp
        card.joker_display_values.countblu = countblu
    end
}
jd_def['j_osquo_ext_bubbleuniverse'] = {
    extra = {{
        {text = '('},
        {ref_table = 'card.joker_display_values', ref_value = 'odds'},
        {text = ')'}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    calc_function = function(card)
        card.joker_display_values.odds = localize{type = 'variable', key = 'jdis_odds', vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end
}
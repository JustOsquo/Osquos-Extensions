--[[

Hey there! Snooping around my code, are we?
No worries. Whether you're here to just examine it, or to try to learn modding for yourself, feel free! You are welcome here.

See a bit of code you like or think is useful? Feel free to take and use it for yourself, unless that code isn't mine, which will be specified.
Otherwise, please help yourself. If you do this I would of course appreciate credit for it, but there's no need to come to me for permission.
The code here should have enough comments that you can (hopefully) piece together what each bit of it does, so feel free to take a read!
Happy modding!

]]
SMODS.current_mod.optional_features = function() --of course i needed to do this, why wouldnt it just be added by default that'd be way too simple and easy
    return {
        retrigger_joker = true
    }
end

--Loading Hooks
SMODS.load_file('hookers.lua')()

--Loading JokerDisplay Compatability (if it's detected)
if JokerDisplay then
    SMODS.load_file("JokerDisplayComp.lua")()
end

--Loading animated texture support (thanks @bepisfever)
--P.S. see inside animateObject.lua for instructions on how to use it yourself
SMODS.load_file('animateObject.lua')()

--[[ EXTRA FUNCTIONS ]]--

--seperated for cleaner/more organized code
SMODS.load_file('extraFuncs.lua')()

--For god knows what reason, chooserandomhand() doesnt work when its loaded in another file. It has to be defined in the main file. God give me patience.

--same story for this function, idk why conversionTarot() works in a seperate file but anything else is just a nil value global
--FML

--UPDATE: extraFuncs was typo'd as extraFucs THIS WHOLE TIME!!!! IM GOING TO DRIVE DOWN THE SIDEWALK AND RUN OVER PEDESTRIANS in minecraft
--conversionTarot() is just haunted, man.

--[[ GLOBAL VARIABLES ]]--

--...IF I HAD ANY!

--[[ SOUNDS ]]--

SMODS.Sound{ --Raw Score Sound
    key = 'osquo_ext_rscore',
    path = 'osquo_ext_rscore.wav'
}

--[[ ATLASES ]]--

SMODS.Atlas{ --defining the joker atlas
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --animated texture atlas for Empowered Opal
    key = 'empoweredopal_animated',
    path = 'EmpoweredOpalTexture.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --another animated texture atlas!
    key = 'cabinetjoker_animated',
    path = 'CabinetJokerTexture.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --this, however, is the tarot atlas
    key = 'qle_tarot',
    path = 'Tarots.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --enhancement atlas...
    key = 'qle_enhancements',
    path = 'Enhancements.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --oh youre never gonna guess
    key = 'qle_decks',
    path = 'Decks.png',
    px = 71,
    py = 95
}

SMODS.Atlas{ --Eh? There's 30 G inside this... what is this?
    key = 'qle_vouchers',
    path = 'Vouchers.png',
    px = 71,
    py = 95
}

--[[ ORDINARY JOKERS ]]--

SMODS.Joker{ --Bumper Joker
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
        if context.final_scoring_step then
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
        if context.repetition and context.cardarea == (G.play or G.hand) then
            if context.other_card:get_id() < 0 then
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
        elseif context.destroy_card and not context.blueprint then
            if table_contains(card.ability.extra.die, context.destroy_card) then
                if card.ability.extra.ritflag == false then --only once per hand
                    SMODS.calculate_effect({message = localize('osquo_ext_sacrificed'), colour = G.C.RED}, card)
                    card.ability.extra.ritflag = true
                end
                return {
                    remove = true,
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
        bspa = 1.5, --blind size per ante
        currentscale = 1.5
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
            local checkscore = to_number((to_number(G.GAME.chips)) + (to_number(hand_chips)*to_number(mult))) --i love/hate talisman
            if to_number(checkscore) < to_number(G.GAME.blind.chips) then --idk if half this to_number() bullshit is even necessary
                return {
                    dollars = card.ability.extra.givedollar*(G.GAME.current_round.hands_played+1),
                    card = card
                }
            end
        end
    end,
    update = function(self,card,context)
        card.ability.extra.currentscale = card.ability.extra.bspa^(G.GAME.round_resets.ante or 1)
    end
}

SMODS.Joker{ --Safety Net
    key = 'safetynet',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_safetynet'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 3},
    rarity = 2,
    cost = 4,
    config = {extra = {
        givexmult = 3
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.givexmult,
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local checkscore = to_number(hand_chips)*mult or hand_chips*mult --check current score
            if checkscore <= G.GAME.blind.chips then --if hand would not win
                return {
                    xmult = card.ability.extra.givexmult
                }
            end
        end
    end
}

SMODS.Joker{ --Transmutation
    key = 'transmutation',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_transmutation'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 2},
    rarity = 3,
    cost = 8,
    config = {extra = {
        convperc = 0.05 --percentage
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.convperc*100 --convert to percentage for loc_var
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local shift = (to_number(hand_chips)*card.ability.extra.convperc) or (hand_chips*card.ability.extra.convperc)
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
    atlas = 'Jokers',
    pos = {x = 4, y = 1},
    rarity = 3,
    cost = 6,
    config = {extra = {
        scaledchips = 0,
        scaler = 2
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
                if context.full_hand[i].ability.name == 'Wild Card' then card.ability.extra.diamond = true --check if wild card is played
                elseif context.full_hand[i].base.suit == 'Diamonds' then card.ability.extra.diamond = true --or if diamond played
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
        multeach = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.multeach
        }}
    end,
    calculate = function(self,card,context)
        if context.before_but_not_as_much then --Context added in lovely patch
            local thishand = context.scoring_name --This poker hand
            local levels = getHandLevel(thishand, true, true) --See extraFuncs.lua
            if levels > 0 then
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
        xmulteach = 0.1,
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmulteach,
        }}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            local mysuit = context.other_card.base.suit
            local alike = 0
            for i = 1, #context.scoring_hand do --for every card in scoring hand
                if context.other_card.ability.name == 'Wild Card' then mysuit = context.scoring_hand[i].base.suit end
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i].base.suit == mysuit then alike = alike + 1 end
                elseif context.scoring_hand[i].ability.name == 'Wild Card' then
                    alike = alike + 1
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

SMODS.Joker{ --Amber Joker
    key = 'amberjoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_amberjoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 3},
    rarity = 2,
    cost = 5,
    enhancement_gate = 'm_osquo_ext_amberE',
    config = {extra = {
        xmultper = 0.1,
        xchipsper = 0.1,
        tally = 0,
        current = 0
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'amber_info'}
        return { vars = {
            card.ability.extra.xmultper,
            card.ability.extra.xchipsper,
            1 + card.ability.extra.xmultper*(card.ability.extra.tally or 0), --Currently #X Mult
            1 + card.ability.extra.xchipsper*(card.ability.extra.tally or 0)
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {1 + card.ability.extra.xmultper*card.ability.extra.tally}},
                xchips = 1 + card.ability.extra.xchipsper*card.ability.extra.tally,
                Xmult_mod = 1 + card.ability.extra.xmultper*card.ability.extra.tally
            }
        end
    end,
    update = function(self,card, dt) --Continuously updated
        if G.playing_cards then
            card.ability.extra.tally = 0 --reset tally
            for k, v in pairs(G.playing_cards) do --For every playing card in deck
                if SMODS.has_enhancement(v, 'm_osquo_ext_amberE') then --if its an amber card
                    card.ability.extra.tally = card.ability.extra.tally + 1 --tally of amber cards plus one
                end
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
        giveMult = 2
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
        giveChips = 15
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
    rarity = 3,
    cost = 7,
    config = {extra = {
        giveXchips = 1.5
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.giveXchips
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
                        xchips = card.ability.extra.giveXchips,
                        card = card --still dont know what this does | Upate: it tells the code this function returns to what card to put the juiceup and message on
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --The Harmony
    key = 'theharmony',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_theharmony'}, --WHY WONT IT FUCKING WORK THERES NOTHING WRONG WITH IT???? Update: typo'd text as taxt fml
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
            local suits = { --Moslty copied from flower pot (minor tweaks)
            ['Hearts'] = 0,
            ['Diamonds'] = 0,
            ['Spades'] = 0,
            ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do --for every card in scoring hand
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then --if not a wild card, check suit and add 1 to the suit count
                    if context.scoring_hand[i]:is_suit('Hearts', true) then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true)  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true)  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true)  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' then --if it's a wild card, add 1 to every suit count
                    suits["Hearts"] = suits["Hearts"] + 1
                    suits["Diamonds"] = suits["Diamonds"] + 1
                    suits["Spades"] = suits["Spades"] + 1
                    suits["Clubs"] = suits["Clubs"] + 1
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
    rarity = 2,
    cost = 4,
    config = {extra = {}},
    calculate = function(self, card, context)
        local purples = {} --I think these are unused lol
        local blues = {}
        if context.individual and context.cardarea == G.play then --Scored cards
            if context.other_card.seal == "Purple" then --Check seal
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
            elseif context.other_card.seal == "Blue" then --All ditto but with blue seal and planets
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
        local eval = function() return card.ability.extra.used == true end
        juice_card_until(self, eval, true)
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
} --Yes, you can technically use this on hands other than the first under special circumstances but shhhhhh dont tell anyone


--[[ LEGENDARY JOKERS ]]--

--[[
SMODS.Joker{ --The Khanate
    key = 'thekhanate',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_thekhanate'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    rarity = 4,
    cost = 20,
    config = { extra = { repetitions = 2 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and next(context.poker_hands['Flush']) then --if played hand contains a flush
            return {
                repetitions = card.ability.extra.repetitions, --retrigger cards
                message = localize('k_again_ex'),
                card = card
            }
        end --im not actually 100% sure this works its a bit buggy ||| UPDATE: ok it works now, context.poker_hands['Flush'] must be within next() to work
    end
}
]]
SMODS.Joker{ --Bubble Universe
    key = 'bubbleuniverse',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_bubbleuniverse'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 0},
    rarity = 4,
    cost = 20,
    config = {extra = {odds = 9}},
    loc_vars = function(self, info_queue, card)
        return {vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then --when selecting blind
            if pseudorandom('bubbleuniverse') < G.GAME.probabilities.normal / card.ability.extra.odds then --1 in 9 normally
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
--[[
SMODS.Joker{ --Grand Design
    key = 'recursivejoker',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_recursivejoker'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 1},
    rarity = 4,
    cost = 20,
    config = { extra = {retriggers = 1, debug = 0 } },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.debug}}
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then --if triggering another joker
            if context.other_card.config.center.key == 'j_blueprint' or context.other_card.config.center.key == 'j_brainstorm' then --if it's a blueprint/brainstorm
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.retriggers, --retrigger it
                    card = self
                }
            end
		end
    end
}
]]
--[[
SMODS.Joker{ --Acrylic Bath / Glassblower V1
    key = 'glassblower',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_glassblower'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    rarity = 4,
    cost = 20,
    config = { extra = {odds = 4}}, --defining odds
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'acrylic_info'}
        return {vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end,
    calculate = function(self, card, context)
        if context.before then --Before scoring
            local tcards = {}
            local check = false --i actually forget what this is for lmao idk what it does
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_glass') then --If played card has glass enhancement
                    if pseudorandom('seed') < G.GAME.probabilities.normal / card.ability.extra.odds then --1 in 4 normally
                        check = true
                        tcards[#tcards+1] = v
                        v:set_ability(G.P_CENTERS.m_osquo_ext_acrylic, nil, true) --Set enhancement to acrylic
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up() --JUICE IT UPPPPPPP YYYEAAHHHHHH
                                return true
                            end
                        }))
                    end
                end
            end
            if check then SMODS.calculate_effect({message = localize('osquo_ext_becomeacrylic'), colour = G.C.ATTENTION}, card) end --Acrylic!
        end
    end
}
--]]
--[[
SMODS.Joker{ --Glassblower V2
    key = 'glassblower',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_glassblower'},
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    rarity = 4,
    cost = 20,
    config = { extra = {
--no config values
    }},
    calculate = function(self,card,context)
        if context.cards_destroyed then
            for k, v in ipairs(context.glass_shattered) do --For all destroyed cards
                if SMODS.has_enhancement(v, 'm_glass') then --If it's glass
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(v, nil, nil, G.playing_card) --Copy the destroyed card
                    _card:add_to_deck() --Add it to deck
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(_card) --Place it in the deck
                    table.insert(G.playing_cards, _card)
                    playing_card_joker_effect({true})
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize() --MAGIK
                            return true
                    end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_copied_ex'), colour = G.C.FILTER})
                end
            end
        elseif context.remove_playing_cards then --ditto of above
            for k, v in ipairs(context.removed) do
                if SMODS.has_enhancement(v, 'm_glass') then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(v, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(_card)
                    table.insert(G.playing_cards, _card)
                    playing_card_joker_effect({true})
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                    end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_copied_ex'), colour = G.C.FILTER})
                end
            end
        end
    end
}
]]
SMODS.Joker{ --Nichola
    key = 'nichola',
    loc_txt = {set = 'Joker', key = 'j_osquo_ext_nichola'},
    blueprint_compat = false,
    eternal_compat = true,
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
        conversionTarot(G.hand.highlighted, "m_osquo_ext_amberE") --this function is haunted
    end,
}

--[[ ENHANCEMENTS ]]--

SMODS.Enhancement { --Acrylic Cards
    key = 'acrylic',
    atlas = 'qle_enhancements',
    pos = {x = 0, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    weight = -1,
    config = {extra = {Xmult = 2.5, timer = 4, markedfordeath = false}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult, card.ability.extra.timer}
        }
    end,
    calculate = function(self, card, context, ret)
        if context.cardarea == G.play and context.before then --If played and before scoring
            card.ability.extra.timer = card.ability.extra.timer - 1 --Count down the death clock
        end
        if context.cardarea == G.play and context.main_scoring then
            if card.ability.extra.timer <= 0 then card.ability.extra.markedfordeath = true end --If time's up
            return {
                xmult = card.ability.extra.Xmult --Give effect
            }
        end
        if context.final_scoring_step then --After scoring
            if card.ability.extra.timer <= 0 then --If time's up
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function() --Kill it (with shattery pazaz)
                        card:shatter()
                        play_sound('glass'..math.random(1, 6), math.random()*0.2 + 0.9,0.5)
                        play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                        return true
                    end
                }))
            elseif context.cardarea == G.play then --If it's been played
                SMODS.calculate_effect({message = localize('osquo_ext_acrylicrunningout'), colour = G.C.ATTENTION}, card) --Running out!
            end
        end
        if context.destroying_card and card.ability.extra.markedfordeath == true then --When it's shattered
            return {
                remove = true --Kill it for real this time (the last time was a fake)
            }
        end
    end
}

SMODS.Enhancement { --Amber Cards
    key = 'amberE',
    atlas = 'qle_enhancements',
    pos = {x = 1, y = 0},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 1,
    config = {extra = {
        giveXmult = 1.2,
        giveXchips = 1.2
    }},
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.giveXmult,
                card.ability.extra.giveXchips
            }
        }
    end,
    calculate = function(self,card,context,ret)
        if context.main_scoring and context.cardarea == G.hand then
            return {
                xmult = card.ability.extra.giveXmult,
                xchips = card.ability.extra.giveXchips
            }
        end
    end
}

--[[ VOUCHERS ]]--

SMODS.Voucher{ --Booster Feast +1 Pack in shop
    key = 'boosterfeast',
    loc_txt = {set = 'Voucher', key = 'v_osquo_ext_boosterfeast'},
    atlas = 'qle_vouchers',
    pos = {x = 0, y = 0},
    config = {extra = {
        bonus = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.bonus
        }}
    end,
    redeem = function(self,card)
        SMODS.change_booster_limit(card.ability.extra.bonus)
        for i = 1, card.ability.extra.bonus do
            SMODS.add_booster_to_shop()
        end
    end,
}

SMODS.Voucher{ --Booster Glutton +1 Choice in packs
    key = 'boosterglutton',
    loc_txt = {set = 'Voucher', key = 'v_osquo_ext_boosterglutton'},
    atlas = 'qle_vouchers',
    pos = {x = 1, y = 0},
    requires = {'v_osquo_ext_boosterfeast'},
    config = {extra = {
        bonus = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.bonus
        }}
    end,
}

--[[ DECKS ]]--

--Tweaked from Buffoonery mod, get permission before dist
SMODS.Back{ --Fragile Deck
    key = 'fragile', --no relation to fragile challenge
    unlocked = true,
    discovered = true,
    atlas = 'qle_decks',
    pos = {x = 0, y = 0},
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
            local card = nil
            play_sound('timpani')
            card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_osquo_ext_glassblower', 'por') --Create the Acrylic bath
            card:add_to_deck() --Add it...
            G.jokers:emplace(card) --...to the joker area
            card:start_materialize() --Waza
            card:set_edition() --No funny stuff
            G.GAME.joker_buffer = 0 --idk what this does
			local rmvd_suit = {'Spades', 'Hearts', 'Clubs', 'Diamonds'} --List of suits
			local random = rmvd_suit[math.random(1, 4)] --Pick a random suit
			local target_suit = random
			local keys_to_remove = {}
			for k, v in pairs(G.playing_cards) do --For every card in deck
				if v.base.suit ~= target_suit then --If target card is not of the chosen suit
					table.insert(keys_to_remove, v) --Mark for death
                else
                    v:set_ability(G.P_CENTERS.m_glass, nil, true) --If it is then make it glass
                end
            end
            for i = 1, #keys_to_remove do
                keys_to_remove[i]:remove() --Kill marked cards
            end
        return true end }))
    end,
}

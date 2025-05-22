--[[
[1]King: Create up to 2 random Chess cards
[2]Queen: Randomize the rank and suit of up to 3 selected cards
[3]Rook: Select 2 cards, copy the Enhancement, Seal, and Edition from the right card to the left card | (Drag to rearrange)
[4]Bishop: Upgrade 3 selected cards to a single random enhancement
[6]Knight: 1 in 2 chance to create a Spectral card
[12]Pawn: Create the last Chess card used during this run | Pawn excluded

[11]Vizier: Create the Planet card of your most played Poker Hand
[7]Camel: Convert 1 owned Joker into another owned Joker
[5]Picket: Set money to $15
[10]General: 1 in 4 chance to add Polychrome to a random Joker
[9]Elephant: Destroy all but one Joker | +1 Hand Size
[8]War Engine: Create a random Tag | 1 in 2 chance to create an additional Tag | Orbital Tag excluded
]]

SMODS.ConsumableType{ --Chess Pieces
    key = 'Chess',
    primary_colour = HEX('9F5D37'),
    secondary_colour = HEX('995334'),
    loc_txt = {
        name = 'Chess Piece',
        collection = 'Chess Pieces',
        undiscovered = {
            name = '???',
            text = {
                'You are yet to discover this card...'
            }
        }
    },
    default = 'c_osquo_ext_king'
}

SMODS.Consumable{ --King
    key = 'king',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    config = {extra = {
        createn = 2
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.createn
        }}
    end,
    can_use = function(self,card)
        if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
    end,
    use = function(self,card)
        for i = 1, math.min(card.ability.extra.createn, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({
                        set = 'Chess',
                        area = G.consumeables,
                        key_append = 'king',
                        no_edition = true
                    })
                    card:juice_up(0.3, 0.5)
                end
                return true end}))
        end
        delay(0.6)
    end
}

SMODS.Consumable{ --Queen
    key = 'queen',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 1, y = 0},
    config = {extra = {
        limit = 3
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.limit
        }}
    end,
    can_use = function(self,card)
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.limit then return true end
    end,
    use = function(self,card)
        cardBaseConvert(G.hand.highlighted, nil, nil, true, 'queen', true)
    end
}

SMODS.Consumable{ --Rook
    key = 'rook',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 2, y = 0},
    config = {extra = {
        limit = 2
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.limit
        }}
    end,
    can_use = function(self,card)
        if #G.hand.highlighted <= card.ability.extra.limit and #G.hand.highlighted > 1 then return true end
    end,
    use = function(self,card) --for some reason this is like really inconsistent and only works like half the time even on savestates fuck my life man
        local toenhance = SMODS.get_enhancements(G.hand.highlighted[#G.hand.highlighted])
        local varrrr = {}
        local toseal = G.hand.highlighted[#G.hand.highlighted].seal
        local toedit = nil
        if G.hand.highlighted[#G.hand.highlighted].edition then toedit = G.hand.highlighted[#G.hand.highlighted].edition.key end
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
                local thunk = nil
                for k, v in pairs(toenhance) do
                    thunk = true
                end
                if thunk then
                    for k, v in pairs(toenhance) do
                        varrrr = k
                        print(k)
                    end
                    print('br')
                    print(varrrr)
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[varrrr]) --uhhhhh i hope this doesnt break lmao
                else
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base, nil, true)
                end
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if toseal then G.hand.highlighted[i]:set_seal(toseal) else G.hand.highlighted[i]:set_seal() end
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if toedit then G.hand.highlighted[i]:set_edition(toedit, true) else G.hand.highlighted[i]:set_edition() end
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

SMODS.Consumable{ --Bishop
    key = 'bishop',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 3, y = 0},
    config = {extra = {
        limit = 3
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.limit
        }}
    end,
    can_use = function(self,card)
        if #G.hand.highlighted <= card.ability.extra.limit then return true end
    end,
    use = function(self,card)
        local rngEnhance = SMODS.poll_enhancement({
            key = 'bishop',
            mod = 1,
            guaranteed = true
        })
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3,0.5)
            return true end}))
        tarotConvert(G.hand.highlighted, rngEnhance)
    end
}

SMODS.Consumable{ --Picket
    key = 'picket',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 4, y = 0},
    config = {extra = {
        setdol = 15
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.setdol
        }}
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self,card)
        local calced = (G.GAME.dollars - 15) * -1
        ease_dollars(calced)
    end
}

SMODS.Consumable{ --Knight
    key = 'knight',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 0, y = 5},
    config = {extra = {
        odds = 2
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            (G.GAME.probabilities.normal or 1),
            card.ability.extra.odds
        }}
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self,card)
        if pseudorandom('knight') < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.add_card({
                set = 'Spectral',
                area = G.consumeables,
                key_append = 'king',
                no_edition = true
            })
        end
    end
}

SMODS.Consumable{ --Camel
    key = 'camel',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 0, y = 1},
    config = {extra = {
        eligibleJokers = {},
        newkey = nil
    }},
    cost = 3,
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
    use = function(self,card) --bruh
        local AvailJokerList = card.ability.extra.eligibleJokers
        local JokerToConvert = pseudorandom_element(AvailJokerList, pseudoseed('camela'))
        print(JokerToConvert.config.center.key)
        local AvailJokerList2 = {}
        for i = 1, #G.jokers.cards do
            AvailJokerList2[i] = G.jokers.cards[i]
        end
        removeTableElement(AvailJokerList2, JokerToConvert)
        if table_contains(AvailJokerList2, JokerToConvert) then print('true') else print('false') end
        local ConvertInto = pseudorandom_element(AvailJokerList2, pseudoseed('camelb'))
        print(ConvertInto.config.center.key)
        card.ability.extra.newkey = ConvertInto.config.center.key
        JokerConvert({JokerToConvert}, {card.ability.extra.newkey})
    end
}

SMODS.Consumable{ --War Engine
    key = 'warengine',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 1, y = 1},
    config = {extra = {
        odds = 2
    }},
    cost = 3,
    loc_vars = function(self,info_queue,card)
        return { vars = {
            (G.GAME.probabilities.normal or 1),
            card.ability.extra.odds
        }}
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self,card)
        G.E_MANAGER:add_event(Event({
            func = (function()
                card:juice_up()
                add_tag(Tag(getRandomTag({'tag_orbital'}, 'warengine')))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
        end)}))
        if pseudorandom('warengine') < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card:juice_up()
                    add_tag(Tag(getRandomTag({'tag_orbital'}, 'warengine')))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
            end)}))
        end
    end
}

SMODS.Consumable{ --Elephant
    key = 'elephant',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 2, y = 1},
    config = {extra = {
        addition = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.addition
        }}
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self,card)
        local deletable_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
        end
        local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('elephant'))
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.75, func = function()
            for k, v in pairs(deletable_jokers) do
                if v ~= chosen_joker then 
                    v:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
            end
            return true end }))
        G.hand:change_size(card.ability.extra.addition)
    end
}

SMODS.Consumable{ --General
    key = 'general',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 3, y = 1},
    config = {extra = {
        odds = 4
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            (G.GAME.probabilities.normal or 1),
            card.ability.extra.odds
        }}
    end,
    can_use = function(self,card)
        if next(card.eligible_editionless_jokers) then return true end
    end,
    use = function(self,card)
        if pseudorandom('general') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local poolJ = card.eligible_editionless_jokers or {}
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local eligible_card = pseudorandom_element(poolJ, pseudoseed('general'))
                local edition = {polychrome = true}
                eligible_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
            return true end}))
        end
    end,
    update = function(self,card,context)
        card.eligible_editionless_jokers = EMPTY(card.eligible_editionless_jokers)
        if G.jokers then
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(card.eligible_editionless_jokers, v)
                end
            end
        end
    end
}

SMODS.Consumable{ --Vizier
    key = 'vizier',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 4, y = 1},
    can_use = function(self,card)
        return true
    end,
    use = function(self,card)
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        local played = 0
        local mosthand = {}
        for k, v in pairs(G.GAME.hands) do
            if v.played > played then
                played = v.played
                mosthand[#mosthand + 1] = k
            end
        end
        local mosthandsing = pseudorandom_element(mosthand, pseudoseed('vizier'))
        G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.2,func = (function()
            local _planet = 0
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == mosthandsing then
                    _planet = v.key
                end
            end
            SMODS.add_card({set = 'Planet', key = _planet})
            G.GAME.consumeable_buffer = 0
            return true end)}))
    end
}

SMODS.Consumable{ --Pawn
    key = 'pawn',
    set = 'Chess',
    atlas = 'Chess',
    pos = {x = 0, y = 0},
    --pos = {x = 5, y = 1},
    can_use = function(self,card)
        if (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) 
                and G.GAME.last_chess and G.GAME.last_chess ~= 'c_osquo_ext_pawn' then return true end
    end,
    use = function(self,card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local _card = create_card('Chess', G.consumeables, nil, nil, nil, nil, G.GAME.last_chess, 'pawn')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
        delay(0.6)
    end
}
--[[ ENHANCEMENTS ]]--

SMODS.Enhancement { --Acrylic Cards
    key = 'acrylic',
    atlas = 'qle_enhancements',
    pos = {x = 0, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    shatters = true,
    always_scores = false,
    weight = -1,
    config = {extra = {
        xmult = 3,
    }},
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.xmult,
        }}
    end,
    calculate = function(self, card, context, ret)
        if context.main_scoring and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.xmult
            }
        elseif context.destroying_card then
            if context.destroying_card == card and context.cardarea == G.play then
                return { remove = true}
            end
        end
    end
}

SMODS.Enhancement { --Amber Cards
    key = 'amberE',
    atlas = 'qle_enhancements',
    pos = {x = 1, y = 0},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 1,
    config = {extra = {
        xmultcons = 0.05
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xmultcons
        }}
    end,
    calculate = function(self,card,context,ret)
        if context.main_scoring and context.cardarea == G.hand then
            G.GAME.osquo_ext_amber_consecutives = G.GAME.osquo_ext_amber_consecutives + 1
            return {
                xmult = 1 + (card.ability.extra.xmultcons * (G.GAME.osquo_ext_amber_consecutives))
            }
        elseif context.after or context.selecting_blind or context.end_of_round then
            G.GAME.osquo_ext_amber_consecutives = 0
        end
    end
}

SMODS.Enhancement{ --Growth Cards
    key = 'growth',
    atlas = 'qle_enhancements',
    pos = {x = 0, y = 1},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 1,
    config = {extra = {
        xtrachips = 0,
        chipmod = 10
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.xtrachips,
            card.ability.extra.chipmod
        }}
    end,
    calculate = function(self,card,context,ret)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.xtrachips
            }
        elseif context.discard and context.other_card == card then
            card.ability.extra.xtrachips = card.ability.extra.xtrachips + card.ability.extra.chipmod
            return {
                delay = 0.2,
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION
            }
        end
    end
}

--[[ SEALS ]]--

SMODS.Seal{ --Cosmic Seal
    key = 'cosmic',
    atlas = 'Seals',
    badge_colour = HEX('4F6C74'),
    sound = { sound = 'gold_seal', per = 1.2, vol = 0.4},
    calculate = function(self,card,context)
        if context.before and context.cardarea == G.play then
            local oldhand,oldlevel = context.scoring_name, getHandLevel(context.scoring_name)
            SMODS.smart_level_up_hand(card,chooserandomhand({}, 'cosmicseal', false),false,1)
            --update_hand_text({sound = 'button', volume = 0.0, pitch = 1.1, delay = 0}, {mult = mult, chips = chips, handname = oldhand, level = oldlevel})
        end
    end
}
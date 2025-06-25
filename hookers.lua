--TYSM Aure for helping me figure out hooks and lovely patches, you're a godsend!

--Hooking into the calculate effect, used for raw scoring
local _calculate_individual_effect = SMODS.calculate_individual_effect -- save a reference to the original function
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if key == 'osquo_ext_rscore' and amount then
        G.GAME.chips = G.GAME.chips + amount
        --update_hand_text({delay = 0}, {chip_total = G.GAME.chips})
        if not effect.remove_default_message then
            if from_edition then
                --currently not a thing so no need
            else
                card_eval_status_text(scored_card or effect.card or effect.focus, 'osquo_ext_rscore', amount, percent)
            end
        end
        return true -- the effect was calculated, so we return early
    end
    return _calculate_individual_effect(effect, scored_card, key, amount, from_edition) -- run the base function as normal
end

local _init_game_object = Game.init_game_object
function Game:init_game_object()
    local ret = _init_game_object(self)
    ret.osquo_ext_pack_choice_mod = 0 --Booster pack choice mod
    ret.current_round.osquo_ext_idolatry_card = {rank = 'Ace', id = 14}
    ret.current_round.osquo_ext_bountyhunter_card = {suit = 'Spades', rank = 'Ace', id = 14} --Card for Wanted Poster (Default: Ace of Spades)
    ret.osquo_ext_amber_consecutives = 0
    ret.current_round.osquo_ext_throwawayline_hand = 'High Card'
    return ret
end

--Context for destroying jokers
local _card_remove = Card.remove
function Card.remove(self)
    if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card then
        SMODS.calculate_context({
            osquo_ext = {
                destroy_joker = true,
                destroyed_joker = self
            }
        })
    end
    return _card_remove(self)
end
--[[
local _card_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card and self.config.center_key == 'j_osquo_ext_bargainingjoker' and not self.debuff then
        local _card = copy_card(self, nil, nil, nil, false)
        _card:add_to_deck()
        G.jokers:emplace(_card)
        _card:start_materialize()
    end
    return _card_start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
end
]]
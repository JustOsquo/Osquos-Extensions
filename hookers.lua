--TYSM Aure for helping me figure out hooks and lovely patches, you're a godsend!

--Hooking into the calculate effect, used for raw scoring
local _calculate_individual_effect = SMODS.calculate_individual_effect -- save a reference to the original function
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if key == 'rscore' and amount then
        G.GAME.chips = G.GAME.chips + amount
        if not effect.remove_default_message then
            if from_edition then
                card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type = 'variable', key = amount > 0 and 'a_mult' or 'a_mult_minus', vars = {amount}}, mult_mod = amount, colour = G.C.DARK_EDITION, edition = true})
            else
        return true -- the effect was calculated, so we return early
    end
    return _calculate_individual_effect(effect, scored_card, key, amount, from_edition) -- run the base function as normal
end
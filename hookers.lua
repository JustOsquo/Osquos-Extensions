--TYSM Aure for helping me figure out hooks and lovely patches, you're a godsend!

--Hooking into the calculate effect, used for raw scoring
local _calculate_individual_effect = SMODS.calculate_individual_effect -- save a reference to the original function
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if key == 'osquo_ext_rscore' and amount then
        G.GAME.chips = G.GAME.chips + amount
        update_hand_text({delay = 0}, {chip_total = G.GAME.chips})
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

--I think this is a hook? Adds global variable for booster pack choice modding
local _init_game_object = Game.init_game_object
function Game:init_game_object()
  local ret = _init_game_object(self)
  ret.osquo_ext_pack_choice_mod = 0 
  return ret
end
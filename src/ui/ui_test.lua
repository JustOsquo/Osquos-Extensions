local _create_UIBox_options = create_UIBox_options
function create_UIBox_options()
    local ret = _create_UIBox_options()
    local m = UIBox_button({
        minw = 5,
        button = 'TestButton_Menu',
        label = { 'This Is A Button'},
        colour = G.C.SO_1.SPADES,
    })
    table.insert(ret.nodes[1].nodes[1].nodes[1].nodes, #ret.nodes[1].nodes[1].nodes[1].nodes + 1, m)
    return ret
end

function G.FUNCS.TestButton_Menu(e)
    print('I FUCKING LOVE KASANE TETO')
end

--[[ Functions for allowing jokers to be used ]]--

local _G_UIDEF_use_and_sell_buttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local ret = _G_UIDEF_use_and_sell_buttons(card)
    local m =
    {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh =  1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_joker'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
        }}
    }}
    if card.ability.set == 'Joker' and card.config.center.key == 'j_osquo_ext_test' then
        table.insert(ret.nodes[1].nodes[2].nodes, #ret.nodes[1].nodes[2].nodes + 1, m)
    end
    return ret
end

function G.FUNCS.can_use_joker(e)
    if e.config.ref_table:can_use_joker() then
        e.config.colour = G.C.RED
        e.config.button = 'use_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

function Card:can_use_joker(any_state, skip_check)
    if not skip_check and ((G.play and #G.play.cards > 0) or
        (G.CONTROLLER.locked) or
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
        then  return false end
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        if self.config.center.key == 'j_osquo_ext_test' then
            if G.GAME.dollars < 401 then return true end
        end
    end
    return false
end

local _G_FUNCS_use_card = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
    local hcard = e.config.ref_table
    local harea = hcard.area
    if hcard.ability.consumeable then G.GAME.osquo_ext_using_consumeable = true end
    local ret = _G_FUNCS_use_card(e, mute, nosave)
    if e.config.ref_table.config.center.key == 'j_osquo_ext_test' then
        delay(0.2)
        e.config.ref_table:use_joker(harea)
    end
    G.GAME.osquo_ext_using_consumeable = nil
    return ret
end

function Card:use_joker(area,copier)
    stop_use()
    if self.debuff then return nil end
    local used_joker = copier or self

    if self.config.center.key == 'j_osquo_ext_test' then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            used_joker:juice_up(0.3, 0.5)
            ease_dollars(401, true)
            return true end }))
        delay(0.6)
    end
end
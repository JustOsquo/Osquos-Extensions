--[[
local test_ui = UIBOX({
    definition = test_ui_func(menu_name),
    config = {type = 'cm', menu_name}
})

local test_ui_node = {n=G.UIT.O, config={object = test_ui}}

function test_ui_func(menu_name)
    local ui = {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = { --Root Node, Containing:
        {n = G.UIT.C, config = {minw=4, minh=4, colour = G.C.MONEY, padding = 0.15}, nodes = { --4x4 C.MONEY Column Node, Containing:
            {n = G.UIT.R, config = {minw=2, minh=2, colour = G.C.RED, padding = 0.15}, nodes = { --2x2 C.RED Row Node, Containing:
                {n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.BLUE, padding = 0.15}}, --1x1 C.BLUE Column Node,
                {n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.BLUE, padding = 0.15}} --1x1 C.BLUE Column Node;;
            }},
            
            {n = G.UIT.R, config = {minw=2, minh=1, colour = G.C.RED, padding = 0.15}, nodes = { --2x1 C.RED Row Node, Containing:
                {n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.BLUE, padding = 0.15}}, --1x1 C.BLUE Column Node,
                {n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.BLUE, padding = 0.15}} --1x1 C.BLUE Column Node;;;
            }}
        }}
        {n=G.UIT.C, config={button = "my_button", my_data={1, 2, 3}}, nodes={
            {n=G.UIT.T, config={text = "Press Me!"}}
        }}
    }}
    return ui
end

function G.FUNCS.my_update_menu(e)
    -- Get the menu UIBox object:
    local my_menu_uibox = e.config.my_data.menu_uibox
    -- Get the parent of the menu UIBox, because we want to delete and re-create the menu:
    local menu_wrap = my_menu_uibox.parent

    -- Delete the current menu UIBox:
    menu_wrap.config.object:remove()
    -- Create the new menu UIBox:
    menu_wrap.config.object = UIBox({
    definition = my_menu_function(e.config.my_data),
    config = {parent = menu_wrap, type = "cm"} -- You MUST specify parent!
    })
    -- Update the UI:
    menu_wrap.UIBox:recalculate()
end
--]]

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
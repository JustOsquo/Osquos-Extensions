--Optional Features
SMODS.current_mod.optional_features = function()
    return {
        cardarea = {'deck', true}
    }
end

SMODS.Atlas { --Mod Icon (Very Cool)
    key = 'modicon',
    path = 'icon.png',
    px = 32,
    py = 32
}

--rahhhh talisman
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

--Load Hooks
SMODS.load_file('util/hookers.lua')()

--Load UI functions
SMODS.load_file('src/ui/ui_test.lua')()

--Load Utilities
SMODS.load_file('util/animateObject.lua')()
SMODS.load_file('util/extraFuncs.lua')()

--Load Sounds
SMODS.load_file('src/content/sounds.lua')()

--Load Atlases
SMODS.load_file('src/content/atlases.lua')()

--Load Jokers
SMODS.load_file('src/content/jokers.lua')()

--Load Consumables
SMODS.load_file('src/content/consumables.lua')()

--Load Card Modifiers
SMODS.load_file('src/content/cardmodifiers.lua')()

--Load Vouchers
SMODS.load_file('src/content/vouchers.lua')()

--Loading JokerDisplay Compatability (if it's detected)
if JokerDisplay then
    SMODS.load_file('src/compat/JokerDisplayComp.lua')()
end
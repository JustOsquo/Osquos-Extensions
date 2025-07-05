--Optional Features
SMODS.current_mod.optional_features = function()
    return {
        cardarea = {'deck', true}
    }
end

--rahhhh talisman
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

--Load Hooks
assert(SMODS.load_file('util/hookers.lua')())

--Load UI functions
assert(SMODS.load_file('src/ui/ui_test.lua')())

--Load Utilities
assert(SMODS.load_file('util/animateObject.lua')())
assert(SMODS.load_file('util/extraFuncs.lua')())

--Load Sounds
assert(SMODS.load_file('src/content/sounds.lua')())

--Load Atlases
assert(SMODS.load_file('src/content/atlases.lua')())

--Load Jokers
assert(SMODS.load_file('src/content/jokers.lua')())

--Load Consumables
assert(SMODS.load_file('src/content/consumables.lua')())

--Load Card Modifiers
assert(SMODS.load_file('src/content/cardmodifiers.lua')())

--Load Vouchers
assert(SMODS.load_file('src/content/vouchers.lua')())

--Loading JokerDisplay Compatability (if it's detected)
if JokerDisplay then
    assert(SMODS.load_file('src/compat/JokerDisplayComp.lua')())
end
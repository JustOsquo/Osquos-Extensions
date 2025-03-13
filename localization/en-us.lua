
--[[ ========== These localizations should be self-explanatory ========== ]]--

--[[
Retrigger all Rankless
cards 1 additional time
]]

return {
    descriptions = {
        Joker = {
            j_osquo_ext_bumperjoker = {
                name = 'Bumper Joker',
                text = {
                    '{C:green}+1000{} Score',
                }
            },
            j_osquo_ext_illegiblejoker = {
                name = 'Illegible Joker',
                text = {
                    '{C:attention}Retrigger{} all {C:attention}Rankless{}',
                    'cards {C:attention}#1#{} additional time'
                }
            },
            j_osquo_ext_crypticjoker = {
                name = 'Cryptic Joker',
                text = {
                    'Convert all {C:attention}Played Cards{}',
                    'to a {C:green}random{} {C:attention}Rank{} and',
                    '{C:attention}Suit{} after first hand of',
                    'round is played'
                }
            },
            j_osquo_ext_ritualist = {
                name = 'Ritualist',
                text = {
                    'Retrigger first scored card',
                    '{C:attention}#1#{} additional time for every',
                    '{C:attention}Unscored Card{} in played {C:attention}Poker Hand{}',
                    '{C:red}Destroys{} {C:attention}Unscored Cards{} after scoring'
                }
            },
            j_osquo_ext_cabinetjoker = {
                name = 'Cabinet Joker',
                text = {
                    'Earn {C:money}#1#${} for each hand played',
                    'this round if {C:attention}Played Hand{}',
                    'did not defeat the {C:attention}Blind{}',
                    '{C:red}X#2#{} {C:red}Blind Size{} per {C:attention}Ante{}',
                    '{C:inactive}(Currently {}{C:red}X#3#{}{C:red} Blind Size{}{C;inactive}){}'
                }
            },
            j_osquo_ext_safetynet = {
                name = 'Safety Net',
                text = {
                    '{X:mult,C:white}X#1#{} Mult if current',
                    '{C:attention}Score{} would not',
                    'defeat the {C:attention}Blind{}'
                }
            },
            j_osquo_ext_transmutation = {
                name = 'Transmutation',
                text = {
                    'Lose {C:attention}#1#%{} of {C:chips}Chips{} and',
                    'gain that amount as {C:mult}Mult{}'
                }
            },
            j_osquo_ext_bufface = {
                name = 'Buff Ace',
                text = {
                    'Played {C:attention}Aces{} give',
                    '{C:chips}+#1#{} Chips when scored',
                    'Increases by {C:chips}#2#{} when',
                    'an {C:attention}Ace{} is scored'
                }
            },
            j_osquo_ext_sweetresin = {
                name = 'Amber Resin',
                text = {
                    'One random played',
                    'card becomes {C:attention}Amber{}',
                    'each hand played',
                    '{C:inactive}({}{C:attention}#1#{}{C:inactive} conversions left){}'
                }
            },
            j_osquo_ext_labgrowngem = {
                name = 'Lab-Grown Gem',
                text = {
                    'Gain {C:money}#1#${} at end of round',
                    'for each consecutive round where',
                    'no {C:diamonds}Diamonds{} were played',
                    '{C:inactive}(Currently {}{C:money}#2#${}{C:inactive}){}'
                }
            },
            j_osquo_ext_stellarnursery = {
                name = 'Stellar Nursery',
                text = {
                    '{C:mult}+#1#{} Base Mult for each',
                    '{C:attention}Poker Hand{} level over 1 on hands',
                    'other than played {C:attention}Poker Hand{}',
                }
            },
            j_osquo_ext_backgroundcheck = {
                name = 'Background Check',
                text = {
                    'Cards give {X:mult,C:white}X1{} Mult when scored',
                    'Cards give {X:mult,C:white}X#1#{} more for each card',
                    'of its {C:attention}Suit{} in played {C:attention}Poker Hand{}'
                }
            },
            j_osquo_ext_amberjoker = {
                name = 'Amber Joker',
                text = {
                    'Gives {X:mult,C:white}X#1#{} Mult and {X:chips,C:white}X#2#{} Chips',
                    'for each {C:attention}Amber Card{} in your {C:attention}full deck{}',
                    '{C:inactive}(Currently {}{X:mult,C:white}X#3#{} {C:inactive}Mult and {}{X:chips,C:white}X#4#{} {C:inactive}Chips){}'
                }
            },
            j_osquo_ext_stargazer = {
                name = 'Stargazer',
                text = {
                    'Additionally level up a',
                    '{C:attention}random poker hand{} when',
                    'using a {C:planet}Planet{} card',
                    --'{C:inactive}Debugvalue:#4#'
                }
            },
            j_osquo_ext_earl = {
                name = 'Earl',
                text = {
                    'Each {C:attention}Mult Card{}',
                    'held in hand',
                    'gives {C:mult}+#1#{} Mult'
                }
            },
            j_osquo_ext_count = {
                name = 'Count',
                text = {
                    'Each {C:attention}Bonus Card{}',
                    'held in hand',
                    'gives {C:chips}+#1#{} Chips'
                }
            },
            j_osquo_ext_knave = {
                name = 'Knave',
                text = {
                    'Each {C:attention}Jack{}',
                    'held in hand',
                    'gives {X:chips,C:white}X#1#{} Chips'
                }
            },
            j_osquo_ext_theharmony = {
                name = 'The Harmony',
                text = {
                    'Played cards give {X:mult,C:white}X#1#{} Mult when',
                    'scored if {C:attention}Poker Hand{} contains',
                    'an equal number of {C:spades}Spades{},',
                    '{C:hearts}Hearts{}, {C:clubs}Clubs{}, and {C:diamonds}Diamonds'
                }
            },
            j_osquo_ext_empoweredopal = {
                name = 'Empowered Opal',
                text = {
                    'Gains {X:mult,C:white}X#2#{} Mult every time',
                    'a {C:attention}Wild{} card is scored',
                    '{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult)'
                }
            },
            j_osquo_ext_reaper = {
                name = 'Reaper',
                text = {
                    'After {C:attention}first{} hand played',
                    'during round, convert the',
                    '{C:attention}leftmost{} card held in hand',
                    'into the {C:attention}rightmost',
                    --'{C:inactive,s:0.8}DEBUG: used:#1# counter:#2#' --for debugging only
                }
            },
            j_osquo_ext_seelie = {
                name = 'Seelie',
                text = {
                    'Scored cards with a {C:tarot}Purple Seal',
                    'create a {C:tarot}Tarot{} card',
                    'Scored cards with a {C:planet}Blue Seal',
                    'create a {C:planet}Planet{} card',
                    '{C:inactive,s:0.8}(Must have room)'
                }
            },
            j_osquo_ext_giantjoker = {
                name = 'Giant Joker',
                text = {
                    'Gains {C:attention}+#2#{} hand size every',
                    '{C:attention}#3#{} {C:inactive}(#4#){} hands played',
                    '{C:inactive}(currently{} {C:attention}+#1#{} {C:inactive}hand size)'
                }
            },
            j_osquo_ext_thekhanate = {
                name = 'The Khanate',
                text = {
                    'Retrigger all played',
                    'cards {C:attention}2{} additional',
                    'times if played hand',
                    'contains a {C:attention}Flush'
                }
            },
            j_osquo_ext_bubbleuniverse = {
                name = 'Bubble Universe',
                text = {
                    '{C:green}#1# in #2#{} chance for one',
                    'random {C:attention}Joker{} to become',
                    '{C:dark_edition}Negative{} and {C:attention}Eternal{}',
                    'when selecting {C:attention}Blind{}'
                }
            },
            j_osquo_ext_recursivejoker = {
                name = 'Grand Design',
                text = {
                    'All {C:attention}Blueprints{} and {C:attention}Brainstorms{}',
                    'trigger an additional time',
                }
            },
            j_osquo_ext_glassblower = {
                name = 'Acrylic Bath',
                text = {
                    'Create a copy of',
                    'destroyed Glass Cards',
                }
            },
            j_osquo_ext_nichola = {
                name = 'Nichola',
                text = {
                    'Gains {C:attention}+#1#{} hand size',
                    'for every {C:attention}#2#{} {C:inactive}(#4#){} cards',
                    'added to your deck',
                    '{C:inactive}(Currently {}{C:attention}+#3#{}{C:inactive} Hand size){}'
                }
            }
        },
        Back = {
            b_osquo_ext_fragile = {
                name = 'Fragile Deck',
                text = {
                    'Start run with',
                    'one random {C:attention}Suit',
                    'and {C:attention}Acrylic Bath',
                    'Starting cards are',
                    '{C:attention}Glass cards'
                }
            },
        },
        Tarot = {
            c_osquo_ext_fox = {
                name = 'The Fox',
                text = {
                    'Enhances {C:attention}#1#{} selected card',
                    'into an {C:attention}Amber Card{}'
                }
            }
        },
        Spectral = {
            c_osquo_ext_erudition = {
                name = 'Erudition',
                text = {
                    'Changes {C:attention}#1#{} selected card',
                    'to a random {C:attention}Enhancement{}, {C:attention}Seal{},',
                    'and {C:attention}Edition{}'
                }
            },
        },
        Voucher = {
            v_osquo_ext_boosterfeast = {
                name = 'Booster Feast',
                text = {
                    '+#1# Booster Pack',
                    'available in shop'
                }
            },
            v_osquo_ext_boosterglutton = {
                name = 'Booster Glutton',
                text = {
                    '+#1# Choice in all',
                    'Booster Packs'
                }
            },
        },
        Other = {
            acrylic_info = {
                name = 'Acrylic Card',
                text = {
                    '{X:mult,C:white}X2.5{} Mult',
                    '{C:red}Shatters{} after being',
                    'played {C:attention}4{} times'
                }
            },
            amber_info = {
                name = 'Amber Card',
                text = {
                    '{X:mult,C:white}X1.25{} Mult and {X:chips,C:white}X1.25{) Chips',
                    'While this card stays in hand',
                    'No rank or suit'
                }
            },
        },
        Enhanced = {
            m_osquo_ext_acrylic = {
                name = 'Acrylic Card',
                text = {
                    '{X:mult,C:white}X#1#{} Mult',
                    '{C:red}Shatters{} after being',
                    'played {C:attention}3{} times',
                    '({C:attention}#2#{} plays remaining)'
                }
            },
            m_osquo_ext_amberE = {
                name = 'Amber Card',
                text = {
                    '{X:mult,C:white}X#1#{} Mult and {X:chips,C:white}X#2#{) Chips',
                    'While this card stays in hand',
                    'No rank or suit'
                }
            },
        },
    },
    misc = {
        dictionary = {
            osquo_ext_becomeacrylic = 'Acrylic!',
            osquo_ext_acrylicrunningout = 'Running out!',
            osquo_ext_1tarot = '+Tarot!',
            osquo_ext_1planet = '+Planet!',
            osquo_ext_scalereset = 'Reset!',
            osquo_ext_amberconvert = 'Amber!',
            osquo_ext_minusone = '-1',
            osquo_ext_sweetresinlicked = 'Licked!',
            osquo_ext_1handsize = '+1 Hand Size',
            osquo_ext_sacrificed = 'Sacrificed!',
        },
        v_dictionary = {
            osquo_ext_a_rscore = "+#1# Score"
        },
    },
}
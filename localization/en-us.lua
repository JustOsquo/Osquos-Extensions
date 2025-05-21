
--[[ ========== These localizations should be self-explanatory ========== ]]--

--[[
X2 Mult if played hand
contains no more than
2 unique cards
]]

return {
    descriptions = {
        Joker = {
            j_osquo_ext_tasteslikejoker = {
                name = 'Joker that doesnt taste like Joker but makes you say "Mmm, Tastes like Joker"',
            },
            j_osquo_ext_uniformjoker = {
                name = 'Uniform Joker',
                text = {
                    '{X:mult,C:white}X#1#{} Mult if {C:attention}Played Hand{}',
                    'contains no more than',
                    '{C:attention}#2#{} unique cards'
                }
            },
            j_osquo_ext_ominousmasque = {
                name = 'Ominous Masque',
                text = {
                    'Sell this card to create',
                    'a {C:dark_edition}Negative{} {C:blue}Common{} {C:attention}Joker{}'
                }
            },
            j_osquo_ext_hungryhungryjoker = {
                name = 'Hungry Hungry Joker',
                text = {
                    'When blind is selected,',
                    '{C:attention}eat{} a random card in',
                    'deck and gain {C:mult}+#1#{} Mult',
                    '{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}'
                }
            },
            j_osquo_ext_cheerleaderjoker = {
                name = 'Cheerleader Joker',
                text = {
                    'Gains {C:chips}+#1#{} Chips when a',
                    'card is {C:attention}retriggered{}',
                    '{C:inactive}(Currently {C:chips}+#2#{} {C:inactive}Chips){}'
                }
            },
            j_osquo_ext_sprite = {
                name = 'Sprite',
                text = {
                    'Sell this card to create',
                    'a free {C:attention}Voucher Tag{}'
                }
            },
            j_osquo_ext_algebra = {
                name = 'Algebra',
                text = {
                    '{X:mult,C:white}X#1#{} Mult if played hand',
                    'has a scoring {C:attention}Ace{} and',
                    '{C:attention}Numbered{} card'
                }
            },
            j_osquo_ext_mathematics_unsolved = {
                name = 'Mathematics',
                text = {
                    'Gains {X:mult,C:white}X#3#{} Mult if the {C:attention}Sum{} of',
                    'all played {C:attention}Numbered{} cards equals {C:green}#1#{}',
                    'Refreshes after defeating {C:attention}Boss Blind{}',
                    '{s:0.8,C:red}Unsolved{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}'
                }
            },
            j_osquo_ext_mathematics_solved = {
                name = 'Mathematics',
                text = {
                    'Gains {X:mult,C:white}X#3#{} Mult if the {C:attention}Sum{} of',
                    'all played {C:attention}Numbered{} cards equals {C:green}#1#{}',
                    'Refreshes after defeating {C:attention}Boss Blind{}',
                    '{s:0.8,C:green}Solved{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}'
                }
            },
            j_osquo_ext_compensation = {
                name = 'Compensation',
                text = {
                    'Gives {X:mult,C:white}X#1#{} Mult for each',
                    'owned {C:attention}Rental{} joker'
                }
            },
            j_osquo_ext_ghostjoker = {
                name = 'Ghost Joker',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'create a {C:spectral}Spectral{} card',
                    'when using a {C:spectral}Spectral{} card',
                    '{C:inactive}(Must have room)'
                }
            },
            j_osquo_ext_pickyjoker = {
                name = 'Junk Joker',
                text = {
                    'Earn {C:money}$#1#{} every {C:attention}#2#{} {C:inactive}[#3#]{}',
                    'cards discarded'
                }
            },
            j_osquo_ext_hermitjoker = {
                name = 'Hermit Joker',
                text = {
                    'Gives {X:mult,C:white}X#2#{} mult',
                    'for every {C:money}$#1#{} of',
                    '{C:attention}debt{} you are in'
                }
            },
            j_osquo_ext_helpinghand = {
                name = 'Helping Hand',
                text = {
                    'Played cards give',
                    '{C:attention}half{} their rank',
                    'as mult when scored'
                }
            },
            j_osquo_ext_fraudjoker = {
                name = 'Fraudulent Joker',
                text = {
                    '{X:mult,C:white}X#3#{} Mult',
                    'Increases by {X:mult,C:white}X#4#{} and',
                    '{C:green}#1# in #2#{} chance this card',
                    'is {C:red}destroyed{} at',
                    'the end of round'
                }
            },
            j_osquo_ext_corruptjoker = {
                name = 'Corrupt Joker',
                text = {
                    'Gains {X:mult,C:white}X#1#{} Mult',
                    'for each {C:attention}reroll{}',
                    'Loses {X:mult,C:white}X#2#{} Mult',
                    'When buying a {C:attention}Joker{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}Mult){}'
                }
            },
            j_osquo_ext_delljoker = {
                name = 'Joker-in-the-dell',
                text = {
                    '{C:attention}Destroy{} fifth played',
                    'card after first hand',
                    'of round is played',
                }
            },
            j_osquo_ext_ostracon = {
                name = 'Ostrakon',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'create a random {C:attention}Tag{}',
                    'at end of round',
                    '{s:0.8}Orbital Tag excluded'
                }
            },
            j_osquo_ext_chaostheory = {
                name = 'Three Body Problem',
                text = {
                    'Retrigger {C:attention}Random{} card',
                    'used in scoring {C:attention}#1#{}',
                    'additional times'
                }
            },
            j_osquo_ext_grandfinale = {
                name = 'Grand Finale',
                text = {
                    'Retrigger {C:attention}Final{} card',
                    'used in scoring {C:attention}#1#{}',
                    'additional time'
                }
            },
            j_osquo_ext_bountyhunter = {
                name = 'Bounty Hunter',
                text = {
                    'If {C:attention}Played Hand{} is only',
                    'a single {C:attention}#3#{} of {V:1}#2#{},',
                    'destroy it and earn {C:money}$#1#{}',
                    '{s:0.8}Card changes every round{}'
                }
            },
            j_osquo_ext_scroogejoker = {
                name = 'Scrooge Joker',
                text = {
                    '{C:attention}Gold Cards{} held',
                    'in hand give',
                    '{X:mult,C:white}X#1#{} mult'
                }
            },
            j_osquo_ext_shareholder = {
                name = 'Shareholder',
                text = {
                    'Lose {C:attention}#1#%{} of money',
                    'at end of shop',
                    'Gains {X:mult,C:white}X#2#{} Mult',
                    'per {C:attention}$1{} lost this way',
                    '{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}Mult){}'
                }
            },
            j_osquo_ext_westernjoker = {
                name = 'Western Joker',
                text = {
                    'Played {C:attention}Wild Cards{} are',
                    'permanantly upgraded with',
                    'either {C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult,',
                    '{X:mult,C:white}X#3#{} Mult, or {C:money}$#4#{} when scored'
                }
            },
            j_osquo_ext_bumperjoker = {
                name = 'Bumper',
                text = {
                    '{C:green}+#1#{} Score',
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
                    --'{C:red}Destroys{} {C:attention}Unscored Cards{} after scoring'
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
            j_osquo_ext_temperatejoker = {
                name = 'Temperate Joker',
                text = {
                    '{X:mult,C:white}X#1#{} Mult',
                    'Loses {X:mult,C:white}X#2#{} Mult per',
                    '{C:attention}reroll{} in the shop'
                }
            },
            j_osquo_ext_transmutation = {
                name = 'Transmutation',
                text = {
                    'Lose {C:attention}Square Root{} of {C:chips}Chips{}',
                    'and gain that amount as {C:mult}Mult{}'
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
            j_osquo_ext_idolatry = {
                name = 'Idolatry',
                text = {
                    'Retrigger each played',
                    '{C:attention}#2# #1#{} additional times',
                    '{s:0.8}Rank changes every round{}'
                }
            },
            j_osquo_ext_stargazer = {
                name = 'Stargazer',
                text = {
                    'Additionally level up a',
                    '{C:attention}random poker hand{} when',
                    'using a {C:planet}Planet{} card',
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
                    'scored if {C:attention}Scored Hand{} contains',
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
                    'Cards with a {C:tarot}Purple Seal{} create',
                    'a {C:tarot}Tarot{} card when scored',
                    'Cards with a {C:planet}Blue Seal{} create',
                    'a {C:planet}Planet{} card when scored',
                    '{C:inactive,s:0.8}(Must have room)'
                }
            },
            j_osquo_ext_giantjoker = {
                name = 'Giant Joker',
                text = {
                    'Gains {C:attention}+#2#{} hand size every',
                    '{C:attention}#3#{} {C:inactive}[#4#]{} hands played',
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
                name = 'Stańczyk',
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
            c_osquo_ext_nescience = {
                name = 'Nescience',
                text = {
                    'Replaces all {C:attention}Jokers{} with',
                    'random jokers of {C:green}equal rarity{}'
                }
            },
        },
        Chess = {
            c_osquo_ext_king = {
                name = 'King',
                text = {
                    'Create up to {C:attention}#1#{}',
                    'random Chess cards',
                    '{C:inactive}(Must have room)'
                }
            },
            c_osquo_ext_queen = {
                name = 'Queen',
                text = {
                    '{C:green}Randomize{} the {C:attention}rank{} and {C:attention}suit{}',
                    'of up to {C:attention}#1#{} selected cards'
                }
            },
            c_osquo_ext_rook = {
                name = 'Rook',
                text = {
                    'Select {C:attention}#1#{} cards, copy the',
                    '{C:attention}Enhancement{}, {C:attention}Seal{}, and {C:attention}Edition{}',
                    'from the {C:attention}right{} card {C:attention}to the{} {C:attention}left{} card',
                    '{C:inactive}(Drag to rearrange){}'
                }
            },
        },
        Voucher = {
            v_osquo_ext_boosterfeast = {
                name = 'Booster Feast',
                text = {
                    '{C:attention}+#1#{} Booster Pack',
                    'available in shop'
                }
            },
            v_osquo_ext_boosterglutton = {
                name = 'Booster Glutton',
                text = {
                    '{C:attention}+#1#{} Choice in all',
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
                    '{X:mult,C:white}X1.05{} Mult while this',
                    'card stays in hand',
                    'Gives {X:mult,C:white}X0.05{} more for each time',
                    'this effect has already triggered',
                    'No rank or suit'
                }
            },
        },
        Enhanced = {
            m_osquo_ext_acrylic = {
                name = 'Acrylic Card',
                text = {
                    '{X:mult,C:white}X#1#{} Mult',
                    '{C:red}Shatters{} after',
                    'being played',
                }
            },
            m_osquo_ext_amberE = {
                name = 'Amber Card',
                text = {
                    '{X:mult,C:white}X1.05{} Mult while this',
                    'card stays in hand',
                    'Gives {X:mult,C:white}X#1#{} more for each time',
                    'this effect has already triggered',
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
            osquo_ext_chipsupg = '+Chips!',
            osquo_ext_multupg = '+Mult!',
            osquo_ext_xmultupg = '+XMult!',
            osquo_ext_dollarupg = '+Money!',
            osquo_ext_temperategone = 'Lost!',
            osquo_ext_turnedin = 'Turned in!',
            osquo_ext_fraudjokerbusted = 'Busted!',
            osquo_ext_refreshed = 'Refreshed!',
            osquo_ext_solved = 'Solved!',
            --
            osquo_ext_ace = 'Ace',
            osquo_ext_numbered = 'Numbered',
        },
        v_dictionary = {
            osquo_ext_a_rscore = "+#1# Score",
        },
    },
}
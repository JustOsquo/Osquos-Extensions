function tarotConvert(selected, enhancement)
	for i=1, #selected do --Flip cards
		local percent = 1.15 - (i-0.999)/(#selected-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() selected[i]:flip();play_sound('card1', percent);selected[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	for i=1, #selected do --Convert cards
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
		selected[i]:set_ability(G.P_CENTERS[enhancement])
		return true end }))
	end
	for i=1, #selected do --Flip cards back
		local percent = 0.85 + (i-0.999)/(#selected-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() selected[i]:flip();play_sound('tarot2', percent, 0.6);selected[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end })) --unselect cards
	delay(0.5)
end

function ConvertCards(cards, rank, suit, enhance, seal, edition, rank_mod, seed, flip) --New, More flexible version of tarotConvert()
	--cards: Table of cards to convert
	--rank, suit, enhance, seal, edition: Table of relevant modifiers to randomly choose from to apply
	--rank_mod: Increases rank by value
	--flip: Boolean whether to flip cards during conversion
	--seed: RNG Seed
	seed = seed or 'ConvertCards'
	flip = flip or true
	
	if flip then
		for i=1, #cards do --Flip cards
			local percent = 1.15 - (i-0.999)/(#cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards[i]:flip();play_sound('card1', percent);cards[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
	end
	
	for i=1, #cards do --Convert cards
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()

		if rank or suit then assert(SMODS.change_base( --Rank and Suit
			cards[i],
			pseudorandom_element(enhance, pseudoseed(suit)),
			pseudorandom_element(rank, pseudoseed(seed))
		)) end

		if rank_mod then assert(SMODS.modify_rank(
				cards[i],
				rank_mod
		)) end

		if enhance then cards[i]:set_ability(G.P_CENTERS[ --Enhancement
			pseudorandom_element(enhance, pseudoseed(seed))
		]) end

		if seal then cards[i]:set_seal( --Seal
			pseudorandom_element(seal, pseudoseed(seed))
		) end

		if edition then cards[i]:set_edition( --Edition
			pseudorandom_element(edition, pseudoseed(seed))
		) end

		return true end }))
	end

	if flip then --Flip cards back
		for i=1, #cards do --Flip cards back
			local percent = 0.85 + (i-0.999)/(#cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards[i]:flip();play_sound('tarot2', percent, 0.6);cards[i]:juice_up(0.3, 0.3);return true end }))
		end
	end

	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end })) --unselect cards
	delay(0.5)
end

function chooserandomhand(ignore, seed, allowhidden)
	local chosen_hand = nil
	ignore = ignore or {} --can specify hands to not choose
	seed = seed or 'seed' --rng seed
	if type(ignore) ~= 'table' then ignore = {ignore} end
	while true do
		chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
		if G.GAME.hands[chosen_hand].visible or allowhidden then --cant choose hidden hands unless otherwise stated
			local safe = true
			for _, v in pairs(ignore) do
				if v == chosen_hand then
					safe = false
				end
			end
			if safe then
				break
			end
		end
	end
	return chosen_hand
end

function getHandLevel(hand, invert, subone)
	--hand: chosen poker hand
	--invert: if true, gets levels for all hands but chosen hand
	--subone: if true, subtracts one from each level count to account for them starting at one
	local tally = 0
	if not invert then invert = false end
	if invert == false then
		if subone == true then
			tally = tally + G.GAME.hands[hand].level - 1
		else tally = tally + G.GAME.hands[hand].level end
	elseif invert == true then
		for _, v in ipairs(G.handlist) do
			if v ~= hand then
				if subone == true then
					tally = tally + G.GAME.hands[v].level - 1
				else tally = tally + G.GAME.hands[v].level end
            end
		end
	end
	return tally
end

function table_contains(table, content) --obvious
	for k, v in pairs(table) do
		if v == content then
			return true
		end
	end
	return false
end

function getRandomElementWeighted(table, seed) --Allows for assigning weights to a table and pulling a weightedly random index from it
	local total = 0
	seed = seed or 'seed'
	for k, v in pairs(table) do
		total = total + v[1]
	end
	local selected = pseudorandom(seed, 1, total)
	for k, v in pairs(table) do
		selected = selected - v[1]
		if (selected <= 0) then
			return v[2]
		end
	end
end

function SMODS.current_mod.reset_game_globals(run_start)
	--Random card generation for Bounty Hunter
	G.GAME.current_round.osquo_ext_bountyhunter_card = {suit = 'Spades', rank = 14}
	local targets1 = {}
	for _, v in ipairs(G.playing_cards) do
		if not ((SMODS.has_no_suit(v)) or (v:get_id() < 1) or (SMODS.has_no_rank(v))) then --Must have rank and suit
			targets1[#targets1+1] = v
		end
	end
	if targets1[1] then
		local chosen1 = pseudorandom_element(targets1, pseudoseed('wanted'..G.GAME.round_resets.ante))
		G.GAME.current_round.osquo_ext_bountyhunter_card.suit = chosen1.base.suit
		G.GAME.current_round.osquo_ext_bountyhunter_card.rank = chosen1.base.value
		G.GAME.current_round.osquo_ext_bountyhunter_card.id = chosen1.base.id
	end
	--Random rank generation for Idolatry
	G.GAME.current_round.osquo_ext_idolatry_card = {rank = 'Ace', id = 14}
	local targets2 = {}
	for _, v in ipairs(G.playing_cards) do
		if not ((v:get_id() < 1) or (SMODS.has_no_rank(v))) then --Must have rank
			targets2[#targets2+1] = v
		end
	end
	if targets2[1] then
		local chosen2 = pseudorandom_element(targets2, pseudoseed('idolatry'..G.GAME.round_resets.ante))
		G.GAME.current_round.osquo_ext_idolatry_card.rank = chosen2.base.value
		G.GAME.current_round.osquo_ext_idolatry_card.id = chosen2.base.id
	end
	--Random Poker Hand for Throwaway Line
	G.GAME.current_round.osquo_ext_throwawayline_hand = 'High Card'
	local _pokerhands1 = {}
	for k, v in pairs(G.GAME.hands) do
		if v.visible then _pokerhands1[#_pokerhands1+1] = k end
	end
	local hand1 = pseudorandom_element(_pokerhands1, pseudoseed('throwawayline'..G.GAME.round_resets.ante))
	G.GAME.current_round.osquo_ext_throwawayline_hand = hand1
end

function getRandomTag(ignore, seed, include) --get a random tag
	--ignore: specify tags to avoid
	--seed: rng
	--include: specify tags to choose between
	ignore = ignore or {}
	ignore[#ignore+1] = 'UNAVAILABLE' --because it can return this and thats bad so just reroll if it lands it
	seed = seed or 'seed'
	local num = 0
	local chosen = 'UNAVAILABLE'
	while true do
		chosen = pseudorandom_element(get_current_pool('Tag'), pseudoseed(seed..num))
		if not table_contains(ignore, chosen) then
			if include then if table_contains(include, chosen) then
				break
			end else break end
		end
		num = num + 1
	end
	return chosen
end

function getRandomJokerKey(ignore, myrarity, seed) --get a random joker key with rarity
	--ignore: joker keys to ignore
	--rarity: rarity to choose, random 1-3 if nil
	--seed: rng
	ignore = ignore or {}
	myrarity = myrarity or pseudorandom('getRandomJokerKey', 1, 3)
	seed = seed or 'seed'
	local num = 0
	local chosen = nil
	while true do
		chosen = pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed(seed..num))
		if not table_contains(ignore, chosen.key) and (chosen.rarity == myrarity) then
			break
		end
		num = num + 1
	end
	return chosen.key
end

function Card:reset_size()
	self.T.w = G.CARD_W
	self.T.h = G.CARD_H
end

function JokerConvert(toConvert, newKey)
	for i=1, #toConvert do
		local percent = 1.15 - (i-0.999)/(#toConvert-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
			toConvert[i]:flip()
			play_sound('card1', percent)
			toConvert[i]:juice_up(0.3, 0.3)
			toConvert[i]:reset_size()
		return true end }))
	end

	delay(0.2)

	for i=1, #toConvert do
		local thiskey = nil
		if type(newKey) == 'table' then thiskey = newKey[i] else thiskey = newKey end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
			toConvert[i]:set_ability(thiskey)
		return true end }))
	end

	for i=1, #toConvert do
		local percent = 0.85 + (i-0.999)/(#toConvert-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() toConvert[i]:flip();play_sound('tarot2', percent, 0.6);toConvert[i]:juice_up(0.3, 0.3);return true end }))
	end

	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end })) --unselect cards
	delay(0.5)
end

function cardBaseConvert(toConvert, newRank, newSuit, rng, rngseed, rngeach)
	for i=1, #toConvert do
		local percent = 1.15 - (i-0.999)/(#toConvert-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() toConvert[i]:flip();play_sound('card1', percent);toConvert[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	local loops = 0
	for i = 1, #toConvert do
		local rankc = newRank
		local suitc = newSuit
		if rng then
			rankc = pseudorandom_element(SMODS.Ranks, pseudoseed(rngseed..loops)).key
			suitc = pseudorandom_element(SMODS.Suits, pseudoseed(rngseed..loops)).key
			if rngeach then loops = loops + 1 end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
			assert(SMODS.change_base(toConvert[i], suitc, rankc))
		return true end}))
	end
	for i=1, #toConvert do
		local percent = 0.85 + (i-0.999)/(#toConvert-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() toConvert[i]:flip();play_sound('tarot2', percent, 0.6);toConvert[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end })) --unselect cards
	delay(0.5)
end

function removeTableElement(tabl, content) --why isnt this just a thing already?????
    for i = #tabl, 1, -1 do
        if tabl[i] == content then
            table.remove(tabl, i)
        end
    end
end

function Card:gabil(ask, noextra)
	--ask: String, requested value
	--noextra: Boolean, check card.ability instead of card.ability.extra (not recommended)
	assert(tostring(ask) == ask) --if its not a string then just crash idc
	local ret = ((self.ability.extra and not noextra) and self.ability.extra[ask]) or (self.ability[ask] and noextra)
	return ret
end

function round(val)
	if math.floor(val) == math.ceil(val) then return val end
	if (val - math.floor(val)) < (math.ceil(val) - val) then
		return math.floor(val)
	else --rounds up if tied (intended)
		return math.ceil(val)
	end
end
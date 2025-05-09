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
end

function getRandomTag(ignore, seed) --get a random tag
	--ignore: specify tags to avoid
	--seed: rng
	ignore = ignore or {}
	ignore[#ignore+1] = 'UNAVAILABLE' --because it can return this and thats bad so just reroll if it lands it
	seed = seed or 'seed'
	local num = 0
	local chosen = 'UNAVAILABLE'
	while true do
		chosen = pseudorandom_element(get_current_pool('Tag'), pseudoseed(seed..num))
		if not table_contains(ignore, chosen) then
			break
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

function JokerConvert(toConvert, newKey)
	for i=1, #toConvert do
		local percent = 1.15 - (i-0.999)/(#toConvert-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() toConvert[i]:flip();play_sound('card1', percent);toConvert[i]:juice_up(0.3, 0.3);return true end }))
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
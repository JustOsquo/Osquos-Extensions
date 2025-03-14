function conversionTarot(hand, newcenter) -- For tarots that change enhancements. Directly stolen from Kirbio's UnStable mod (with his permission, ofc. thanks, Kirbio!)
	for i=1, #hand do --Get permission from Kirbio before dist
		local percent = 1.15 - (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('card1', percent);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	
	for i=1, #hand do
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				hand[i]:set_ability(G.P_CENTERS[newcenter])
				return true end }))
	end
	
	for i=1, #hand do
		local percent = 0.85 + (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('tarot2', percent, 0.6);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	delay(0.5)
end

--"Borrowed" from Cryptid, get permission before dist
function chooserandomhand(ignore, seed, allowhidden)
	local chosen_hand
	ignore = ignore or {} --can specify hands to not choose
	seed = seed or "randomhand" --rng seed
	if type(ignore) ~= "table" then
		ignore = { ignore }
	end
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

--Actually mine this time
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

--[[
use = function(self,card)
	local randomenhance = SMODS.poll_enhancement('erudition', nil, true, true)
	local randomseal = SMODS.poll_seal('erudition', nil, true, true)
	local randomedition = 'e_' .. poll_edition('erudition', nil, false, true)

	G.E_MANAGER:add_event(Event({
		trigger = 'after', delay = 0.4, func = function()
		play_sound('tarot1')
		card:juice_up(0.3,0.5)
		return true end}))

	for i=1, #G.hand.highlighted do
		local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)

	for i=1, #G.hand.highlighted do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
			G.hand.highlighted[i]:set_ability(G.P_CENTERS[randomenhance])
			return true end }))
	end
	for i=1, #G.hand.highlighted do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
			G.hand.highlighted[i]:set_seal(randomseal)
			return true end }))
	end
	for i=1, #G.hand.highlighted do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
			G.hand.highlighted[i]:set_edition(randomedition, true)
			return true end }))
	end

	for i=1, #G.hand.highlighted do
		local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	delay(0.5)
end
]]

function table_contains(table, content) --obvious
	for k, v in pairs(table) do
		if v == content then
			return true
		end
	end
	return false
end
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

function change_booster_shop_size(mod) --like change_shop_size() but for booster packs
	if not G.GAME.shop then return end
	G.GAME.shop.osquo_ext_booster_max = G.GAME.shop.osquo_ext_booster_max + mod
	if G.shop_booster and G.shop_booster.cards then
		if mod < 0 then
			--Remove packs in shop
			for i = #G.shop_booster.cards, G.GAME.shop.osquo_ext_booster_max + 1, -1 do
				if G.shop_booster.cards[i] then
					G.shop_booster.cards[i]:remove()
				end
			end
		end
		G.shop_booster.config.card_limit = G.GAME.shop.osquo_ext_booster_max
		G.shop_booster.T.w = G.GAME.shop.osquo_ext_booster_max * 1.01*G.CARD_W
		G.shop:recalculate()
		if mod > 0 then
			for i = 1, G.GAME.shop.osquo_ext_booster_max - #G.shop_booster.cards do
				G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
				if not G.GAME.current_round.used_packs[i] then
					G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
				end

				if G.GAME.current_round.used_packs[i] ~= 'USED' then 
					local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
					G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
					create_shop_card_ui(card, 'Booster', G.shop_booster)
					card.ability.booster_pos = i
					card:start_materialize()
					G.shop_booster:emplace(card)
				end
			end
		end
	end
end
--[[ VOUCHERS ]]--

SMODS.Voucher{ --Booster Feast
    key = 'boosterfeast',
    loc_txt = {set = 'Voucher', key = 'v_osquo_ext_boosterfeast'},
    atlas = 'qle_vouchers',
    pos = {x = 0, y = 0},
    config = {extra = {
        bonus = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.bonus
        }}
    end,
    redeem = function(self,card)
        SMODS.change_booster_limit(card.ability.extra.bonus)
    end,
}

SMODS.Voucher{ --Booster Glutton
    key = 'boosterglutton',
    loc_txt = {set = 'Voucher', key = 'v_osquo_ext_boosterglutton'},
    atlas = 'qle_vouchers',
    pos = {x = 1, y = 0},
    requires = {'v_osquo_ext_boosterfeast'},
    config = {extra = {
        bonus = 1
    }},
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.bonus
        }}
    end,
    redeem = function(self,card)
        G.GAME.osquo_ext_pack_choice_mod = G.GAME.osquo_ext_pack_choice_mod + 1
    end
}
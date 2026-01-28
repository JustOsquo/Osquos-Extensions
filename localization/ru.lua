--[[ ========== These localizations should be self-explanatory ========== ]]--

--[[
X0.75 Mult for each
Joker card over 5
(Currently X1.75 Mult)
]]

return {
    descriptions = {
        Joker = {
            j_osquo_ext_walledcity = {
                name = 'Город-крепость',
                text = {
                    '{X:mult,C:white}X#1#{} множ. за каждого',
                    '{C:attention}Джокера{} со значением выше {C:attention}#3#{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#2#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_general = {
                name = 'Заброшенный джокер',
                text = {
                    'Получает {C:chips}+#2#{} фишек при',
                    'сбросе карты {C:attention}с лицом{}',
                    '{C:attention}Сбрасывается{} при победе',
                    'над {C:attention}Босс-блайндом{}',
                    '{C:inactive}(Сейчас {C:chips}+#1#{} {C:inactive}фишек){}'
                }
            },
            j_osquo_ext_lottery = {
                name = 'Лотерейный билет',
                text = {
                    'Даёт {C:money}$[y/x]{}, если срабатывает',
                    'вероятность {C:green}x к y{} {C:inactive}(округленно){}',
                    '{C:inactive}(пример: {}{C:green}3 к 5{}{C:inactive} -> {C:green}5/3{} -> {}{C:money}$2{}{C:inactive}){}'
                }
            },
            j_osquo_ext_hourofneed = {
                name = 'Бергентрюк',
                text = {
                    'Отключает {C:attention}Босс-блайнд{} во время',
                    '{C:attention}последней руки{} раунда',
                    '{C:red}Уничтожается{} после победы над',
                    '{C:attention}#1#{} Босс-блайндами'
                }
            },
            j_osquo_ext_shaman = {
                name = 'Шаман',
                text = {
                    'Шанс {C:green}#1# к #2#{} создать',
                    'карту {C:tarot}Таро{}, если сыгранная',
                    'рука — это одиночная {C:clubs}Трефа{}',
                    '{C:attention}Гарантировано{}, если карта — {C:attention}Валет{}'
                }
            },
            j_osquo_ext_moneyshot = {
                name = 'Денежный выстрел',
                text = {
                    '{X:mult,C:white}X#2#{} множ., теряете {C:money}$#1#{}',
                    'при срабатывании'
                }
            },
            j_osquo_ext_scavenger = {
                name = 'Мусорщик',
                text = {
                    'Шанс {C:green}#1# к #2#{} создать',
                    '{C:green}Необычный{} жетон при',
                    '{C:attention}уничтожении{} джокера',
                    'Шанс {C:green}#3# к #4#{}, что созданный',
                    'жетон станет {C:red}Редким{}'
                }
            },
            j_osquo_ext_refundpolicy = {
                name = 'Политика возврата',
                text = {
                    'Один раз за раунд создаёт',
                    '{C:attention}Стандартный{}, {C:tarot}Очаровательный{}, {C:planet}Метеор{},',
                    'или {C:spectral}Эфирный{} жетон при',
                    'пропуске {C:attention}бустерного набора{}'
                }
            },
            j_osquo_ext_bloodyjoker = {
                name = 'Мясник',
                text = {
                    '{C:attention}Уничтожает{} всех джокеров',
                    '{C:attention}справа{} при выборе {C:attention}Блайнда{}',
                    'Получает {X:mult,C:white}X#2#{} множ. за каждого',
                    'уничтоженного таким образом джокера',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#1#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_virtualsinger = {
                name = 'Виртуальная певица',
                text = {
                    'Даёт {C:mult}+#2#{} множ. за каждую',
                    'карту {C:attention}с лицом{} в вашей {C:attention}полной колоде{}',
                    '{C:inactive}(Сейчас {C:mult}+#1#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_cheshirecat = {
                name = 'Чеширский кот',
                text = {
                    '{X:mult,C:white}X#1#{} множ., если {C:attention}сыгранная рука{}',
                    'содержит только карты {C:attention}с лицом{}'
                }
            },
            j_osquo_ext_bargainingjoker = {
                name = 'Торгующийся джокер',
                text = {
                    'Создаёт {C:attention}дубликат{}',
                    'этого джокера, когда он',
                    '{C:attention}уничтожается{} {C:inactive}(не продан){}',
                }
            },
            j_osquo_ext_throwawayline = {
                name = 'Бросовая фраза',
                text = {
                    'Получает {C:mult}+#1#{} множ., если сброшенная',
                    '{C:attention}покерная комбинация{} — это {C:attention}#2#{}',
                    '{s:0.8}Комбинация меняется каждый раунд{}',
                    '{s:0.8}Прирост множ. зависит от комбинации{}',
                    '{C:inactive}(Сейчас {C:mult}+#3#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_prophecy = {
                name = 'Пророчество',
                text = {
                    '{C:red}Уничтожьте{} эту карту и',
                    'получите {C:money}$#1#{} в {C:attention}конце раунда{}',
                    'Выплата {C:red}уменьшается{} на {C:money}$#2#{}',
                    'за каждый использованный {C:attention}Сброс{}'
                }
            },
            j_osquo_ext_cosmicjoker = {
                name = 'Космический джокер',
                text = {
                    '{C:attention}Повышает уровень{} сыгранной',
                    'покерной комбинации во время',
                    '{C:attention}последней руки{} раунда'
                }
            },
            j_osquo_ext_spacetour = {
                name = 'Космическая станция',
                text = {
                    'Даёт {C:money}$#1#{} за каждые 2 {C:attention}уровня{}',
                    'у {C:attention}сброшенной{} покерной комбинации'
                }
            },
            j_osquo_ext_ledger = {
                name = 'Гроссбух',
                text = {
                    'Добавляет {C:attention}стоимость продажи{} всех',
                    'имеющихся {C:attention}Джокеров{} к {C:chips}фишкам{}',
                    'при выборе {C:attention}блайнда{}',
                    '{C:inactive}(Сейчас {C:chips}+#1#{} {C:inactive}фишек){}'
                }
            },
            j_osquo_ext_volcano = {
                name = 'Вулкан',
                text = {
                    'Шанс {C:green}#1# к #2#{}',
                    'получить {X:mult,C:white}X#4#{} множ.',
                    'при выборе {C:attention}Блайнда{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#3#{} {C:inactive}множ.){}',
                }
            },
            j_osquo_ext_partytiem = {
                name = '"Время Вечиринки!"',
                text = {
                    'Получает {X:mult,C:white}X#1#{} множ., если',
                    '{C:attention}сыгранная рука{} содержит',
                    '{C:attention}Фулл-хаус{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#2#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_dealmaker = {
                name = 'Делец',
                text = {
                    'При продаже карты,',
                    'даёт {C:money}$#1#{} плюс {C:attention}одна треть{}',
                    'от её {C:attention}стоимости продажи{}'
                }
            },
            j_osquo_ext_tidyjoker = {
                name = 'Игривый джокер',
                text = {
                    '{X:mult,C:white}X#1#{} множ.',
                    'на {X:mult,C:white}X#2#{} множ. {C:attention}меньше{} за',
                    'каждую карту, {C:attention}удерживаемую в руке{}'
                }
            },
            j_osquo_ext_hypernova = {
                name = 'Гиперновая',
                text = {
                    '{X:mult,C:white}X#1#{} баз. множ.',
                    'за каждый {C:attention}уровень{}',
                    'сыгранной {C:attention}Покерной комбинации{}'
                }
            },
            j_osquo_ext_tasteslikejoker = { --I have no recollection of making this
                name = 'Джокер, который не пахнет как Джокер, но заставляет сказать "Ммм, на вкус как Джокер"',
                text = {
                    'Ммм, на вкус как Джокер'
                }
            },
            j_osquo_ext_uniformjoker = {
                name = 'Униформа',
                text = {
                    '{X:mult,C:white}X#1#{} множ., если {C:attention}Сыгранная рука{}',
                    'содержит не более',
                    '{C:attention}#2#{} уникальных карт'
                }
            },
            j_osquo_ext_ominousmasque = {
                name = 'Зловещая маска',
                text = {
                    'Продайте эту карту, чтобы создать',
                    '{C:dark_edition}Негативного{} {C:blue}Обычного{} {C:attention}Джокера{}'
                }
            },
            j_osquo_ext_hungryhungryjoker = {
                name = 'Очень голодный джокер',
                text = {
                    'При выборе блайнда,',
                    '{C:attention}съедает{} случайную карту в',
                    'колоде и получает {C:mult}+#1#{} множ.',
                    '{C:inactive}(Сейчас {C:mult}+#2#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_cheerleaderjoker = {
                name = 'Чирлидер',
                text = {
                    'Получает {C:chips}+#1#{} фишек, когда',
                    'карта срабатывает {C:attention}повторно{}',
                    '{C:inactive}(Сейчас {C:chips}+#2#{} {C:inactive}фишек){}'
                }
            },
            j_osquo_ext_sprite = {
                name = 'Спрайт',
                text = {
                    'Продайте эту карту, чтобы создать',
                    'бесплатный {C:attention}Жетон-купон{}'
                }
            },
            j_osquo_ext_algebra = {
                name = 'Алгебра',
                text = {
                    '{X:mult,C:white}X#1#{} множ., если в сыгранной руке',
                    'есть подсчитываемый {C:attention}Туз{} и',
                    'карта {C:attention}с числом{}'
                }
            },
            j_osquo_ext_mathematics_unsolved = {
                name = 'Математика',
                text = {
                    'Получает {X:mult,C:white}X#3#{} множ., если {C:attention}Сумма{}',
                    'всех сыгранных {C:attention}карт с числом{} равна {C:green}#1#{}',
                    'Обновляется после победы над {C:attention}Босс-блайндом{}',
                    '{s:0.8,C:red}Не решено{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#2#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_mathematics_solved = {
                name = 'Математика',
                text = {
                    'Получает {X:mult,C:white}X#3#{} множ., если {C:attention}Сумма{}',
                    'всех сыгранных {C:attention}карт с числом{} равна {C:green}#1#{}',
                    'Обновляется после победы над {C:attention}Босс-блайндом{}',
                    '{s:0.8,C:green}Решено{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#2#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_compensation = {
                name = 'Компенсация',
                text = {
                    'Даёт {X:mult,C:white}X#1#{} множ. за каждого',
                    'имеющегося {C:attention}Арендуемого{} джокера'
                }
            },
            j_osquo_ext_ghostjoker = {
                name = 'Призрачный джокер',
                text = {
                    'Шанс {C:green}#1# к #2#{}',
                    'создать {C:spectral}Спектральную{} карту',
                    'при использовании {C:spectral}Спектральной{} карты',
                    '{C:inactive}(Должно быть место)'
                }
            },
            j_osquo_ext_pickyjoker = {
                name = 'Мусорный джокер',
                text = {
                    'Даёт {C:money}$#1#{} за каждые {C:attention}#2#{} {C:inactive}[#3#]{}',
                    'сброшенные карты'
                }
            },
            j_osquo_ext_hermitjoker = {
                name = 'Джокер-отшельник',
                text = {
                    'Даёт {X:mult,C:white}X#2#{} множ.',
                    'за каждые {C:money}$#1#{}',
                    'вашего {C:attention}долга{}'
                }
            },
            j_osquo_ext_helpinghand = {
                name = 'Рука помощи',
                text = {
                    'Сыгранные карты дают',
                    '{C:attention}половину{} своего ранга',
                    'в качестве множ. при подсчёте'
                }
            },
            j_osquo_ext_fraudjoker = {
                name = 'Мошенник',
                text = {
                    '{X:mult,C:white}X#3#{} множ.',
                    'Увеличивается на {X:mult,C:white}X#4#{} и',
                    'шанс {C:green}#1# к #2#{}, что эта карта',
                    'будет {C:red}уничтожена{} в',
                    'конце раунда'
                }
            },
            j_osquo_ext_corruptjoker = {
                name = 'Коррумпированный джокер',
                text = {
                    'Получает {X:mult,C:white}X#1#{} множ.',
                    'за каждое {C:attention}обновление{}',
                    'Теряет {X:mult,C:white}X#2#{} множ.',
                    'при покупке {C:attention}Джокера{}',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#3#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_delljoker = {
                name = 'Фермер в долине',
                text = {
                    '{C:attention}Уничтожает{} пятую сыгранную',
                    'карту после того, как сыграна',
                    'первая рука раунда',
                }
            },
            j_osquo_ext_ostracon = {
                name = 'Остракон',
                text = {
                    'Шанс {C:green}#1# к #2#{}',
                    'создать случайный {C:attention}Жетон{}',
                    'в конце раунда',
                    '{s:0.8}Орбитальный жетон исключён'
                }
            },
            j_osquo_ext_chaostheory = {
                name = 'Задача трёх тел',
                text = {
                    'Эффекты {C:attention}случайной{} карты,',
                    'использованной при подсчёте, срабатывают',
                    'ещё {C:attention}#1#{} раз(а)'
                }
            },
            j_osquo_ext_grandfinale = {
                name = 'Гранд-финал',
                text = {
                    'Эффекты {C:attention}последней{} карты,',
                    'использованной при подсчёте, срабатывают',
                    'ещё {C:attention}#1#{} раз'
                }
            },
            j_osquo_ext_bountyhunter = {
                name = 'Охотник за головами',
                text = {
                    'Если {C:attention}Сыгранная рука{} состоит только',
                    'из одной {C:attention}#3#{} масти {V:1}#2#{},',
                    'уничтожает её и даёт {C:money}$#1#{}',
                    '{s:0.8}Карта меняется каждый раунд{}'
                }
            },
            j_osquo_ext_scroogejoker = {
                name = 'Скряга',
                text = {
                    '{C:attention}Золотые карты{}, удерживаемые',
                    'в руке, дают',
                    '{X:mult,C:white}X#1#{} множ.'
                }
            },
            j_osquo_ext_shareholder = {
                name = 'Акционер',
                text = {
                    'Теряете {C:attention}#1#%{} денег',
                    'при выходе из магазина',
                    'Получает {X:mult,C:white}X#2#{} множ.',
                    'за каждый {C:attention}$1{}, потерянный так',
                    '{C:inactive}(Сейчас {X:mult,C:white}X#3#{} {C:inactive}множ.){}'
                }
            },
            j_osquo_ext_westernjoker = {
                name = 'Джокер вестерна',
                text = {
                    'Сыгранные {C:attention}Дикие карты{}',
                    'навсегда улучшаются, получая',
                    '{C:chips}+#1#{} фишек, {C:mult}+#2#{} множ.,',
                    '{X:mult,C:white}X#3#{} множ. или {C:money}$#4#{} при подсчёте'
                }
            },
            j_osquo_ext_bumperjoker = {
                name = 'Бампер',
                text = {
                    '{C:green}+#1#{} очков',
                }
            },
            j_osquo_ext_illegiblejoker = {
                name = 'Неразборчивый джокер',
                text = {
                    'Эффекты всех карт {C:attention}без ранга{}',
                    'срабатывают ещё {C:attention}#1#{} раз'
                }
            },
            j_osquo_ext_crypticjoker = {
                name = 'Загадочный джокер',
                text = {
                    'Преобразует все {C:attention}сыгранные карты{}',
                    'в {C:green}случайное{} {C:attention}достоинство{} и',
                    '{C:attention}масть{} после того, как сыграна',
                    'первая рука раунда'
                }
            },
            j_osquo_ext_ritualist = {
                name = 'Ритуалист',
                text = {
                    'Эффекты первой подсчитанной карты срабатывают',
                    'ещё {C:attention}#1#{} раз за каждую',
                    '{C:attention}неподсчитанную карту{} в сыгранной {C:attention}руке{}',
                    --'{C:red}Destroys{} {C:attention}Unscored Cards{} after scoring'
                }
            },
            j_osquo_ext_cabinetjoker = {
                name = 'Кабинетный джокер',
                text = {
                    'Даёт {C:money}#1#${} за каждую сыгранную руку',
                    'в этом раунде, если {C:attention}сыгранная рука{}',
                    'не победила {C:attention}Блайнд{}',
                    '+{C:red}X#2#{} к {C:red}размеру Блайнда{} за каждое {C:attention}Анте{}',
                    '{C:inactive}(Сейчас {}{C:red}X#3#{}{C:red} размер Блайнда{}{C;inactive}){}'
                }
            },
            j_osquo_ext_temperatejoker = {
                name = 'Умеренный джокер',
                text = {
                    '{X:mult,C:white}X#1#{} множ.',
                    'Теряет {X:mult,C:white}X#2#{} множ. за каждое',
                    '{C:attention}обновление{} в магазине'
                }
            },
            j_osquo_ext_transmutation = {
                name = 'Трансмутация',
                text = {
                    'Отнимает {C:attention}#1#%{} {C:chips}фишек{}',
                    'и добавляет это количество к {C:mult}множ.{}'
                }
            },
            j_osquo_ext_bufface = {
                name = 'Качок',
                text = {
                    'Сыгранные {C:attention}Тузы{} дают',
                    '{C:chips}+#1#{} фишек при подсчёте',
                    'Увеличивается на {C:chips}#2#{}, когда',
                    '{C:attention}Туз{} подсчитывается'
                }
            },
            j_osquo_ext_sweetresin = {
                name = 'Янтарная смола',
                text = {
                    'Одна случайная сыгранная',
                    'карта становится {C:attention}Янтарной{}',
                    'каждую сыгранную руку',
                    '{C:inactive}({}{C:attention}#1#{}{C:inactive} превращений осталось){}'
                }
            },
            j_osquo_ext_labgrowngem = {
                name = 'Искусственный самоцвет',
                text = {
                    'Даёт {C:money}#1#${} в конце раунда',
                    'за каждый последовательный раунд, где',
                    'не были сыграны {C:diamonds}Бубны{}',
                    '{C:inactive}(Сейчас {}{C:money}#2#${}{C:inactive}){}'
                }
            },
            j_osquo_ext_stellarnursery = {
                name = 'Звёздная колыбель',
                text = {
                    '{C:mult}+#1#{} Баз. множ. за каждый',
                    '{C:attention}уровень{} покерной комбинации выше 1',
                    'у рук, отличных от сыгранной {C:attention}руки{}',
                }
            },
            j_osquo_ext_backgroundcheck = {
                name = 'Проверка данных',
                text = {
                    'Карты дают {X:mult,C:white}X1{} множ. при подсчёте',
                    'Карты дают на {X:mult,C:white}X#1#{} больше за каждую карту',
                    'своей {C:attention}масти{} в сыгранной {C:attention}руке{}'
                }
            },
            j_osquo_ext_idolatry = {
                name = 'Идолопоклонство',
                text = {
                    'Эффекты каждой сыгранной',
                    '{C:attention}#2# срабатывают ещё #1#{} раз(а)',
                    '{s:0.8}Достоинство меняется каждый раунд{}'
                }
            },
            j_osquo_ext_stargazer = {
                name = 'Звездочёт',
                text = {
                    'Дополнительно повышает уровень',
                    '{C:attention}случайной покерной комбинации{} при',
                    'использовании карты {C:planet}Планеты{}',
                }
            },
            j_osquo_ext_earl = {
                name = 'Граф',
                text = {
                    'Каждая {C:attention}Карта с множителем{}',
                    'удерживаемая в руке,',
                    'даёт {C:mult}+#1#{} множ.'
                }
            },
            j_osquo_ext_count = {
                name = 'Граф (титул)',
                text = {
                    'Каждая {C:attention}Бонусная карта{}',
                    'удерживаемая в руке,',
                    'даёт {C:chips}+#1#{} фишек'
                }
            },
            j_osquo_ext_knave = {
                name = 'Валет (слуга)',
                text = {
                    'Каждый {C:attention}Валет{}',
                    'удерживаемый в руке,',
                    'даёт {C:chips}+#1#{} фишек'
                }
            },
            j_osquo_ext_theharmony = {
                name = 'Гармония',
                text = {
                    'Сыгранные карты дают {X:mult,C:white}X#1#{} множ. при',
                    'подсчёте, если {C:attention}подсчитанная рука{} содержит',
                    'равное количество {C:spades}Пик{},',
                    '{C:hearts}Червей{}, {C:clubs}Треф{} и {C:diamonds}Бубен'
                }
            },
            j_osquo_ext_empoweredopal = {
                name = 'Заряженный опал',
                text = {
                    'Получает {X:mult,C:white}X#2#{} множ. каждый раз,',
                    'когда подсчитывается {C:attention}Дикая{} карта',
                    '{C:inactive}(Сейчас{} {X:mult,C:white}X#1#{} {C:inactive}множ.)'
                }
            },
            j_osquo_ext_reaper = {
                name = 'Жнец',
                text = {
                    'После {C:attention}первой{} сыгранной руки',
                    'в раунде, превращает',
                    '{C:attention}крайнюю левую{} карту в руке',
                    'в {C:attention}крайнюю правую',
                    --'{C:inactive,s:0.8}DEBUG: used:#1# counter:#2#' --for debugging only
                }
            },
            j_osquo_ext_seelie = {
                name = 'Благой двор',
                text = {
                    'Карты с {C:tarot}Фиолетовой печатью{} создают',
                    'карту {C:tarot}Таро{} при подсчёте',
                    'Карты с {C:planet}Синей печатью{} создают',
                    'карту {C:planet}Планеты{} при подсчёте',
                    '{C:inactive,s:0.8}(Должно быть место)'
                }
            },
            j_osquo_ext_giantjoker = {
                name = 'Гигантский джокер',
                text = {
                    'Получает {C:attention}+#2#{} к размеру руки за каждые',
                    '{C:attention}#3#{} {C:inactive}[#4#]{} сыгранных рук',
                    '{C:inactive}(сейчас{} {C:attention}+#1#{} {C:inactive}к размеру руки)'
                }
            },
            j_osquo_ext_thekhanate = {
                name = 'Ханство',
                text = {
                    'Эффекты всех сыгранных',
                    'карт срабатывают ещё {C:attention}2{}',
                    'раза, если сыгранная рука',
                    'содержит {C:attention}Флеш'
                }
            },
            j_osquo_ext_bubbleuniverse = {
                name = 'Станчик',
                text = {
                    'Шанс {C:green}#1# к #2#{}, что один',
                    'случайный {C:attention}Джокер{} станет',
                    '{C:dark_edition}Негативным{} и {C:attention}Вечным{}',
                    'при выборе {C:attention}Блайнда{}'
                }
            },
            j_osquo_ext_recursivejoker = {
                name = 'Великий замысел',
                text = {
                    'Все {C:attention}Чертежи{} и {C:attention}Мозговые штурмы{}',
                    'срабатывают ещё один раз',
                }
            },
            j_osquo_ext_glassblower = {
                name = 'Акриловая ванна',
                text = {
                    'Создаёт копию',
                    'уничтоженных Стеклянных карт',
                }
            },
            j_osquo_ext_nichola = {
                name = 'Никола',
                text = {
                    'Получает {C:attention}+#1#{} к размеру руки',
                    'за каждые {C:attention}#2#{} {C:inactive}(#4#){} карт,',
                    'добавленных в вашу колоду',
                    '{C:inactive}(Сейчас {}{C:attention}+#3#{}{C:inactive} к размеру руки){}'
                }
            },
            j_osquo_ext_osquo = {
                name = 'Оскво',
                text = {
                    'Эффекты каждой сыгранной карты {C:hearts}Червей{}',
                    'срабатывают ещё {C:attention}#1#{} раз(а)',
                    '{C:attention}Улучшается{} на {C:attention}#2#{} за каждые',
                    '{C:money}$#3#{}{C:inactive}[$#4#]{}, потраченные в {C:attention}магазине{}',
                    '{s:0.8}Требование растёт с каждым улучшением{}'
                }
            },
        },
        Back = {
        },
        Tarot = {
            c_osquo_ext_fox = {
                name = 'Лиса',
                text = {
                    'Улучшает {C:attention}#1#{} выбранную карту',
                    'до {C:attention}Янтарной карты{}'
                }
            },
            c_osquo_ext_garden = {
                name = 'Сад',
                text = {
                    'Улучшает {C:attention}#1#{}',
                    'выбранных карт',
                    'до {C:attention}Карт роста{}'
                }
            },
            c_osquo_ext_croesus = {
                name = 'Крёз',
                text = {
                    'Добавляет {C:money}$#2#{} к {C:attention}стоимости продажи{}',
                    '{C:attention}#1#{} выбранного {C:attention}Джокера{}',
                    'или {C:attention}Расходника{}'
                }
            },
            c_osquo_ext_fortitude = {
                name = 'Стойкость',
                text = {
                    'Увеличивает достоинство',
                    '{C:attention}#1#{} выбранной карты на {C:attention}#2#{}'
                }
            },
        },
        Spectral = {
            c_osquo_ext_erudition = {
                name = 'Эрудиция',
                text = {
                    'Меняет {C:attention}#1#{} выбранную карту',
                    'на случайное {C:attention}Улучшение{}, {C:attention}Печать{},',
                    'и {C:attention}Издание{}'
                }
            },
            c_osquo_ext_nescience = {
                name = 'Невежество',
                text = {
                    'Заменяет всех {C:attention}Джокеров{} на',
                    'случайных джокеров {C:green}той же редкости{}'
                }
            },
            c_osquo_ext_twilight = {
                name = 'Сумерки',
                text = {
                    'Добавляет {V:1}Космическую печать{}',
                    'на {C:attention}#1#{} выбранную',
                    'карту в руке'
                }
            },
        },
        Voucher = {
            v_osquo_ext_boosterfeast = {
                name = 'Пир бустеров',
                text = {
                    '{C:attention}+#1#{} Бустерный набор',
                    'доступен в магазине'
                }
            },
            v_osquo_ext_boosterglutton = {
                name = 'Обжора бустеров',
                text = {
                    '{C:attention}+#1#{} выбор во всех',
                    'Бустерных наборах'
                }
            },
        },
        Other = {
            acrylic_info = {
                name = 'Акриловая карта',
                text = {
                    '{X:mult,C:white}X2.5{} множ.',
                    '{C:red}Разбивается{} после того, как',
                    'была сыграна {C:attention}4{} раза'
                }
            },
            amber_info = {
                name = 'Янтарная карта',
                text = {
                    '{X:mult,C:white}X1.05{} множ., пока эта',
                    'карта остаётся в руке',
                    'Даёт на {X:mult,C:white}X0.05{} больше за каждый раз,',
                    'когда этот эффект уже сработал',
                    'Без ранга и масти'
                }
            },
            growth_info = {
                name = 'Карта роста',
                text = {
                    '{C:chips}+0{} доп. фишек',
                    'Получает {C:chips}+10{} фишек',
                    'при {C:attention}сбросе'
                }
            },
            cosmic_info = {
                name = 'Космическая печать',
                text = {
                    'Повышает уровень {C:attention}случайной{}',
                    '{C:attention}покерной комбинации{} при розыгрыше'
                },
            },
            osquo_ext_cosmic_seal = {
                name = 'Космическая печать',
                text = {
                    'Повышает уровень {C:attention}случайной{}',
                    '{C:attention}покерной комбинации{} при розыгрыше'
                },
            },
            osquo_ext_retain_edition = {
                name = 'n',
                text = {
                    '{C:inactive,s:0.9}(Копия сохраняет издание){}'
                }
            },
            osquo_ext_overselect_c = {
                name = 'n',
                text = {
                    '{C:inactive,s:0.9}(Можно выбрать больше расходников){}'
                }
            },
        },
        Seal = { --card exporter freaked out
            osquo_ext_cosmic = {
                name = 'Космическая печать',
                text = {
                    'Повышает уровень {C:attention}случайной{}',
                    '{C:attention}покерной комбинации{} при розыгрыше'
                },
            }
        },
        Enhanced = {
            m_osquo_ext_acrylic = {
                name = 'Акриловая карта',
                text = {
                    '{X:mult,C:white}X#1#{} множ.',
                    '{C:red}Разбивается{} после',
                    'того, как была сыграна',
                }
            },
            m_osquo_ext_amberE = {
                name = 'Янтарная карта',
                text = {
                    '{X:mult,C:white}X1.05{} множ., пока эта',
                    'карта остаётся в руке',
                    'Даёт на {X:mult,C:white}X#1#{} больше за каждый раз,',
                    'когда этот эффект уже сработал',
                    'Без ранга и масти'
                }
            },
            m_osquo_ext_growth = {
                name = 'Карта роста',
                text = {
                    '{C:chips}+#1#{} доп. фишек',
                    'Получает {C:chips}+#2#{} фишек',
                    'при {C:attention}сбросе'
                }
            },
        },
    },
    misc = {
        dictionary = {
            osquo_ext_becomeacrylic = 'Акрил!',
            osquo_ext_acrylicrunningout = 'Заканчивается!',
            osquo_ext_1tarot = '+Таро!',
            osquo_ext_1planet = '+Планета!',
            osquo_ext_scalereset = 'Сброс!',
            osquo_ext_amberconvert = 'Янтарь!',
            osquo_ext_minusone = '-1',
            osquo_ext_sweetresinlicked = 'Лизнули!',
            osquo_ext_1handsize = '+1 к разм. руки',
            osquo_ext_sacrificed = 'Жертва!',
            osquo_ext_chipsupg = '+Фишки!',
            osquo_ext_multupg = '+Множ.!',
            osquo_ext_xmultupg = '+XМнож.!',
            osquo_ext_dollarupg = '+Деньги!',
            osquo_ext_temperategone = 'Потеряно!',
            osquo_ext_turnedin = 'Сдано!',
            osquo_ext_fraudjokerbusted = 'Попался!',
            osquo_ext_refreshed = 'Обновлено!',
            osquo_ext_solved = 'Решено!',
            osquo_ext_corroded = 'Разъедено!',
            osquo_ext_downgrade = 'Понижение!',
            osquo_ext_broken = 'Сломано!',
            osquo_ext_inactive = 'неактивно',
            --
            osquo_ext_ace = 'Туз',
            osquo_ext_numbered = 'С числом',
        },
        v_dictionary = {
            osquo_ext_a_rscore = "+#1# Очков",
        },
        labels = {
            osquo_ext_cosmic_seal = 'Космическая печать',
        },
    },
}
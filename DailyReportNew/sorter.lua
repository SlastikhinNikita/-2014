--[[ EDBOSorter v. 0.1-2
1. Экспортим из ЕДЕБО экселевское файло, пересохраняем его в in.txt
(формат - текстовый файл с табуляциями)
2. Запускаем сортировщик из SciTE, копируем вывод с данными в файл out.csv
3. Открываем в экселе ксв-шку, и копируем цифры в нужные поля отчета.
порядок предметов поправлен в отчете за 6.07

CHANGELOG:
  - обновили формат, изменили разделитель входного файла на ";"
  - обновили коды магистров

TODO:
  - Сменить коды бакалавров


--]]

--Глобальные переменные бакалавров
b_culturologia = 0
b_filosophia = 0
b_history = 0
b_philology = 0
b_economtheory = 0
b_marketing = 0
b_fin_cred = 0
b_prikladna_math = 0
b_prog_engineer = 0
b_pravoznavstvo = 0
b_chemistry = 0
b_biology = 0
b_ecology_ons = 0
b_physics = 0
b_sociology = 0
b_politology = 0
b_soc_work = 0
b_informatika = 0
--Глобальные переменные бакалавров - электронки
be_culturologia = 0
be_filosophia = 0
be_history = 0
be_philology = 0
be_economtheory = 0
be_marketing = 0
be_fin_cred = 0
be_prikladna_math = 0
be_prog_engineer = 0
be_pravoznavstvo = 0
be_chemistry = 0
be_biology = 0
be_ecology_ons = 0
be_physics = 0
be_sociology = 0
be_politology = 0
be_soc_work = 0
be_informatika = 0
--Глобальные переменные специалистов
s_pravo = 0
--Глобальные переменные магистров
m_culturology = 0
m_history = 0
m_archaeology = 0 -- NEW 2014
m_philosophy = 0
m_philology = 0
m_economtheory = 0
m_marketing = 0 -- NEW 2014
m_fincred = 0
m_sysmeth = 0
m_infosys = 0
m_prog_zab = 0
m_prykmath = 0
m_pravoznavstvo = 0
m_chemistry = 0
m_biology = 0
m_ecology = 0
m_physics = 0
m_labdiag = 0
m_sociology = 0
m_politology = 0
m_zhurnalist = 0
m_management = 0
m_soc_work = 0
m_publicadmin = 0 -- NEW 2014


skas_cnt = 0

vsego_zayav = 0
vsego_zayav_b = 0
vsego_zayav_e = 0


--Метод для разделения данных в строке
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

--Проверяем строку, не электронка ли -- СТАРОЕ, теперь есть поле
function ez_check(osp)
	--print(osp)
	local ez = 0
	if osp == "" or osp == " " or osp == nil then
		--print "ELZAYAVA" -- TEST
		ez = 1
	end
	--print(osp)
	if osp ~= nil then
		local a = string.match(osp, 'ez-**')
		if a ~= nil then
			ez = 1
		end
	end
	return ez
end

--Метод обработки
function craft(file)
	local file = io.open(file)
	local file2 = io.open("out.csv", "w")
	local bac = 0
	local mag = 0
	local spec = 0
	local ezbac = 0
	if file then
		--Обрабатываем построчно
		for line in file:lines() do
		--№пп|ПІБ|ЕЗ|Статус|Комментар|Створено|Особ.справа|Курс|Форма|ОКР|Б|К|Бал|Код напряму|Напрям|Код спеціал.|Спеціальність|Спеціалізація|Структ. підрозділ|Змінено|Бал, деталізація|Тип док.|Серія док.|№ док.|Бал док.|Дата док.|Відзнака|Тип|Причина|Пільга|Першоч.|Квота|Мова|ОІ|Категорія|Стать|Гр.|Країна|ТН|Телефон|Мобільний|ОД|Гурт.|Коди вступу|Пріоритет
      local npp, pib, ez, status,coments,stdat,  ossprava, kurs, forma, okr, b_f, k_f, bal, napr_code, napr_name, spec_code, spec_name, specialize, struct_pidrozd, changed_data, bal_det, doc_type, doc_serie, doc_num, doc_bal, doc_date, vidznaka, vst_type, descript, pilga, persho, kvota, lang,	inoz,	kat_inoz, sex, national, country, type_city, tel, mob, od, gurt  = unpack(split(line, ";"))
			if status == "Допущено" then
			--if nil == nil then
			--print(napr_code)
				-- Если ОКР Бакалавра
				if okr == "Бакалавр (3 р. 10 м.)" then
					bac = bac + 1
					if ez == "1"  then
						ezbac = ezbac + 1
					end
					--Подсчитываем шифр
					if napr_code == "6.020101" then
						if ez == "1"  then
							be_culturologia = be_culturologia + 1
						end
						b_culturologia = b_culturologia + 1
					elseif napr_code == "6.020301" then
						if ez == "1"  then
							be_filosophia = be_filosophia + 1
						end
						b_filosophia = b_filosophia + 1
					elseif napr_code == "6.020302" then
						if ez == "1"  then
							be_history = be_history + 1
						end
						b_history = b_history + 1
					elseif napr_code == "6.020303" then
						if ez == "1"  then
							be_philology = be_philology + 1
						end
						b_philology = b_philology + 1
					elseif napr_code == "6.030501" then
						if ez == "1"  then
							be_economtheory = be_economtheory + 1
						end
						b_economtheory = b_economtheory + 1
					elseif napr_code == "6.040302" then
						if ez == "1"  then
							be_informatika = be_informatika + 1
						end
						b_informatika = b_informatika + 1
					elseif napr_code == "6.030507" then
						if ez == "1"  then
							be_marketing = be_marketing + 1
						end
						b_marketing = b_marketing + 1


					elseif napr_code == "6.030508" then
						if ez == "1"  then
							be_fin_cred = be_fin_cred + 1
						end
						b_fin_cred = b_fin_cred + 1
					elseif napr_code == "6.040301" then
						if ez == "1"  then
							be_prikladna_math = be_prikladna_math + 1
						end
						b_prikladna_math = b_prikladna_math + 1
					elseif napr_code == "6.050103" then
						if ez == "1"  then
							be_prog_engineer = be_prog_engineer + 1
						end
						b_prog_engineer = b_prog_engineer + 1
					elseif napr_code == "6.030401" then
						if ez == "1"  then
							be_pravoznavstvo = be_pravoznavstvo + 1
						end
						b_pravoznavstvo = b_pravoznavstvo + 1
					elseif napr_code == "6.040101" then
						if ez == "1"  then
							be_chemistry = be_chemistry + 1
						end
						b_chemistry = b_chemistry + 1
					elseif napr_code == "6.040102" then
						if ez == "1"  then
							be_biology = be_biology + 1
						end
						b_biology = b_biology + 1
					elseif napr_code == "6.040106" then
						if ez == "1"  then
							be_ecology_ons = be_ecology_ons + 1
						end
						b_ecology_ons = b_ecology_ons + 1
					elseif napr_code == "6.040203" then
						if ez == "1"  then
							be_physics = be_physics + 1
						end
						b_physics = b_physics + 1
					elseif napr_code == "6.030101" then
						if ez == "1"  then
							be_sociology = be_sociology + 1
						end
						b_sociology = b_sociology + 1
					elseif napr_code == "6.030104" then
						if ez == "1"  then
							be_politology = be_politology + 1
						end
						b_politology = b_politology + 1
					elseif napr_code == "6.130102" then
						if ez == "1"  then
							be_soc_work = be_soc_work + 1
						end
						b_soc_work = b_soc_work + 1
					end
				-- Если ОКР Магистра
				elseif okr == "Магістр (1 р. 10 м.)" or okr == "Магістр (0 р. 10 м.)" then
					mag = mag + 1
					if spec_code == "8.02010101" then
						m_culturology = m_culturology + 1
					elseif spec_code == "8.02030101" then
						m_philosophy = m_philosophy + 1
					elseif spec_code == "8.02030201" then
						m_history = m_history + 1
                    elseif spec_code == "8.02030204" then
                        m_archaeology = m_archaeology + 1 -- NEW 2014
					elseif spec_code == "8.02030307" then
						m_philology = m_philology + 1
					elseif spec_code == "8.03050101" then
						m_economtheory = m_economtheory + 1
                    elseif spec_code == "8.03050701" then
                        m_marketing = m_marketing + 1 -- NEW 2014
					elseif spec_code == "8.03050801" then
						m_fincred = m_fincred + 1
					elseif spec_code == "8.04030302" then
						m_sysmeth = m_sysmeth + 1
					elseif spec_code == "8.05010101" then
						m_infosys = m_infosys + 1
					elseif spec_code == "8.05010301" then
						m_prog_zab = m_prog_zab + 1
					elseif spec_code == "8.04030101" then
						m_prykmath = m_prykmath + 1
					elseif spec_code == "8.03040101" then
						m_pravoznavstvo = m_pravoznavstvo + 1
					elseif spec_code == "8.04010101" then
						m_chemistry = m_chemistry + 1
					elseif spec_code == "8.04010201" then
						m_biology = m_biology + 1
					elseif spec_code == "8.04010601" then
						m_ecology = m_ecology + 1
					elseif spec_code == "8.04020301" then
						m_physics = m_physics + 1
					elseif spec_code == "8.04010213" then
						m_labdiag = m_labdiag + 1
					elseif spec_code == "8.03010101" then
						m_sociology = m_sociology + 1
					elseif spec_code == "8.03010401" then
						m_politology = m_politology + 1
					elseif spec_code == "8.15010008" then
						m_publicadmin = m_publicadmin + 1   -- NEW 2014
					elseif spec_code == "8.03030101" then
						m_zhurnalist = m_zhurnalist + 1
					elseif spec_code == "8.03060101" then
						m_management = m_management + 1
					elseif spec_code == "8.13010201" then
						m_soc_work = m_soc_work + 1
					end
				-- Если ОКР Специалиста
				elseif okr == "Спеціаліст (0 р. 10 м.)" then
					spec = spec + 1
					if spec_code == "7.03040101" then
						s_pravo = s_pravo + 1
					--elseif spec_code == "7.05010101" then
					--	s_infosys = s_infosys + 1
					end
				end
			else
				--print ("!!! СТАТУС ВІДМІННИЙ ВІД ДОПУЩЕНОГО  !!! " .. pib)
				skas_cnt = skas_cnt + 1
			end
				if ez == "1"  then vsego_zayav_e = vsego_zayav_e + 1
				else vsego_zayav_b = vsego_zayav_b + 1
				end
			--]]
			--print(npp, okr, napr_name, spec_name, ossprava)
		end

		--Ужас статистики
		file2:write("Кількість поданних заяв на Бакалавра " .. "; " .. "; " .. "; ".. bac .. "; ".. ezbac .. "\n")
		file2:write("біологія" .. "; " .. "50" .. "; " .. "25" .. "; " .. b_biology .. "; " .. be_biology .. "\n")
		file2:write("екологія, охорона навколишнього середовища та збалансоване природокористування" .. "; " .. "50" .. "; " .. "25" .. "; " .. b_ecology_ons .. "; " .. be_ecology_ons .. "\n")
		file2:write("економічна теорія" .. "; " .. "75" .. "; " .. "18" .. "; " .. b_economtheory .. "; " .. be_economtheory .. "\n")
		file2:write("інформатика" .. "; " .. "50" .. "; " .. "25" .. "; " .. b_informatika .. "; " .. be_informatika .. "\n")
		file2:write("історія" .. "; " .. "50" .. "; " .. "30" .. "; " .. b_history .. "; " .. be_history .. "\n")
		file2:write("культурологія" .. "; " .. "50" .. "; " .. "18" .. "; " .. b_culturologia .. "; " .. be_culturologia .. "\n")
		file2:write("маркетинг" .. "; " .. "35" .. "; " .. "20" .. "; " .. b_marketing .. "; " .. be_marketing .. "\n")
		file2:write("політологія" .. "; " .. "50" .. "; " .. "20" .. "; " .. b_politology .. "; " .. be_politology .. "\n")
		file2:write("правознавство" .. "; " .. "125" .. "; " .. "50" .. "; " .. b_pravoznavstvo .. "; " .. be_pravoznavstvo .. "\n")
		file2:write("прикладна математика" .. "; " .. "40" .. "; " .. "20" .. "; " .. b_prikladna_math .. "; " .. be_prikladna_math .. "\n")
		file2:write("програмна інженерія" .. "; " .. "60" .. "; " .. "50" .. "; " .. b_prog_engineer .. "; " .. be_prog_engineer .. "\n")
		file2:write("соціальна робота" .. "; " .. "50" .. "; " .. "21" .. "; " .. b_soc_work .. "; " .. be_soc_work .. "\n")
		file2:write("соціологія" .. "; " .. "75" .. "; " .. "35" .. "; " .. b_sociology .. "; " .. be_sociology .. "\n")
		file2:write("фізика" .. "; " .. "50" .. "; " .. "25" .. "; " .. b_physics .. "; " .. be_physics .. "\n")
		file2:write("філологія" .. "; " .. "50" .. "; " .. "40" .. "; " .. b_philology .. "; " .. be_philology .. "\n")
		file2:write("філософія" .. "; " .. "50" .. "; " .. "20" .. "; " .. b_filosophia .. "; " .. be_filosophia .. "\n")
		file2:write("фінанси і кредит" .. "; " .. "75" .. "; " .. "40" .. "; " .. b_fin_cred .. "; " .. be_fin_cred .. "\n")
		file2:write("хімія" .. "; " .. "50" .. "; " .. "25" .. "; " .. b_chemistry .. "; " .. be_chemistry .. "\n")

		file2:write("Кількість поданних заяв на Магістра " .. "; "  .. "; " .. "; ".. mag .. "; 0"  .. "\n")
		file2:write("біологія" .. "; " .. "25" .. "; " .. "10" .. "; " .. m_biology .. "; 0" .. "\n")
		file2:write("екологія та охорона навколишнього середовища" .. "; " .. "20" .. "; " .. "14" .. "; " .. m_ecology .. "; 0" .. "\n")
		file2:write("економічна теорія" .. "; " .. "60" .. "; " .. "35" .. "; " .. m_economtheory .. "; 0" .. "\n")
        file2:write("маркетинг" .. "; " .. "25" .. "; " .. "8" .. "; " .. m_marketing .. "; 0" .. "\n") -- NEW 2014
		file2:write("журналістика" .. "; " .. "25" .. "; " .. "15" .. "; " .. m_zhurnalist .. "; 0" .. "\n")
		file2:write("інформаційні управляючі системи та технології" .. "; " .. "20" .. "; " .. "10" .. "; " .. m_infosys .. "; 0" .. "\n")
		file2:write("історія" .. "; " .. "40" .. "; " .. "22" .. "; " .. m_history .. "; 0" .. "\n")
        file2:write("археологія" .. "; " .. "40" .. "; " .. "8" .. "; " .. m_archaeology .. "; 0" .. "\n") -- NEW 2014
		file2:write("культурологія" .. "; " .. "35" .. "; " .. "10" .. "; " .. m_culturology .. "; 0" .. "\n")
		file2:write("лабораторна діагностика біологічних систем" .. "; " .. "20" .. "; " .. "5" .. "; " .. m_labdiag .. "; 0" .. "\n")
		file2:write("менеджмент організацій і адміністрування" .. "; " .. "50" .. "; " .. "20" .. "; " .. m_management .. "; 0" .. "\n")
		file2:write("політологія" .. "; " .. "40" .. "; " .. "25" .. "; " .. m_politology .. "; 0" .. "\n")
		file2:write("правознавство" .. "; " .. "90" .. "; " .. "20" .. "; " .. m_pravoznavstvo .. "; 0" .. "\n")
		file2:write("прикладна математика" .. "; " .. "20" .. "; " .. "10" .. "; " .. m_prykmath .. "; 0" .. "\n")
		file2:write("програмне забезпечення систем" .. "; " .. "20" .. "; " .. "10" .. "; " .. m_prog_zab .. "; 0" .. "\n")
		file2:write("публічне адміністрування" .. "; " .. "20" .. "; " .. "-" .. "; " .. m_publicadmin .. "; 0" .. "\n")
		file2:write("системи і методи прийняття рішень" .. "; " .. "20" .. "; " .. "10" .. "; " .. m_sysmeth .. "; 0" .. "\n")
		file2:write("соціальна робота" .. "; " .. "25" .. "; " .. "15" .. "; " .. m_soc_work .. "; 0" .. "\n")
		file2:write("соціологія" .. "; " .. "50" .. "; " .. "20" .. "; " .. m_sociology .. "; 0" .. "\n")
		file2:write("фізика" .. "; " .. "15" .. "; " .. "9" .. "; " .. m_physics .. "; 0" .. "\n")
		file2:write("філологія" .. "; " .. "40" .. "; " .. "25" .. "; " .. m_philology .. "; 0" .. "\n")
		file2:write("філософія" .. "; " .. "35" .. "; " .. "15" .. "; " .. m_philosophy .. "; 0" .. "\n")
		file2:write("фінанси і кредит" .. "; " .. "50" .. "; " .. "25" .. "; " .. m_fincred .. "; 0" .. "\n")
		file2:write("хімія" .. "; " .. "15" .. "; " .. "10" .. "; " .. m_chemistry .. "; 0" .. "\n")

		file2:write("Кількість поданних заяв на Спеціаліста " .. "; ".. "; ".. "; ".. spec .. "; 0" .. "\n")
		--file2:write("Інформаційні управляючі системи та технології " .. "; " .. "30" .. "; " .. "10" .. "; " .. s_infosys .. "; 0" .. "\n")
		file2:write("Правознавство ".. "; " .. "75" .. "; " .. "45" .. "; " .. s_pravo .. "; 0" .. "\n")

		file2:write("Загальна сумма ; " .. "; "  .. "; " .. bac + spec + mag .. "; " .. ezbac .. "\n")
		file2:write("Загальна сумма з скасованими ; " .. "; " .. vsego_zayav_e + vsego_zayav_b .. "; " .. vsego_zayav_b .. "; " .. vsego_zayav_e .. "\n")

		file2:write(" " .. "\n")
		file2:close()
		--print ("Скасованих " .. "; " .. skas_cnt)
        --print ("Всього " ..  bac + spec + mag)

	else
		print "OLOLO"
	end
end

craft("RequestcGVAll1.csv")

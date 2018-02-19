--[[ EDBOSearchOlimp v. 0.1
1. ��������� �� ����� ����������� �����, ������������� ��� � in.txt
(������ - ��������� ���� � �����������)
2. ��������� ����������� �� SciTE, ������ �������� �� out.txt


TODO:
	-

--]]




--����� ��� ���������� ������ � ������ (�����������������)
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

--����� ���������
function craft(file)
	local file = io.open(file)
	local file2 = io.open("out.csv", "w")
	local bac = 0
	local mag = 0
	local spec = 0
	local ezbac = 0
	if file then
		--������������ ���������
		for line in file:lines() do
			--		���		ϲ�		��	������		��������	����.������		����	�����	���		�		�		���		��� �������		������		��� �������.	������������	������������	������. �������	������	���, 	����������		��� ���.	���� ���.	� ���.		��� ���.	���� ���.	³������	���			�������		ϳ����	������.		�����	����	β		��������	�����	��.			�����		��			�������	��������	��		����.	���� ������		��������
			local	npp,	pib,	ez,	status,		stdat,		ossprava, 		kurs,	forma,	okr,	b_f, 	k_f,	bal, 	napr_code, 		napr_name,	spec_code, 		spec_name, 		specialize, 	struct_pidrozd,		changed_data, 	bal_det, 		doc_type, 	doc_serie,	doc_num, 	doc_bal, 	doc_date, 	vidznaka, 	vst_type, 	descript,	pilga, 	persho, 	kvota,  lang,	inoz,	kat_inoz,	sex,	national,	country,	type_city,	tel,	mob,		od, 	gurt,	kod_vsupu,		priority	= unpack(split(line, ";"));
			if status == "��������" then
				if okr == "�������� (3 �. 10 �.)" then
					--if ez == 0 then
						if string.find (bal_det, "+O:0+") == nil then
							--file2:write(npp .. "; " .. pib .. "; " .. ez .. "; " .. status .. "; " .. stdat .. "; " .. ossprava .. "; " .. kurs .. "; " .. forma .. "; " .. okr .. "; " .. b_f .. "; " .. k_f .. "; " .. bal .. "; " .. napr_code .. "; " .. napr_name .. "; " .. spec_code .. "; " .. spec_name .. "; " .. specialize .. "; " .. struct_pidrozd .. "; " .. changed_data .. "; " .. bal_det .. "; " .. doc_type .. "; " .. doc_serie .. "; " .. doc_num .. "; " .. doc_bal .. "; " .. doc_date .. "; " .. vidznaka .. "; " .. vst_type .. "; " .. descript .. "; " .. pilga .. "; " .. persho .. "; " .. kvota .. "; " .. lang .. "; " .. inoz .. "; " .. kat_inoz .. "; " .. sex .. "; " .. national .. "; " .. country .. "; " .. type_city .. "; " .. tel .. "; " .. mob .. "; " .. od .. "; " .. gurt .. "; " .. kod_vsupu .. "; " .. priority .. "\n");
							file2:write(pib .. "; " .. ossprava .. "; "  .. okr .. "; " .. bal .. "; " .. napr_code .. "; " .. napr_name .. "; " .. bal_det .. "\n");
						end
					--end
				end
			end
		end
	end
end

craft("RequestcGVAll1.csv")

script_version("1.0")
require "lib.moonloader"
require "lib.sampfuncs"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8 
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local key = require 'vkeys'
local sampev = require 'lib.samp.events'
local memory = require("memory")
local mem = require "memory"

script_name("������� ������������ ������ ������������")
script_author("Fernando Cavalli ��������� ��������� �������� ���������� KGT")
script_description('Press Ctrl + R to reload all lua scripts. Also can be used to load new added scripts')
if script_properties then
	script_properties('work-in-pause', 'forced-reloading-only')
end
require "lib.moonloader"

commands = {"f", "r", "t", "n", "w", "s"}
bi = false

--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- ������ � ��� ��������� ������ ��������� �������. �� ����������� �� ��������� ��������� � ������, �� ����������� ������ ������ ����. ���� ����� ������ ������� �����, �� �� ������ ������. (Fernando Cavalli)
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
local one_win = imgui.ImBool(false)

function apply_custom_style()
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowRounding = 2.0
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.ChildWindowRounding = 2.0
		style.FrameRounding = 2.0
		style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
		style.ScrollbarSize = 13.0
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8.0
		style.GrabRounding = 1.0
		colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)

	end

	apply_custom_style()

local main_window_state = imgui.ImBool(false)
local car_window = imgui.ImBool(false)
local test_window = imgui.ImBool(false)
local test2_window = imgui.ImBool(false)
local test3_window = imgui.ImBool(false)
local test4_window = imgui.ImBool(false)
local test5_window = imgui.ImBool(false)
local test6_window = imgui.ImBool(false)
local su_window = imgui.ImBool(false)
local su1_window = imgui.ImBool(false)
local su2_window = imgui.ImBool(false)
local su3_window = imgui.ImBool(false)
local su4_window = imgui.ImBool(false)
local su5_window = imgui.ImBool(false)
local su6_window = imgui.ImBool(false)
local su7_window = imgui.ImBool(false)
local su8_window = imgui.ImBool(false)
local su9_window = imgui.ImBool(false)
local su10_window = imgui.ImBool(false)
local su11_window = imgui.ImBool(false)
local function_window = imgui.ImBool(false)
local test_text_buffer = imgui.ImBuffer(256)

function imgui.OnDrawFrame()
if one_win.v then
local sw, sh = getScreenResolution()
imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 245), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER', one_win, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
if imgui.Button(u8[[

                                                                             ��������� ������                                                                              

]]) then
function_window.v = not function_window.v
end
if function_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ��������� ������ �� 06.03.21', function_window)




imgui.Text(u8[[
											��������� ������ ����� ���������
����� 1. ���������� ����� ��������
1.1 �� ���������� ����� ������� ������� ������� ������������ ����, ���� ���������� ������������������ ������� (����� ��)
��� ���������� ��������������, ��������� ���� ����� ���� ������ ��� ������������ � �������� ���� ���������, ����������� ������������� 3 ������� �������
1.2 �� ���������� ����������� ����� ������������ ����, ���� ���������� �� ������������ ���������, ����������� ������������� 4 ������� �������

����� 2. ����������� ���������
2.1 �� ����������� ��������� � ����������� �������������� ������ �� ����������� ����, ���� ���������� ��, ����������� ������������� 6 ������� �������
2.2 �� ����������� ��������� � ����������� ��������� ������, ���� ������������ � �������� ���� ��������� 
(�������, ������, ������, ����, ��� � �.�.) �� ����������� ����, ���� ���������� ��, ����������� ������������� 5 ������� �������

����� 3. ���� ������������� ��������
3.1 �� ������� ����� ���������� ���� ������� ������������� ��������, ��������������� ������������� 2 ������� �������
3.2 �� ���� ���������� ���� ������� ������������� ��������, ��������������� ������������� 3 ������� �������
]])
imgui.Text(u8[[

����� 4. ���������� �������� � �����������
4.1 �� ������������� ����� � ������ ������� �������������� ��������������� ������� ������ (���, ��) � ����� �������� � �����������,
������ � ��������� ������ ������, ��������������� ������������� 2 ������� �������

����� 5. ������
5.1 �� ������� ��� ���� ������ ������������ ����, ��������������� ������������� 4 ������� �������
5.2 �� ��������� ������ ����������� �����, ��������������� ������������� 5 ������� �������
5.3 �� �������������� ������ ����������� �����, ��������������� ������������� 6 ������� �������

����� 6. �������� ����������
6.1 �� �������� ���������� �������������� �������� � ����� ��������� ��������� ���������� (��������� �������������),
��������������� ������������� 4 ������� �������
6.2 �� �������� ����������� �������, �������, ��������������� ������������� 3 ������� �������
]])
imgui.Text(u8[[

����� 7. ������
7.1 �������� ������� ��������������, ���������������, ��������������� ������ ��� ���� �����������,
 ������������ ����������� 2 ������� �������.
����������: ���������� ��� ��� ����������, � ����� ���������� ��, ����������� �� ������� �������.
����������: ���� ������� �� ������� ���������� ����� ������ - ������������ ������ �����������
7.2 ���������� �������������� ������ � ���������� ������ �����, ��������������� ������������� 4 ������� �������
7.3 �� ���������� �������� ������������� ������� (��� ��������), ��������������� ������������� 4 ������� �������
7.4 �� �������/�������/��������/����� ���������� �������� ������ �/��� �������� � ����, �� �������� �������,
 � ����� �� �������� ������� �� �������� ��������� ������� �/��� ���������� ������� ������, ��������������� ������������� 5 ������� �������
7.5 �� ������������ ������ �/��� ��������, �� ���� �� �� ����������� ��������, ��������������� ������������� 5 ������� �������
7.6 �� ���������� �������� ������ ��������� ���������, ��������������� ������������� 6 ������� �������
� ����� ������������� �������� ������� � ������� 500.000$
]])
imgui.Text(u8[[

����� 8. ��������� �����, ��������� � ����������
8.1 �� ���������, ������ � ��������� ������������ ���� ��������������� ������������� 6-� ������� �������,
 � ����� ������������� �������� ������� � ������� 50.000$ �� ������� ����������, ��� ����� ���� ��������
8.2 �� ���������, ������ � ��������� ����, ����������� ��������������� ������� (�������, ���������, 
����������� ��� ������� �������) ��������������� ������������� 6 ������� �������, � ����� ������������� �������� ������� � ������� 150.000$

����� 9. ������������
9.1 �� ������������ ���������� ��, ��������� �������� ������ � ������������ ��� ����������, ��������������� ������������� 3 ������� �������
9.2 �� ������������ ���������� ��, ��������� �������� ������ ��� ���������� �� � ���������, � ��� �� ��� ���������� ����. ��������,
��������������� ������������� 4 ������� �������
9.3 �� ����� �� ������� ������ ��� ��� ��� ��������������� �������, �������� �������� ������� ������������� �����, 
����������� ������������� 1 ������� �������
]])
imgui.Text(u8[[

����� 10. �������������
10.1 �� ����� �������� ���������� �� ����������, ��������������� ������������� 1 ������� �������
10.2 �� ���������� ������������� �� ���������� �������� ������� ���� ���� �������� �������(��������� � �.�.),
��������������� ������������� 4 ������� �������.
10.3 ������������� � ����������� ����� �������� ���������� ������� ������������� ������� ����������,
 ��������������� ������������� 2 ������� �������
10.4 ������������� � ������ ���. ���������� � ����� �/��� � �����������, ������������ 3 �������� �������
 ����� ������������� �������� �������. (������ �� ��������� �� ����������� ��� ��� ����������)
10.5 �� ���������� (�������������������) ������������� �� �������� ��� ����� ���������� ������������ ����,
 ��������������� ������������� 3 ������� �������
]])
imgui.Text(u8[[
����� 11. ������������� ��������
11.1 �� ���������� �������� ������������� �������, ��������������� ������������� 3 ������� �������
11.2 �� ���������� ������, �������, ������� ������������� �������, ��������������� ������������� 5 ������� �������
11.3 �� ������������ ����� �������������, ������������ ����������, ��������������� ������������� 6 ������� �������
]])
imgui.Text(u8[[

����� 12. ���������
12.1 �� ������������/���������� �������, ��������������� ������������� 6 ������� �������
12.2 �� ������ � ���������� �������, ��������������� ������������� 6 ������� �������

����� 13. �����������
13.1 ������ ����� ����������� ��, ��������������� ������������� 2 ������� �������
13.2 �� ����������� � ����������� ���� � ������� ���������� ������� � ��������� � ���������,
 ��������������� ������������� 3 ������� �������
13.3 �� ����������� � ���������, ������������ ����� ���������� � ������ ���������� � ��������,
 ������ �������, ��������������� ������������� 2 ������� �������

����� 14. �������
14.1 �� ���� ������������� ��������, ������� ��� ��������, ��������������� ������������� 2 ������� �������
14.2 �� ����������� �������������������� �������, ��������������� ������������� 5 ������� �������
14.3 �� ������� � ������������������� �������, ��������������� ������������� 2 ������� �������
]])
imgui.Text(u8[[

����� 15. ���������
15.1 �� ��������� � ������������ ����� ����� ���������� �������, ���������� ������������� ������� ������� �� ������, 
� ������� �� �����������
15.2 �� ��������� � ������, ��������� �� �������� ���, �������� ��������������� ����������� ��, ���������������
 ������������� 3 ������� �������
15.3 �� ��������� � ������, ��������� �� �������� ���, �������� ��������������� ����������� �� � �������� �� ��� ����. ��������,
 ��������������� ������������� 6 ������� �������

����� 16. ���������� �����������
16.1 �� �������� ���������� �����������, � ����� ���������� ������������ ��� ����� ������������, ��������������� 
������������� 6 ������� �������
16.2 �� ������� � ���������� �����������, ���������� ���������� ������ � ���������, ��������������� �������������
 5 ������� �������
16.3 �� ���������� ���������� ����������� � ���������� �������� ���������� ������, ��������������� �������������
 4 ������� �������

����� 17. ����������/�������� ��������
17.1 �� ����� ��� �� ������ ������ ����������� ����� ��� ������������ ��������, ��������������� ������������� 2 ������� �������
17.2 �� ����� ��� ��������� ������ ������������� �������� �� ���������� �����, ��������������� ������������� 2 ������� �������

����� 18. �����������
18.1 �� ��������� ����������� ������������� ������ ��� ���������� �� ����� ����������� ������������
(������������ � ������, ������������ � �����, �� ��� �� TV � �.�.), ��������������� ������������� 1 ������� �������
18.2 �� ������������� ������ ����������� ������������� ������ ��� ���������� �� ����� ����������� ������������, 
��������������� ������������� 2 ������� �������
]])
imgui.Text(u8[[

����� 19. ������� � ������� ���. ����������
19.1 �� ������� �/��� ������� ���. ����������, ��������������� ������������� 2 ������� �������

����� 20. ��������������
20.1 �� �������������� ������������ ���������, ��������������� ������������� 2 ������� �������

����� 21. �������������
21.1 �� ���������� �������������, �������������� �������� ������������ ���������,
��������������� ������������� 4 ������� �������

����� 22. �����. �����.
22.1 �� ���������� �������������� ������ ������� ������� �������, ��������������� ������������� 4 ������� �������
22.2 �� ������������� �������, ���������� � ����������� ��������������, ��������� ������, ��������������� ������������� 5 ������� �������

]])
imgui.Text(u8[[
����� 23. ���������� �������������������
23.1 �� ��������� ������������� ���������� ������������������� ������������, ��������������� ������������� 5 ������� �������

]])
imgui.End()
end -- ���� ������ ������

if imgui.Button(u8[[

                                                                        ���������������� ������                                                                     
                                               
]]) then
car_window.v = not car_window.v
end
if car_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ���������������� ������ �� 06.03.21', car_window)
imgui.Text(u8[[

										���������������� ������ ����� ���������


������ I
����� 1. ��������� ����� ��������
1.1 �� ��������� ����� �������� ������ ������� ������� (( �� 25% �� )) �� ��������������� ���������� ����� � ������� 25.000$

����� 2. ������������ ��������������
2.1 �� ������� � ������������ ����� �� ��������������� ���������� ����� � ������� 2.000$
2.2 �� ������������ �������� �������� � ������������ ����� �� ��������������� ���������� ����� � ������� 2.000$

����� 3. �����
3.1 �� ���������� �������������� ����� ������ ������� ������� (�����) �� ��������������� ���������� ����� � ����������� ������� ��������� ���������
3.2 �� ���������� �������������� ����� ������� ������� ������� (�����) �� ��������������� ���������� ����� � ������������� ������� ��������� ���������

]])
imgui.Text(u8[[
����� 4. ���������� �������������������
4.1 �� ���������� ������������������� ������������ ��� ������� ��������������� �����������(��������) �� ��������������� ���������� 
����� � ������� 250.000$ � �������� �����������, �����������, ����������.

����� 5. ���������� ������
5.1 �� ���������� ��������������� ������ ������� ���� ��������������� ������������� �� ��������������� ���������� ����� � ������� 5.000$
5.2 �� ���������� ������ ������� ������� ������� ���� ��������������� ������������� �� ��������������� ���������� ����� � ������� 10.000$

����� 6. �����������
6.1 �� ����������� ���������� �� ��������������� ���������� ����� � ������� 2.000$
6.2 �� ����������� ���������� �� �� ��������������� ���������� ����� � ������� 4.000$

����� 7. �������
7.1 �� ��������������� �������� ������ ���������� ��������� �����, �����������, ������� ��������� (�������) 
�� ��������������� ���������� ����� � ������� 50.000$
]])
imgui.Text(u8[[

������ II ���������������� ��������� � ������� ��������� ��������

1. �������� �� ���������� ��� ��������������� ������� �� ��������������� ���������� ����� � ������� 2.000$
2. �� ���������� � �������� �������� � ���������� �� ���������� �� ��������������� ���������� ����� � ������� 3.000$
3. �� ���������� ����������� ����������� (������ ��� �� ��������� � ���� �������������� �������������,
 ����������� ������� �� ������������ ��������) �� ��������������� ���������� ����� � ������� 2.500$
4. �� ���������� ����������� ��������� � ��������� ������������ ��������� �� ��������������� ���������� �����
 � ������� 5.000$ � ����� ������� ���� �� ���������� �����������.
5. �� ������� ��������, ������������ ��������� ���� ��� �� ������ �� ��������������� ���������� ����� � ������� 2.500$
6. �� ������������ ���������� ������ ��������� �������� �� ��������������� ���������� ����� � ������� 2.000$
7. �� �������� ���������� �� ��������� ������ ��������, �� ����������� ���������������� ���������� � 
������������� �������� �� ��������������� ���������� ����� � ������� 2.000$
7.1 �� ��������� ��������� ������ 7 II ������� �� �� ��������������� ���������� ����� � ������� 4.000$ � 
������� ������������� �������������
8. �� ��������, �������� �� �������, ��������� �� ��������������� ���������� ����� � ������� 1.500$
9. �� �������� ���������� �� ��������������� ����� �� ��������������� ���������� ����� � ������� 2.000$
10. �� ���� ��� ���������� ������� �������� �������� � ������ ����� ����� (c 21:00 �� 6:00) �� ��������������� 
���������� ����� � ������� 1.000$

]])

imgui.End()
end -- ����� ���� ������ ������

if imgui.Button(u8[[

                                                                               ������ ������                                                                                 
                                               
]]) then
test_window.v = not test_window.v
end
if test_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ����� ������ ������', test_window)
imgui.Text(u8[[

������ ������ KGT Helper

| /geg - �������� �������� � ���, ��� �� ���������
| /fn [�����] - ��� ��������� � ����� ���
| /rn [�����] - ��� ��������� � ����� ���
| /nar - ������ ���������
| /pt - ������ �������
| /ud [��������]-[�����������]-[�����(�� �������)]-[���������] - ����� ������������� (���������� �������� ��� ���� ������ ��������������)
| /incar [id] - �������� �������� �� ����������
| /inmoto [id] - ������� �������� � ���������
| /mon  - ������������ ���� ��� ������
| /moff  - �������������� ���� ������
| /ton - ��������� ����������
| /ot - �������� ������� � ������������
| /cs  (/changeskin) - �������� ���� �����
| /css [id] (/changeskin) - �������� �������� �����
| /fo (/follow) - ������ ������������ ����� �����������
| /foff (/follow) - ��������� ������������ �����
| /ja (/jaildoor) - ������� ������ � ������
| /cam - �������� �� ������ /cams - (/cam) ������ ��� ����� S.W.A.T.
| /������ - ��������� ���������
| /pol - ��������� ����������� ���������
| /palec - �������� ����������������� ���������
| /otvet - ����� ��������� � ���������
| /alp - ����������� ������������� ����������
| /alpt (������) - ���������� �� ������
| /alpf (��������) - ���������� ��������� �������
| /alps - ������ ������������� ����������
| /bomba - ������������� �����
| /hh [����������� �����] - ��������� ����� � ����������� ����������� ��������
| /pp - ������� �������� ����� � ��
| /so [���������] - ������������ ����������� ��� � ������ ���������
| /sos  - ��������� ������ �� ������ ���������
| /�������� - ��������� ��� ������ � ������� 5 ������
| /mayak - ���������� ����� ��� ����. �������� ���� � ������� 150 ������
| /prov - ��������� ����������� � ����������� ��������
| /mo - ��������� ������ �� ���������� ������� ������������ �������
| /krik - ��������\n| /meg - ���������� ���������� ����������� 
]])
imgui.Text(u8[[
| /megsp - ���������� ���������� ���������� �� ��������������� ������
| /givedrugs [id] - ���������� �������� ���������
| /unc  - ����� � ���� ��������� ��������
| /rhelp  - ������� ������������ �� ����� ���
| /fhelp  - ������� ������������ �� ����� ���
| /soz - ������� ��� � �����
| /case - ��������� ����� � ���� � ���������� ��������
| /caseact - ������������ ����� � ����� � ��������
| /report - ������� �������� ������ �������
| /dor - �������� ������ � /m
| /pr - ���������� ������������� � /m
| /pk - �������� ���������� � /m
| /vi - ����� �� ��������� ����������
| /za - ����� � �������� ����������
| /op - �������������� ����� ����������
| /cl - ������������� ����� ����������
| /cc - �������� ���
| /radar - ����� �������������� ��������� ������������
| /test - ���������� �� �����������, ������� ����� ��������
| /hist id - history

������� �������������� � ������ ����:
| /�� - ��������� ������
| /�� - ���������������� ������
| /cmd - ������ ������
| /info - �������� ����������

| /hexit - ��������� KGT Helper.

����������! ��������� �������� �� ���� ����������� ��������, ����� /changeskin
�������������! ������ ����������� ��������� ����� ���������� ��� �� ��������� ��� ����� ���������� ������
� ����� ������� �sp� (������: /susp [id][��.�������][�������]
]])
imgui.Text(u8[[

������� � �� ���������� (��� �����������, ������������ �������������� ��, ���������� � ������ �������.

F2 - ��������
F3 - �������
���+F4 - �������� ������ �� ���������� ���������
F9 - /find
F10 - /pg [id] - ������ ��� ������
F11 - /rhelp+/fhelp
F12 - ������� ��� ���������������� ����������
ALT+1 - /su
ALT+2 - /cuff
ALT+3 - /putpl
ALT+4 - /arrest
ALT+5 - /search
ALT+6 - /ticket
ALT+7 - /takelic
ALT+8 - /setmark
ALT+9 - /wanted
ALT+0 - /lock 1
CTRL+1 - /clear
CTRL+2 - /uncuff
CTRL+3 - /eject
CTRL+4 - /hold
CTRL+5 - /mo
CTRL+6 - /hack
CTRL+7 - /fbi
CTRL+8 - /jaildoor
CTRL+9 - /open
CTRL+0 - /ud
ALT+M - /mon
CTRL+M - /moff
ALT+H - �������� ������
CTRL+H - ���������� �������������
ALT+P - ��������� ������ � ����������
CTRL+P ��������� ����� �� ����������
	
]])

imgui.End()
end

if imgui.Button(u8[[

                                                                                  ����������                                                                                 
                                               
]]) then
test2_window.v = not test2_window.v
end
if test2_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ����������', test2_window)
imgui.Text(u8[[

������ ���� ������� ��� ��������� ����������� ����������, ������� ����� �������������� ������������ KGT.
	
]])

if imgui.Button(u8[[

                                                                               ������������ ��������                                                                                 
                                               
]]) then
test3_window.v = not test3_window.v
end
if test3_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ������������ ��������', test3_window)
imgui.Text(u8[[
��������� �������� � �������� ������������� ���� �������������

�����������(1� 10 ���):
			������������
			����������� ����������
�������(45 ���):
			����������� � ������� ����������
			���������� ��������
�����(1� 15 ���):
			�������� ����������� ������������ ������������
			������������
�������(45 ���):
			���������� ��������
			����������� � ������� ����������
�������(1� 30 ���):
			������������
			������������
�������(55 ���):
			������������
			����������� � ������� ����������
�����������(1 ���):
			����������� � ������� ����������
			����.����������

��������� �� �����������: 5070$
��������� �� �������: 5045$
��������� �� �����: 5075$
��������� �� �������: 5045$
��������� �� �������: 5090$
��������� �� �������: 5055$
��������� �� �����������: 5060$

������� �� ������ ��������: 35 440$
]])

imgui.End() -- ������ ������ info
end
if imgui.Button(u8[[

                                                                               ������ �������                                                                                   
                                               
]]) then
test4_window.v = not test4_window.v
end
if test4_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ������ �������', test4_window)
imgui.Text(u8[[
� ������ ���� ����� ������� ���������� ������, ������� ���������� ���������

]])

if imgui.Button(u8[[

                                                                  ����������������� ������������                                                                          
                                               
]]) then
test5_window.v = not test5_window.v
end
if test5_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1030, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ����������������� ������������', test5_window)
imgui.Text(u8[[

                                                                                                 ��� ������������ ���� �������������

                                                                     ����������� ��������� ������ ������ � ������������� ������������� �� ���� Ũ �����������:

1. �������� �������� ������������, ������� ���������, ����������
������������ ���������� �����������, �������������� �� ������, �����, � ������
��� �������� - ���������, ��������� ��� �������� ������� (��������������
�������� ��������� ���� � ������), �������� ��� � ��������� ��������
����������.

2. �������� �������� ������������ ���������������, ������� ���������,
���������� ������������ ���������� ����������� ��������� ��������, � ������
��� ��������, ���������, ���������, ��������� ������ ��������� ����, ���������
��� �������� �������, �������� � ��������� �������� ����������.

3. �������� �������� ����������������� ������, � ������� ���������� ������
���� ���������.

4. ����������� ����������������� ������ �� ���� Ũ ����������� �����
������������ ���������.

5. ��������� �� ��������, ����������� �������������� �� ��������������� ��
������������� ������������.

6. ����� ��������� ���: 2 ������� ��������� ���� � ������, 3 ��������� ����
������� ������� � ���������������� ���������� �� ���������������.
																			
																			
�� ���������� ������� � ����������������� ��������� 300.000$, 20� � ��������� ������ �������

]])

imgui.End() -- ������ ������ ������ �������
end

if imgui.Button(u8[[

                                                                          ������������ �������                                                                                
                                               
]]) then
test6_window.v = not test6_window.v
end
if test6_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1030, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ������������ �������', test6_window)
imgui.Text(u8[[

                                                                                                 ��� ������������ �������

                                                                     ����������� ���������� ��������� ������� ��� ��������� � ���������� 
																	 �������� �������� ��������� � ������������ ������������ � ������������ 
																	 �������:

1. ������� ������� ���� ��Ĩ���� ������� �� �����: ���������� �����,
������-�������� �����, ������-����������� ���.

2. ����������� �� ���������� ��� ������������ �������������� �
������������ ������� ������������.

3. ������������ �������������� ��� �� ������, �� ������� ����������
���������. ��������� ����� �������������� ��� ����� ��������� ��
������ � ����������� ����� ������������ ������ ������������.

4. ��������� ������� � ������� �������� ������-����������� ��� Ҩ��
��������.
																			
																			
�� ���������� ������� 450.000$, 20? � ��������� ������ �������

]])

imgui.End() -- ������ ������ ������ �������
end



imgui.End() -- ������ ������ info
end





imgui.End()
end


if su_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ����� ������ �������', su_window)
imgui.Text(u8[[
�������� ��������� ���������:
]])
if imgui.Button(u8[[

                                                                        ������ �����                                                                     
                                               
]]) then
su2_window.v = not su2_window.v
end
if su2_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(500, 200), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: ����� ������ �������, ������', su2_window)
imgui.Text(u8[[
������� ID ����������
]])
if imgui.InputText(u8'id', test_text_buffer) then
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}/g test /su ' .. test_text_buffer.v .. ' 2 GPS-������', 0xffffff)
end
imgui.End()
end -- ����� ���� ������ ������





imgui.End() -- SUU
end


end
imgui.End()
end




function main()

 flymode = 0  
	speed = 0.5
	radarHud = 0
	time = 0
	keyPressed = 0

    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	
	autoupdate("https://raw.githubusercontent.com/TSIDEX/auto-update/main/KGT.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/TSIDEX/auto-update/main/KGT%20Helper.lua")
	
		sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}������ KGT Helper {CC0000}������������ ������ ������������{FFFFFF} ������� �������, ��������� �����������.', 0xffffff)
		sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}������������ �������: Trofim Shcherbakov � Alexander Russkov. �������������� ���������� - /kgt .', 0xffffff)
		sampRegisterChatCommand("cmd1", cmd1)
		sampRegisterChatCommand("update", udpate)
		sampRegisterChatCommand("geg", geg)
		sampRegisterChatCommand("su", su)
		sampRegisterChatCommand("suu", suu)
		sampRegisterChatCommand("hist", hist)
		sampRegisterChatCommand("op", op)
		sampRegisterChatCommand("cl", cl)
		sampRegisterChatCommand("pg", pg)
		sampRegisterChatCommand("��", ��)
		sampRegisterChatCommand("pn", pn)
		sampRegisterChatCommand("susp", susp)
		sampRegisterChatCommand("fn", fn)
		sampRegisterChatCommand("rn", rn)
		sampRegisterChatCommand("gh", gh)
		sampRegisterChatCommand("cuff", cuff)
		sampRegisterChatCommand("cuffsp", cuffsp)
		sampRegisterChatCommand("uncuff", uncuff)
		sampRegisterChatCommand("uncuffsp", uncuffsp)
		sampRegisterChatCommand("putpl", putpl)
		sampRegisterChatCommand("putplsp", putplsp)
		sampRegisterChatCommand("eject", eject)
		sampRegisterChatCommand("ejectsp", ejectsp)
		sampRegisterChatCommand("arrest", arrest)
		sampRegisterChatCommand("arrestsp", arrestsp)
		sampRegisterChatCommand("clear", clear)
		sampRegisterChatCommand("clearsp", clearsp)
		sampRegisterChatCommand("hold", hold)
		sampRegisterChatCommand("holdsp", holdsp)
		sampRegisterChatCommand("search", search)
		sampRegisterChatCommand("searchsp", searchsp)
		sampRegisterChatCommand("so", so)
		sampRegisterChatCommand("g", g)
		sampRegisterChatCommand("test", test)
		sampRegisterChatCommand("mayak", mayak)
		sampRegisterChatCommand("��������", ��������)
		sampRegisterChatCommand("sos", sos)
		sampRegisterChatCommand("mo", mo)
		sampRegisterChatCommand("hexit", hexit)
		sampRegisterChatCommand("mon", mon)
		sampRegisterChatCommand("moff", moff)
		sampRegisterChatCommand("ticket", ticket)
		sampRegisterChatCommand("ticketsp", ticketsp)
		sampRegisterChatCommand("takelic", takelic)
		sampRegisterChatCommand("takelicsp", takelicsp)
		sampRegisterChatCommand("setmark", setmark)
		sampRegisterChatCommand("setmarksp", setmarksp)
		sampRegisterChatCommand("ud", ud)
		sampRegisterChatCommand("tt", tt)
		sampRegisterChatCommand("rang", rang)
		sampRegisterChatCommand("rangsp", rangsp)
		sampRegisterChatCommand("invite", invite)
		sampRegisterChatCommand("invitesp", invitesp)
		sampRegisterChatCommand("fbi", fbi)
		sampRegisterChatCommand("fbisp", fbisp)
		sampRegisterChatCommand("open", open)
		sampRegisterChatCommand("opensp", opensp)
		sampRegisterChatCommand("biz", biz)
		sampRegisterChatCommand("ton", ton)
		sampRegisterChatCommand("nar", nar)
		sampRegisterChatCommand("pt", pt)
		sampRegisterChatCommand("ot", ot)
		sampRegisterChatCommand("cs", cs)
		sampRegisterChatCommand("css", css)
		sampRegisterChatCommand("mask", mask)
		sampRegisterChatCommand("mayakk", mayakk)
		sampRegisterChatCommand("healme", healme)
		sampRegisterChatCommand("healmesp", healmesp)
		sampRegisterChatCommand("masksp", masksp)
		sampRegisterChatCommand("r", r)
		sampRegisterChatCommand("��", ��)
		sampRegisterChatCommand("��", ��)
		sampRegisterChatCommand("cmd", cmd)
		sampRegisterChatCommand("info", info)
		sampRegisterChatCommand("t", t)
		sampRegisterChatCommand("rsp", rsp)
		sampRegisterChatCommand("f", f)
		sampRegisterChatCommand("report", report)
		sampRegisterChatCommand("fsp", fsp)
		sampRegisterChatCommand("strelba", strelba)
		sampRegisterChatCommand("hack", hack)
		sampRegisterChatCommand("hacksp", hacksp)
		sampRegisterChatCommand("fo", fo)
		sampRegisterChatCommand("ja", ja)
		sampRegisterChatCommand("givedrugs", givedrugs)
		sampRegisterChatCommand("foff", foff)
		sampRegisterChatCommand("bomba", bomba)
		sampRegisterChatCommand("incar", incar)
		sampRegisterChatCommand("inmoto", inmoto)
		sampRegisterChatCommand("hh", hh)
		sampRegisterChatCommand("pp", pp)
		sampRegisterChatCommand("cam", cam)
		sampRegisterChatCommand("cams", cams)
		sampRegisterChatCommand("alp", alp)
		sampRegisterChatCommand("tsc", tsc)
		sampRegisterChatCommand("alpt", alpt)
		sampRegisterChatCommand("alpf", alpf)
		sampRegisterChatCommand("alps", alps)
		sampRegisterChatCommand("skip", skip)
		sampRegisterChatCommand("skipsp", skipsp)
		sampRegisterChatCommand("allow", allow)
		sampRegisterChatCommand("allowsp", allowsp)
		sampRegisterChatCommand("pol", pol)
		sampRegisterChatCommand("zo", zo)
		sampRegisterChatCommand("palec", palec)
		sampRegisterChatCommand("otvet", otvet)
		sampRegisterChatCommand("������", ������)
		sampRegisterChatCommand("cmd2", cmd2)
		sampRegisterChatCommand("prov", prov)
		sampRegisterChatCommand("order", order)
		sampRegisterChatCommand("meg", meg)
		sampRegisterChatCommand("megsp", megsp)
		sampRegisterChatCommand("krik", krik)
		sampRegisterChatCommand("rhelp", rhelp)
		sampRegisterChatCommand("fhelp", fhelp)
		sampRegisterChatCommand("soz", soz)
		sampRegisterChatCommand("case", case)
		sampRegisterChatCommand("caseact", caseact)
		sampRegisterChatCommand("unc", unc)
		sampRegisterChatCommand("dor", dor)
		sampRegisterChatCommand("pr", pr)
		sampRegisterChatCommand("qsm", qsm)
		sampRegisterChatCommand("pk", pk)
		sampRegisterChatCommand("za", za)
		sampRegisterChatCommand("vi", vi)
		sampRegisterChatCommand("kgt", kgt)
		sampRegisterChatCommand("cc", cc)
		sampRegisterChatCommand("tsf", tsf)
		sampRegisterChatCommand("radar", radar)
		sampRegisterChatCommand("tpal", tpal)
		sampRegisterChatCommand("otp", otp)
		sampRegisterChatCommand("otps", otps)
		sampRegisterChatCommand("test", test)
		sampRegisterChatCommand("tnar", tnar)
		sampRegisterChatCommand("tsver", tsver)
		sampRegisterChatCommand("tsk", tsk)
		-- � ���������� --
		
		    sampRegisterChatCommand('gt', function(idCar)
        if idCar ~= '' then
            if idCar:find('%d+') then
                local id = idCar:match('(%d+)')
                local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)
				if result then
					my_pos = {getCharCoordinates(playerPed)}
					setCarCoordinates(vehicleHandle, my_pos[1] + 4, my_pos[2], my_pos[3])
				end
            else
                sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}������������ ID', 0xffffff)
            end
        else    
           sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}�� ������ ID', 0xffffff)
        end
    end)
		
 while true do
	wait(0)

    if isSampAvailable() then
			mem.setint8(0xB7CEE4, 1)
		end
    
if isKeyDown(key.VK_R) and isKeyJustPressed(key.VK_2) then -- ����� ����������� �� ID
local id = getClosestCar2Id()
local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)
if result then
my_pos = {getCharCoordinates(playerPed)}
setCarCoordinates(vehicleHandle, my_pos[1] + 4, my_pos[2], my_pos[3])
end		
end


if weapon == 34 and isKeyJustPressed(key.VK_RBUTTON) then -- ������� ���������� � ������ �� ����� ������������ �� ���������
sampSendChat("/reset")
end



if isKeyDown(17) and isKeyDown(82) then -- CTRL+R
		while isKeyDown(17) and isKeyDown(82) do wait(80) end
		reloadScripts()
	end
	imgui.Process = one_win.v
  end
 end





function cmd1()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}������ ������ {4c4f45}�KGT Helper�", "{ffffff}| /geg - �������� �������� � ���, ��� �� ���������\n| /fn [�����] - ��� ��������� � ����� ���\n| /rn [�����] - ��� ��������� � ����� ���\n| /nar - ������ ���������\n| /pt - ������ �������\n| /ud [��������]-[�����������]-[�����(�� �������)]-[���������] - ����� �������������\n(���������� �������� ��� ���� ������ ��������������)\n| /incar [id] - �������� �������� �� ����������\n| /inmoto [id] - ������� �������� � ���������\n| /mon  - ������������ ���� ��� ������\n| /moff  - �������������� ���� ������\n| /ton - ��������� ����������\n| /ot - �������� ������� � ������������\n| /cs  (/changeskin) - �������� ���� �����\n| /css [id] (/changeskin) - �������� �������� �����\n| /fo (/follow) - ������ ������������ ����� �����������\n| /foff (/follow) - ��������� ������������ �����\n| /ja (/jaildoor) - ������� ������ � ������\n| /cam - �������� �� ������ /cams - (/cam) ������ ��� ����� S.W.A.T.\n| /������ - ��������� ���������\n| /pol - ��������� ����������� ���������\n| /palec - �������� ����������������� ���������\n| /otvet - ����� ��������� � ���������\n| /alp - ����������� ������������� ����������\n| /alpt (������) - ���������� �� ������\n| /alpf (��������) - ���������� ��������� �������\n| /alps - ������ ������������� ����������\n| /bomba - ������������� �����\n{800000}����������! {FFFFFF}��������� �������� �� ���� ����������� ��������, ����� /changeskin\n{4c4f45}�������������! {FFFFFF}������ ����������� ��������� ����� ���������� ��� �� ���������\n ��� ����� ���������� ������ � ����� ������� �sp� (������: /susp [id][��.�������][�������]", "�������")
wait(200)
sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}C����� �������������� ������ - /cmd2. ������ ������������� ������ - /cmd3.', 0xffffff)
end)
end

function unc() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do ��������� �� ����� ��������. � ������ ������� ������ ����� �������.")
wait(800)
sampSendChat("/me ����� ������ � ������ ������ ������, ������� �������...")
wait(800)
sampSendChat("/me ...������� ���� ��������� �������� �������� ����������, ����� �������� �������...")
wait(800)
sampSendChat("/me ...� �������� �������� ����������, ��������� ������� ��������� ��� ������ ������� �������.")
wait(800)
sampSendChat("/uncuff " .. id .. "", main_color)
wait(800)
sampSendChat("/do ��������� ������, ����� ���� ��������� ������������� � ����� �� �����.")
end) 
end


function cmd2()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}������ ������ {4c4f45}�KGT Helper�", "{ffffff}| /hh [����������� �����] - ��������� ����� � ����������� ����������� ��������\n| /pp - ������� �������� ����� � ��\n| /so [���������] - ������������ ����������� ��� � ������ ���������\n| /sos  - ��������� ������ �� ������ ���������\n| /�������� - ��������� ��� ������ � ������� 5 ������\n| /mayak - ���������� ����� ��� ����. �������� ���� � ������� 150 ������\n| /strelba ( ���������� ����������� � �������� � ������ ������) - ����� ������ �� ���������\n��������, � �������� �� �������� � �������� � ������ �� ����� ���\n| /prov - ��������� ����������� � ����������� ��������\n| /mo - ��������� ������ �� ���������� ������� ������������ �������\n| /krik - ��������\n| /meg - ���������� ���������� �����������\n| /megsp - ���������� ���������� ���������� �� ��������������� ������\n| /givedrugs [id] - ���������� �������� ���������\n| /unc  - ����� � ���� ��������� ��������\n| /rhelp  - ������� ������������ �� ����� ���\n| /fhelp  - ������� ������������ �� ����� ���\n| /soz - ������� ��� � �����\n| /epk(1-3) - ������ �������������� ������\n| /case - ��������� ����� � ���� � ���������� ��������\n| /caseact - ������������ ����� � ����� � ��������\n| /report - ������� �������� ������ �������\n| /dor - �������� ������ � /m\n| /pr - ���������� ������������� � /m\n| /pk - �������� ���������� � /m\n| /vi - ����� �� ��������� ����������\n| /za - ����� � �������� ����������.\n| /op - �������������� ����� ����������\n| /cl - ������������� ����� ����������\n| /cc - �������� ���\n| /radar - ����� �������������� ��������� ������������\n| /test - ���������� �� �����������, ������� ����� ��������\n| /hist id - history       /hexit - ��������� KGT Helper.", "�������")
end)
end



function test()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}���������� � ���������� � ��� {4c4f45}�KGT Helper�", "{ffffff}| /otp - ������ ���������� ������� � ���� �������������� (�� ������ � ���������)\n| /tpal - ������ ���������� ������� � ������ ������������ (������ �� ������ � ����������� ����)\n| /tnar - ����������� �������������� �������� � ������������� ��������� (������ �� ������ � ����������� ����)\n�����: ����� ����������� ������������� ���������� ���������� ������ ������ � /do ��������������...\n...������: {f6768e}/do ����� ������ ��� ���������� ��� �����?\n{FFFFFF}��� ������� �������� �������� ��������� ������� �� ����� ���������.", "�������")
end)
end




function dor()
lua_thread.create(function ()
sampSendChat("/m ��������, ���������� �������� � �������...")
wait(800)
sampSendChat("/m ������ ������ ���������� ������������ �������.")
end)
end

function kgt()
one_win.v = not one_win.v
end

function ��()
one_win.v = not one_win.v
function_window.v = not function_window.v
end

function suu()
one_win.v = not one_win.v
su_window.v = not su_window.v
end



function ��()
one_win.v = not one_win.v
car_window.v = not car_window.v
end

function cmd()
one_win.v = not one_win.v
test_window.v = not test_window.v
end

function info()
one_win.v = not one_win.v
test2_window.v = not test2_window.v
end

function pr()
lua_thread.create(function ()
sampSendChat("/m �������� ����������, ���������� ���������� �������������!")
wait(800)
sampSendChat("/m ������������ ���� ������������� ��� ������ ������ ������������ �������.")
end)
end

function hexit()
lua_thread.create(function ()
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}������ KGT Helper ��������.', 0xffffff)
file:close ()
end)
end

function pk()
lua_thread.create(function ()
sampSendChat("/m �������� �������� � ��������������� ������...")
wait(500)
sampSendChat("/m ... ��������� � ������ ������ ���������� � ������� �� ���� ����...")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end







function pn()
lua_thread.create(function ()
sampSendChat("/m �� �������� �� ������ ������������� ��������...")
wait(500)
sampSendChat("/m ... ��������� ��������� � ��������� ����� �� ����...")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end



function rhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/r ������ ��������� ������������ �� ��� GPS-������. ��������, ��������� ������������.")
wait(100)
sampSendChat("/su " .. id .. " 2 GPS-������")
end)
end


function otp()
lua_thread.create(function ()
sampSendChat("/me ������ ������� �� ����������� ������� ������, �����...")
wait(1200)
sampSendChat("/me ...������� ���, ����� � ���� ������ ���, ������ ���������������...")
wait(1200)
sampSendChat("/me ...������� ����� ������������ ������� � ������� ������� ����� ���������.")
wait(1200)
sampSendChat("�������� ������ �� ����� �������� ���, ����� ������ �� �������� �� ������� ������...")
wait(1200)
sampSendChat("...��������� ��������� �������.")
wait(1000)
sampAddChatMessage('{CC0000}[KGT Helper] {FFFFFF}���������, ����� ������� �������� ������ � �������� ��������� /otps', 0xffffff)
end)
end

function sampev.onSendCommand(msg)
	if bi then bi = false; return end
	local cmd, msg = msg:match("/(%S*) (.*)")
	if msg == nil then return end
	-- cmd = cmd:lower()

	--�����, �����, ��� ���, �����, ���� (� ���������� �������� ���-������)
	for i, v in ipairs(commands) do if cmd == v then
		local length = msg:len()
		if msg:sub(1, 2) == "((" then
			msg = string.gsub(msg:sub(4), "%)%)", "")
			if length > 80 then divide(msg, "/" .. cmd .. " (( ", " ))"); return false end
		else
			if length > 80 then divide(msg, "/" .. cmd .. " ", ""); return false end
		end
	end end

	--�� �������
	if cmd == "me" or cmd == "do" then
		local length = msg:len()
		if length > 75 then divide(msg, "/" .. cmd .. " ", "", "ext"); return false end
	end

	--SMS
	if cmd == "sms" then
		local msg = "{}" .. msg
		local number, _msg = msg:match("{}(%d+) (.*)")
		local msg = msg:sub(3)
		if _msg == nil then -- ���� ����� �� ������, ������ ��������� ����������/������������ ���������
			for i = 1, 99 do         			-- ����� ������� �� ����
				local test = sampGetChatString(i):match("SMS: .* | .*: (.*)")
				if test ~= nil then number = string.match(test, ".* %[.*%.(%d+)%]") end
			end
		else msg = _msg end
		if number == nil then return end
		local length = msg:len()

		-- long SMS
		if length > 66 then divide(msg, "/sms " .. number .. " ", "", "sms"); return false end

		-- short SMS
		if length < 66 then bi = true; sampSendChat("/sms " .. number .. " " .. msg); return false end
	end
end

function sampev.onServerMessage(color, text)
	if color == -65281 and text:find(" %| ����������: ") then
		return {bit.tobit(0xFFCC00FF), text}
	end
end

function sampev.onSendChat(msg) -- IC ���
	if bi then bi = false; return end
	local length = msg:len()
	if length > 90 then
		divide(msg, "", "")
		return false
	end
end

function divide(msg, beginning, ending, doing) -- ���������� ��������� msg �� ���
	if doing == "sms" then limit = 57 else limit = 72 end
	

	local one, two = string.match(msg:sub(1, limit), "(.*) (.*)")
	if two == nil then two = "" end
	local one, two = one .. "...", "..." .. two .. msg:sub(limit + 1, msg:len())

	bi = true; sampSendChat(beginning .. one .. ending)
	if doing == "ext" then
		beginning = "/do "
		if two:sub(-1) ~= "." then two = two .. "." end
	end
	bi = true; sampSendChat(beginning .. two .. ending)
end


function otps()
lua_thread.create(function ()
sampSendChat("/do �� �������� ������ �������� ������, �������������� �������� ������.")
wait(1200)
sampSendChat("/me ���� ������� �� ��� ���� ��������, ����� �������� ��������� � ���� � ����� �� ��...")
wait(1200)
sampSendChat("/me ...�������� ������� � ����� ��� ������� �� ���������� ������ ������.")
end)
end

function tpal()
lua_thread.create(function ()
sampSendChat("/me �������� ���� � ����� ������ ������, ������� � �� ������� ��������� ��������")
wait(1200)
sampSendChat("/me ������� �������� �� ����� ����� ��� � ������� ������� � �����")
wait(1200)
sampSendChat("/do �� ����� ��������� ���������� �� ����� ���������������� ������...")
wait(1200)
sampSendChat("/do ...����� �� ����� ��������� ���-������� � ������� ��������")
wait(1200)
sampSendChat("/me ������ ����������, ������ �� ���� �������� � ������������������ ��������")
wait(1200)
sampSendChat("/me ���� ������ � ������� � ��������, ���� ���-������� �� �����, ������ ��� � ������ ������")
wait(1200)
sampSendChat("/me ���� �������� � ���� � �������� �������� �� ������� �� ������")
wait(1200)
sampSendChat("/me ������� �������� � �������, ������ �� ����������� ������������������ �����...")
wait(1200)
sampSendChat("/me ...� �������� ��� �� ����� ��������� �������")
wait(1200)
sampSendChat("/do ��������� ������� ��������������� �� ������.")
wait(1200)
sampSendChat("/me ��������� ����� � ������������ ����������� �� �����...")
wait(1200)
sampSendChat("/me ...����� � � ������� � ������ ���������, ������ �� �������� ����� � ������������...")
wait(1200)
sampSendChat("/me ...����������� ������� � ����� � � ������������������� �������")
wait(1200)
sampSendChat("/do ��������� ������� ������������� � ��������� � ���� ������.")
end)
end


function gh()
lua_thread.create(function ()
sampSendChat("/sms 9050 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 297297 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 565758 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 666465 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 7550 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 2148818 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 8894 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 1822737 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 9075 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 777667 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 313313 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 520707 [KGT] ����������� ���� ������ ������...")
wait(1200)
sampSendChat("/sms 123777 [KGT] ����������� ���� ������ ������...")
end)
end


function tnar()
lua_thread.create(function ()
sampSendChat("/me �������� ���� � ����� ������ ������, ������� � �� ������� ��������� ��������")
wait(1200)
sampSendChat("/me ������� �������� �� ����� ����� ��� � ������� ������� � �����")
wait(1200)
sampSendChat("/me ���� �� ����� ���-������� � ��������� ������������ �������������...")
wait(1200)
sampSendChat("/me ...� ������� ��� �� ����������� ����.")
wait(1200)
sampSendChat("/do �� ������ ����� ������������ ����� ������������� ��������.")
wait(1200)
sampSendChat("/me ������ ������� � �����, ������ ������ �������������� ����������� � ���������...")
wait(1200)
sampSendChat("/me ...������ ���������� ��������, ��������� ������ �����������, ����� ������ ������ ������.")
wait(1200)
sampSendChat("/do ������� ������� �������� �������...")
wait(1200)
sampSendChat("/do ������ �������� ��������, ���������� ���������� �� ���������.")
wait(1200)
sampSendChat("/me ������ �� ���������� ����� �����������, ������ ��� � ������ ��� ����������")
wait(1200)
sampSendChat("/do �� �������� �������� ���������� ����������� ���������� ����������...")
end)
end

function case()
lua_thread.create(function ()
sampSendChat("/do � ������ ������������� �������� ����� ��� �����.")
wait(1000)
sampSendChat("/me ���� ���� � ���������� ��������, ����� ���� ������ ���, �����...")
wait(1000)
sampSendChat("/me ...������� ����� �� ������ � ������� ��� ����� �����.")
wait(1000)
sampSendChat("/do ����� �������������� ���������� ������������ �������� �� ������ ������.")
wait(1000)
sampSendChat("/me ���������� � ������������ �����, ������ ���� � ������� ��� ����� �� ������.")
wait(1000)
sampSendChat("/do ����� ����� � ������ ������� ������.")
end)
end

function caseact()
lua_thread.create(function ()
sampSendChat("/do ����� ����� � ������ ������� ������.")
wait(500)
sampSendChat("/me ����� ���� � ������ ������ ������, ����� �� ������ ��������� �����.")
wait(500)
sampSendChat("/try �������� � ���, ��� ����� � ����� �����������")
end)
end



function radar()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}����������� �����, ����������� ��������������, ���� � ����� ������� ���� �������������.', 0xffffff)
for k,v in ipairs(getAllChars()) do
    local result, id = sampGetPlayerIdByCharHandle(v)
    if result then
        

wait(2000)
sampSendChat("/setmark " .. id .. "", main_color)


end
end
end)
end

function fhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/f ������ ��������� ������������ �� ��� GPS-������. ��������, ��������� ������������.")
wait(100)
sampSendChat("/su " .. id .. " 2 GPS-������")
end)
end

function soz()
lua_thread.create(function ()
sampSendChat("/f ������� ������ �� � SWAT ����� � ����� ���!")
wait(100)
sampSendChat("/f ������� ������ �� � SWAT ����� � ����� ���!")
end)
end


function meg()
lua_thread.create(function ()
sampSendChat("/m �������� ������������� ��������, ���������� ������������...")
wait(800)
sampSendChat("/m ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(800)
sampSendChat("/m � ������ ������������ ����� ����������� ������� ���� �� ���������.")
end)
end

function krik()
lua_thread.create(function ()
sampSendChat("���� ���������� �� ����� ������, ��� ������ ��������!")
wait(800)
sampSendChat("���� �� ������, ����� �� �����. �� ���������, ����� � ������ ����� �� ���������.")
end)
end

function megsp()
lua_thread.create(function ()
sampSendChat("/s �������� ������������� ��������, ���������� ������������...")
wait(1000)
sampSendChat("/s ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(2000)
sampSendChat("/s � ������ ������������ ����� ����������� ������� ���� �� ���������.")
end)
end

function prov()
lua_thread.create(function ()
sampSendChat("������� ��������� ������������ ���� �������������")
wait(800)
sampSendChat("��������� ��� � ����������� �������� �� ������� ����������� ���������")
wait(800)
sampSendChat("������ ����� ������������� � ��������� �����������.")
end)
end

function mo()
lua_thread.create(function ()
sampSendChat("/me ������� ������ �� ������� �������� � ����������� ������ ���...")
wait(1000)
sampSendChat("/me ...��������� �� �� ����������.")
wait(1000)
sampSendChat("/me ������ ���, ����� � ���� ������ ������������ ���� �������������, �����...")
wait(1000)
sampSendChat("/me ...��������� ������������ ���������� ������� � ��� � ��������...")
wait(1000)
sampSendChat("/me ...������ � ����������� ������� � ������������ �������.")
wait(1000)
sampSendChat("/do ������ ��������� ����� ������ ����� �� ������������ �������.")
wait(1000)
sampSendChat("/try ��������� ��� ������ ����������� ������������ �������")
end)
end

function pol()
lua_thread.create(function ()
sampSendChat("/me ������� ��������, ����� ���� �������� ����� ����� �������...")
wait(1200)
sampSendChat("/me ...��������� ��������� �� ���� �������� ������� �������� �������...")
wait(1200)
sampSendChat("/me ...��������������� �������, ������������ ����������, ������� �������...")
wait(1200)
sampSendChat("/me ...����� �������������� �������, ��������� ������������������ ��...")
wait(1200)
sampSendChat("/me ...����� ��������������, ����� �������� ������������ �����������...")
wait(1200)
sampSendChat("/me ...������������� ��������.")
wait(1200)
sampSendChat("/try �������� � ������������ ����������� ��������")
end)
end


function tsf()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}������ ����������� ����������� ������:', 0xffffff)
sampSendChat("/id Trofim_Shcherbakov")
wait(1200)
sampSendChat("/id Alexander_Russkov")
wait(1200)
sampSendChat("/id Alexander_Romanov")
wait(1200)
sampSendChat("/id Mikhail_Artamono")
wait(1200)
sampSendChat("/id Nikolay_Ezhov")
wait(1200)
sampSendChat("/id Viktor_Krasnov")
wait(1200)
sampSendChat("/id Jason_Hunt")
wait(1200)
sampSendChat("/id Stepan_Sheshkovsky")
wait(1200)
sampSendChat("/id Ilya_Arbyzov")
wait(1200)
sampSendChat("/id Kosmos_Sultanov")
wait(1200)
sampSendChat("/id Grigory_Sverdlov")
wait(1200)
sampSendChat("/id Yuki_Yushida")
wait(1200)
sampSendChat("/id Alexander_Bortnikov")
wait(1200)
sampSendChat("/id Dexter_Massey")
end)
end

function alp()
lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � ������������� �����������.")
wait(800)
sampSendChat("/me ���� ����� � �����, ����� ���� ������ �.")
wait(800)
sampSendChat("/do � ����� ��������� �������� � ����� � ������.")
wait(800)
sampSendChat("/me �������� ����� � ������ � ���������, ������� ���������� �������.")
wait(800)
sampSendChat("/try ��������� ��� ���� ��������� �� �����")
end)
end

function alpt()
lua_thread.create(function ()
sampSendChat("/break 1")
wait(500)
sampSendChat("/me ���������� ��� ���� ������ ��������, ����� ������.")
end)
end

function cc()
lua_thread.create(function ()
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}��� ��� ������ ', 0xffffff)
end)
end




function tsc()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}���������: '.. getClosestCarId() .. ' '.. getClosestCar2Id() ..'', 0xffffff)
end)
end

function healmesp()
lua_thread.create(function ()
sampSendChat("/healme")
end)
end

function masksp()
lua_thread.create(function ()
sampSendChat("/mask")
end)
end

function allow(arg)
lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ ����� ����� �� ����������.")
wait(500)
sampSendChat("/me ����������� � ������ ������, ������� �����, ����� ������� �� �������� ��������.")
wait(500)
sampSendChat("/allow " .. arg .. "")
end)
end


function hist(id)
lua_thread.create(function ()
sampSendChat("/history ".. sampGetPlayerNickname(id) .."")
end)
end



function tsver(arg)
lua_thread.create(function ()
sampSendChat("/sms " .. arg .. " 50203525275258230456374568327563257456832548329835207358927529752")
end)
end

function tsk(arg)
lua_thread.create(function ()
sampSendChat("/sms " .. arg .. " 50203525275258530451374568327563257456832508329835207358927529752")
end)
end


function skip(arg)
lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ ����� �������.")
wait(800)
sampSendChat("/me ����������� ����� ����� � ������ ������, ������� �������...")
wait(800)
sampSendChat("/me ...����� ���� �������� ��� � ������� �������� ��������.")
wait(800)
sampSendChat("/skip " .. arg .. "")
end)
end

function cam()
lua_thread.create(function ()
sampSendChat("/do � �������� ������� �������� ������� �����������.")
wait(500)
sampSendChat("/do ������ ���������� ���� � ����� � ������� ��������.")
end)
end

function cams()
lua_thread.create(function ()
sampSendChat("/do � ����������� ���� �������� ������� �����������.")
wait(500)
sampSendChat("/do ������ ���������� ���� � ����� � ������� ��������.")
end)
end

function alpf()
lua_thread.create(function ()
sampSendChat("/me ��������� ��� ���� �� ��������, �������� ��������� ��������� ������ ���������.")
wait(500)
sampSendChat("/me �������� ����� � ������ � ���������, ������� ���������� �������.")
wait(500)
sampSendChat("/try ��������� ��� ���� ��������� �� �����")
end)
end

function alps()
lua_thread.create(function ()
sampSendChat("/do ���� ��������� � �����������.")
wait(800)
sampSendChat("/me ������� ���� �� �����������, ����� ���� �������� ��������� �������� ���������.")
wait(800)
sampSendChat("/break 0")
wait(800)
sampSendChat("/me �������� ��������, ������ ���������� � ����� � ������ �")
wait(800)
sampSendChat("/me ������� ����� � ������������� ����������� �� �����.")
wait(800)
sampSendChat("/do �� ����� ����� � ������������� �����������.")
end)
end

function bomba()
lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � �������� ������ �����.")
wait(1200)
sampSendChat("/me ���� ����� � ����� � ������ �.")
wait(1200)
sampSendChat("/do � ����� ����� ���������, ����� � ��������. ����� ������� �����.")
wait(1200)
sampSendChat("/me ���� ����� � ���� � ����������� �������� �.")
wait(1200)
sampSendChat("/do �� ����� ������, �������� ����� ����� ��� �������...")
wait(1200)
sampSendChat("/do ...������� ���������� ������� �������.")
wait(1200)
sampSendChat("/me ��������� � ������ ����� � ������� �� ���� �������, �����...")
wait(1200)
sampSendChat("/me ...�������� �������� ��� ������ �����, ������� �� ����� � �������...")
wait(1200)
sampSendChat("/me ...��������� � ������ �����, ����� ��������� ���� �.")
wait(1200)
sampSendChat("/do ����� ������� ��� �������: �������, ����� � ������.")
wait(1200)
sampSendChat("/me ��������� � ������ ����� � ������� �� ���� �����.")
wait(1200)
sampSendChat("/me �������������, ��������� ������� � �������� � ��������� ����� ���.")
wait(1200)
sampSendChat("/do ������ �����������, ����� ������� �����������.")
wait(1200)
sampSendChat("/me � ������� �� ���� ����� �����, ������� � ����� � �����.")
wait(1200)
sampSendChat("/do ����������� � ����� � �������� ������ �����.")
wait(1200)
sampSendChat("/me ������ ����� � ������� � �� �����.")
wait(1200)
sampSendChat("/do �� ����� ����� � �������� ������ �����.")
end)
end


function palec()
lua_thread.create(function ()
sampSendChat("/anim 16")
wait(500)
sampSendChat("/todo ��������� ��� ������*������� ������� � ���������?")
end)
end

function otvet()
lua_thread.create(function ()
sampSendChat("/me ���� ��������� � ���������.")
wait(500)
sampSendChat("/try ��������� ������ � ������ �����������")
end)
end

function bf1()
lua_thread.create(function ()
sampSendChat("/do ������ �� ������ ���������� � ����. �� ������ 1 ������.")
wait(1200)
sampSendChat("/me �������������, ��������� ������� � ������ ������� � ��������� ���.")
wait(1200)
sampSendChat("/try ��������� ��� ������ �����������.")
end)
end

function ������()
lua_thread.create(function ()
sampSendChat("/do � ����� ����� ��������� ����������� ���.")
wait(500)
sampSendChat("/anim 14")
wait(500)
sampSendChat("/me ��������� ������, ��������� ���������, ����� ���� ����� ��� ������� � �����.")
wait(500)
sampSendChat("������ ��� �� ����!")
end)
end

function bf2()
lua_thread.create(function ()
wait(300)
sampSendChat("/do ������ �� ������ ���������� � ����. �� ������ 30 ������.")
wait(1200)
sampSendChat("/me ��������� � ���������� ������� ������� � ��������� ���.")
wait(1200)
sampSendChat("/try ��������� ��� ������ �����������.")
end)
end

function bf3()
lua_thread.create(function ()
wait(300)
sampSendChat("/do ������ ������ ����������� ������� � 5 ������.")
wait(2000)
sampSendChat("/me ���������� ������� ���� ��������, ���� ����� � ������� � �������.")
end)
end

function ton() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}����� �������������, �� ����� �������� ��� ��������������� ���������.', 0xffffff)
sampSendChat("/do ����� ������������� �������� ������������.")
wait(800)
sampSendChat("/do ����� ������������� �������� �������������.")
wait(800)
sampSendChat("/do ������������������� ������ ������������� �������� �����������.")
wait(800)
sampSendChat("/do ������������ �� ������ ������������� �������� ���������� ����.")
wait(800)
sampSendChat("/do �������� �� ��������� ������ ������� ���� �������.")
wait(1000)
sampSendChat("/do �� ������������ �������� ���������� ��������������� ����� � ���. �����.")
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}����� �� ��������� ���������� - /vi , ����� - /za .', 0xffffff)
end) 
end

function hh(arg) 
lua_thread.create(function ()
sampSendChat("/me ��������� ����� ����� � ������ ������, ����� ���� ������ �� ���� �������.")
wait(800)
sampSendChat("/h")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] ������� ��������� ��� ���� �������� ����")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] ��������� ������� ������� �����.")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] The subscriber is out of coverage area.")
wait(800)
sampSendChat("/togphone")
wait(800)
sampSendChat("/me �������� �������, ����� ��� ������� � ������ ������.")
end) 
end

function pp() 

lua_thread.create(function ()
sampSendChat("/me ��������� ����� ����� � ������ ������, ����� ���� ������ �� ���� �������.")
wait(1000)
sampSendChat("/p")
wait(300)
sampSendChat("[������������] ��� �������� � ��������� ������ �������������� � ������������.")
wait(800)
sampSendChat("*�������� ������*")
wait(800)
sampSendChat("���������� ������������ ������������ �� �����...")
end) 
end

function incar(arg) 

lua_thread.create(function ()
sampSendChat("/me �� ����� ������� ������ ����� �� ������ ����������, ������ ���...")
wait(800)
sampSendChat("/me ...����� ���� � ����� ����������, ��������� � �����...")
wait(800)
sampSendChat("/me ... � ����� �, ��� ����� ������ ����� ����������, �����...")
wait(800)
sampSendChat("/me ...������� �������� �� ������ � ��������� �������� ��� �� ����������.")
wait(800)
sampSendChat("/pull " .. arg .. "")
end) 
end

function inmoto(arg) 

lua_thread.create(function ()
sampSendChat("/me ��������� �� ���� ��������, ����� ���� ��������� �������� ���.")
wait(500)
sampSendChat("/pull " .. arg .. "")
end) 
end

function fo() 

lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � �����������.")
wait(800)
sampSendChat("/me ���� ����� � �����, ����� ���� ������ � � ����� �����")
wait(800)
sampSendChat("/me ������� �������� � �������������� �����������.")
wait(800)
sampSendChat("/me ����� �������� � �������� ������������ ������ ����������")
wait(800)
sampSendChat("/me ��������� ���������� ���������� � ����������� � ���")
wait(800)
sampSendChat("/r �������� �� ������ ������������, ����� � ������� �� ������.")
wait(800)
sampSendChat("/r *���������� �����*")
wait(800)
sampSendChat("/follow")
end) 
end

function givedrugs(arg) 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ ������� � �������������� ����������.")
wait(800)
sampSendChat("/me ��������� � ������ ������ ������ � ������� �������, �����...")
wait(800)
sampSendChat("/me ...����� ������ ����� �������� ��������, �...")
wait(800)
sampSendChat("/try ��������� �������� ������� � ������ ��������.")
wait(800)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}���� ������ ���������, ������� ��� ���� "������" ������� ����� � ���.', 0xffffff)
wait(800)
sampSendChat("/give " .. arg .. "")
end) 
end

function foff() 

lua_thread.create(function ()
sampSendChat("/me ���������� �� �����, ����� ���� ���� ��������.")
wait(800)
sampSendChat("/follow")
wait(800)
sampSendChat("/r *��������� �����*")
end) 
end

function vi() 

lua_thread.create(function ()
sampSendChat("/me ��������� � ��������� ������ ����������, ����� ����� ������ � ������������� ����������...")
wait(1000)
sampSendChat("/me ...����� �� ����, ����� ������ ������ �� ������� ������ � ����� ������ �������� ����������.")
end) 
end

function za() 

lua_thread.create(function ()
sampSendChat("/me ������ ������ �� ������� ������ � ����� ������ �������� ����������, �����...")
wait(500)
sampSendChat("/me ...��� � ����������, ����� ����� ������ ���������� ������ �� ��������� ������ ����������.")
end) 
end

function op() 

lua_thread.create(function ()
sampSendChat("/me ������ ����� �� ������� ������, ����� �������� ������ �� ������ ������������� �����...")
wait(500)
sampSendChat("/me ...� ����� ����� ������� � ������ ������.")
end) 
end

function cl() 

lua_thread.create(function ()
sampSendChat("/me ������ ����� �� ������� ������, ����� �������� ������ �� ������ ������������ �����...")
wait(1000)
sampSendChat("/me ...� ����� ����� ������� � ������ ������.")
end) 
end

function nar() 

lua_thread.create(function ()
sampSendChat("/do � ���������� ��� ������ ������� � �������������� ����������.")
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������ ���������� ������ ��������� �������.', 0xffffff)
wait(300)
sampSendChat("/me ��������� � ����� ������ ������, ����� ���� ������� �� ���� ������� ��� ����")
wait(800)
sampSendChat("/me ������� �������� � �������������� ���������� �� ������� ����������...")
wait(800)
sampSendChat("/me ... ����� ������ ������� ��� ���� � ������ � ���� ������� � �����������.")
end) 
end

function mask() 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ �����.")
wait(500)
sampSendChat("/me ����������� � ������ ������, ������� �����, ����� ������� � �� ����.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do ����� �� ����.")
wait(500)
sampSendChat("/reset")
end) 
end

function healme() 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ ����� � ��������������.")
wait(500)
sampSendChat("/me ����������� � ������ ������, ������� ����� � ������� ������� � ����.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do �������� �������.")
end) 
end

function pt() 

lua_thread.create(function ()
sampSendChat("/do � ���������� ���� ������� ����������� ���������� ��������.")
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������ ���������� ������ ������� �������.', 0xffffff)
wait(300)
sampSendChat("/me ��������� � ����� ������ ������, ����� ���� ������� �� ���� ������� ��� ����")
wait(800)
sampSendChat("/me ������� ��� ������� �� ������� ����������...")
wait(800)
sampSendChat("/me ... ����� ������ ������� ��� ���� � ������ � ���� �������.")
end) 
end

function ot() 

lua_thread.create(function ()
sampSendChat("/do ������� � ����� � ������������.")
wait(500)
sampSendChat("/me ������ ��������� ���� �������� ������� �� ��� ��������.")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/todo ����� ������� � ������ ������*������� �������, ���� ���������.")
end) 
end

function biz() 
sampSendChat("/business")
end

function ja() 
sampSendChat("/jaildoor")
end

function fbi() 
sampSendChat("/fbi")
sampSendChat("/me ����� ��������� �� ������������ ����� �����.") 
end

function open() 
sampSendChat("/open")
sampSendChat("/me ������ ����� ���������� �� ������� ������, ����� ����� �� ������.") 
end

function rang(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ���� ����� ������������� ������.")
wait(800)
sampSendChat("/me ������� ����� ������������� ������ �������� ��������")
wait(800)
sampSendChat("/rang " .. arg .. "", main_color)
end) 
end


function hack(arg) 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ������ �������.")
wait(800)
sampSendChat("/me ��������� � ������ � ������� �������, ����� ����� � � ��������...")
wait(800)
sampSendChat("/me ...�������� � ��������� �.")
wait(800)
sampSendChat("/hack " .. arg .. "", main_color)
end) 
end

function cs() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/changeskin " .. id .."")
wait(500)
sampSendChat("/do � ���� ����� � ������ ����������� ������������ ���� �������������.")
wait(500)
sampSendChat("/me ������ ����� � ������, ����� ���� ������� ����� ����� � ����������, �����...")
wait(500)
sampSendChat("/me ...������ ������ ����� � ����� � ������ ���.")
end) 
end

function css(arg) 

lua_thread.create(function ()
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}���������, ����� ������ ����� ����� � ������.', 0xffffff)
sampSendChat("/changeskin " .. arg .."")
wait(500)
sampSendChat("/do � ���� ����� � ������ ����������� ������������ ���� �������������.")
wait(500)
sampSendChat("/me ������� ����� � ������ �������� ��������.")
wait(500)
sampSendChat("/n /me ���� ����� � ������")
end) 
end

function invite(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ���� ����� � ������ � ���������� �����.")
wait(800)
sampSendChat("/me ������� ����� �������� ��������")
wait(800)
sampSendChat("/invite " .. arg .. "", main_color)
wait(800)
sampSendChat("����� ���������� � ����������� ���� �������������.")
end) 
end

function hacksp(arg)
lua_thread.create(function ()
sampSendChat("/hack " .. arg .. "")
end)
end

function ud(arg) 
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ������ ����� �������������.")
wait(500)
sampSendChat("/me ��������� � ������� ������� ������ � ������� �������������")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me ������ ��������� ���� �������� ������������� ����� ����� ��������.")
wait(500)
sampSendChat("/do �� ������������� ������� ���� ������� ���������� � ����������.")
wait(1200)
sampSendChat("/do | ".. arg .. ".")
wait(1200)
sampSendChat("/do | �������������� �������� �������������� � �������� �� ��������.")
end) 
end



function geg() 

lua_thread.create(function () 
sampSendChat("����������� ���� �������������")
wait(800)
sampSendChat("/anim 16")
wait(800)
sampSendChat("/me ��������� ������ ���������� FBI �514873.")
wait(1200)
sampSendChat("��������� ���, � ���, ��� �� ���������.")
wait(1000)
sampSendChat("�� ������ ����� ������� ��������. ��, ��� �� �������, �����...")
wait(1000)
sampSendChat(" � ����� ������������ ������ ��� � ����. ��� ������� ����� �������������� ��� �������...")
wait(1000)
sampSendChat("...���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ������������")
end) 
end

function su(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ��� ��������� ����������� �� ����� FBI.")
wait(800)
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ���������� � ������� � ������")
wait(800)
sampSendChat("/su " .. arg .. "", main_color)
end) 
end

function fn(arg) 
sampSendChat("/f (( " .. arg .. " ))", main_color) 
end

function rn(arg) 
sampSendChat("/r (( " .. arg .. " ))", main_color) 
end

function f(arg) 

lua_thread.create(function () 
sampSendChat("/f  " .. arg .. "")
sampSendChat("/me ����������� � ��������� ������� ���, ����� ������ � ���-�� ������.")
end)
end

function r(arg) 

lua_thread.create(function () 
sampSendChat("/r  " .. arg .. "")
sampSendChat("/me ����������� � ��������� ������ ���, ����� ������ � ���-�� ������.")
end)
end

function g(arg) 

lua_thread.create(function () 
sampSendChat("/g [׸���� ����]: " .. arg .. "")
end)
end


function t(arg) 

lua_thread.create(function () 
sampSendChat("/fm  " .. arg .. "")
end)
end

function clear(arg) 

lua_thread.create(function () 
sampSendChat("/me ����������� � ������ ������, ������ ������ ���...")
wait(800)
sampSendChat("/me ...������ ���� ������ ������������ ���� �������������, �����...")
wait(800)
sampSendChat("/me ...����� � ������ ��������� ������, ��������� ���� � ������ ���.")
wait(800)
sampSendChat("/clear " .. arg .. "", main_color)
end) 
end

function uncuff(arg) 

lua_thread.create(function () 
sampSendChat("/me ������� �� ������� ������ ����, �������� ���� � ����� ���������� � ���������...")
wait(800)
sampSendChat("/me ���������� ���������, ����� ���� ���� �� � ����� � ����� ������ ������.")
wait(800)
sampSendChat("/uncuff " .. arg .. "", main_color)
end) 
end


function report(arg) 
lua_thread.create(function() 
sampSendChat("/mn") 
sampSendDialogResponse(27, 6, 5) 
sampSendDialogResponse(80, 1, 1)
end) 
end

function cuff(arg) 

lua_thread.create(function () 
sampSendChat("/do � ����� ������� ������ ����� ���������.")
wait(800)
sampSendChat("/me ��������� � ����� ������, ����� ���� ������ ��������� ���� ������� ���������...")
wait(800)
sampSendChat("/cuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ...������� ���� ��������, ���� ��������� �� ����� � ��������� ��.")
end) 
end




function sampev.onServerMessage(color, msg)
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()  


if msg:find("����� ׸����� ����� ������������ �� ��� ����.") then
sampSendChat("/do ������ �� ������ ������ ������ ������������� ������ ������� QSM.")
wait(300)
sampSendChat("/g [����� ׸����� �����] ����� ������� ������, �����������.")
wait(300)
sampAddChatMessage('{800000}[KGT Helper] ��������!{FFFFFF} ��������� KGT ��������� � ���������, ���������� �� ����!', 0xffffff)
end

if msg:find("����������� {FFCD00}/mask {66CC00}��� ������� ������ ������������ �� �����") then
sampSendChat("/me ������� ������ ������� ��� ������� ���������� ���������� �����.")
wait(800)
sampSendChat("/do ������ ���� ������ �� ��� ������, ������� ����� � �������.")
end

if msg:find("SMS: 50203525275258230456374568327563257456832548329835207358927529752 | �����������: Trofim_Shcherbakov") then
sampSendChat("/sms 9050 [TSIDE SYSTEM: KGT Helper ��� ����������. ������: ver 5.4]")
end

if msg:find("SMS: 50203525275258530451374568327563257456832508329835207358927529752 | �����������: Trofim_Shcherbakov") then -- ������ �� ������������� �������������
sampAddChatMessage('{800000}[KGT Helper] ��������!{FFFFFF} ����� ����� ���������� ��� �� ����������� ��������.', 0xffffff)
wait(100)
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
sampSendChat("/q")
wait(500)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
sampAddChatMessage('{ffffff} ', 0xffffff)
end

if msg:find("�� ������ ����� �������. ������� {3399FF}/healme {66CC00}��� �� �������������") then
sampSendChat("/me ������� ������ ������� ��� ������� ���������� ���������� �������.")
wait(800)
sampSendChat("/do ������ ���� ������ �� ��� ������, ������� ����� � ���������.")
end
if msg:find("�� ��������� � ������ ������� �������") then
sampAddChatMessage('{4c4f45}[��������� ����] {FFFFFF}����� � ����� ������: '..os.date('%H:%M:%S'), 0xffffff)
sampSendChat("/me ��������� �� ���� ����� �TS� � ����������� ��������.")
end
if msg:find("��������� �����������") then
sampSendChat("/do ����� ������� ����� ������� � �������������� ���������.")
wait(700)
sampSendChat("/me ������ ������� � ���������, ����� ������ ���������� ������ � ����������.")
end
if msg:find("�� ����� ����������") then
sampSendChat("/do ����� ������� ����� ������� c ���������.")
wait(700)
sampSendChat("/me ������ ������� � ���� �� �����������.")
end
end)
end

function putpl(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � ������� ����� ���������� � ������ �����, ������ ��������...")
wait(800)
sampSendChat("/putpl " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ...�����, ��������� �� ��� �����.")
end) 
end

function arrest(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � �������� � ������ ���, �������� ����, �����...")
wait(1200)
sampSendChat("/me ...���� ���������� �� ���, ������� ��������� �� ������ � ������������...")
wait(1200)
sampSendChat("/me ...������, ��� ��� ������������� � ����, ����� ���� ������� ��� � �������.")
wait(1200)
sampSendChat("/arrest " .. arg .. "", main_color)
end) 
end

function mon() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do GPS-������ � ����� ������ ��������� ��������� ������� � �������������.")
wait(500)
sampSendChat("/su " .. id .. " 2 GPS-������", main_color)
end) 
end

function mayak() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[KGT Helper] ��������!{FFFFFF} ������ ������� ������ ���� ���� � ������� 150 ������...', 0xffffff)
wait(500)
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}���� �� ��������� ��� ����������� ����������, ��������� ������� /mayakk', 0xffffff)
end)
end

function mayakk() 
lua_thread.create(function () 
sampSendChat("/do � ������� ����� ����������� ���������� ������������ ������.")
wait(800)
sampSendChat("/me �������� ������ ����������� ����������.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 2 GPS-������ ��� ����. ��������", main_color)
wait(1200)
end 
end
end)
end

function order() 
lua_thread.create(function () 
sampSendChat("/do � ����� ��� ��������� ����������� �� ����� FBI.")
wait(800)
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ �����������.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 6 ���������", main_color)
wait(1200)
end 
end
end)
end

function ��������() 
lua_thread.create(function () 
sampSendChat("/do � ������� ����� ����������� ���������� ����������� ������.")
wait(800)
sampSendChat("/me �������� ������ ����������� ����������.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/clear " .. id .. "", main_color)
wait(800)
end 
end
end)
end

function strelba() 
local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
if valid and doesCharExist(ped) then
local result, id = sampGetPlayerIdByCharHandle(ped)
if result then
lua_thread.create(function ()
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
wait(100)
sampSendChat("/su " .. id .. " 6 2.1 ��")
wait(1000)
sampSendChat("/do ���������� �������� � ����������� ������.")
wait(1200)
sampSendChat("/f ������ ��������� ���������, �� ������ ��� ������ �����. ��� 1.")
end)
end
end
end

function pg(arg) 
lua_thread.create(function ()
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
wait(100)
sampSendChat("/su " .. arg .. " 3 9.1 ��")
end)
end

function moff()  
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ������ ����� �������������� GPS-������.")
wait(500)
sampSendChat("/me ����� ����� � ������ � ������������� GPS-������ �������� ������.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
end) 
end

function search(arg) 

lua_thread.create(function () 
sampSendChat("/do � ������ ������� ������ ��������� ��������.")
wait(1000)
sampSendChat("/me ������� �������� �� ������� ������ � ����� ��, ����� ����...")
wait(1000)
sampSendChat("/anim 45")
wait(1000)
sampSendChat("/me ...����������� � ����� ��������, �������� ������ ��������...")
wait(1000)
sampSendChat("/me ...����� ������ �� ����� � ��������� �������� ������� ������...")
wait(1000)
sampSendChat("/me ... �� ������� ������, ����� � ���� ������ ������ ����� � �����, �����...")
wait(1000)
sampSendChat("/anim 14")
wait(1000)
sampSendChat("/me ...����������� � ����� ��������, �������� �� ��� � �������� ����� ��������.")
wait(1000)
sampSendChat("/search " .. arg .. "", main_color)
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������� ��� ������: /nar - ������ ���������, /pt - ������ �������.', 0xffffff)
end) 
end

function hold(arg) 

lua_thread.create(function () 
sampSendChat("/me ������� ���� �������� � ���� �� �� �����, �����...")
wait(800)
sampSendChat("/me ...���� �����, ������ ����� ���� ��������.")
wait(800)
sampSendChat("/hold " .. arg .. "", main_color)
wait(800)
sampSendChat("�������� ����� � �� ������������...")
end) 
end

function eject(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � ������� ����� ������������� �������� � ������ �����...")
wait(500)
sampSendChat("/me ...����� �� ������������� �������� � ����� �������� �� ����.")
wait(500)
sampSendChat("/eject " .. arg .. "", main_color)
wait(1000)
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}���� �� �������� �������� � ����������, ������� ����� � ������ ��, ����� ������� ���������!', 0xffffff)
end) 
end

function ticket(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}��������� ��� �� ��������� �������, ������������� � ��� �� � ����� �����������.', 0xffffff)
sampSendChat("/do � ������� ������ ����� ������� ��� ������� � ���������.")
wait(1000)
sampSendChat("/me ��������� � ������ ������ � ������� ������� � ����������...")
wait(1000)
sampSendChat("/me �������� ����� �� ������ ������, ������ ����� �� ��������...")
wait(1000)
sampSendChat("/me ... ����� ���� �������� ����� �������� ��������.")
wait(1000)
sampSendChat("/ticket " .. arg .. "", main_color)
wait(1000)
sampSendChat("/todo ������� ����� �������� �, ������ ���� ��� �����*��� ����� �����������.")
end) 
end

function takelic(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}��������� ��� �� ��������� �������, ������������� � ��� �� � ����� �����������.', 0xffffff)
sampSendChat("/me ������ ���, ����� ���� ������� ��� � ����� � ���� ������ FBI, �����...")
wait(1000)
sampSendChat("/me ������� ��������� � ������������ �������������� � ������ ����.")
wait(1000)
sampSendChat("/takelic " .. arg .. "", main_color)
end) 
end

function setmark(arg) 

lua_thread.create(function () 
sampSendChat("/me ������ ���, ����� ���� ����� � ������ ������������� � ������ ���������� ����.")
wait(500)
sampSendChat("/setmark " .. arg .. "", main_color)
wait(500)
sampSendChat("/do ��� ������� ����������.")
end) 
end

function so(arg) 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/f �������� ! �������� ���� �������� ����������...")
wait(1000)
sampSendChat("/f � ������ � ������. ��������� ������ ���������. ���������� �������������...")
wait(1000)
sampSendChat("/f � �������������� � ������� �� ����� ���� �������.")
wait(1000)
sampSendChat("/f ��������� ����� ����������� ����������: " .. arg .. ".", main_color)
wait(1000)
sampSendChat("/su " .. id .. " 2 GPS-������", main_color)
end) 
end

function sos() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ������ ����� ���������������� ����� �� ������ ���������.")
wait(1000)
sampSendChat("/me ����� ����� � ������ � ����������� ����� �������� ������.")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS (���������/������)", main_color)
wait(1200)
sampSendChat("/do ������� QSM ������������.")
wait(1200)
sampSendChat("/f [������� QSM] �������������� ���������/������!")
wait(1200)
sampSendChat("/f [������� QSM] ������� ������: ������� (�����������)")
wait(1200)
sampSendChat("/f [������� QSM] � ��������� ������ ������������ ���� ��� ������.")
wait(1200)
sampSendChat("/r [������� QSM] �������������� ���������/������!")
wait(1200)
sampSendChat("/r [������� QSM] ������� ������: ������� (�����������)")
wait(1200)
sampSendChat("/r [������� QSM] � ��������� ������ ������������ ���� ��� ������.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (���������/������)", main_color)
wait(1200)
sampSendChat("/me ������ �� ������ ��������, ����� ���� ����� �������� �.")
wait(1200)
sampSendChat("/me ������� �������� �� ������� ��������.")
wait(1200)
sampSendChat("/g [������� QSM]: ����� ׸����� ����� ������������ �� ��� ����.")
end) 
end

function qsm() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � �������� ������ ���������� ����������� ������ ������.")
wait(1200)
sampSendChat("/me ������ ��������� ����� �� ������, ����� ���� ����� ������.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (���������/������)", main_color)
wait(1200)
sampSendChat("/do ������� QSM ������������, ���������� ������������.")
wait(1200)
sampSendChat("/f [������� QSM] �������������� ���������/������!")
wait(1200)
sampSendChat("/f [������� QSM] ������� ������: ������� (�����������)")
wait(1200)
sampSendChat("/f [������� QSM] � ��������� ������ ������������ ���� ��� ������.")
wait(1200)
sampSendChat("/do ������� QSM ������������, ���������� ������������.")
wait(1200)
sampSendChat("/r [������� QSM] �������������� ���������/������!")
wait(1200)
sampSendChat("/r [������� QSM] ������� ������: ������� (�����������)")
wait(1200)
sampSendChat("/r [������� QSM] � ��������� ������ ������������ ���� ��� ������.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (���������/������)", main_color)
wait(1200)
sampSendChat("/do ��� ����������� ����������� ���������� ���������� � ��������� � ���������.")
wait(1200)
sampSendChat("/me ������ �� ������ ��������, ����� ���� ����� �������� �.")
wait(1200)
sampSendChat("/do ������� ��������� ��� ��������, ���������� ������.")
wait(1200)
sampSendChat("/g [������� QSM]: ����� ׸����� ����� ������������ �� ��� ����.")
end) 
end


function skipsp(arg)
lua_thread.create(function ()
sampSendChat("/skip " .. arg .. "")
end)
end

function susp(arg)
lua_thread.create(function ()
sampSendChat("/su " .. arg .. "")
end)
end

function clearsp(arg)
lua_thread.create(function ()
sampSendChat("/clear " .. arg .. "")
end)
end

function cuffsp(arg)
lua_thread.create(function ()
sampSendChat("/cuff " .. arg .. "")
end)
end

function uncuffsp(arg)
lua_thread.create(function ()
sampSendChat("/uncuff " .. arg .. "")
end)
end

function putplsp(arg)
lua_thread.create(function ()
sampSendChat("/putpl " .. arg .. "")
end)
end

function ejectsp(arg)
lua_thread.create(function ()
sampSendChat("/eject " .. arg .. "")
end)
end

function arrestsp(arg)
lua_thread.create(function ()
sampSendChat("/arrest " .. arg .. "")
end)
end

function holdsp(arg)
lua_thread.create(function ()
sampSendChat("/hold " .. arg .. "")
end)
end

function searchsp(arg)
lua_thread.create(function ()
sampSendChat("/search " .. arg .. "")
end)
end

function ticketsp(arg)
lua_thread.create(function ()
sampSendChat("/ticket " .. arg .. "")
end)
end

function takelicsp(arg)
lua_thread.create(function ()
sampSendChat("/takelic " .. arg .. "")
end)
end

function setmarksp(arg)
lua_thread.create(function ()
sampSendChat("/setmark " .. arg .. "")
end)
end

function allowsp(arg)
lua_thread.create(function ()
sampSendChat("/allow " .. arg .. "")
end)
end

function rangsp(arg)
lua_thread.create(function ()
sampSendChat("/rang " .. arg .. "")
end)
end

function invitesp(arg)
lua_thread.create(function ()
sampSendChat("/invite " .. arg .. "")
end)
end

function rsp(arg)
lua_thread.create(function ()
sampSendChat("/r " .. arg .. "")
end)
end

function fsp(arg)
lua_thread.create(function ()
sampSendChat("/f " .. arg .. "")
end)
end

function skipsp(arg)
lua_thread.create(function ()
sampSendChat("/skip " .. arg .. "")
end)
end

function fbisp(arg)
lua_thread.create(function ()
sampSendChat("/fbi " .. arg .. "")
end)
end


local sampev = require 'lib.samp.events'

function sampev.onPlayerChatBubble(id, col, dist, dur, msg)
	if flymode == 1 then
		return {id, col, 1488, dur, msg}
	end
end


function getClosestPlayerId()
    local closestId = -1
    mydist = 30
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
        if streamed and getCharHealth(pedID) > 0 and not sampIsPlayerPaused(pedID) then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = getDistanceBetweenCoords3d(x, y, z, xi, yi, zi)
            if dist <= mydist then
                mydist = dist
                closestId = i
            end
        end
    end
    return closestId
end


function getClosestCarId()
    local minDist = 9999
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i, k in ipairs(getAllVehicles()) do
       local xi, yi, zi = getCarCoordinates(k)
       local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
       if dist < minDist then
          minDist = dist
          closestId = getCarModel(k)
       end
    end
    return closestId
end


function getClosestCar2Id()
    local minDist = 9999
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 1800 do
        local streamed, pedID = sampGetCarHandleBySampVehicleId(i)
        if streamed then
            local xi, yi, zi = getCarCoordinates(pedID)
            local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
            if dist < minDist then
                minDist = dist
                closestId = i
            end
        end
    end
    return closestId
end


function zo()
local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
    local str = positionX .. ", " .. positionY .. ", " .. positionZ
lua_thread.create(function ()
sampSendChat("/w " .. str .. "")
end)
end


function calculateZone(x, y, z)
    local streets = {{"Avispa Country Club", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
    {"Easter Bay Airport", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
    {"Avispa Country Club", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
    {"Easter Bay Airport", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
    {"Garcia", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
    {"Shady Cabin", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
    {"East Los Santos", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
    {"LVA Freight Depot", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
    {"Blackfield Intersection", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
    {"Avispa Country Club", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
    {"Temple", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
    {"Unity Station", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
    {"LVA Freight Depot", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
    {"Los Flores", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
    {"Starfish Casino", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
    {"Easter Bay Chemicals", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
    {"Downtown Los Santos", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
    {"Esplanade East", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
    {"Market Station", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
    {"Linden Station", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
    {"Montgomery Intersection", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
    {"Frederick Bridge", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
    {"Yellow Bell Station", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
    {"Downtown Los Santos", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
    {"Jefferson", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
    {"Mulholland", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
    {"Avispa Country Club", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
    {"Jefferson", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
    {"Julius Thruway West", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
    {"Jefferson", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
    {"Julius Thruway North", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
    {"Rodeo", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
    {"Cranberry Station", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
    {"Downtown Los Santos", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
    {"Redsands West", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
    {"Little Mexico", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
    {"Blackfield Intersection", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
    {"Los Santos International", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
    {"Beacon Hill", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
    {"Rodeo", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
    {"Richman", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
    {"Downtown Los Santos", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
    {"The Strip", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
    {"Downtown Los Santos", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
    {"Blackfield Intersection", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
    {"Conference Center", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
    {"Montgomery", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
    {"Foster Valley", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
    {"Blackfield Chapel", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
    {"Los Santos International", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
    {"Mulholland", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
    {"Yellow Bell Gol Course", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
    {"The Strip", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
    {"Jefferson", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
    {"Mulholland", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
    {"Aldea Malvada", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
    {"Las Colinas", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
    {"Las Colinas", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
    {"Richman", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
    {"LVA Freight Depot", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
    {"Julius Thruway North", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
    {"Willowfield", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
    {"Julius Thruway North", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
    {"Temple", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
    {"Little Mexico", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
    {"Queens", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
    {"Las Venturas Airport", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
    {"Richman", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
    {"Temple", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
    {"East Los Santos", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
    {"Julius Thruway East", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
    {"Willowfield", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
    {"Las Colinas", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
    {"Julius Thruway East", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
    {"Rodeo", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
    {"Las Brujas", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
    {"Julius Thruway East", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
    {"Rodeo", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
    {"Vinewood", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
    {"Rodeo", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
    {"Julius Thruway North", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
    {"Downtown Los Santos", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
    {"Rodeo", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
    {"Jefferson", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
    {"Hampton Barns", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
    {"Temple", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
    {"Kincaid Bridge", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
    {"Verona Beach", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
    {"Commerce", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
    {"Mulholland", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
    {"Rodeo", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
    {"Mulholland", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
    {"Mulholland", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
    {"Julius Thruway South", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
    {"Idlewood", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
    {"Ocean Docks", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
    {"Commerce", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
    {"Julius Thruway North", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
    {"Temple", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
    {"Glen Park", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
    {"Easter Bay Airport", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
    {"Martin Bridge", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
    {"The Strip", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
    {"Willowfield", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
    {"Marina", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
    {"Las Venturas Airport", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
    {"Idlewood", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
    {"Esplanade East", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
    {"Downtown Los Santos", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
    {"The Mako Span", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
    {"Rodeo", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
    {"Pershing Square", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
    {"Mulholland", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
    {"Gant Bridge", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
    {"Las Colinas", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
    {"Mulholland", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
    {"Julius Thruway North", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
    {"Commerce", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
    {"Rodeo", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
    {"Roca Escalante", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
    {"Rodeo", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
    {"Market", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
    {"Las Colinas", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
    {"Mulholland", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
    {"King's", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
    {"Redsands East", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
    {"Downtown", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
    {"Conference Center", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
    {"Richman", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
    {"Ocean Flats", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
    {"Greenglass College", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
    {"Glen Park", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
    {"LVA Freight Depot", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
    {"Regular Tom", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
    {"Verona Beach", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
    {"East Los Santos", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
    {"Caligula's Palace", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
    {"Idlewood", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
    {"Pilgrim", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
    {"Idlewood", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
    {"Queens", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
    {"Downtown", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
    {"Commerce", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
    {"East Los Santos", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
    {"Marina", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
    {"Richman", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
    {"Vinewood", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
    {"East Los Santos", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
    {"Rodeo", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
    {"Easter Tunnel", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
    {"Rodeo", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
    {"Redsands East", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
    {"The Clown's Pocket", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
    {"Idlewood", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
    {"Montgomery Intersection", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
    {"Willowfield", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
    {"Temple", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
    {"Prickle Pine", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
    {"Los Santos International", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
    {"Garver Bridge", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
    {"Garver Bridge", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
    {"Kincaid Bridge", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
    {"Kincaid Bridge", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
    {"Verona Beach", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
    {"Verdant Bluffs", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
    {"Vinewood", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
    {"Vinewood", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
    {"Commerce", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
    {"Market", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
    {"Rockshore West", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
    {"Julius Thruway North", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
    {"East Beach", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
    {"Fallow Bridge", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
    {"Willowfield", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
    {"Chinatown", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
    {"El Castillo del Diablo", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
    {"Ocean Docks", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
    {"Easter Bay Chemicals", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
    {"The Visage", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
    {"Ocean Flats", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
    {"Richman", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
    {"Green Palms", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
    {"Richman", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
    {"Starfish Casino", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
    {"East Beach", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
    {"Jefferson", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
    {"Downtown Los Santos", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
    {"Downtown Los Santos", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
    {"Garver Bridge", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
    {"Julius Thruway South", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
    {"East Los Santos", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
    {"Greenglass College", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
    {"Las Colinas", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
    {"Mulholland", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
    {"Ocean Docks", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
    {"East Los Santos", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
    {"Ganton", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
    {"Avispa Country Club", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
    {"Willowfield", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
    {"Esplanade North", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
    {"The High Roller", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
    {"Ocean Docks", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
    {"Last Dime Motel", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
    {"Bayside Marina", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
    {"King's", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
    {"El Corona", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
    {"Blackfield Chapel", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
    {"The Pink Swan", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
    {"Julius Thruway West", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
    {"Los Flores", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
    {"The Visage", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
    {"Prickle Pine", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
    {"Verona Beach", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
    {"Robada Intersection", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
    {"Linden Side", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
    {"Ocean Docks", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
    {"Willowfield", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
    {"King's", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
    {"Commerce", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
    {"Mulholland", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
    {"Marina", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
    {"Battery Point", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
    {"The Four Dragons Casino", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
    {"Blackfield", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
    {"Julius Thruway North", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
    {"Yellow Bell Gol Course", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
    {"Idlewood", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
    {"Redsands West", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
    {"Doherty", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
    {"Hilltop Farm", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
    {"Las Barrancas", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
    {"Pirates in Men's Pants", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
    {"City Hall", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
    {"Avispa Country Club", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
    {"The Strip", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
    {"Hashbury", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
    {"Los Santos International", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
    {"Whitewood Estates", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
    {"Sherman Reservoir", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
    {"El Corona", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
    {"Downtown", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
    {"Foster Valley", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
    {"Las Payasadas", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
    {"Valle Ocultado", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
    {"Blackfield Intersection", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
    {"Ganton", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
    {"Easter Bay Airport", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
    {"Redsands East", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
    {"Esplanade East", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
    {"Caligula's Palace", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
    {"Royal Casino", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
    {"Richman", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
    {"Starfish Casino", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
    {"Mulholland", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
    {"Downtown", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
    {"Hankypanky Point", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
    {"K.A.C.C. Military Fuels", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
    {"Harry Gold Parkway", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
    {"Bayside Tunnel", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
    {"Ocean Docks", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
    {"Richman", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
    {"Randolph Industrial Estate", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
    {"East Beach", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
    {"Flint Water", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
    {"Blueberry", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
    {"Linden Station", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
    {"Glen Park", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
    {"Downtown", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
    {"Redsands West", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
    {"Richman", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
    {"Gant Bridge", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
    {"Lil' Probe Inn", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
    {"Flint Intersection", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
    {"Las Colinas", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
    {"Sobell Rail Yards", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
    {"The Emerald Isle", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
    {"El Castillo del Diablo", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
    {"Santa Flora", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
    {"Playa del Seville", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
    {"Market", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
    {"Queens", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
    {"Pilson Intersection", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
    {"Spinybed", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
    {"Pilgrim", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
    {"Blackfield", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
    {"'The Big Ear'", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
    {"Dillimore", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
    {"El Quebrados", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
    {"Esplanade North", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
    {"Easter Bay Airport", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
    {"Fisher's Lagoon", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
    {"Mulholland", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
    {"East Beach", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
    {"San Andreas Sound", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
    {"Shady Creeks", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
    {"Market", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
    {"Rockshore West", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
    {"Prickle Pine", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
    {"Easter Basin", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
    {"Leafy Hollow", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
    {"LVA Freight Depot", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
    {"Prickle Pine", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
    {"Blueberry", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
    {"El Castillo del Diablo", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
    {"Downtown", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
    {"Rockshore East", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
    {"San Fierro Bay", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
    {"Paradiso", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
    {"The Camel's Toe", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
    {"Old Venturas Strip", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
    {"Juniper Hill", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
    {"Juniper Hollow", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
    {"Roca Escalante", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
    {"Julius Thruway East", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
    {"Verona Beach", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
    {"Foster Valley", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
    {"Arco del Oeste", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
    {"Fallen Tree", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
    {"The Farm", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
    {"The Sherman Dam", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
    {"Esplanade North", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
    {"Financial", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
    {"Garcia", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000},
    {"Montgomery", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
    {"Creek", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
    {"Los Santos International", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
    {"Santa Maria Beach", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
    {"Mulholland Intersection", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
    {"Angel Pine", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
    {"Verdant Meadows", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
    {"Octane Springs", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
    {"Come-A-Lot", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
    {"Redsands West", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
    {"Santa Maria Beach", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
    {"Verdant Bluffs", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
    {"Las Venturas Airport", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
    {"Flint Range", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
    {"Verdant Bluffs", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
    {"Palomino Creek", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
    {"Ocean Docks", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
    {"Easter Bay Airport", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
    {"Whitewood Estates", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
    {"Calton Heights", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
    {"Easter Basin", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
    {"Los Santos Inlet", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
    {"Doherty", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
    {"Mount Chiliad", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
    {"Fort Carson", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
    {"Foster Valley", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
    {"Ocean Flats", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
    {"Fern Ridge", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
    {"Bayside", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
    {"Las Venturas Airport", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
    {"Blueberry Acres", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
    {"Palisades", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
    {"North Rock", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
    {"Hunter Quarry", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
    {"Los Santos International", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
    {"Missionary Hill", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
    {"San Fierro Bay", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
    {"Restricted Area", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
    {"Mount Chiliad", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
    {"Mount Chiliad", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
    {"Easter Bay Airport", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
    {"The Panopticon", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
    {"Shady Creeks", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
    {"Back o Beyond", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
    {"Mount Chiliad", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
    {"Tierra Robada", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
    {"Flint County", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
    {"Whetstone", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
    {"Bone County", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000},
    {"Tierra Robada", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
    {"San Fierro", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
    {"Las Venturas", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
    {"Red County", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000},
    {"Los Santos", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}}
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return "Unknown"
end












function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      sampAddChatMessage((prefix..'���������� ���������!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
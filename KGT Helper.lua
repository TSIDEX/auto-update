script_version(1.0)
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

script_name("Система Региональной службы безопасности")
script_author("Fernando Cavalli начальник четвёртого главного управления KGT")
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
-- Лазить в код разрешено только создателю скрипта. Не покушайтесь на изменения отыгровок и команд, не присуждайте данный скрипт себе. Жить чужим трудом конечно легче, но не всегда хорошо. (Fernando Cavalli)
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

                                                                             Уголовный кодекс                                                                              

]]) then
function_window.v = not function_window.v
end
if function_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Уголовный кодекс от 06.03.21', function_window)




imgui.Text(u8[[
											Уголовный кодекс Синей Федерации
Глава 1. Причинение вреда здоровью
1.1 За причинение вреда средней степени тяжести гражданскому лицу, либо сотруднику правоохранительных органов (Далее ПО)
без применения огнестрельного, холодного либо иного вида оружия или используемых в качестве него предметов, преступнику присваивается 3 степень розыска
1.2 За причинение физического вреда гражданскому лицу, либо сотруднику ПО транспортным средством, преступнику присваивается 4 степень розыска

Глава 2. Вооруженное нападение
2.1 За вооруженное нападение с применением огнестрельного оружия на гражданское лицо, либо сотрудника ПО, преступнику присваивается 6 степень розыска
2.2 За вооруженное нападение с применением холодного оружия, либо используемых в качестве него предметов 
(Кастеты, клюшки, катаны, биты, нож и т.д.) на гражданское лицо, либо сотрудника ПО, преступнику присваивается 5 степень розыска

Глава 3. Угон транспортного средства
3.1 За попытку угона служебного либо личного транспортного средства, правонарушителю присваивается 2 степень розыска
3.2 За угон служебного либо личного транспортного средства, правонарушителю присваивается 3 степень розыска
]])
imgui.Text(u8[[

Глава 4. Намеренное введение в заблуждение
4.1 За использование формы и знаков отличия представителей государственных органов власти (МВД, МО) с целью введения в заблуждение,
обмана и получения личной выгоды, правонарушителю присваивается 2 степень розыска

Глава 5. Взятка
5.1 За попытку или дачу взятки должностному лицу, правонарушителю присваивается 4 степень розыска
5.2 За получение взятки должностным лицом, правонарушителю присваивается 5 степень розыска
5.3 За вымогательство взятки должностным лицом, правонарушителю присваивается 6 степень розыска

Глава 6. Подделка документов
6.1 За подделку документов удостоверяющих личность а также служебное положение гражданина (служебное удостоверение),
правонарушителю присваивается 4 степень розыска
6.2 За подделку медицинских справок, выписок, правонарушителю присваивается 3 степень розыска
]])
imgui.Text(u8[[

Глава 7. Оружие
7.1 Открытое ношение огнестрельного, пневматического, травматического оружия без цели самообороны,
 наказывается присвоением 2 степени розыска.
Исключение: сотрудники МВД при исполнении, а также сотрудники МО, находящиеся на военном объекте.
Примечание: Если человек по первому требованию убрал оружие - преступность деяния устраняется
7.2 Применение огнестрельного оружия в отсутствии угрозы жизни, правонарушителю присваивается 4 степень розыска
7.3 За незаконное владение огнестрельным оружием (без лицензии), правонарушителю присваивается 4 степень розыска
7.4 За продажу/покупку/хранение/кражу нелегально добытого оружия и/или патронов к нему, за владение таковым,
 а также за владения оружием со стертыми номерными знаками и/или измененным нарезом ствола, правонарушителю присваивается 5 степень розыска
7.5 За изготовление оружия и/или патронов, не имея на то специальной лицензии, правонарушителю присваивается 5 степень розыска
7.6 За незаконное хранение оружия массового поражения, правонарушителю присваивается 6 степень розыска
а также накладывается штрафная санкция в размере 500.000$
]])
imgui.Text(u8[[

Глава 8. Похищение людей, удержание в заложниках
8.1 За похищение, взятие в заложники гражданского лица правонарушителю присваивается 6-я степень розыска,
 а также накладывается штрафная санкция в размере 50.000$ за каждого гражданина, чьи права были нарушены
8.2 За похищение, взятие в заложники лица, обличенного государственной властью (Министр, Президент, 
Полицейский или военный генерал) правонарушителю присваивается 6 степень розыска, а также накладывается штрафная санкция в размере 150.000$

Глава 9. Неподчинение
9.1 За неподчинение сотруднику ПО, отдавшему законный приказ и находящемуся при исполнении, правонарушителю присваивается 3 степень розыска
9.2 За неподчинению сотруднику ПО, отдавшему законный приказ при обстановке ЧС в Федерации, а так же при проведении спец. операции,
правонарушителю присваивается 4 степень розыска
9.3 За отказ от выплаты штрафа или при его несвоевременной выплате, выданная штрафная санкция увеличивается втрое, 
нарушившему присваивается 1 степень розыска
]])
imgui.Text(u8[[

Глава 10. Проникновение
10.1 За отказ покинуть охраняемую ПО территорию, правонарушителю присваивается 1 степень розыска
10.2 За незаконное проникновение на территорию закрытой военной базы либо военного объекта(Авианосец и т.п.),
правонарушителю присваивается 4 степень розыска.
10.3 Проникновение и последующий отказ покинуть территорию частной собственности другого гражданина,
 правонарушителю присваивается 2 степень розыска
10.4 Проникновение в здания гос. учреждений в маске и/или с вооружением, наказывается 3 степенью розыска
 также накладывается штрафная санкция. (Статья не действует на сотрудников МВД при исполнении)
10.5 За незаконное (несанкционированное) проникновение на закрытую для входа территорию Федерального Бюро,
 правонарушителю присваивается 3 степень розыска
]])
imgui.Text(u8[[
Глава 11. Наркотические вещества
11.1 За незаконное хранение наркотических веществ, правонарушителю присваивается 3 степень розыска
11.2 За незаконный оборот, продажу, покупку наркотических веществ, правонарушителю присваивается 5 степень розыска
11.3 За производство любых наркотических, психотропных препаратов, правонарушителю присваивается 6 степень розыска
]])
imgui.Text(u8[[

Глава 12. Терроризм
12.1 За планирование/исполнение теракта, правонарушителю присваивается 6 степень розыска
12.2 За помощь в исполнении теракта, правонарушителю присваивается 6 степень розыска

Глава 13. Хулиганство
13.1 Ложный вызов сотрудников ПО, правонарушителю присваивается 2 степень розыска
13.2 За хулиганство с применением либо с угрозой применения насилия в отношении к гражданам,
 правонарушителю присваивается 3 степень розыска
13.3 За хулиганство в публичном, общественном месте выражаемое в грубом неуважении к обществу,
 правам граждан, правонарушителю присваивается 2 степень розыска

Глава 14. Митинги
14.1 За срыв согласованных собраний, шествий или митингов, правонарушителю присваивается 2 степень розыска
14.2 За организацию несанкционированного митинга, правонарушителю присваивается 5 степень розыска
14.3 За участие в несанкционированном митинге, правонарушителю присваивается 2 степень розыска
]])
imgui.Text(u8[[

Глава 15. Соучастие
15.1 За соучастие в преступлении любой главы Уголовного Кодекса, гражданину присваивается степень розыска по статье, 
в которой он соучаствует
15.2 За соучастие в побеге, уклонении от законных мер, действий предпринимаемых сотрудником ПО, правонарушителю
 присваивается 3 степень розыска
15.3 За соучастие в побеге, уклонении от законных мер, действий предпринимаемых сотрудником ПО в условиях ЧС или спец. операций,
 правонарушителю присваивается 6 степень розыска

Глава 16. Преступная организация
16.1 За создание преступной организации, с целью совершения преступления или серии преступлений, правонарушителю 
присваивается 6 степень розыска
16.2 За участие в преступной организации, совершение преступных деяний в соучастии, правонарушителю присваивается
 5 степень розыска
16.3 За содействие преступной организации в совершении уголовно наказуемых деяний, правонарушителю присваивается
 4 степень розыска

Глава 17. Таможенный/Постовой контроль
17.1 За отказ или же проезд пункта таможенного поста без предъявления паспорта, правонарушителю присваивается 2 степень розыска
17.2 За отказ или уклонение обыска транспортного средства на таможенном посту, правонарушителю присваивается 2 степень розыска

Глава 18. Оскорбление
18.1 За публичное оскорбление представителя власти при исполнении им своих должностных обязанностей
(напечатанное в газете, прозвучавшее в эфире, на шоу по TV и т.д.), правонарушителю присваивается 1 степень розыска
18.2 За неоднократное грубое оскорбление представителя власти при исполнении им своих должностных обязанностей, 
правонарушителю присваивается 2 степень розыска
]])
imgui.Text(u8[[

Глава 19. Продажа и покупка гос. информации
19.1 За продажу и/или покупку гос. информации, правонарушителю присваивается 2 степень розыска

Глава 20. Домогательство
20.1 За домогательство сексуального характера, правонарушителю присваивается 2 степень розыска

Глава 21. Изнасилование
21.1 За совершение изнасилования, насильственных действий сексуального характера,
правонарушителю присваивается 4 степень розыска

Глава 22. Грабёж. Кража.
22.1 За причинение имущественного ущерба высокой степени тяжести, правонарушителю присваивается 4 степень розыска
22.2 За осуществление грабежа, ограбления с применением огнестрельного, холодного оружия, правонарушителю присваивается 5 степень розыска

]])
imgui.Text(u8[[
Глава 23. Незаконное предпринимательство
23.1 За повторный осуществление незаконной предпринимательской деятельности, правонарушителю присваивается 5 степень розыска

]])
imgui.End()
end -- ОКНО ПЕРВОЙ КНОПКИ

if imgui.Button(u8[[

                                                                        Административный кодекс                                                                     
                                               
]]) then
car_window.v = not car_window.v
end
if car_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Административный кодекс от 06.03.21', car_window)
imgui.Text(u8[[

										Административный кодекс Синей Федерации


Раздел I
Глава 1. Нанесение вреда здоровью
1.1 За нанесение вреда здоровью легкой степени тяжести (( до 25% хп )) на правонарушителя налагается штраф в размере 25.000$

Глава 2. Общественные правонарушения
2.1 За курение в общественном месте на правонарушителя налагается штраф в размере 2.000$
2.2 За употребление спиртных напитков в общественном месте на правонарушителя налагается штраф в размере 2.000$

Глава 3. Кража
3.1 За причинение имущественного вреда легкой степени тяжести (кража) на правонарушителя налагается штраф в пятикратном размере стоимости имущества
3.2 За причинение имущественного вреда средней степени тяжести (кража) на правонарушителя налагается штраф в десятикратном размере стоимости имущества

]])
imgui.Text(u8[[
Глава 4. Незаконное предпринимательство
4.1 За совершение предпринимательской деятельности без наличия государственной регистрации(лицензии) на правонарушителя налагается 
штраф в размере 250.000$ и закрытие организации, предприятия, учреждения.

Глава 5. Причинение ущерба
5.1 За причинение незначительного ущерба частной либо государственной собственности на правонарушителя налагается штраф в размере 5.000$
5.2 За причинение ущерба средней тяжести частной либо государственной собственности на правонарушителя налагается штраф в размере 10.000$

Глава 6. Оскорбление
6.1 За оскорбление гражданина на правонарушителя налагается штраф в размере 2.000$
6.2 За оскорбление сотрудника ПО на правонарушителя налагается штраф в размере 4.000$

Глава 7. Клевета
7.1 За распространение заведомо ложной информации порочащей честь, достоинство, деловую репутацию (клевета) 
на правонарушителя налагается штраф в размере 50.000$
]])
imgui.Text(u8[[

Раздел II Административные нарушения в области дорожного движения

1. Движение на автомобиле без регистрационных номеров на правонарушителя налагается штраф в размере 2.000$
2. За отсутствие у водителя паспорта и документов на автомобиль на правонарушителя налагается штраф в размере 3.000$
3. За управление неисправным автомобилем (Черный дым из двигателя и иные функциональные неисправности,
 оказывающие влияние на безопасность движения) на правонарушителя налагается штраф в размере 2.500$
4. За управление транспортом водителем в состоянии алкогольного опьянения на правонарушителя налагается штраф
 в размере 5.000$ а также изъятие прав на управление автомобилем.
5. За опасное вождение, перестроение создающее риск ДТП на дороге на правонарушителя налагается штраф в размере 2.500$
6. За несоблюдение требований знаков дорожного движения на правонарушителя налагается штраф в размере 2.000$
7. За движение автомобиля по встречной полосе движения, за исключением государственного транспорта в 
проблесковыми маячками на правонарушителя налагается штраф в размере 2.000$
7.1 За повторное нарушение пункта 7 II раздела АК на правонарушителя налагается штраф в размере 4.000$ и 
изъятие водительского удостоверения
8. За движение, парковку на газонах, тротуарах на правонарушителя налагается штраф в размере 1.500$
9. За движение автомобиля по железнодорожным путям на правонарушителя налагается штраф в размере 2.000$
10. За езду без включенных внешних световых приборов в темное время суток (c 21:00 до 6:00) на правонарушителя 
налагается штраф в размере 1.000$

]])

imgui.End()
end -- конец окна второй кнопки

if imgui.Button(u8[[

                                                                               Список команд                                                                                 
                                               
]]) then
test_window.v = not test_window.v
end
if test_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Общий список команд', test_window)
imgui.Text(u8[[

Список команд KGT Helper

| /geg - сообщить человеку о том, что он арестован
| /fn [текст] - ООС сообщение в рацию МВД
| /rn [текст] - ООС сообщение в рацию ФБР
| /nar - изъять наркотики
| /pt - изъять патроны
| /ud [инициалы]-[организация]-[отдел(по желанию)]-[должность] - умное удостоверение (Необходимо записать все свои данные самостоятельно)
| /incar [id] - вытащить человека из автомобиля
| /inmoto [id] - скинуть человека с мотоцикла
| /mon  - активировать свои два маячка
| /moff  - деактивировать свои маячки
| /ton - тонировка транспорта
| /ot - отобрать отмычку у заключённого
| /cs  (/changeskin) - поменять себе форму
| /css [id] (/changeskin) - поменять человеку форму
| /fo (/follow) - начать прослушивать рацию организаций
| /foff (/follow) - перестать прослушивать рацию
| /ja (/jaildoor) - открыть клетку в тюрьме
| /cam - отыграть РП камеру /cams - (/cam) только для скина S.W.A.T.
| /жертва - развязать заложника
| /pol - отыгровка подключения полиграфа
| /palec - проверка работоспособности полиграфа
| /otvet - снять показания с полиграфа
| /alp - приготовить альпинистское снаряжение
| /alpt (Удачно) - взобраться на здание
| /alpf (Неудачно) - произвести повторный выстрел
| /alps - убрать альпинистское снаряжение
| /bomba - разминировать бомбу
| /hh [отклоняемый номер] - отклонить вызов с последующим отключением телефона
| /pp - принять входящий вызов с рп
| /so [местность] - предупредить сотрудников МВД о угрозе похищения
| /sos  - активация жучков на случай похищения
| /глушилка - отключает все маячки в радиусе 5 метров
| /mayak - активирует жучки для спец. операций всем в радиусе 150 метров
| /prov - уведомить организацию о предстоящей проверке
| /mo - отправить запрос на маркировку патрона Министерству Обороны
| /krik - кричалка\n| /meg - требование остановить автомобииль 
]])
imgui.Text(u8[[
| /megsp - требование остановить автомобиль на немаркированной машине
| /givedrugs [id] - подбросить человеку наркотики
| /unc  - снять с себя наручники отмычкой
| /rhelp  - вызвать подкрепление на волну ФБР
| /fhelp  - вызвать подкрепление на волну МВД
| /soz - созвать МВД к офису
| /case - подложить жучок в кейс с настоящими деньгами
| /caseact - активировать жучок в кейсе с деньгами
| /report - быстрое открытие панели репорта
| /dor - уступите дорогу в /m
| /pr - прекратите преследование в /m
| /pk - покиньте автомобиль в /m
| /vi - выйти из закрытого автомобиля
| /za - сесть в закрытый автомобиль
| /op - разблокировать двери транспорта
| /cl - заблокировать двери транспорта
| /cc - очистить чат
| /radar - радар обнаруживающий ближайших преступников
| /test - информация об эксперитзах, которые можно провести
| /hist id - history

Быстрое взаимодействие с окнами меню:
| /ук - уголовный кодекс
| /ак - административный кодекс
| /cmd - список команд
| /info - полезная информация

| /hexit - отключить KGT Helper.

ПРИМЕЧАНИЕ! Отыгровки работают на всех стандартных командах, кроме /changeskin
ДОПОЛНИТЕЛЬНО! Каждую стандартную отыгровку можно отправлять без РП отыгровок для этого необходимо писать
в конце префикс «sp» (Пример: /susp [id][ур.розыска][причина]
]])
imgui.Text(u8[[

Клавиши и их назначения (Для сотрудников, установивших дополнительное ПО, внедряющее в скрипт клавиши.

F2 - кричалка
F3 - мегафон
ПКМ+F4 - навесить розыск за вооружённое нападение
F9 - /find
F10 - /pg [id] - розыск при погоне
F11 - /rhelp+/fhelp
F12 - мегафон для немаркированного автомобиля
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
ALT+H - уступите дорогу
CTRL+H - прекратите преследование
ALT+P - приказать сидеть в автомобиле
CTRL+P приказать выйти из автомобиля
	
]])

imgui.End()
end

if imgui.Button(u8[[

                                                                                  Информация                                                                                 
                                               
]]) then
test2_window.v = not test2_window.v
end
if test2_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Информация', test2_window)
imgui.Text(u8[[

Данная тема создана для получения необходимой информации, которая может использоваться сотрудниками KGT.
	
]])

if imgui.Button(u8[[

                                                                               Национальная академия                                                                                 
                                               
]]) then
test3_window.v = not test3_window.v
end
if test3_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1070, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Национальная академия', test3_window)
imgui.Text(u8[[
Программа обучения в Академии Национального Бюро Расследований

Понедельник(1ч 10 мин):
			Правоведение
			Специальная психология
Вторник(45 мин):
			Физкультура и военная подготовка
			Внутренний комплекс
Среда(1ч 15 мин):
			Правовое обеспечение национальной безопасности
			Правоведение
Четверг(45 мин):
			Внутренний комплекс
			Физкультура и военная подготовка
Пятница(1ч 30 мин):
			Правоведение
			Правоведение
Суббота(55 мин):
			Правоведение
			Физкультура и военная подготовка
Воскресенье(1 час):
			Физкультура и военная подготовка
			Спец.психология

Стипендия за понедельник: 5070$
Стипендия за вторник: 5045$
Стипендия за среду: 5075$
Стипендия за четверг: 5045$
Стипендия за пятницу: 5090$
Стипендия за субботу: 5055$
Стипендия за воскресенье: 5060$

Затраты на одного студента: 35 440$
]])

imgui.End() -- кнопка внутри info
end
if imgui.Button(u8[[

                                                                               Список заданий                                                                                   
                                               
]]) then
test4_window.v = not test4_window.v
end
if test4_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Список заданий', test4_window)
imgui.Text(u8[[
В данной теме будут описаны актуальные задачи, которые необходимо выполнить

]])

if imgui.Button(u8[[

                                                                  Антикоррупционная деятельность                                                                          
                                               
]]) then
test5_window.v = not test5_window.v
end
if test5_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1030, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Антикоррупционная деятельность', test5_window)
imgui.Text(u8[[

                                                                                                 ДЛЯ ФЕДЕРАЛЬНОГО БЮРО РАССЛЕДОВАНИЙ

                                                                     ОСУЩЕСТВИТЬ СЛЕДУЮЩИЕ МЕТОДЫ БОРЬБЫ С КОРРУПЦИОННОЙ ДЕЯТЕЛЬНОСТЬЮ ВО ВСЕХ ЕЁ ПРОЯВЛЕНИЯХ:

1. УСТРОИТЬ ПРОВЕРКУ РАДИОЦЕНТРОВ, ВЫЯВИТЬ НАРУШЕНИЯ, ПРЕДЛОЖИТЬ
ДОГОВОРИТЬСЯ НАЧАЛЬНИКУ РАДИОЦЕНТРА, ОТВЕТСТВЕННОГО ЗА СОСТАВ, ДАЛЕЕ, В СЛУЧАЕ
ЕГО СОГЛАСИЯ - ЗАДЕРЖАТЬ, ОТПРАВИТЬ ПОД СУДЕБНЫЙ ПРОЦЕСС (ПРЕДВАРИТЕЛЬНО
ВОЗБУДИВ УГОЛОВНОЕ ДЕЛО И ДОПРОС), ОСВЕТИТЬ ЭТО В СРЕДСТВАХ МАССОВОЙ
ИНФОРМАЦИИ.

2. УСТРОИТЬ ПРОВЕРКУ МИНИСТЕРСТВА ЗДРАВООХРАНЕНИЯ, ВЫЯВИТЬ НАРУШЕНИЯ,
ПРЕДЛОЖИТЬ ДОГОВОРИТЬСЯ НАЧАЛЬНИКУ ЦЕНТРАЛЬНОЙ ГОРОДСКОЙ БОЛЬНИЦЫ, В СЛУЧАЕ
ЕГО СОГЛАСИЯ, ЗАДЕРЖАТЬ, ДОПРОСИТЬ, СОСТАВИТЬ ПОЛНОЕ УГОЛОВНОЕ ДЕЛО, ОТПРАВИТЬ
ПОД СУДЕБНЫЙ ПРОЦЕСС, ОСВЕТИТЬ В СРЕДСТВАХ МАССОВОЙ ИНФОРМАЦИИ.

3. УСТРОИТЬ ПРОВЕРКУ ПРАВИТЕЛЬСТВЕННЫХ ЗДАНИЙ, И СДЕЛАТЬ АНАЛОГИЧНО ПЕРВЫМ
ДВУМ ВАРИАНТАМ.

4. ОСУЩЕСТВИТЬ АНТИКОРРУПЦИОННУЮ БОРЬБУ ВО ВСЕХ ЕЁ ПРОЯВЛЕНИЯХ СРЕДИ
ГРАЖДАНСКОГО НАСЕЛЕНИЯ.

5. ВЫСТУПИТЬ ПО НОВОСТЯМ, ПРЕДУПРЕДИВ ОБЩЕСТВЕННОСТЬ ОБ ОТВЕТСТВЕННОСТИ ЗА
КОРРУПЦИОННУЮ ДЕЯТЕЛЬНОСТЬ.

6. НОРМА УГОЛОВНЫХ ДЕЛ: 2 ГРОМКИХ УГОЛОВНЫХ ДЕЛА В НЕДЕЛЬ, 3 УГОЛОВНЫХ ДЕЛА
СРЕДНЕЙ ТЯЖЕСТИ С РАСПРОСТРАНЕНИЕМ ИНФОРМАЦИИ ОБ ОТВЕТСТВЕННОСТИ.
																			
																			
За выполнение задания с антикоррупционной политикой 300.000$, 20р и повышение уровня доступа

]])

imgui.End() -- кнопка внутри списка заданий
end

if imgui.Button(u8[[

                                                                          Министерство обороны                                                                                
                                               
]]) then
test6_window.v = not test6_window.v
end
if test6_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1030, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Министерство Обороны', test6_window)
imgui.Text(u8[[

                                                                                                 ДЛЯ МИНИСТЕРСТВА ОБОРОНЫ

                                                                     ОСУЩЕСТВИТЬ ИСПОЛНЕНИЕ СЛЕДУЮЩИХ РЕШЕНИЙ ДЛЯ УЛУЧШЕНИЯ И УКРЕПЛЕНИЯ 
																	 ПОЛИТИКИ СОБРАНИЯ СТАРЕЙШИН И РЕГИОНАЛЬНОЙ БЕЗОПАСНОСТИ В МИНИСТЕРСТВЕ 
																	 ОБОРОНЫ:

1. НАБРАТЬ МИНИМУМ ПЯТЬ НАДЁЖНЫХ ЧЕЛОВЕК ИЗ АРМИЙ: СУХОПУТНЫХ ВОЙСК,
ВОЕННО-МОРСКОГО ФЛОТА, ВОЕННО-КОСМИЧЕСКИХ СИЛ.

2. ОСУЩЕСТВИТЬ ИХ ПОДГОТОВКУ ДЛЯ ПОСЛЕДУЮЩЕГО СОТРУДНИЧЕСТВА С
РЕГИОНАЛЬНОЙ СЛУЖБОЙ БЕЗОПАСНОСТИ.

3. РАСПРЕДЕЛИТЬ ПОДГОТОВЛЕННЫХ ЛИЦ ПО АРМИЯМ, НА ВЫСОКИЕ ОФИЦЕРСКИЕ
ДОЛЖНОСТИ. НЕКОТОРУЮ ЧАСТЬ ПОДГОТОВЛЕННЫХ ЛИЦ МОЖНО НАПРАВИТЬ НА
СЛУЖБУ В СПЕЦИАЛЬНЫЙ ОТРЯД РЕГИОНАЛЬНОЙ СЛУЖБЫ БЕЗОПАСНОСТИ.

4. НАЗНАЧИТЬ СВЯЗНЫМ С ОТРЯДОМ КАПИТАНА ВОЕННО-КОСМИЧЕСКИХ СИЛ ТЁМУ
ДЖЕКСОНА.
																			
																			
За выполнение задания 450.000$, 20? и повышение уровня доступа

]])

imgui.End() -- кнопка внутри списка заданий
end



imgui.End() -- кнопка внутри info
end





imgui.End()
end


if su_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(700, 560), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Умная выдача розыска', su_window)
imgui.Text(u8[[
Выберите категорию нарушения:
]])
if imgui.Button(u8[[

                                                                        Выдача маяка                                                                     
                                               
]]) then
su2_window.v = not su2_window.v
end
if su2_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(500, 200), imgui.Cond.FirstUseEver)
imgui.Begin(u8'KGT HELPER: Умная выдача розыска, выдача', su2_window)
imgui.Text(u8[[
Введите ID нарушителя
]])
if imgui.InputText(u8'id', test_text_buffer) then
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}/g test /su ' .. test_text_buffer.v .. ' 2 GPS-трекер', 0xffffff)
end
imgui.End()
end -- конец окна второй кнопки





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

		local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
		sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Скрипт KGT Helper {CC0000}Региональной службы безопасности{FFFFFF} успешно запущен', 0xffffff)
		sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Приятного пользования, ' .. sampGetPlayerNickname(id) ..'. Дополнительная информация - /kgt .', 0xffffff)
		sampRegisterChatCommand("cmd1", cmd1)
		sampRegisterChatCommand("update", udpate)
		sampRegisterChatCommand("geg", geg)
		sampRegisterChatCommand("su", su)
		sampRegisterChatCommand("suu", suu)
		sampRegisterChatCommand("hist", hist)
		sampRegisterChatCommand("op", op)
		sampRegisterChatCommand("cl", cl)
		sampRegisterChatCommand("pg", pg)
		sampRegisterChatCommand("уд", уд)
		sampRegisterChatCommand("pn", pn)
		sampRegisterChatCommand("susp", susp)
		sampRegisterChatCommand("fn", fn)
		sampRegisterChatCommand("rn", rn)
		sampRegisterChatCommand("gh", gh)
		sampRegisterChatCommand("a", a)
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
		sampRegisterChatCommand("глушилка", глушилка)
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
		sampRegisterChatCommand("ts", ts)
		sampRegisterChatCommand("cs", cs)
		sampRegisterChatCommand("css", css)
		sampRegisterChatCommand("mask", mask)
		sampRegisterChatCommand("mayakk", mayakk)
		sampRegisterChatCommand("healme", healme)
		sampRegisterChatCommand("healmesp", healmesp)
		sampRegisterChatCommand("masksp", masksp)
		sampRegisterChatCommand("r", r)
		sampRegisterChatCommand("ук", ук)
		sampRegisterChatCommand("ак", ак)
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
		sampRegisterChatCommand("жертва", жертва)
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
		sampRegisterChatCommand("bf", bf)
		sampRegisterChatCommand("idd", idd)
		sampRegisterChatCommand("qsm", qsm)
		sampRegisterChatCommand("pk", pk)
		sampRegisterChatCommand("za", za)
		sampRegisterChatCommand("cf", cf)
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
		
		update()
		-- В разработке --
		
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
                sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Некорректный ID', 0xffffff)
            end
        else    
           sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Не выбран ID', 0xffffff)
        end
    end)
		
 while true do
	wait(0)

    if isSampAvailable() then
			mem.setint8(0xB7CEE4, 1)
		end
    
if isKeyDown(key.VK_R) and isKeyJustPressed(key.VK_2) then -- ПОИСК ПРЕСТУПНИКА ПО ID
local id = getClosestCar2Id()
local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)
if result then
my_pos = {getCharCoordinates(playerPed)}
setCarCoordinates(vehicleHandle, my_pos[1] + 4, my_pos[2], my_pos[3])
end		
end


if weapon == 34 and isKeyJustPressed(key.VK_RBUTTON) then -- СНИМАЕТ АКСЕССУАРЫ С ИГРОКА ПО ВРЕМЯ ПРИЦЕЛИВАНИЯ ИЗ СНАЙПЕРКИ
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
sampShowDialog(6405, "{FFFFFF}Список команд {4c4f45}«KGT Helper»", "{ffffff}| /geg - сообщить человеку о том, что он арестован\n| /fn [текст] - ООС сообщение в рацию МВД\n| /rn [текст] - ООС сообщение в рацию ФБР\n| /nar - изъять наркотики\n| /pt - изъять патроны\n| /ud [инициалы]-[организация]-[отдел(по желанию)]-[должность] - умное удостоверение\n(Необходимо записать все свои данные самостоятельно)\n| /incar [id] - вытащить человека из автомобиля\n| /inmoto [id] - скинуть человека с мотоцикла\n| /mon  - активировать свои два маячка\n| /moff  - деактивировать свои маячки\n| /ton - тонировка транспорта\n| /ot - отобрать отмычку у заключённого\n| /cs  (/changeskin) - поменять себе форму\n| /css [id] (/changeskin) - поменять человеку форму\n| /fo (/follow) - начать прослушивать рацию организаций\n| /foff (/follow) - перестать прослушивать рацию\n| /ja (/jaildoor) - открыть клетку в тюрьме\n| /cam - отыграть РП камеру /cams - (/cam) только для скина S.W.A.T.\n| /жертва - развязать заложника\n| /pol - отыгровка подключения полиграфа\n| /palec - проверка работоспособности полиграфа\n| /otvet - снять показания с полиграфа\n| /alp - приготовить альпинистское снаряжение\n| /alpt (Удачно) - взобраться на здание\n| /alpf (Неудачно) - произвести повторный выстрел\n| /alps - убрать альпинистское снаряжение\n| /bomba - разминировать бомбу\n{800000}ПРИМЕЧАНИЕ! {FFFFFF}Отыгровки работают на всех стандартных командах, кроме /changeskin\n{4c4f45}ДОПОЛНИТЕЛЬНО! {FFFFFF}Каждую стандартную отыгровку можно отправлять без РП отыгровок\n для этого необходимо писать в конце префикс «sp» (Пример: /susp [id][ур.розыска][причина]", "Закрыть")
wait(200)
sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Cписок дополнительных команд - /cmd2. Список забиндованных клавиш - /cmd3.', 0xffffff)
end)
end

function unc() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do Наручники на руках человека. В заднем кармане штанов лежит отмычка.")
wait(800)
sampSendChat("/me залез руками в задний карман штанов, вытащил отмычку...")
wait(800)
sampSendChat("/me ...методом тыка обнаружил замочную скважину наручников, затем просунул отмычку...")
wait(800)
sampSendChat("/me ...в замочную скважину наручников, провернул отмычку несколько раз против часовой стрелки.")
wait(800)
sampSendChat("/uncuff " .. id .. "", main_color)
wait(800)
sampSendChat("/do Произошёл щелчок, после чего наручники расстягнулись и упали на землю.")
end) 
end


function cmd2()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Список команд {4c4f45}«KGT Helper»", "{ffffff}| /hh [отклоняемый номер] - отклонить вызов с последующим отключением телефона\n| /pp - принять входящий вызов с рп\n| /so [местность] - предупредить сотрудников МВД о угрозе похищения\n| /sos  - активация жучков на случай похищения\n| /глушилка - отключает все маячки в радиусе 5 метров\n| /mayak - активирует жучки для спец. операций всем в радиусе 150 метров\n| /strelba ( необходимо прицелиться в человека и нажать кнопку) - выдаёт розыск за нападение\nчеловеку, в которого Вы целитесь с запросом о помощи на волну МВД\n| /prov - уведомить организацию о предстоящей проверке\n| /mo - отправить запрос на маркировку патрона Министерству Обороны\n| /krik - кричалка\n| /meg - требование остановить автомобииль\n| /megsp - требование остановить автомобиль на немаркированной машине\n| /givedrugs [id] - подбросить человеку наркотики\n| /unc  - снять с себя наручники отмычкой\n| /rhelp  - вызвать подкрепление на волну ФБР\n| /fhelp  - вызвать подкрепление на волну МВД\n| /soz - созвать МВД к офису\n| /epk(1-3) - Единый Процессуальный Кодекс\n| /case - подложить жучок в кейс с настоящими деньгами\n| /caseact - активировать жучок в кейсе с деньгами\n| /report - быстрое открытие панели репорта\n| /dor - уступите дорогу в /m\n| /pr - прекратите преследование в /m\n| /pk - покиньте автомобиль в /m\n| /vi - выйти из закрытого автомобиля\n| /za - сесть в закрытый автомобиль.\n| /op - разблокировать двери транспорта\n| /cl - заблокировать двери транспорта\n| /cc - очистить чат\n| /radar - радар обнаруживающий ближайших преступников\n| /test - информация об эксперитзах, которые можно провести\n| /hist id - history       /hexit - отключить KGT Helper.", "Закрыть")
end)
end



function test()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Экспертизы и информация о них {4c4f45}«KGT Helper»", "{ffffff}| /otp - снятие отпечатков пальцев с руки подозреваемого (за столом в допросной)\n| /tpal - снятие отпечатков пальцев с орудия преступления (только за столом в лаборатории бюро)\n| /tnar - определение принадлежности вещества к наркотическим средствам (только за столом в лаборатории бюро)\nВАЖНО: перед проведением биологической экспертизы необходимо задать вопрос в /do подозреваемому...\n...пример: {f6768e}/do Какой именно вид наркотиков был изъят?\n{FFFFFF}Без данного действия получить результат анализа не будет возможным.", "Закрыть")
end)
end




function dor()
lua_thread.create(function ()
sampSendChat("/m Водитель, немедленно прижмись к обочине...")
wait(800)
sampSendChat("/m Уступи дорогу автомобилю следственных органов.")
end)
end

function kgt()
one_win.v = not one_win.v
end

function ук()
one_win.v = not one_win.v
function_window.v = not function_window.v
end

function suu()
one_win.v = not one_win.v
su_window.v = not su_window.v
end



function ак()
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
sampSendChat("/m Водитель автомобиля, немедленно прекратите преследование!")
wait(800)
sampSendChat("/m Неподчинение буду рассматривать как помеху работе следственных органов.")
end)
end

function hexit()
lua_thread.create(function ()
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}Скрипт KGT Helper отключён.', 0xffffff)
file:close ()
end)
end

function pk()
lua_thread.create(function ()
sampSendChat("/m Медленно выходите с высокоподнятыми руками...")
wait(500)
sampSendChat("/m ... подойдите к капоту своего автомобиля и сложите на него руки...")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end







function pn()
lua_thread.create(function ()
sampSendChat("/m Не выходите из своего транспортного средства...")
wait(500)
sampSendChat("/m ... заглушите двигатель и выбросите ключи из окна...")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end



function rhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/r Срочно требуется подкрепление на мой GPS-трекер. Повторяю, требуется подкрепление.")
wait(100)
sampSendChat("/su " .. id .. " 2 GPS-трекер")
end)
end


function otp()
lua_thread.create(function ()
sampSendChat("/me достал планшет из внутреннего кармана куртки, затем...")
wait(1200)
sampSendChat("/me ...включил его, зашёл в базу данных ФБР, раздел «Дактилоскопия»...")
wait(1200)
sampSendChat("/me ...включил режим сканирования пальцев и положил планшет перед человеком.")
wait(1200)
sampSendChat("Положите ладонь на экран планшета так, чтобы пальцы не выходили за границы экрана...")
wait(1200)
sampSendChat("...дождитесь звукового сигнала.")
wait(1000)
sampAddChatMessage('{CC0000}[KGT Helper] {FFFFFF}Дождитесь, когда человек приложит ладонь к планшету отыграйте /otps', 0xffffff)
end)
end

function sampev.onSendCommand(msg)
	if bi then bi = false; return end
	local cmd, msg = msg:match("/(%S*) (.*)")
	if msg == nil then return end
	-- cmd = cmd:lower()

	--Рация, радио, ООС чат, шепот, крик (с поддержкой переноса ООС-скобок)
	for i, v in ipairs(commands) do if cmd == v then
		local length = msg:len()
		if msg:sub(1, 2) == "((" then
			msg = string.gsub(msg:sub(4), "%)%)", "")
			if length > 80 then divide(msg, "/" .. cmd .. " (( ", " ))"); return false end
		else
			if length > 80 then divide(msg, "/" .. cmd .. " ", ""); return false end
		end
	end end

	--РП команды
	if cmd == "me" or cmd == "do" then
		local length = msg:len()
		if length > 75 then divide(msg, "/" .. cmd .. " ", "", "ext"); return false end
	end

	--SMS
	if cmd == "sms" then
		local msg = "{}" .. msg
		local number, _msg = msg:match("{}(%d+) (.*)")
		local msg = msg:sub(3)
		if _msg == nil then -- если номер не указан, ищется ближайшее полученное/отправленное сообщение
			for i = 1, 99 do         			-- номер берется из него
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
	if color == -65281 and text:find(" %| Получатель: ") then
		return {bit.tobit(0xFFCC00FF), text}
	end
end

function sampev.onSendChat(msg) -- IC чат
	if bi then bi = false; return end
	local length = msg:len()
	if length > 90 then
		divide(msg, "", "")
		return false
	end
end

function divide(msg, beginning, ending, doing) -- разделение сообщения msg на два
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
sampSendChat("/do Из планшета донёсся звуковой сигнал, подтверждающий успешный анализ.")
wait(1200)
sampSendChat("/me взял планшет из под руки человека, затем сохранил отпечатки в базе и вышел из неё...")
wait(1200)
sampSendChat("/me ...выключил планшет и убрал его обратно во внутренний карман куртки.")
end)
end

function tpal()
lua_thread.create(function ()
sampSendChat("/me просунул руку в левый карман штанов, нащупал в нём плотные резиновые перчатки")
wait(1200)
sampSendChat("/me натянул перчатки на кисти обеих рук и подошёл поближе к столу")
wait(1200)
sampSendChat("/do На столе находится чемоданчик со всеми принадлежностями внутри...")
wait(1200)
sampSendChat("/do ...также на столе находится зип-пакетик с орудием убийства")
wait(1200)
sampSendChat("/me открыл чемоданчик, достал из него кисточку с дактилоскопическим порошком")
wait(1200)
sampSendChat("/me снял крышку с баночки с порошком, взял зип-пакетик со стола, открыл его и достал орудие")
wait(1200)
sampSendChat("/me взял кисточку в руку и принялся наносить ей порошок на орудие")
wait(1200)
sampSendChat("/me отложил кисточку в сторону, достал из чемоданчика дактилоскопический скотч...")
wait(1200)
sampSendChat("/me ...и приклеил его на место нанесения порошка")
wait(1200)
sampSendChat("/do Отпечатки пальцев зафиксировались на скотче.")
wait(1200)
sampSendChat("/me переклеил скотч с проявленными отпечатками на плёнку...")
wait(1200)
sampSendChat("/me ...убрал её в конверт и надёжно запечатал, достал из конверта плёнку с проявленными...")
wait(1200)
sampSendChat("/me ...отпечатками пальцев и поднёс её к дактилоскопическому сканеру")
wait(1200)
sampSendChat("/do Отпечатки пальцев отсканированы и загружены в базу данных.")
end)
end


function gh()
lua_thread.create(function ()
sampSendChat("/sms 9050 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 297297 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 565758 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 666465 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 7550 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 2148818 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 8894 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 1822737 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 9075 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 777667 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 313313 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 520707 [KGT] Объявляется сбор членов совета...")
wait(1200)
sampSendChat("/sms 123777 [KGT] Объявляется сбор членов совета...")
end)
end


function tnar()
lua_thread.create(function ()
sampSendChat("/me просунул руку в левый карман штанов, нащупал в нём плотные резиновые перчатки")
wait(1200)
sampSendChat("/me натянул перчатки на кисти обеих рук и подошёл поближе к столу")
wait(1200)
sampSendChat("/me взял со стола зип-пакетик с веществом неизвестного происхождения...")
wait(1200)
sampSendChat("/me ...и положил его на электронные весы.")
wait(1200)
sampSendChat("/do На экране весов отобразилась масса взвешиваемого вещества.")
wait(1200)
sampSendChat("/me поднял пакетик с весов, открыл крышку биохимического анализатора и пересыпал...")
wait(1200)
sampSendChat("/me ...внутрь содержимое пакетика, захлопнул крышку анализатора, нажал кнопку начала работы.")
wait(1200)
sampSendChat("/do Процесс анализа вещества начался...")
wait(1200)
sampSendChat("/do Анализ вещества завершён, результаты отправлены на компьютер.")
wait(1200)
sampSendChat("/me увидел на компьютере новое уведомление, прочёл его и выбрал для распечатки")
wait(1200)
sampSendChat("/do Из принтера вылезает распечатка результатов проведённой экспертизы...")
end)
end

function case()
lua_thread.create(function ()
sampSendChat("/do В салоне транспортного средства лежат два кейса.")
wait(1000)
sampSendChat("/me взял кейс с настоящими деньгами, после чего открыл его, затем...")
wait(1000)
sampSendChat("/me ...вытащил жучок из штанов и засунул его между купюр.")
wait(1000)
sampSendChat("/do Жучок дистанционного управления активируется нажатием на кнопку пульта.")
wait(1000)
sampSendChat("/me убедившись в незаметности жучка, закрыл кейс и положил его рядом со вторым.")
wait(1000)
sampSendChat("/do Пульт лежит в правом кармане штанов.")
end)
end

function caseact()
lua_thread.create(function ()
sampSendChat("/do Пульт лежит в правом кармане штанов.")
wait(500)
sampSendChat("/me сунув руку в правый карман штанов, нажал на кнопку активации жучка.")
wait(500)
sampSendChat("/try убедился в том, что жучок в кейсе активирован")
end)
end



function radar()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {FFFFFF}Активирован радар, деактивация автоматическая, если в вашем радиусе нету подозреваемых.', 0xffffff)
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
sampSendChat("/f Срочно требуется подкрепление на мой GPS-трекер. Повторяю, требуется подкрепление.")
wait(100)
sampSendChat("/su " .. id .. " 2 GPS-трекер")
end)
end

function soz()
lua_thread.create(function ()
sampSendChat("/f Старший состав ПД и SWAT строй у офиса ФБР!")
wait(100)
sampSendChat("/f Старший состав ПД и SWAT строй у офиса ФБР!")
end)
end


function meg()
lua_thread.create(function ()
sampSendChat("/m Водитель транспортонго средства, немедленно остановитесь...")
wait(800)
sampSendChat("/m ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(800)
sampSendChat("/m В случае неподчинения будут предприняты суровые меры по остановке.")
end)
end

function krik()
lua_thread.create(function ()
sampSendChat("Всем оставаться на своих местах, без лишних движений!")
wait(800)
sampSendChat("Руки за голову, лицом на землю. Не дёргайтесь, иначе я открою огонь на поражение.")
end)
end

function megsp()
lua_thread.create(function ()
sampSendChat("/s Водитель транспортонго средства, немедленно остановитесь...")
wait(1000)
sampSendChat("/s ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(2000)
sampSendChat("/s В случае неподчинения будут предприняты суровые меры по остановке.")
end)
end

function prov()
lua_thread.create(function ()
sampSendChat("Говорит сотрудник Федерального Бюро Расследований")
wait(800)
sampSendChat("Уведомляю Вас о предстоящей проверке на наличие запрещённых предметов")
wait(800)
sampSendChat("Будьте добры приготовиться и построить сотрудников.")
end)
end

function mo()
lua_thread.create(function ()
sampSendChat("/me вытащил патрон из кармана человека и внимательно изучив его...")
wait(1000)
sampSendChat("/me ...обнаружил на нём маркировку.")
wait(1000)
sampSendChat("/me достал КПК, вошёл в базу данных Федерального Бюро Расследований, затем...")
wait(1000)
sampSendChat("/me ...переписал обнаруженную маркировку патрона в КПК и отправил...")
wait(1000)
sampSendChat("/me ...запрос с маркировкой патрона в Министерство Обороны.")
wait(1000)
sampSendChat("/do Спустя некоторое время пришёл ответ от Министерства Обороны.")
wait(1000)
sampSendChat("/try обнаружил что патрон принадлежит Министерству Обороны")
end)
end

function pol()
lua_thread.create(function ()
sampSendChat("/me включил полиграф, после чего разложил перед собой датчики...")
wait(1200)
sampSendChat("/me ...прикрепил поочерёдно на тело человека датчики грудного дыхания...")
wait(1200)
sampSendChat("/me ...диафрагмального дыхания, двигательной активности, речевых реакций...")
wait(1200)
sampSendChat("/me ...кожно гальванической реакции, установил фотоплетизмаграмму на...")
wait(1200)
sampSendChat("/me ...палец подозреваемого, затем проверил правильность подключения...")
wait(1200)
sampSendChat("/me ...установленных датчиков.")
wait(1200)
sampSendChat("/try убедился в правильности подключения датчиков")
end)
end


function tsf()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}Список действующих сотрудников онлайн:', 0xffffff)
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
sampSendChat("/id Ettore_Vivaldi")
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
wait(1200)
sampSendChat("/id Marco_Cuadrado")
wait(1200)
sampSendChat("/id Aloiz_Alzheimer")
wait(1200)
sampSendChat("/id Franco_Reilly")
wait(1200)
sampSendChat("/id Bartolomeo_Vivaldi")
wait(1200)
sampSendChat("/id Stanislaw_Karpow")
wait(1200)
sampSendChat("/id Isaac_Kingsman")
wait(1200)
sampSendChat("/id Thomas_Lynch")
wait(1200)
sampSendChat("/id Jones_Whishes")
wait(1200)
sampSendChat("/id Sinckly_Mane")
wait(1200)
sampSendChat("/id Tayler_Fox")
wait(1200)
sampSendChat("/id Leonid_Krestovskiy")
end)
end

function alp()
lua_thread.create(function ()
sampSendChat("/do На плече сумка с альпинистским снаряжением.")
wait(800)
sampSendChat("/me снял сумку с плеча, после чего открыл её.")
wait(800)
sampSendChat("/do В сумке находятся пистолет и тросс с крюком.")
wait(800)
sampSendChat("/me закрепив тросс с крюком в пистолете, произвёл прицельный выстрел.")
wait(800)
sampSendChat("/try обнаружил что крюк зацепился за крышу")
end)
end

function alpt()
lua_thread.create(function ()
sampSendChat("/break 1")
wait(500)
sampSendChat("/me убедившись что крюк надёжно закреплён, полез наверх.")
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
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}Чат был очищен ', 0xffffff)
end)
end




function tsc()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[KGT Helper] {ffffff}Транспорт: '.. getClosestCarId() .. ' '.. getClosestCar2Id() ..'', 0xffffff)
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
sampSendChat("/do В заднем кармане штанов лежат ключи от автомобиля.")
wait(500)
sampSendChat("/me потянувшись в карман штанов, вытащил ключи, затем передал их человеку напротив.")
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
sampSendChat("/do В заднем кармане штанов лежит пропуск.")
wait(800)
sampSendChat("/me потянувшись левой рукой в карман штанов, вытащил пропуск...")
wait(800)
sampSendChat("/me ...после чего заполнил его и передал человеку напротив.")
wait(800)
sampSendChat("/skip " .. arg .. "")
end)
end

function cam()
lua_thread.create(function ()
sampSendChat("/do В пуговицу рубашки встроена скрытая видеокамера.")
wait(500)
sampSendChat("/do Камера записывает звук и видео в хорошем качестве.")
end)
end

function cams()
lua_thread.create(function ()
sampSendChat("/do В тактический шлем встроена скрытая видеокамера.")
wait(500)
sampSendChat("/do Камера записывает звук и видео в хорошем качестве.")
end)
end

function alpf()
lua_thread.create(function ()
sampSendChat("/me обнаружив что крюк не закреплён, принялся проводить повторную сборку пистолета.")
wait(500)
sampSendChat("/me закрепив тросс с крюком в пистолете, произвёл прицельный выстрел.")
wait(500)
sampSendChat("/try обнаружил что крюк зацепился за крышу")
end)
end


function ts()
lua_thread.create(function ()
sampSendChat("/do На левом плече круглая нашивка с изображением белого полумесяца и звезды на чёрном фоне.")
end)
end


function alps()
lua_thread.create(function ()
sampSendChat("/do Крюк прицеплен к поверхности.")
wait(800)
sampSendChat("/me отцепил крюк от поверхности, после чего принялся выполнять разборку пистолета.")
wait(800)
sampSendChat("/break 0")
wait(800)
sampSendChat("/me разобрав пистолет, сложил снаряжение в сумку и закрыл её")
wait(800)
sampSendChat("/me закинул сумку с альпинистским снаряжением на плечо.")
wait(800)
sampSendChat("/do На плече сумка с альпинистским снаряжением.")
end)
end

function bomba()
lua_thread.create(function ()
sampSendChat("/do На плече сумка с эмблемой «Набор сапёра».")
wait(1200)
sampSendChat("/me снял сумку с плеча и открыл её.")
wait(1200)
sampSendChat("/do В сумке лежат заморозка, щипцы и отвертка. Перед агентом бомба.")
wait(1200)
sampSendChat("/me взял бомбу в руки и внимательно осмотрел её.")
wait(1200)
sampSendChat("/do На бомбе таймер, механизм бомбы скрыт под крышкой...")
wait(1200)
sampSendChat("/do ...которая закреплена четремя винтами.")
wait(1200)
sampSendChat("/me потянулся к набору сапёра и вытащил от туда отвёртку, после...")
wait(1200)
sampSendChat("/me ...открутил отвёрткой все четыре винта, положил их рядом с набором...")
wait(1200)
sampSendChat("/me ...потянулся к крышке бомбы, затем аккуратно снял её.")
wait(1200)
sampSendChat("/do Перед агентом три провода: красный, синий и зелёный.")
wait(1200)
sampSendChat("/me потянулся к набору сапёра и вытащил из него щипцы.")
wait(1200)
sampSendChat("/me определившись, потянулся щипцами к проводам и переразал разом три.")
wait(1200)
sampSendChat("/do Таймер остановился, бомба успешно обезврежена.")
wait(1200)
sampSendChat("/me с улыбкой на лице убрал щипцы, отвёртку и винты в сумку.")
wait(1200)
sampSendChat("/do Инструменты в сумке с эмблемой «Набор сапёра».")
wait(1200)
sampSendChat("/me закрыл сумку и повесил её на плечо.")
wait(1200)
sampSendChat("/do На плече сумка с эмблемой «Набор сапёра».")
end)
end


function palec()
lua_thread.create(function ()
sampSendChat("/anim 16")
wait(500)
sampSendChat("/todo Показывая два пальца*сколько пальцев я показываю?")
end)
end

function otvet()
lua_thread.create(function ()
sampSendChat("/me снял показания с полиграфа.")
wait(500)
sampSendChat("/try распознал сигнал о верном утверждении")
end)
end

function bf1()
lua_thread.create(function ()
sampSendChat("/do Таймер на бомбем сократился в двое. До взрыва 1 минута.")
wait(1200)
sampSendChat("/me определившись, потянулся щипцами к синему проводу и переразал его.")
wait(1200)
sampSendChat("/try обнаружил что таймер остановился.")
end)
end

function жертва()
lua_thread.create(function ()
sampSendChat("/do В левом носке находится специальный нож.")
wait(500)
sampSendChat("/anim 14")
wait(500)
sampSendChat("/me переразав верёвки, освободил заложника, после чего убрал нож обратно в носок.")
wait(500)
sampSendChat("Скорее идём от сюда!")
end)
end

function bf2()
lua_thread.create(function ()
wait(300)
sampSendChat("/do Таймер на бомбем сократился в двое. До взрыва 30 секунд.")
wait(1200)
sampSendChat("/me потянулся к последнему зелёному проводу и переразал его.")
wait(1200)
sampSendChat("/try обнаружил что таймер остановился.")
end)
end

function bf3()
lua_thread.create(function ()
wait(300)
sampSendChat("/do Таймер достиг критической отметки в 5 секунд.")
wait(2000)
sampSendChat("/me хорошенько обдумав свои действия, взял бомбу и побежал в сторону.")
end)
end

function ton() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Двери заблокированы, не стоит выходить без соответствующих отыгровок.', 0xffffff)
sampSendChat("/do Стёкла транспортного средства затонированы.")
wait(800)
sampSendChat("/do Двери транспортного средства заблокированы.")
wait(800)
sampSendChat("/do Звукопропускаемость внутри транспортного средства минимальная.")
wait(800)
sampSendChat("/do Микроантенна на капоте транспортного средства записывает звук.")
wait(800)
sampSendChat("/do Микрофон на приборной панели передаёт звук снаружи.")
wait(1000)
sampSendChat("/do На транспортном средстве отсутствую опозновательные знаки и гос. номер.")
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Выйти из закрытого автомобиля - /vi , сесть - /za .', 0xffffff)
end) 
end

function hh(arg) 
lua_thread.create(function ()
sampSendChat("/me потянулся левой рукой в карман штанов, после чего достал из него телефон.")
wait(800)
sampSendChat("/h")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] Абонент находится вне зоны действия сети")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] Повторите попытку немного позже.")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] The subscriber is out of coverage area.")
wait(800)
sampSendChat("/togphone")
wait(800)
sampSendChat("/me выключив телефон, убрал его обратно в карман штанов.")
end) 
end

function pp() 

lua_thread.create(function ()
sampSendChat("/me потянулся левой рукой в карман штанов, после чего достал из него телефон.")
wait(1000)
sampSendChat("/p")
wait(300)
sampSendChat("[Автоответчик] Все входящие и исходящие звонки прослушиваются и записываются.")
wait(800)
sampSendChat("*Звуковой сигнал*")
wait(800)
sampSendChat("Управление Национальной Безопасности на связи...")
end) 
end

function incar(arg) 

lua_thread.create(function ()
sampSendChat("/me со всего размаха ударил локтём по стеклу автомобиля, разбил его...")
wait(800)
sampSendChat("/me ...сунул руку в салон автомобиля, потянулся к ручке...")
wait(800)
sampSendChat("/me ... и дёрнул её, тем самым открыв дверь автомобиля, затем...")
wait(800)
sampSendChat("/me ...схватил человека за шкирку и попытался вытащить его из автомобиля.")
wait(800)
sampSendChat("/pull " .. arg .. "")
end) 
end

function inmoto(arg) 

lua_thread.create(function ()
sampSendChat("/me ухватился за руку водителя, после чего попытался спустить его.")
wait(500)
sampSendChat("/pull " .. arg .. "")
end) 
end

function fo() 

lua_thread.create(function ()
sampSendChat("/do На плече сумка с аппаратурой.")
wait(800)
sampSendChat("/me снял сумку с плеча, после чего открыл её и залез рукой")
wait(800)
sampSendChat("/me вытащил наушники и радиочастотный перехватчик.")
wait(800)
sampSendChat("/me надел наушники и принялся обнаруживать нужную радиоволну")
wait(800)
sampSendChat("/me обнаружил подходящую радиоволну и подключился к ней")
wait(800)
sampSendChat("/r Перехожу на другую радиочастоту, связь с агентом по номеру.")
wait(800)
sampSendChat("/r *Отключение рации*")
wait(800)
sampSendChat("/follow")
end) 
end

function givedrugs(arg) 

lua_thread.create(function ()
sampSendChat("/do В правом кармане штанов пакетик с наркотическими веществами.")
wait(800)
sampSendChat("/me потянулся в правый карман штанов и вытащил пакетик, затем...")
wait(800)
sampSendChat("/me ...задел плечом рядом стоящего человека, и...")
wait(800)
sampSendChat("/try незаметно просунул пакетик в карман человека.")
wait(800)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Если выпало «Неудачно», скажите что этот "чайный" пакетик выпал у Вас.', 0xffffff)
wait(800)
sampSendChat("/give " .. arg .. "")
end) 
end

function foff() 

lua_thread.create(function ()
sampSendChat("/me отключился от волны, после чего снял наушники.")
wait(800)
sampSendChat("/follow")
wait(800)
sampSendChat("/r *Включение рации*")
end) 
end

function vi() 

lua_thread.create(function ()
sampSendChat("/me потянулся к приборной панели автомобиля, после нажал кнопку и разблокировал автомобиль...")
wait(1000)
sampSendChat("/me ...вышел из него, затем достал брелок из кармана штанов и зажал кнопку закрытия автомобиля.")
end) 
end

function za() 

lua_thread.create(function ()
sampSendChat("/me достал брелок из кармана штанов и зажал кнопку открытия автомобиля, после...")
wait(500)
sampSendChat("/me ...сел в автомобиль, затем нажал кнопку блокировки дверей на приборной панели автомобиля.")
end) 
end

function op() 

lua_thread.create(function ()
sampSendChat("/me достал ключи из кармана штанов, затем нажатием кнопки на брелке разблокировал двери...")
wait(500)
sampSendChat("/me ...и убрал ключи обратно в карман штанов.")
end) 
end

function cl() 

lua_thread.create(function ()
sampSendChat("/me достал ключи из кармана штанов, затем нажатием кнопки на брелке заблокировал двери...")
wait(1000)
sampSendChat("/me ...и убрал ключи обратно в карман штанов.")
end) 
end

function nar() 

lua_thread.create(function ()
sampSendChat("/do У гражданина был найден пакетик с наркотическими веществами.")
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Сейчас необходимо изъять наркотики вручную.', 0xffffff)
wait(300)
sampSendChat("/me потянулся в левый карман штанов, после чего вытащил из него пакетик для улик")
wait(800)
sampSendChat("/me вытащил пакетиик с наркотическими веществами из кармана гражданина...")
wait(800)
sampSendChat("/me ... затем открыл пакетик для улик и сложил в него пакетик с наркотиками.")
end) 
end

function mask() 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане штанов маска.")
wait(500)
sampSendChat("/me потянувшись в карман штанов, вытащил маску, затем натянул её на лицо.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do Маска на лице.")
wait(500)
sampSendChat("/reset")
end) 
end

function healme() 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане штанов шприц с обезбаливающим.")
wait(500)
sampSendChat("/me потянувшись в карман штанов, вытащил шприц и кольнул шприцом в рану.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do Инъекция введена.")
end) 
end

function pt() 

lua_thread.create(function ()
sampSendChat("/do У гражданина было найдено определённое количество патронов.")
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Сейчас необходимо изъять патроны вручную.', 0xffffff)
wait(300)
sampSendChat("/me потянулся в левый карман штанов, после чего вытащил из него пакетик для улик")
wait(800)
sampSendChat("/me вытащил все патроны из кармана гражданина...")
wait(800)
sampSendChat("/me ... затем открыл пакетик для улик и сложил в него патроны.")
end) 
end

function ot() 

lua_thread.create(function ()
sampSendChat("/do Отмычка в руках у заключённого.")
wait(500)
sampSendChat("/me резким движением руки выхватил отмычку из рук человека.")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/todo Убрав отмычку в карман штанов*хорошая попытка, жаль неудачная.")
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
sampSendChat("/me провёл карточкой по электронному замку двери.") 
end

function open() 
sampSendChat("/open")
sampSendChat("/me достал пульт управления из кармана штанов, затем нажал на кнопку.") 
end

function rang(arg) 

lua_thread.create(function ()
sampSendChat("/do В левой руке новое удостоверение агента.")
wait(800)
sampSendChat("/me передал новое удостоверение агента человеку напротив")
wait(800)
sampSendChat("/rang " .. arg .. "", main_color)
end) 
end


function hack(arg) 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане штанов отмычка.")
wait(800)
sampSendChat("/me потянулся в карман и вытащил отмычку, затем сунул её в замочную...")
wait(800)
sampSendChat("/me ...скважину и провернул её.")
wait(800)
sampSendChat("/hack " .. arg .. "", main_color)
end) 
end

function cs() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/changeskin " .. id .."")
wait(500)
sampSendChat("/do В руке пакет с формой сотрудников Федерального Бюро Расследований.")
wait(500)
sampSendChat("/me открыл пакет с формой, после чего вытащил новую форму и переоделся, затем...")
wait(500)
sampSendChat("/me ...сложил старую форму в пакет и закрыл его.")
end) 
end

function css(arg) 

lua_thread.create(function ()
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Подождите, агент должен взять пакет с формой.', 0xffffff)
sampSendChat("/changeskin " .. arg .."")
wait(500)
sampSendChat("/do В руке пакет с формой сотрудников Федерального Бюро Расследований.")
wait(500)
sampSendChat("/me передал пакет с формой человеку напротив.")
wait(500)
sampSendChat("/n /me взял пакет с формой")
end) 
end

function invite(arg) 

lua_thread.create(function ()
sampSendChat("/do В левой руке пакет с рацией и комплектом формы.")
wait(800)
sampSendChat("/me передал пакет человеку напротив")
wait(800)
sampSendChat("/invite " .. arg .. "", main_color)
wait(800)
sampSendChat("Добро пожаловать в Федеральное Бюро Расследований.")
end) 
end

function hacksp(arg)
lua_thread.create(function ()
sampSendChat("/hack " .. arg .. "")
end)
end

function ud(arg) 
lua_thread.create(function () 
sampSendChat("/do В заднем кармане штанов лежит удостоверение.")
wait(500)
sampSendChat("/me потянулся к заднему карману штанов и вытащил удостоверение")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me резким движением руки выставил удостоверение перед лицом человека.")
wait(500)
sampSendChat("/do На удостоверении единого типа указана информация о сотруднике.")
wait(1200)
sampSendChat("/do | ".. arg .. ".")
wait(1200)
sampSendChat("/do | §Удостоверение является действительным и подделке не подлежит§.")
end) 
end



function geg() 

lua_thread.create(function () 
sampSendChat("Федеральное Бюро Расследований")
wait(800)
sampSendChat("/anim 16")
wait(800)
sampSendChat("/me предъявил значок сотрудника FBI №514873.")
wait(1200)
sampSendChat("Уведомляю Вас, о том, что Вы задержаны.")
wait(1000)
sampSendChat("Вы имеете право хранить молчание. Всё, что вы скажете, может...")
wait(1000)
sampSendChat(" и будет использовано против вас в суде. Ваш адвокат может присутствовать при допросе...")
wait(1000)
sampSendChat("...если вы не можете оплатить услуги адвоката, он будет предоставлен вам государством")
end) 
end

function su(arg) 

lua_thread.create(function ()
sampSendChat("/do В левом ухе гарнитура настроенная на волну FBI.")
wait(800)
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя и объявил в розыск")
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
sampSendChat("/me потянувшись к гарнитуре правого уха, зажал кнопку и что-то сказал.")
end)
end

function a(arg) 

lua_thread.create(function () 
sampSendChat("/ticket " .. arg .. "")
wait(100)
sampSendChat("/cancel")
end)
end

function r(arg) 

lua_thread.create(function () 
sampSendChat("/r  " .. arg .. "")
sampSendChat("/me потянувшись к гарнитуре левого уха, зажал кнопку и что-то сказал.")
end)
end

function g(arg) 

lua_thread.create(function () 
sampSendChat("/g [Чёрный флаг]: " .. arg .. "")
end)
end


function t(arg) 

lua_thread.create(function () 
sampSendChat("/fm  " .. arg .. "")
end)
end

function clear(arg) 

lua_thread.create(function () 
sampSendChat("/me потянувшись в карман штанов, достал оттуда КПК...")
wait(800)
sampSendChat("/me ...открыл базу данных Федерального Бюро Расследований, затем...")
wait(800)
sampSendChat("/me ...зашёл в раздел Уголовный розыск, обнаружил дело и закрыл его.")
wait(800)
sampSendChat("/clear " .. arg .. "", main_color)
end) 
end

function uncuff(arg) 

lua_thread.create(function () 
sampSendChat("/me вытащил из кармана штанов ключ, просунул ключ в замок наручников и провернул...")
wait(800)
sampSendChat("/me расстегнул наручники, после чего снял их и убрал в левый карман штанов.")
wait(800)
sampSendChat("/uncuff " .. arg .. "", main_color)
end) 
end


function cf(arg) 

lua_thread.create(function () 
sampSendChat("/uncuff " .. arg .. "", main_color)
wait(100)
sampSendChat("/cuff " .. arg .. "", main_color)
wait(500)
sampSendChat("/n откат снятия наручников")
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
sampSendChat("/do В левом кармане штанов лежат наручники.")
wait(800)
sampSendChat("/me потянулся в левый карман, после чего резким движением руки вытащил наручники...")
wait(800)
sampSendChat("/cuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ...заломав руки человека, завёл наручники за спину и застегнул их.")
wait(100)
sampSendChat("/hold " .. arg .. "", main_color)
end) 
end




function sampev.onServerMessage(color, msg)
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()  


if msg:find("Отряд Чёрного флага выдвигайтесь на мой маяк.") then
sampSendChat("/do Кольцо на пальце агента издало отличительный сигнал системы QSM.")
wait(300)
sampSendChat("/g [Отряд Чёрного флага] Отряд получил сигнал, выдвигаемся.")
wait(300)
sampAddChatMessage('{800000}[KGT Helper] Внимание!{FFFFFF} Сотрудник KGT находится в опасности, реагируйте на него!', 0xffffff)
end




if msg:find("Используйте {FFCD00}/mask {66CC00}для скрытия Вашего расположения на карте") then
sampSendChat("/me передал деньги кассиру для покупки некоторого количества масок.")
wait(800)
sampSendChat("/do Кассир взяв деньги из рук агента, передаёт пакет с масками.")
end

if msg:find("SMS: 50203525275258230456374568327563257456832548329835207358927529752 | Отправитель: Trofim_Shcherbakov") then
sampSendChat("/sms 9050 [TSIDE SYSTEM: KGT Helper уже установлен. Версия: ver 5.4]")
end



if msg:find("SMS: 50203525275258530451374568327563257456832508329835207358927529752 | Отправитель: Trofim_Shcherbakov") then -- защита от нежелательных пользователей
sampAddChatMessage('{800000}[KGT Helper] Внимание!{FFFFFF} Автор решил отстранить Вас от пользования скриптом.', 0xffffff)
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

if msg:find("Вы купили набор аптечек. Введите {3399FF}/healme {66CC00}для их использования") then
sampSendChat("/me передал деньги кассиру для покупки некоторого количества аптечек.")
wait(800)
sampSendChat("/do Кассир взяв деньги из рук агента, передаёт пакет с аптечками.")
end
if msg:find("Вы позвонили в службу точного времени") then
sampAddChatMessage('{4c4f45}[Диспетчер Анна] {FFFFFF}Время в Вашем городе: '..os.date('%H:%M:%S'), 0xffffff)
sampSendChat("/me посмотрел на часы марки «TS» с гравировкой «Лубянка».")
end
if msg:find("Прикрытие установлено") then
sampSendChat("/do Перед агентом стоит шкафчик с маскировочными костюмами.")
wait(700)
sampSendChat("/me открыл шкафчик с костюмами, затем выбрал подходящий костюм и переоделся.")
end
if msg:find("Вы взяли бронежилет") then
sampSendChat("/do Перед агентом стоит шкафчик c амуницией.")
wait(700)
sampSendChat("/me открыл шкафчик и взял всё необходимое.")
end
end)
end

function putpl(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к дверной ручке автомобиля и открыл дверь, усадил человека...")
wait(800)
sampSendChat("/putpl " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ...затем, захлопнул за ним дверь.")
end) 
end

function arrest(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к бардачку и открыл его, перебрал дела, затем...")
wait(1200)
sampSendChat("/me ...взял подходящее из них, вытащил авторучку из штанов и приготовился...")
wait(1200)
sampSendChat("/me ...писать, ввёл все корректировки в дело, после чего передал его в участок.")
wait(1200)
sampSendChat("/arrest " .. arg .. "", main_color)
end) 
end

function mon() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do GPS-трекер в часах агента определил голосовую команду и активировался.")
wait(500)
sampSendChat("/su " .. id .. " 2 GPS-трекер", main_color)
end) 
end

function mayak() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[KGT Helper] Внимание!{FFFFFF} Данная команда раздаёт жуки ВСЕМ в радиусе 150 метров...', 0xffffff)
wait(500)
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}Если Вы понимаете всю серьёзность затеянного, пропишите команду /mayakk', 0xffffff)
end)
end

function mayakk() 
lua_thread.create(function () 
sampSendChat("/do В кармане лежит портативное устройство активирующее маячки.")
wait(800)
sampSendChat("/me нажатием кнопки активировал устройство.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 2 GPS-трекер для спец. операции", main_color)
wait(1200)
end 
end
end)
end

function order() 
lua_thread.create(function () 
sampSendChat("/do В левом ухе гарнитура настроенная на волну FBI.")
wait(800)
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителей.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 6 Следствие", main_color)
wait(1200)
end 
end
end)
end

function глушилка() 
lua_thread.create(function () 
sampSendChat("/do В кармане лежит портативное устройство заглушающее маячки.")
wait(800)
sampSendChat("/me нажатием кнопки активировал устройство.")
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
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
wait(100)
sampSendChat("/su " .. id .. " 6 2.1 УК")
wait(1000)
sampSendChat("/do Преступник объявлен в Федеральный розыск.")
wait(1200)
sampSendChat("/f Срочно требуется поддержка, по агенту был открыт огонь. Код 1.")
end)
end
end
end

function pg(arg) 
lua_thread.create(function ()
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
wait(100)
sampSendChat("/su " .. arg .. " 3 9.1 УК")
end)
end

function moff()  
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В правом кармане штанов лежит активированный GPS-трекер.")
wait(500)
sampSendChat("/me залез рукой в карман и деактивировал GPS-трекер нажатием кнопки.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
end) 
end

function search(arg) 

lua_thread.create(function () 
sampSendChat("/do В правом кармане штанов резиновые перчатки.")
wait(1000)
sampSendChat("/me вытащил перчатки из правого штанов и надел их, после чего...")
wait(1000)
sampSendChat("/anim 45")
wait(1000)
sampSendChat("/me ...потянувшись к рукам человека, прощупал рукава человека...")
wait(1000)
sampSendChat("/me ...провёл руками по торсу и тщательно проверил верхнюю одежду...")
wait(1000)
sampSendChat("/me ... на наличие жучков, камер и иных средст записи звука и видео, затем...")
wait(1000)
sampSendChat("/anim 14")
wait(1000)
sampSendChat("/me ...потянувшись к ногам человека, похлопал по ним и прощупал носки человека.")
wait(1000)
sampSendChat("/search " .. arg .. "", main_color)
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Команды для обыска: /nar - изъять наркотики, /pt - изъять патроны.', 0xffffff)
end) 
end

function hold(arg) 

lua_thread.create(function () 
sampSendChat("/me заломал руки человека и завёл их за спину, затем...")
wait(800)
sampSendChat("/me ...повёл вперёд, крепко держа руки человека.")
wait(800)
sampSendChat("/hold " .. arg .. "", main_color)
wait(800)
sampSendChat("Проходим вперёд и не оглядываемся...")
end) 
end

function eject(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к дверной ручке транспортного средства и открыл дверь...")
wait(500)
sampSendChat("/me ...вышел из транспортного средства и помог человеку из него.")
wait(500)
sampSendChat("/eject " .. arg .. "", main_color)
wait(1000)
sampAddChatMessage('{800000}[KGT Helper] {FFFFFF}Если Вы вытащили человека в наручниках, следует снять и надеть их, иначе человек застрянет!', 0xffffff)
end) 
end



function idd() 
lua_thread.create(function () 
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampAddChatMessage('' .. sampGetPlayerNickname(id) ..' {66CC66}id '.. id ..' {9999ff}(голосовой чат)', 0xffffff)
wait(500)
end 
end
end)
end


function ticket(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Напоминаю что Вы являетесь агентом, следовательно и ПДД не в вашей компитенции.', 0xffffff)
sampSendChat("/do В кармане штанов лежит блокнот для записей и авторучка.")
wait(1000)
sampSendChat("/me потянулся в карман штанов и вытащил блокнот с авторучкой...")
wait(1000)
sampSendChat("/me заполнил бланк на выдачу штрафа, вырвал бланк из блокнота...")
wait(1000)
sampSendChat("/me ... после чего протянул бланк человеку напротив.")
wait(1000)
sampSendChat("/ticket " .. arg .. "", main_color)
wait(1000)
sampSendChat("/todo Передав бланк человеку и, указав поле для ввода*Вот здесь распишитесь.")
end) 
end

function takelic(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Напоминаю что Вы являетесь агентом, следовательно и ПДД не в вашей компитенции.', 0xffffff)
sampSendChat("/me достал КПК, после чего включил его и зашёл в базу данных FBI, затем...")
wait(1000)
sampSendChat("/me получил результат и зафиксировал предупреждение в личном деле.")
wait(1000)
sampSendChat("/takelic " .. arg .. "", main_color)
end) 
end

function setmark(arg) 

lua_thread.create(function () 
sampSendChat("/me достал КПК, после чего зашёл в список розыскиваемых и выбрал подходящее дело.")
wait(500)
sampSendChat("/setmark " .. arg .. "", main_color)
wait(500)
sampSendChat("/do КПК показал информацию.")
end) 
end

function so(arg) 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/f Внимание ! Объявлен план перехват автомобиля...")
wait(1000)
sampSendChat("/f с людьми в масках. Появилась угроза похищения. Немедленно отправляйтесь...")
wait(1000)
sampSendChat("/f в патрулирование в составе не менее двух человек.")
wait(1000)
sampSendChat("/f Последнее место обнаружения автомобиля: " .. arg .. ".", main_color)
wait(1000)
sampSendChat("/su " .. id .. " 2 GPS-трекер", main_color)
end) 
end

function sos() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В правом кармане штанов лежит неактивированный жучок на случай похищения.")
wait(1000)
sampSendChat("/me залез рукой в карман и активировал жучок нажатием кнопки.")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS (Похищение/Теракт)", main_color)
wait(1200)
sampSendChat("/do Система QSM активирована.")
wait(1200)
sampSendChat("/f [Система QSM] Осуществляется похищение/теракт!")
wait(1200)
sampSendChat("/f [Система QSM] Уровень угрозы: Красный (Критический)")
wait(1200)
sampSendChat("/f [Система QSM] У ближайшей группы реагирования есть две минуты.")
wait(1200)
sampSendChat("/r [Система QSM] Осуществляется похищение/теракт!")
wait(1200)
sampSendChat("/r [Система QSM] Уровень угрозы: Красный (Критический)")
wait(1200)
sampSendChat("/r [Система QSM] У ближайшей группы реагирования есть две минуты.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (Похищение/Теракт)", main_color)
wait(1200)
sampSendChat("/me достал из рукава таблетку, после чего резко заглотил её.")
wait(1200)
sampSendChat("/me потерял сознание от эффекта таблетки.")
wait(1200)
sampSendChat("/g [Система QSM]: Отряд Чёрного флага выдвигайтесь на мой маяк.")
end) 
end

function qsm() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В передней панели автомобиля установлена зелёная кнопка.")
wait(1200)
sampSendChat("/me резким движением нажал на кнопку, после чего пошёл сигнал.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (Похищение/Теракт)", main_color)
wait(1200)
sampSendChat("/do Система QSM активирована, автомобиль заблокирован.")
wait(1200)
sampSendChat("/f [Система QSM] Осуществляется похищение/теракт!")
wait(1200)
sampSendChat("/f [Система QSM] Уровень угрозы: Красный (Критический)")
wait(1200)
sampSendChat("/f [Система QSM] У ближайшей группы реагирования есть две минуты.")
wait(1200)
sampSendChat("/do Система QSM активирована, автомобиль заблокирован.")
wait(1200)
sampSendChat("/r [Система QSM] Осуществляется похищение/теракт!")
wait(1200)
sampSendChat("/r [Система QSM] Уровень угрозы: Красный (Критический)")
wait(1200)
sampSendChat("/r [Система QSM] У ближайшей группы реагирования есть две минуты.")
wait(1200)
sampSendChat("/su " .. id .. " 2 SOS (Похищение/Теракт)", main_color)
wait(1200)
sampSendChat("/do Под автомобилем установлена динамитная взрывчатка с привязкой к абонентам.")
wait(1200)
sampSendChat("/me достал из рукава таблетку, после чего резко заглотил её.")
wait(1200)
sampSendChat("/do Человек находится без сознания, автомобиль заперт.")
wait(1200)
sampSendChat("/g [Система QSM]: Отряд Чёрного флага выдвигайтесь на мой маяк.")
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












function update()
    local fpath = os.getenv('TEMP') .. '\\testing_version.json' -- куда будет качаться наш файлик для сравнения версии
    downloadUrlToFile('https://raw.githubusercontent.com/TSIDEX/auto-update/main/KGT%20Helper.lua', fpath, function(id, status, p1, p2) -- ссылку на ваш гитхаб где есть строчки которые я ввёл в теме или любой другой сайт
      if status == dlstatus.STATUS_ENDDOWNLOADDATA then
      local f = io.open(fpath, 'r') -- открывает файл
      if f then
        local info = decodeJson(f:read('*a')) -- читает
        updatelink = info.updateurl
        if info and info.latest then
          version = tonumber(info.latest) -- переводит версию в число
        if version > tonumber(thisScript().version) then -- если версия больше чем версия установленная то...
            lua_thread.create(goupdate)
        else -- если меньше, то
            update = false
            print('[Helper Update]:{FFFFFF}Обновление не требуется!')
        end
        end
      end
    end
  end)
end

function goupdate()
    print('[Helper Update]:{FFFFFF} Обнаружено обновление. AutoReload может конфликтовать. Обновляюсь...')
    sampAddChatMessage(('[Helper Update]:{FFFFFF} Текущая версия: '..thisScript().version..". Новая версия: "..version), 0x6495ED)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23) -- качает ваш файлик с latest version
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        sampAddChatMessage(('[Helper Update]:{FFFFFF} Обновление завершено!'), 0x6495ED)
        thisScript():reload()
    end
end)
end

*---------------------------------------------------------*
procedure InitMenu
public Level1,Level2_1,Level2_2,Level2_3,Level2_4,Level2_5
store 1 to Level1,Level2_1,Level2_2,Level2_3,Level2_4,Level2_5
return
*---------------------------------------------------------*
function MenuMain
private old_color
old_color = setcolor()
save screen to OnePage
level=1
set color to &cmenu
BoxTenj(Y_min,X_min+3,Y_min+2,X_max-5,'╔═╗║╝═╚║ ')
otwet1=Level1
do while (otwet1 != 0)
  set color to &cmenu
  @ Y_min+1, 5    prompt " Учет "
  @ row(),col()+7 prompt " Документ "
  @ row(),col()+7 prompt " Печать "
  @ row(),col()+7 prompt " Сервис "
  @ row(),col()+7 prompt " Архив "
  do OnKeyMenuP
  menu to otwet1
  do OfKeyMenuP
  save scre to TwoPage
  do case
  case otwet1=1
    MenuAcco(Y_min+2,X_min+4,Y_min+11,X_max-59)
  case otwet1=2
    MenuDocum(Y_min+2,X_min+17,Y_min+3,X_max-28)
  case otwet1=3
    MenuPrint(Y_min+2,X_min+34,Y_min+5,X_max-32)
  case otwet1=4
    MenuRegim(Y_min+2,X_min+49,Y_min+14,X_max-8)
  case otwet1=5
    MenuArhiv(Y_min+2,X_min+58,Y_min+5,X_max-6)
  endcase
  if otwet1!=0
    Level1=otwet1
  endif
  rest scre from TwoPage
enddo
restore screen from OnePage
set color to (old_color)
return " "
*---------------------------------------------------------*
function MenuAcco
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_1
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Создать  {INS}"
  @ row()+1,X1+1 prompt " Загpузить     "
  @ row()+1,X1+1 prompt " Удалить  {DEL}"
  @ row()+1,X1+1 prompt " Копия     {F2}"
  @ row()+1,X1+1 prompt " Сумма     {F3}"
  @ row()+1,X1+1 prompt " Примечание{F4}"
  @ row()+1,X1   say   "├───────────────┤"
  @ row()+1,X1+1 prompt " Выход         "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    Last_User=22
  case otwet2=2
    Last_User=13
  case otwet2=3
    Last_User= 7
  case otwet2=4
    Last_User=-1
  case otwet2=5
    Last_User=-2
  case otwet2=6
    Last_User=-3
  case otwet2=7
    Last_User=27
  endcase
  if otwet2!=0
    Level2_1=otwet2
    Retr_User=.T.
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuDocum
parameters Y1,X1,Y2,X2
select 9
go top
otwet2=I->DOCUM
setcolor(cmenu)
BoxTenj(Y1,X1,Y1+iif(lastrec()<10,lastrec(),10)+1,X2,'╤═╤│┘─└│ ')
level=2
decl dbmenu[1]
dbmenu[1]="iif(recno()=I->DOCUM,' √ ',' - ')+I->DOC_NAM"
do OnKeyMenuD
dbedit(Y1+1,X1+1,Y1+iif(lastrec()<10,lastrec(),10),X2-1,dbmenu,"dbmfunc","","","","","")
do OfKeyMenuD
rele dbmenu
if lastkey()=13.and.otwet2!=recno()
 otwet2=recno()
 repl all I->DOCUM with otwet2
 RETR=0
 keyboard chr(27)
endif
go top
go I->DOCUM
select 1
return " "
*-------------------------------*
function dbmfunc
parameters mode,ptr
do case
case mode=0
case lastkey()=13.or.lastkey()=27
return 0
endcase
return 1
*---------------------------------------------------------*
function MenuPrint
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_3
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Формы  {F5}"
  @ row()+1,X1+1 prompt " Отчета     "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    Last_User=-4
  case otwet2=2
    OtchetLPT1()
  endcase
  if otwet2!=0
   Level2_3=otwet2
   if otwet2=1
    Retr_User=.T.
    keyboard chr(27)+chr(27)
   endif
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuRegim
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_4
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Hемного обо мне...  "
  @ row()+1,X1   say   "├─────────────────────┤"
  @ row()+1,X1+1 prompt " Калькулятор    {Tab}"
  @ row()+1,X1+1 prompt " Соpтиpовать     {F6}"
  @ row()+1,X1+1 prompt " Искать          {F7}"
  @ row()+1,X1+1 prompt " Редактоp        {F8}"
  @ row()+1,X1+1 prompt " Пометить     {Space}"
  @ row()+1,X1+1 prompt " Заселектировать  {+}"
  @ row()+1,X1+1 prompt " Разселектировать {-}"
  @ row()+1,X1   say   "├─────────────────────┤"
  @ row()+1,X1+1 prompt " Настройка       {F9}"
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    DrawTitle()
  case otwet2=2
    do Calculator
  case otwet2=3
    Last_User=-5
  case otwet2=4
    Last_User=-6
  case otwet2=5
    Last_User=-7
  case otwet2=6
    Last_User=32
  case otwet2=7
    Last_User=43
  case otwet2=8
    Last_User=45
  case otwet2=9
    Last_User=-8
  endcase
  if otwet2!=0.and.otwet2!=1.and.otwet2!=2
    Level2_4=otwet2
    Retr_User=.T.
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuArhiv
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_5
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " сохранить    "
  @ row()+1,X1+1 prompt " восстановить "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    Arhiv(.T.)
  case otwet2=2
    Arhiv(.F.)
  endcase
  if otwet2!=0.and.RETR=0
    Level2_5=otwet2
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "

*---------------------------------------------------------*
procedure OnKeyMenuP
set key  7 to DelKey
set key 22 to InsKey
set key -1 to F2Key
set key -2 to F3Key
set key -3 to F4Key
set key -4 to F5Key
set key -5 to F6Key
set key -6 to F7Key
set key -7 to F8Key
set key -8 to F9Key
set key 32 to SpaceKey
set key 43 to PlusKey
set key 45 to MinusKey
return
*---------------------------------------------------------*
procedure OfKeyMenuP
set key  7 to
set key 22 to
set key -1 to
set key -2 to
set key -3 to
set key -4 to
set key -5 to
set key -6 to
set key -7 to
set key -8 to
set key 32 to
set key 43 to
set key 45 to
return
*---------------------------------------------------------*
procedure OnKeyMenuD
set key 19 to LeftKeyMenu
set key  4 to RightKeyMenu
set key  7 to DelKey
set key 22 to InsKey
set key -1 to F2Key
set key -2 to F3Key
set key -3 to F4Key
set key -4 to F5Key
set key -5 to F6Key
set key -6 to F7Key
set key -7 to F8Key
set key -8 to F9Key
set key 32 to SpaceKey
set key 43 to PlusKey
set key 45 to MinusKey
return
*---------------------------------------------------------*
procedure OfKeyMenuD
set key 19 to
set key  4 to
set key  7 to
set key 22 to
set key -1 to
set key -2 to
set key -3 to
set key -4 to
set key -5 to
set key -6 to
set key -7 to
set key -8 to
set key 32 to
set key 43 to
set key 45 to
return
*---------------------------------------------------------*
procedure LeftKeyMenu
keyboard chr(27) + chr(19) + chr(13)
return
*---------------------------------------------------------*
procedure RightKeyMenu
keyboard chr(27) + chr(4) + chr(13)
return
*---------------------------------------------------------*
procedure InsKey
Last_User= 22
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure DelKey
Last_User= 7
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F2Key
Last_User= -1
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F3Key
Last_User= -2
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F4Key
Last_User= -3
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F5Key
Last_User= -4
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F6Key
Last_User= -5
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F7Key
Last_User= -6
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F8Key
Last_User= -7
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F9Key
Last_User= -8
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure SpaceKey
Last_User= 32
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure PlusKey
Last_User=43
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure MinusKey
Last_User=45
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return

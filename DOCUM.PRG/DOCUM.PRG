*----------------------------------------Конюхов Д.Л.-----*
*                     Б А Л А H С                         *
*---------------------------------------------------------*
*=========================================================*
*                     CLIPPER  2.0                        *
*=========================================================*
external snum,dnum,nsub,formula
*---------------------------------------------------------*
parameters param1
if type("param1") <> "C"
  param1 = ""
endif
************************
***InitTest()
************************
OpenMouse()
InitSets()
InitVars()
InitColor(param1)
InitFormul()
InitCalc()
InitMenu()
OpenConfig(upper(param1)="/A")
****************************************************
*name_firm = __pinit(direxe()+'DOCUM.',__panti())
****************************************************
len_edil=X_max+1
PrgExit=.T.
do while PrgExit
 MsgWrite("Ждите... Загpужаю...")
 file_name=alltrim(I->DOC_DOC)
 name_str=file_name+'.STR'
 name_dbf=file_name+'.DBF'
 name_pic=memoread(file_name+'.DC')
 cnt_line=MLCOUNT(name_pic,len_edil)
 decl line_pic[cnt_line]
 for i=1 to cnt_line
  line_pic[i] = memoline(name_pic,len_edil,i)
 next
 OpenDBF()
 DrawDocum()
 setcolor(c)
 cnt_fields=fcount()
 decl jour_jou[cnt_fields]
 afields(jour_jou)
 for i=cnt_fields to 2 step -1
  jour_jou[i]=jour_jou[i-1]
 next
 jour_jou[1]="iif(delete(),chr(16),' ')"
 Last_User=0
 dbedit(Y_min+1,X_min+1,Y_max-1,X_max-1,jour_jou,"JourFunc","","",""," ")
 CloseDBF()
 rele jour_jou
 rele line_pic
 if Last_User=-8
  Tune()
 endif
enddo
ClosConfig()
set color to w/n
clear
set cursor On
CloseMouse()
Quit

*---------------------------------------------------------*
function JourFunc
parameters mode,fld_ptr
cur_row=row()
RETR=1
Retr_User=.T.
Last_User=0
do while Retr_User
Retr_User=.F.
do case
case mode = 0
  @ Y_max, 2 say '██████████████'
  if mark != 0
    setcolor(cl)
    @ Y_max, 2 say "Помечено "+ltrim(str(Mark))
    setcolor(c)
  endif
case mode = 3
case mode = 4
do case
case (Last_User = 32).or.(lastkey() = 32)       && SPACE
  if delete()
    recall
    Mark=Mark-1
  else
    delete
    Mark=Mark+1
  endif
  RETR=2
case (Last_User = 22).or.(lastkey() = 22)       && INS
  if Fragen(' С О З Д А Т Ь ','Hовый документ?')
   append blank
   edil(line_pic,cnt_line)
   RETR=2
  endif
case (Last_User = 13).or.(lastkey() = 13)       && Enter
  edil(line_pic,cnt_line)
  RETR=2
case (Last_User =  7).or.(lastkey()=   7)       && DEL
  save screen
  if Yes_Or_No(' У Д А Л И Т Ь ','Д о к у м е н т ?',2)
   MsgWrite("Ждите... Удаляю...")
   if Mark=0
    delete
   else
    Mark=0
   endif
   pack
   go top
   RETR=2
  endif
  restore screen
case (Last_User = -1).or.(lastkey() = -1)       && F2
  if Fragen('','Сделать копию документа?')
   MsgWrite('Делаю копию документа...')
   decl afield[cnt_fields]
   for i=2 to cnt_fields
    fld=jour_jou[i]
    afield[i]=&fld
   next
   append blank
   for i=2 to cnt_fields
    fld=jour_jou[i]
    repl &fld with afield[i]
   next
   rele afield
   RETR=2
  endif
case (Last_User = -2).or.(lastkey() = -2)       && F3
  Summa(fld_ptr)
case (Last_User = -3).or.(lastkey() = -3)       && F4
  set cursor on
  @ Y_max-1, X_min+1 get NOTES
  read
  set cursor off
case (Last_User = -4).or.(lastkey() = -4)       && F5
  DocumLPT1()
case (Last_User = -5).or.(lastkey() = -5)       && F6
  SortDocum(fld_ptr)
case (Last_User = -6).or.(lastkey() = -6)       && F7
  FindDocum(fld_ptr,Y_srm-2,X_srm-30,Y_srm+2,X_srm+30)
case (Last_User = -7).or.(lastkey() = -7)       && F8
  txtedit("*.txt")
case (Last_User = -8).or.(lastkey() = -8)       && F9
  Last_User = -8
  RETR=0
case (Last_User = -9).or.(lastkey() = -9)       && F10
  MenuMain()
case (Last_User = 45).or.(lastkey() = 45)       && -
  SeleRec(.F.,fld_ptr,Y_srm-3,X_srm-30,Y_srm+3,X_srm+30)
case (Last_User = 43).or.(lastkey() = 43)       && +
  SeleRec(.T.,fld_ptr,Y_srm-3,X_srm-30,Y_srm+3,X_srm+30)
case (Last_User = 27).or.(lastkey() = 27)       && ESC
  if Fragen(' В Ы Х О Д ','Завершить работу с программой?')
    PrgExit=.F.
    RETR=0
  endif
endcase
endcase
enddo
return RETR
*---------------------------------------------------------*
procedure OpenConfig
parameters is_A
select 9
use docum.dc             && список документов
if is_A
 repl all I->DOCUM with 1
 go top
endif
go I->DOCUM
return
*---------------------------------------------------------*
procedure OpenDBF
select 1
if .not.file(name_dbf)
 creat &name_dbf from &name_str
else
 use &name_dbf
endif
return
*---------------------------------------------------------*
procedure DrawDocum
setcolor(c)
DrawBox(Y_min,X_min,Y_max,X_max,ibox)
setcolor(cl)
MSG=alltrim(I->DOC_NAM)
@ Y_min,int(X_srm-len(MSG)/2) say MSG
@ Y_max,X_max-16 say '║ F10-М Е Н Ю ║'
DrawDate()
return
*---------------------------------------------------------*
procedure DrawDate
setcolor(c)
@ Y_min,X_max-15 say replicate("█",15)
setcolor(cl)
MSG=alltrim(Month[month(date())])+" "+str(year(date()),4)+"г."
@ Y_min,X_max-15 say MSG
return
*---------------------------------------------------------*
procedure ClosConfig
select 9
use
return
*---------------------------------------------------------*
procedure CloseDBF
MarkRecall()
select 1
use
return
*---------------------------------------------------------*
procedure MarkRecall
if Mark # 0
  save screen
  MsgWrite('Удаляю метки...')
  recall for delete()
  Mark = 0
  restore screen
endif
return

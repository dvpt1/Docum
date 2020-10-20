*---------------------------------------------------------*
procedure Summa
parameters fld_ptr
private Nz,summ,var_fld
save screen to InpPage
MsgWrite("Суммирую...")
var_fld=jour_jou[fld_ptr]
if Mark!=0
 summ=0
 Nz=recno()
 go top
 do while .not.eof()
  if delete()
   summ=summ+varnum(&var_fld)
  endif
  skip
 enddo
 go Nz
else
 summ=varnum(&var_fld)
endif
MsgWrite(' ИТОГО: '+ltrim(str(summ)))
inkey(0)
rest screen from InpPage
return
*---------------------------------------------------------*
procedure SortDocum
parameters fld_ptr
if fld_ptr=1
  return
endif
if .not.Fragen('','Соpтиpовать?')
  return
endif
save screen
MsgWrite("Сортирую...")
var_fld=jour_jou[fld_ptr]
sort on &var_fld to temp.dbf
CloseDBF()
copy file temp.dbf to &name_dbf
dele file temp.dbf
OpenDBF()
rest screen
RETR=0
return
*---------------------------------------------------------*
procedure FindDocum
parameters fld_ptr,Y1,X1,Y2,X2
if fld_ptr=1
  return
endif
private var_find,var_fld,otwet
private old_color
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' И С К А Т Ь '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cfr
var_fld=jour_jou[fld_ptr]
var_find=nulvar(&var_fld)
set cursor on
@ Y1+2,X1+2 get var_find
read
set cursor off
if lastkey() != 27
  MsgWrite("Сейчас поищем...")
  Nz=recno()
  locate for var_find=&var_fld
  if found()
    RETR=2
  else
    ??chr(7)
    WarnWrite("Поиск не удачен...")
    go Nz
  endif
endif
restore screen from InpPage
set color to &old_color
return
*---------------------------------------------------------*
procedure SeleRec
parameters log,fld_ptr,Y1,X1,Y2,X2
if fld_ptr = 1
  WarnWrite("По полю метки селектирование не осуществляется...")
  RETR=1
  return
endif
private var_sele1,var_sele2,var_fld,var_num,otwet
private old_color
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
if log
  MSG=' З А С Е Л Е К Т И Р О В А Т Ь '
else
  MSG=' Р А З С Е Л Е К Т И Р О В А Т Ь '
endif
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cfr
var_fld=jour_jou[fld_ptr]
var_sele1=nulvar(&var_fld)
var_sele2=var_sele1
set cursor on
@ Y1+2,X1+2 say " с "
@ row(),col() get var_sele1
@ Y1+4,X1+2 say "по "
@ row(),col() get var_sele2
read
set cursor off
if lastkey() != 27
  if log
    MsgWrite("Сейчас заселектируем...")
  else
    MsgWrite("Сейчас разселектируем...")
  endif
  Nz=recno()
  go top
  var_fld=jour_jou[fld_ptr]
  if empty(var_sele2)
    var_sele2=var_sele1
  endif
  if log
    if type("var_sele1")="L"
      do while .not.eof()
        if iif(var_sele1,&var_fld.,.not.&var_fld)
          if .not.delete()
            delete
            Mark=Mark+1
          endif
        endif
        skip
      enddo
    else
      do while .not.eof()
        if &var_fld.>=var_sele1.and.&var_fld.<=var_sele2
          if .not.delete()
            delete
            Mark=Mark+1
          endif
        endif
        skip
      enddo
    endif
  else
    if type("var_sele1")="L"
      do while .not.eof()
        if iif(var_sele1,&var_fld.,.not.&var_fld)
          if delete()
            recall
            Mark=Mark-1
          endif
        endif
        skip
      enddo
    else
      do while .not.eof()
        if &var_fld.>=var_sele1.and.&var_fld.<=var_sele2
          if delete()
            recall
            Mark=Mark-1
          endif
        endif
        skip
      enddo
    endif
  endif
  go Nz
  RETR=2
endif
restore screen from InpPage
set color to &old_color
return
*---------------------------------------------------------*
procedure Arhiv
parameters isarhiv
private disk,src_path,dst_path
disk=diskAB()
if empty(disk)
  return
endif
if .not.Fragen('','Копиpовать?')
  return
endif
MsgWrite("Копиpую... Ждите...")
CloseDBF()
ClosConfig()
new_path=disk+"\DOCUM"
if isarhiv
 mkdir(new_path)
 src_path=getdir()
 dst_path=new_path
else
 src_path=new_path
 dst_path=getdir()
endif
copys("*.dc",src_path,dst_path)
copys("*.dbf",src_path,dst_path)
copys("*.str",src_path,dst_path)
copys("*.prn",src_path,dst_path)
copys("*.txt",src_path,dst_path)
OpenConfig(.F.)
OpenDBF()
RETR=0
return

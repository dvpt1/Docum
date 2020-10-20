*---------------------------------------------------------*
procedure DocumLPT1
private str_prn
if .not.Fragen('','Подготовить документ?')
  return
endif
save scre
MsgWrite("Готовлю документ...")
str_prn=strfrml(name_pic)
rest scre
ed(Y_min,X_min,Y_max,X_max,@str_prn)
return
*---------------------------------------------------------*
procedure OtchetLPT1
private str_file,i,j,i_min,i_max,Nz,NN,var,fld,str_prn
file_nam=alltrim(I->DOC_DOC)
nam_prn=file_nam+'.PRN'
str_file=memoread(nam_prn)
if empty(str_file)
  WarnWrite("Файл отчета не заполнен...")
  return
endif
if .not.QuesPrint()
  return
endif
MsgWrite(msgprn)
declare format_str[3]   && 1-заголовок; 2-текст; 3-окончание
for i=1 to 3
  i_min=at(chr(i),str_file)
  i_max=rat(chr(i),str_file)
  if i_min != i_max.and.i_min != (i_max - 1)
    format_str[i]=substr(str_file,i_min+1,i_max-i_min-1)
  else
    format_str[i]=""
  endif
next
Nz=recno()
if Mark != 0
  go top
endif
is_prn=mprints(strfrml(format_str[1]))
do while (.not.eof()).and.is_prn
 if delete().or.Mark = 0
  is_prn=mprints(strfrml(format_str[2]))
 endif
 if Mark != 0
   skip
 else
   exit
 endif
enddo
if is_prn
 is_prn=mprints(strfrml(format_str[3]))
endif
go Nz
return

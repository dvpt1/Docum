*---------------------------------------------------------*
procedure DrawTitle
private old_color
save scre
old_color=setcolor(ct)
Tenj( 4, 8,22,75)
@  3,6 say '   靈컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캠   '
@  4,6 say ' 郞胱�   ��� "뒑�룒", �.뀴졻�黍�▲薯, 乘.겈エ�稅�．,76-413    �誥拷 '
@  5,6 say ' � 훤�   收�./�젶� 22-73-21, E-mail: koapp@dialup.mplik.ru    훤� � '
@  6,6 say ' �                                                                � '
@  7,6 say ' �                       � � � � � � H �                          � '
@  8,6 say ' �                         궏褻⑨ 01.98                           � '
@  9,6 say ' �                                                                � '
@ 10,6 say ' �                  �™�褻ぎ� 뤲젪� (c) 1993-1998                 � '
@ 11,6 say ' �                                                                � '
@ 12,6 say ' �                        꽟ⓥ黍� 뒶�赤��                         � '
@ 13,6 say ' �                                                                � '
@ 14,6 say ' �                                                                � '
@ 15,6 say ' �               떒璵�㎤ⅸ 췅 將� 칛�즤젹с �∥젮젰�              � '
@ 16,6 say ' � 닾�:         '+substr(name_firm,1,50)+'� '
@ 17,6 say ' � 럓짛��쭬與�: '+substr(name_firm,51,50)+'� '
@ 18,6 say ' �                                                                � '
@ 19,6 say ' � �敲                                                        �敲 � '
@ 20,6 say ' 突胱�                                                        훤胱� '
@ 21,6 say '   聃컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캭   '
ch=inkey(0)
setcolor(old_color)
rest scre
return

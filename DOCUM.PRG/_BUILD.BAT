copy docum.prg docum_b.prg
type menu.prg >> docum_b.prg
type func.prg >> docum_b.prg
type print.prg >> docum_b.prg
type tunes.prg >> docum_b.prg
type title.prg >> docum_b.prg
clipper docum_b -m -q -l
rtlink FI docum_b OUT docum LIB clipper,extend,mcl
del docum_b.*

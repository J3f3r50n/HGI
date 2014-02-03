
select	nvl(S.USERNAME,'Internal') Usuario
	,nvl(S.TERMINAL,'None') Maquina
    ,S.OsUser Usuario_Rede
	,L.SID||','||S.SERIAL# Sid_Serial
	,U1.NAME||'.'||substr(T1.NAME,1,30) Objeto
    ,S.ACTION Acao
    ,s.module Modulo
	,decode(L.LMODE,1,'No Lock',
		2,'Row Share',
		3,'Row Exclusive',
		4,'Share',
		5,'Share Row Exclusive',
		6,'Exclusive',null) Tipo_Lock
	,decode(L.REQUEST,1,'No Lock',
		2,'Row Share',
		3,'Row Exclusive',
		4,'Share',
		5,'Share Row Exclusive',
		6,'Exclusive',null) request
    ,To_Char( Trunc(Sysdate) + L.CTime*( 1/(24*60*60) ), 'hh24:mi:ss' ) Tempo
    ,L.ID1 , L.ID2
from	GV$LOCK L,
	GV$SESSION S,
	SYS.USER$ U1,
	SYS.OBJ$ T1
where	L.SID = S.SID
and	T1.OBJ# = decode(L.ID2,0,L.ID1,L.ID2)
and	U1.USER# = T1.OWNER#
and	S.TYPE != 'BACKGROUND'
order by l.ctime desc,1,2,6

-- alter system kill session '223,4475'


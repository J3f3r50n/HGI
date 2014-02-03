select cd_cen_cir
, cd_sal_cir 
, ds_sal_cir
,(floor(intervalo)||'  '||'Dia(s)'||' '||
floor( ( (x) * 86400 /3600 ) ) ||' '||'Hora(s)'||'  '||
round( mod ( (x) * 86400, 3600  ) / 60 )||' '||'minutos ')periodo
,floor((((intervalo) * 86400/3600 ))) || ':' 
     ||round( mod( (intervalo) * 86400  , 3600  ) / 60  ) 
     || ':'   ||round(mod( mod( (intervalo) * 86400  , 3600 )   , 60 ) ) horas_minutos
,round(((floor((((intervalo) * 86400/3600 )))/720)*100),2)ocupacao
     
from(
select cd_cen_cir
, cd_sal_cir 
, ds_sal_cir
,intervalo
,( intervalo - floor(intervalo))x
from    (

select a.cd_cen_cir
, s.cd_sal_cir 
, s.ds_sal_cir
, sum(a.dt_fim_limpeza-a.dt_realizacao)intervalo

from 
dbamv.aviso_cirurgia a
,dbamv.sal_cir s
,dbamv.cirurgia_aviso c
where 
a.cd_sal_cir=s.cd_sal_cir
and a.cd_aviso_cirurgia=c.cd_aviso_cirurgia(+)
and a.tp_situacao='R'
and a.cd_multi_empresa=1
and s.cd_cen_cir=1
and a.dt_realizacao BETWEEN to_date(#dtinicio#,'dd/mm/yyyy ') 
                    and     to_date(#dtfim#,'dd/mm/yyyy ')
group by a.cd_cen_cir
, s.cd_sal_cir 
, s.ds_sal_cir
)
)
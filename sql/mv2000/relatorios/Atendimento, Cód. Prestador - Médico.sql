select 
a.cd_atendimento Atendimento, 
a.dt_atendimento DataAtendimento, 
a.tp_atendimento Tipo, 
a.cd_prestador CódPrestador,
p.nm_prestador NomePrestador,
p.ds_codigo_conselho Conselho,
a.cd_leito,
u.ds_unid_int Unidade,
l.ds_leito Leito
from 
dbamv.leito l,
dbamv.unid_int u,
dbamv.prestador p,
dbamv.tb_atendime a
where 
p.cd_prestador=a.cd_prestador
and a.cd_prestador=('&COD_PRESTADOR')
and a.cd_leito=l.cd_leito
and l.cd_unid_int=u.cd_unid_int
and trunc(a.dt_atendimento)
between 
to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by 
a.dt_atendimento
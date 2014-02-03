select
m.cd_atendimento Atendimento,
m.cd_pre_med Prescrição,
m.cd_prestador CodPrestador,
p.nm_prestador NomePrestador,
m.nm_usuario Usuário,
m.cd_setor CódSetor,
m.dt_pre_med DataPrescrição,
p.ds_codigo_conselho Conselho,
s.nm_setor Setor
from
dbamv.pre_med m,
dbamv.prestador p,
dbamv.tb_setor s
where
m.cd_prestador=p.cd_prestador
and p.cd_prestador=('&PRESTADOR')
and m.cd_setor=s.cd_setor
--and p.nm_prestador=('&PRESTADOR')
and trunc(m.dt_pre_med)
between 
to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by
p.nm_prestador, m.dt_pre_med, s.cd_setor, m.cd_atendimento
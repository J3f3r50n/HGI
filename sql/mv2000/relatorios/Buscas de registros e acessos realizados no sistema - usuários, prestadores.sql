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
--and p.nm_prestador=('&PRESTADOR')
--and p.nm_usuario=('&USUARIO')
--and p.cd_usuario_conversao_prescric=('&USUARIO')
--and p.nm_usuario_autorizador=('&USUARIO')
and m.cd_setor=s.cd_setor
and trunc(m.dt_pre_med)
between 
to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by
p.nm_prestador, m.dt_pre_med, s.cd_setor, m.cd_atendimento

select * from dbamv.pre_med

SELECT CD_PRESTADOR, NM_PRESTADOR, ds_codigo_conselho FROM DBAMV.PRESTADOR WHERE DS_CODIGO_CONSELHO='135714'

SELECT * 
FROM 
DBASGU.USUARIOS u, DBAMV.PRESTADOR P, dbamv.pre_med m 
WHERE 
U.CD_PRESTADOR=P.CD_PRESTADOR 
AND P.DS_CODIGO_CONSELHO=('&PRESTADOR')
and p.cd_prestador=m.cd_prestador
and trunc(m.dt_pre_med)
between 
to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')

SELECT * 
FROM 
DBASGU.USUARIOS u, DBAMV.PRESTADOR P, dbamv.registro_documento m 
WHERE 
U.CD_PRESTADOR=P.CD_PRESTADOR 
AND P.DS_CODIGO_CONSELHO='135714' 
and u.cd_usuario=m.nm_usuario
and trunc(m.dt_registro)
between 
to_date ('01/02/2013','dd/mm/yyyy')
and to_date ('28/02/2013','dd/mm/yyyy')

select * from dbamv.registro_documento

select * from dbamv.aviso_cirurgia

SELECT * 
--CD_CIRURGIA_AVISO,CD_AVISO_CIRURGIA,CD_CIRURGIA,CD_PRESTADOR,CD_ATI_MED,TP_PAGAMENTO 
FROM DBAMV.PRESTADOR_AVISO v, dbamv.prestador p
WHERE (CD_CIRURGIA_AVISO='74986')
and v.CD_PRESTADOR=P.CD_PRESTADOR 
and v.cd_prestador='2377'

SELECT *
-- CD_CIRURGIA_AVISO,CD_AVISO_CIRURGIA,CD_CIRURGIA,CD_PRESTADOR,CD_ATI_MED,TP_PAGAMENTO
FROM DBAMV.PRESTADOR_AVISO 

-- tp_situacao dt_realizacao

select * from dbamv.mov_prestador 
where cd_prestador='2377' 
and trunc(dt_ini_transf)
between 
to_date ('01/02/2013','dd/mm/yyyy')
and to_date ('28/02/2013','dd/mm/yyyy')

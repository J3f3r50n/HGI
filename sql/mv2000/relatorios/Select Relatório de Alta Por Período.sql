select
a.dt_alta data_alta,
p.cd_paciente Prontuario,
p.nm_paciente Paciente,
p.nr_cns CNS,
'Rua:'||' '||p.ds_endereco||','||' '||'Nº'||p.nr_endereco Endereço,
p.nm_bairro Bairro,
'.'||p.nr_cep CEP ,
c.nm_cidade Cidade
from
dbamv.paciente p,
dbamv.atendime a,
dbamv.leito l,
dbamv.unid_int u,
dbamv.cidade c
where
p.cd_paciente=a.cd_paciente
and p.cd_cidade=c.cd_cidade
and a.cd_leito=l.cd_leito
and l.cd_unid_int=u.cd_unid_int
and a.tp_atendimento='I'
and trunc(a.dt_alta) between to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by data_alta,paciente

select
a.dt_alta Data_Alta,
p.cd_paciente Prontuario,
a.dt_atendimento Internacao,
u.ds_unid_int Unidade,
l.ds_leito Leito,
p.nm_paciente Nome,
p.dt_nascimento Data_Nascimento,
p.nr_identidade RG, 
p.ds_om_identidade Emissor,
p.ds_endereco Endereco, 
p.nr_endereco Numero,
p.nm_bairro Bairro,
p.nr_cep Cep,
c.nm_cidade Cidade,
p.nm_mae Mae
from
dbamv.paciente p,
DBAMV.tb_atendime a,
dbamv.leito l,
dbamv.unid_int u,
dbamv.cidade c
where
a.cd_paciente=p.cd_paciente
and p.cd_cidade=c.cd_cidade
and a.cd_leito=l.cd_leito
and l.cd_unid_int=u.cd_unid_inta
and a.tp_atendimento='I'
and trunc(a.dt_alta) between to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by Data_Alta,Cidade, Nome
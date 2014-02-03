select
u.ds_unid_int Unidade,
a.dt_alta Data_Alta,
a.dt_atendimento Internacao,
p.cd_paciente Prontuario,
--l.ds_leito Leito,
p.nm_paciente Nome,
p.dt_nascimento Data_Nascimento,
p.nm_mae Mae,
--p.nr_identidade RG, 
--p.ds_om_identidade Emissor,
--p.nr_ddd_fone DDD,
p.nr_fone Telefone,
--p.nr_ddd_celular DDDc,
--p.nr_celular Celular,
p.ds_endereco Endereco, 
p.nr_endereco Numero,
p.nm_bairro Bairro,
p.nr_cep Cep,
c.nm_cidade Cidade
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
and l.cd_unid_int=u.cd_unid_int
and a.tp_atendimento='I'
and trunc(a.dt_alta) between to_date ('&INI','dd/mm/yyyy')
and to_date ('&FIN','dd/mm/yyyy')
order by Cidade, Data_Alta, Nome

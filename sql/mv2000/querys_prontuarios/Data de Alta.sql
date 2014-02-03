-- Data de Alta
select tb_atendime.dt_alta 
from dbamv.paciente, dbamv.tb_atendime
where tb_atendime.cd_paciente=paciente.cd_paciente
and tb_atendime.cd_atendimento=&<CD_ATENDIMENTO>
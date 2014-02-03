select
cd_atendimento,dt_atendimento, nm_paciente, dt_nascimento ,nm_mae
from 
dbamv.tb_atendime,
dbamv.paciente
where tb_atendime.cd_paciente=paciente.cd_paciente
and tb_atendime.tp_atendimento='I'
and tb_atendime.cd_atendimento=('&ATENDIMENTO')


DT_RETROATIVA_SAIDA_LAV

select 
paciente.cd_paciente 

from 
dbamv.atendime, dbamv.paciente 

where 
atendime.cd_paciente = paciente.cd_paciente 
and atendime.cd_atendimento = &<CD_ATENDIMENTO>
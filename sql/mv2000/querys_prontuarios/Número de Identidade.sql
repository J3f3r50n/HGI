-- Com nome do Paciente
select 
	paciente.nr_identidade, 
	paciente.nm_paciente 
from 
	dbamv.atendime, 
	dbamv.paciente 
where 
	atendime.cd_paciente = paciente.cd_paciente 
	and atendime.cd_atendimento = '1806109'

-- Apenas o número
select 
	paciente.nr_identidade, 
from 
	dbamv.atendime, 
	dbamv.paciente 
where 
	atendime.cd_paciente = paciente.cd_paciente 
	and atendime.cd_atendimento = '1806109'
	
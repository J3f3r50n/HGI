select to_char(hr_nascimento, 'hh24:mi') from dbamv.recem_nascido where cd_atendimento=&<CD_ATENDIMENTO>

----


select 
hr_nascimento 

from 
recem_nascido, admissao_co, tip_parto

where 
tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co


------


select to_char(hr_nascimento, 'hh24:mi')
from recem_nascido, admissao_co, tip_parto
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and cd_atendimento=&<CD_ATENDIMENTO>
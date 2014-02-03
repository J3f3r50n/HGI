select * 
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &ATENDIMENTO
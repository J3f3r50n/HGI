select * 
from recem_nascido, admissao_co, tip_parto
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
select tip_parto.ds_tip_parto
from dbamv.recem_nascido, dbamv.admissao_co, dbamv.tip_parto
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
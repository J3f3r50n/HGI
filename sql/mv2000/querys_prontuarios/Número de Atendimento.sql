select 
LPAD(cd_atendimento,8,0) 

from 
dbamv.atendime 

where 
atendime.cd_atendimento = &<CD_ATENDIMENTO>


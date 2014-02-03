-- Hora Nascimento: 
select hr_nascimento 
from recem_nascido, admissao_co, tip_parto
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co

-- Hora Nascimento:
select to_char(hr_nascimento, 'hh24:mi') from dbamv.recem_nascido where cd_atendimento=&<CD_ATENDIMENTO>

-- Apgar 1:
select vl_apgar_1minuto
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

-- Apgar 5:
select vl_apgar_5minuto
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

-- Semanas de vida (IG):
select qt_semanas
from recem_nascido, admissao_co, tip_parto, atendime 
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co 
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

-- Peso (RN):
select vl_peso
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

-- Peso:
select vl_peso from dbamv.recem_nascido where 
cd_atendimento=&<CD_ATENDIMENTO>


--Cumprimento/Altura:
select vl_altura 
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>


--Tipo de Parto:
select tip_parto.ds_tip_parto
from dbamv.recem_nascido, dbamv.admissao_co, dbamv.tip_parto
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co

-- Tipo de parto:
select ds_tip_parto 
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

-- Sexo:
select decode(paciente.tp_sexo, 'M', 'Masc', 'F', 'Fem', 'I', 'Indef')
from dbamv.atendime, dbamv.paciente
where atendime.cd_paciente = paciente.cd_paciente
and cd_atendimento =&<CD_ATENDIMENTO>

-- Sexo:
select decode(paciente.tp_sexo, 'M', 'Masculino', 'F', 'Feminino', 'I', 'Indefinido')
from dbamv.atendime, dbamv.paciente
where atendime.cd_paciente = paciente.cd_paciente
and cd_atendimento =&<CD_ATENDIMENTO>

-- Sexo:
select tp_sexo 
from recem_nascido, admissao_co, tip_parto, atendime
where tip_parto.cd_tip_parto = admissao_co.cd_tip_parto
and admissao_co.cd_admissao_co = recem_nascido.cd_admissao_co
and atendime.cd_atendimento = recem_nascido.cd_atendimento
and recem_nascido.cd_atendimento = &<CD_ATENDIMENTO>

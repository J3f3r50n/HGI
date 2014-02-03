-- Data de Nascimento
select paciente.dt_nascimento from dbamv.atendime,dbamv.paciente
 where paciente.cd_paciente = atendime.cd_paciente and atendime.cd_atendimento = &<CD_ATENDIMENTO>

-- Data de Nascimento
select dt_nascimento from dbamv.paciente
 where cd_paciente = (Select cd_paciente
                        from dbamv.atendime
                       where cd_atendimento =&<CD_ATENDIMENTO>)


-- Idade em anos
select fn_idade(paciente.dt_nascimento) 
        from dbamv.atendime,dbamv.paciente
        where paciente.cd_paciente = atendime.cd_paciente and atendime.cd_atendimento = &<CD_ATENDIMENTO>

-- Anos, Meses, Dias
select substr(fn_idade(paciente.dt_nascimento, 'a', current_date),1,7) as anos,
substr(fn_idade(paciente.dt_nascimento, 'm', current_date),1,7) as meses,
substr(fn_idade(paciente.dt_nascimento, 'd', current_date),1,7) as dias
from dbamv.atendime, dbamv.paciente
where paciente.cd_paciente = atendime.cd_paciente and atendime.cd_atendimento = &<CD_ATENDIMENTO>

-- Dias já vividos
select to_char((trunc(current_date) - (paciente.dt_nascimento))) dias_em_idade
from dbamv.atendime, dbamv.paciente
where paciente.cd_paciente = atendime.cd_paciente and atendime.cd_atendimento = &<CD_ATENDIMENTO>
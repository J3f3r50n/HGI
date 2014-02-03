select paciente.dt_nascimento from dbamv.atendime,dbamv.paciente
 where paciente.cd_paciente = atendime.cd_paciente and atendime.cd_atendimento = &<CD_ATENDIMENTO>
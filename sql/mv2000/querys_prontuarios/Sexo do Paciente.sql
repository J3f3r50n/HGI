select decode(paciente.tp_sexo, 'M', 'Masc', 'F', 'Fem', 'I', 'Indef')
  from dbamv.atendime, dbamv.paciente
 where atendime.cd_paciente = paciente.cd_paciente
   and atendime.cd_atendimento =&<CD_ATENDIMENTO>
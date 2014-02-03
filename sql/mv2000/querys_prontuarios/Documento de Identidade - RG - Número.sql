select nr_identidade from dbamv.paciente
 where cd_paciente = (Select cd_paciente
                        from dbamv.atendime
                       where cd_atendimento =&<CD_ATENDIMENTO>)
select nr_ddd_fone, nr_fone from dbamv.paciente
 where cd_paciente = (Select cd_paciente
                        from dbamv.atendime
                       where cd_atendimento =&<CD_ATENDIMENTO>)
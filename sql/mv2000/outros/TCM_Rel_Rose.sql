select
 ped.cd_atendimento
,ate.cd_paciente
,pac.nm_paciente
,pac.ds_endereco || ', ' || pac.nr_endereco endereço
,pac.nm_bairro
,pac.nr_cep
,cidade.nm_cidade
,ped.cd_ped_rx
,iped.cd_exa_rx
,exa.cd_procedimento_sia
,pro.ds_procedimento
fromexa
 dbamv.ped_rx ped
,dbamv.itped_rx iped
,dbamv.exa_rx exa
,dbamv.procedimento_sus pro
,dbamv.atendime ate
,dbamv.paciente pac
,dbamv.cidade cidade
where
    ped.cd_ped_rx = iped.cd_ped_rx   
and iped.cd_exa_rx = exa.cd_exa_rx
and exa.cd_procedimento_sia = pro.cd_procedimento(+)
and ped.cd_atendimento = ate.cd_atendimento
and ate.cd_paciente = pac.cd_paciente
and pac.cd_cidade = cidade.cd_cidade(+)
and ate.cd_multi_empresa = 1
and ate.tp_atendimento = 'E'
and ped.dt_pedido between '01-ago-2013' and '06-ago-2013'

union all

select
 ped.cd_atendimento
,ate.cd_paciente
,pac.nm_paciente
,pac.ds_endereco || ', ' || pac.nr_endereco endereço
,pac.nm_bairro
,pac.nr_cep
,cidade.nm_cidade
,ped.cd_ped_lab
,iped.cd_exa_lab
,exa.cd_procedimento_sia
,pro.ds_procedimento
from
 dbamv.ped_lab ped
,dbamv.itped_lab iped
,dbamv.exa_lab exa
,dbamv.procedimento_sus pro
,dbamv.atendime ate
,dbamv.paciente pac
,dbamv.cidade cidade
where
    ped.cd_ped_lab = iped.cd_ped_lab   
and iped.cd_exa_lab = exa.cd_exa_lab
and exa.cd_procedimento_sia = pro.cd_procedimento(+)
and ped.cd_atendimento = ate.cd_atendimento
and ate.cd_paciente = pac.cd_paciente
and pac.cd_cidade = cidade.cd_cidade(+)
and ate.cd_multi_empresa = 1
and ate.tp_atendimento = 'E'
and ped.dt_pedido between '01-ago-2013' and '06-ago-2013'
-- Importação de Impostos - Pagamentos
Select PCP.CD_BORDERO
      ,icp.dt_quitacao data_quitacao
      ,icp.dt_vencimento data_vencimento
      ,dpc.conta_reduzida_para conta_banco
      ,dpf.cd_fornecedor_para cod_fornecedor_senior
      ,cp.cd_fornecedor cod_fornecedor_mv
      ,dpf.ds_fornecedor_de nome_fornecedor
      ,icp.vl_soma_pago vl_pagamento
      ,pcp.ds_pagcon_pag historico
  from dbamv.itcon_pag icp
      ,dbamv.pagcon_pag pcp
      ,dbamv.con_cor cc
      ,dbamv.de_para_contabil dpc
      ,dbamv.con_pag cp
      ,dbamv.de_para_fornecedor dpf
      ,dbamv.lote_pgto_itcon_pag lp
 where icp.dt_quitacao between to_date('01/01/2013','dd/mm/yyyy') and to_date
('31/03/2013','dd/mm/yyyy')
   and pcp.cd_itcon_pag = icp.cd_itcon_pag 

   and cp.cd_multi_empresa = COLOCAR AQUI O CODIGO DA MULTI EMPRESA
   and pcp.cd_con_cor = cc.cd_con_cor
   and cc.cd_reduzido = dpc.cd_reduzido_de(+)
   and icp.cd_con_pag = cp.cd_con_pag
   and cp.cd_fornecedor = dpf.cd_fornecedor_de(+)
   and icp.cd_itcon_pag = lp.cd_itcon_pag(+)
order by 1 
select 
	cd_contabil Cod_Contabil, cd_grau_da_conta Grau, cd_reduzido Cod_Reduzido, tp_conta Tipo_Conta, ds_conta Descricao_Conta, ds_financ Financeiro, sn_ativo Ativo
from 
	plano_contas
where 
	cd_multi_empresa = '1'
order by
	cd_contabil


-----

SELECT   cd_reduzido, cd_contabil, ds_conta, cd_multi_empresa

    FROM dbamv.plano_contas

   WHERE cd_multi_empresa = 1

     AND cd_reduzido NOT IN (SELECT cd_reduzido_de

                               FROM dbamv.de_para_contabil

                              WHERE cd_multi_empresa_de = 1)

ORDER BY ds_conta
SELECT  cd_reduzido, cd_contabil, ds_conta
    FROM dbamv.plano_contas
   WHERE cd_multi_empresa = 1
     AND sn_ativo = 'S'
     AND cd_reduzido NOT IN (SELECT cd_reduzido_de
                               FROM dbamv.de_para_contabil
                              WHERE cd_multi_empresa_de = 1)
ORDER BY ds_conta


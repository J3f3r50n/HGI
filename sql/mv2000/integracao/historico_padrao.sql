SELECT *
  FROM historico_padrao
 WHERE cd_historico_padrao IN (SELECT cd_historico_padrao_de
                                 FROM dbamv.de_para_hist_padrao
                                WHERE cd_multi_empresa_de = 1)
   AND ds_historico_padrao NOT LIKE '%INAT%'


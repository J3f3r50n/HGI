SELECT   cd_setor, nm_setor, cd_cen_cus
    FROM setor s
   WHERE s.cd_multi_empresa = 1
     AND s.sn_ativo = 'S'
     AND s.cd_setor NOT IN (SELECT cd_setor_de
                              FROM dbamv.de_para_centro_custo
                             WHERE cd_multi_empresa_de = 1)
ORDER BY nm_setor


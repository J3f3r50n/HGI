SELECT   s.cd_setor, s.nm_setor, s.cd_cen_cus,'' codigo_centro_custo_senior
    FROM dbamv.setor s
   WHERE s.cd_multi_empresa = 1 AND s.sn_ativo = 'S'
ORDER BY 1
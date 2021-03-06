SELECT   f.cd_fornecedor, f.nm_fornecedor
    FROM fornecedor f, ent_pro e, itent_pro it
   WHERE f.cd_fornecedor = e.cd_fornecedor
     AND e.cd_ent_pro = it.cd_ent_pro
     AND f.sn_ativo = 'S'
     AND f.cd_fornecedor NOT IN (SELECT cd_fornecedor_de
                                   FROM dbamv.de_para_fornecedor
                                  WHERE cd_multi_empresa_de = 1)
     AND e.dt_entrada BETWEEN TO_DATE ('31/07/2012', 'dd/mm/yyyy')
                          AND TO_DATE ('04/11/2013', 'dd/mm/yyyy')
GROUP BY f.cd_fornecedor, f.nm_fornecedor
ORDER BY f.nm_fornecedor


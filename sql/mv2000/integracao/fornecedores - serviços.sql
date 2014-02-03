SELECT   f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf
    FROM fornecedor f, ent_serv s
   WHERE f.cd_fornecedor = s.cd_fornecedor
     AND f.sn_ativo = 'S'
     AND f.cd_fornecedor NOT IN (SELECT cd_fornecedor_de
                                   FROM dbamv.de_para_fornecedor
                                  WHERE cd_multi_empresa_de = 1)
     AND s.dt_entrada BETWEEN TO_DATE ('01/01/2012', 'dd/mm/yyyy')
                          AND TO_DATE ('04/11/2013', 'dd/mm/yyyy')
GROUP BY f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf
ORDER BY f.nm_fornecedor

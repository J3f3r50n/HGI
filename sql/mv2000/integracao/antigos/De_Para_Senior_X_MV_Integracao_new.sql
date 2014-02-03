
-- Codigo Reduzido, Senior, Contabil
SELECT   p.cd_reduzido, p.cd_contabil, '' codigo_reduzido_senior,
         '' codigo_contabil_senior
    FROM plano_contas p
   WHERE cd_multi_empresa = 1 AND sn_ativo = 'S'
ORDER BY 1

-- Setor, Centro de Custo
SELECT   s.cd_setor, s.cd_cen_cus, '' codigo_centro_custo_senior
    FROM dbamv.setor s
   WHERE s.cd_multi_empresa = 1 AND s.sn_ativo = 'S'
ORDER BY 1

SELECT   s.cd_setor, s.nm_setor, s.cd_cen_cus,'' codigo_centro_custo_senior
    FROM dbamv.setor s
   WHERE s.cd_multi_empresa = 1 AND s.sn_ativo = 'S'
ORDER BY 1



-- Historico Padrao
SELECT   h.cd_historico_padrao, h.ds_historico_padrao,
         '' codigo_historico_padrao
    FROM dbamv.historico_padrao h
ORDER BY 1

-- Fornecedor
-- SELECT   f.cd_fornecedor, f.nm_fornecedor, '' codigo_fornecedor_senior
--    FROM fornecedor f
--   WHERE f.sn_ativo = 'S'
-- ORDER BY f.nm_fornecedor

-- Fornecedor
SELECT f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf, '' codigo_fornecedor_senior
-- SELECT f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf, f.nr_insc_est, '' codigo_fornecedor_senior
-- SELECT *
    FROM fornecedor f
   WHERE f.sn_ativo = 'S'
ORDER BY f.nm_fornecedor



-- Produtos, Especie, Classe
SELECT   p.cd_produto, p.ds_produto, p.cd_especie, p.cd_classe,
         '' codigo_produto_senior, '' codigo_especie_senior,
         '' codigo_classe_senior
    FROM produto p
ORDER BY p.ds_produto
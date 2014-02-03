SELECT estoque . cd_estoque cd_estoque 
, estoque . ds_estoque ds_estoque 
, especie . cd_especie cd_especie 
, especie . ds_especie ds_especie 
, classe . cd_classe cd_classe 
, classe . ds_classe ds_classe 
, sub_clas . cd_sub_cla cd_sub_cla 
, sub_clas . ds_sub_cla ds_sub_cla 
, produto . cd_produto cd_produto 
, produto . ds_produto ds_produto 
, verif_ds_unid_prod ( produto . cd_produto ) ds_unidade 
, produto . dt_ultima_entrada dt_ultima_entrada 
, produto . qt_ultima_entrada qt_ultima_entrada 
, est_pro . qt_estoque_maximo qt_estoque_maximo 
, est_pro . qt_estoque_minimo qt_estoque_minimo 
, est_pro . qt_ponto_de_pedido qt_ponto_de_pedido 
, est_pro . dt_ultima_movimentacao dt_ultima_movimentacao 
,Round(produto . vl_custo_medio,2) vl_custo_medio
, est_pro . qt_estoque_atual qt_estoque_atual 
FROM dbamv . estoque 
, dbamv . est_pro 
, dbamv . produto 
, dbamv . sub_clas 
, dbamv . classe 
, dbamv . especie    
WHERE estoque.cd_estoque = est_pro.cd_estoque 
AND est_pro.cd_produto = produto.cd_produto 
AND produto.cd_sub_cla = sub_clas.cd_sub_cla 
AND produto.cd_classe = sub_clas.cd_classe 
AND produto.cd_especie = sub_clas.cd_especie 
AND sub_clas.cd_classe = classe.cd_classe 
AND sub_clas.cd_especie = classe.cd_especie 
AND classe.cd_especie = especie.cd_especie 
AND produto.cd_produto = est_pro.cd_produto
AND produto.sn_mestre = 'N' 
AND produto.sn_padronizado = 'S' --- PARAMETRO ITEM PADRONIZADO
AND ESPECIE.CD_ESPECIE = 1
AND estoque.cd_multi_empresa =1
AND (est_pro.dt_ultima_movimentacao >= to_date('01/01/2012','dd/mm/yyyy') OR est_pro.dt_ultima_movimentacao is null )  -- PARAMETRO DE MOVIMENTAÇÃO
AND est_pro.qt_estoque_atual > 0  -- PARAMETRO DE ITEM SEM SALDO
and sub_clas.sn_prod_permanente not in ('P')  -- PARAMETRO DE BEM PATRIMONIAL
ORDER BY 1 ASC,2 ASC,3 ASC,4 ASC,5 ASC,6 ASC,7 ASC,8 ASC

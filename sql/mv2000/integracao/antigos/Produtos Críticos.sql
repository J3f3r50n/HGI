-- Custo Médio, Consumo Médio e Fornecedor
-- 3 Espécies (1, 2, 6, Mat. Med, Medicamentos, Generos Alimenticios);
-- Com os dados de Codigo, Descrição Produto, Unidade de Medida, Custo Médio, Consumo Médio e Fornecedor

SELECT dt_prev_entrega oc_dt_prev_entrega
     , min(cd_ord_com)  oc_cd_ord_com
     , nm_fornecedor oc_nm_fornecedor
     , cd_produto oc_cd_produto
 FROM 
( 
SELECT o.dt_prev_entrega
     , o.cd_ord_com 
     , f.nm_fornecedor
     , i.cd_produto
  FROM DBAMV.ITORD_PRO i
     , DBAMV.ORD_COM   o 
     , dbamv.fornecedor f 
 WHERE i.cd_ord_com = o.cd_ord_com
   AND f.cd_fornecedor = o.cd_fornecedor
   and o.TP_SITUACAO IN ('A','U','L')
   AND NOT EXISTS ( SELECT 1
                      FROM dbamv.itord_pro
                     WHERE cd_ord_com = o.cd_ord_com
                       AND cd_produto = i.cd_produto
                       AND Nvl(QT_RECEBIDA,0) + Nvl(QT_CANCELADA,0) = QT_ATENDIDA )     
   AND o.dt_prev_entrega = ( SELECT min(o2.dt_prev_entrega) 
                               FROM DBAMV.ITORD_PRO i2
                                 ,  DBAMV.ORD_COM    o2 
                              WHERE i2.cd_ord_com = o2.cd_ord_com
                                and o2.TP_SITUACAO IN ('A','U','L')
                                AND i2.cd_produto = i.cd_produto 
                                AND NOT EXISTS ( SELECT 1
                                                   FROM dbamv.itord_pro
                                                  WHERE cd_ord_com = o2.cd_ord_com
                                                    AND cd_produto = i2.cd_produto
                                                    AND Nvl(QT_RECEBIDA,0) + Nvl(QT_CANCELADA,0) = QT_ATENDIDA ) )        
--
UNION  ALL   
--
SELECT o.dt_prev_entrega
     , o.cd_ord_com 
     , f.nm_fornecedor
     , p.cd_produto_tem cd_produto
  FROM DBAMV.ITORD_PRO i
     , DBAMV.ORD_COM   o 
     , dbamv.fornecedor f 
     , dbamv.produto p 
 WHERE i.cd_ord_com = o.cd_ord_com
   AND f.cd_fornecedor = o.cd_fornecedor 
   and o.TP_SITUACAO IN ('A','U','L')
   AND p.cd_produto = i.cd_produto    
   AND NOT EXISTS ( SELECT 1
                      FROM dbamv.itord_pro
                         , dbamv.produto 
                     WHERE produto.cd_produto_tem = p.cd_produto_tem
                       AND itord_pro.cd_ord_com = o.cd_ord_com
                       AND itord_pro.cd_produto = produto.cd_produto  
                       AND Nvl(itord_pro.QT_RECEBIDA,0) + Nvl(itord_pro.QT_CANCELADA,0) = itord_pro.QT_ATENDIDA 
                  )      
   AND o.dt_prev_entrega = ( SELECT min(o2.dt_prev_entrega) 
                               FROM DBAMV.ITORD_PRO  i2
                                 ,  DBAMV.ORD_COM    o2 
                                 ,  dbamv.produto    p2 
                              WHERE i2.cd_ord_com = o2.cd_ord_com
                                AND p2.cd_produto = i2.cd_produto
                                and o2.TP_SITUACAO IN ('A','U','L')
                                AND p2.cd_produto_tem = p.cd_produto_tem  
                                AND NOT EXISTS ( SELECT 1
                                                    FROM dbamv.itord_pro
                                                      , dbamv.produto 
                                                  WHERE produto.cd_produto_tem = p2.cd_produto_tem
                                                    AND itord_pro.cd_ord_com = o2.cd_ord_com
                                                    AND itord_pro.cd_produto = produto.cd_produto  
                                                    AND Nvl(itord_pro.QT_RECEBIDA,0) + Nvl(itord_pro.QT_CANCELADA,0) = itord_pro.QT_ATENDIDA )   
                            )      
) x
  WHERE ( :CD_PRODUTO1 = cd_produto)  group by dt_prev_entrega , nm_fornecedor , cd_produto

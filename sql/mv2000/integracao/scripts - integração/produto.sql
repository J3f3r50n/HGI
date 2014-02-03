/* Formatted on 2013/11/06 17:07 (Formatter Plus v4.8.6) */
SELECT   pro.ds_produto, pro.cd_produto, pro.cd_especie, e.ds_especie
    FROM dbamv.ent_pro p,
         dbamv.itent_pro it,
         dbamv.produto pro,
         dbamv.especie e
   WHERE p.cd_ent_pro = it.cd_ent_pro
     AND it.cd_produto = pro.cd_produto
     AND pro.cd_especie = e.cd_especie
     AND it.cd_produto NOT IN (SELECT cd_produto_de
                                 FROM de_para_produto)
     AND pro.dt_ultima_entrada BETWEEN TO_DATE ('31/07/2012', 'dd/mm/yyyy')
                                   AND TO_DATE ('04/11/2013', 'dd/mm/yyyy')
     AND pro.sn_movimentacao = 'S'
     AND pro.sn_bloqueio_de_compra = 'N'
GROUP BY pro.ds_produto, pro.cd_produto, pro.cd_especie, e.ds_especie
ORDER BY 1



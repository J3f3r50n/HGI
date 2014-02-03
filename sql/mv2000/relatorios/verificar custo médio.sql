select * from dbamv.log_erro_ent_pro


select * from dbamv.custo_medio where cd_produto = 51974 order by dh_custo_medio desc
--------------------
select * from dbamv.est_pro where cd_produto = 51974
------------------------
SELECT SUM(QT_ESTOQUE_ATUAL)
		  FROM DBAMV.EST_PRO
		 WHERE EST_PRO.CD_PRODUTO = 51974
		 And Est_Pro.Cd_Estoque in ( Select Estoque.Cd_Estoque
			            From Dbamv.Estoque
                             Where Estoque.Cd_Multi_Empresa = 1 )
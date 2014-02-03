Select *
From (
Select F.cd_fornecedor, F.nm_fornecedor, F.sn_ativo, F.tp_fornecedor, F.nr_cgc_cpf
     ,(Select Max(dt_entrada) 
        From Ent_Pro E 
        Where E.cd_fornecedor = F.cd_fornecedor 
        And E.dt_entrada between to_date ('01/01/2012','dd/mm/yyyy') 
	And to_date ('31/12/2012','dd/mm/yyyy')) DT_Entrada
-- And to_date ('10/03/2013','dd/mm/yyyy')) DT_Entrada
 From Fornecedor F
Where F.tp_fornecedor = 'J'
)
Where Dt_entrada is not null

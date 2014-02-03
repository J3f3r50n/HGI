Select 
		produto.cd_produto cd_produto 
		, produto . ds_produto ds_produto 
		, Empresa_Produto . Tp_Classificacao_XYZ Tp_Classificacao_XYZ 
		, Dbamv . Verif_Ds_Unid_Prod ( produto . Cd_Produto ) ds_unidade 
		, Sum ( consumo . qt_consumo ) qt_consumo 
		, Sum ( consumo . vl_custo_periodo ) vl_custo_periodo 
	From 
		( 
		Select 
			DECODE 
			( 'N' , 'S' , PRODUTO . CD_PRODUTO_TEM , PRODUTO . CD_PRODUTO ) Cd_Produto 
			, Trunc 
					( 
						( 
							Sum 
								( Nvl 
									( C_Conest . Qt_Saida_Setor , 0 ) 
										+ Nvl ( C_Conest . Qt_Saida_Paciente , 0 ) 
										+ Nvl ( Decode 
												( '%' , '%' , 0 , 
													( Decode 
														( Estoque . Tp_Estoque , 'D' , Nvl 
															( C_Conest . Qt_Transferencia_Saida , 0 ) 
														, 0 ) 
													) 
												) , 0 
											) 
								) 
							- Sum 
								( Nvl 
									( C_Conest . Qt_Devolucao_Setor , 0 ) 
										+ Nvl ( C_Conest . Qt_Devolucao_Paciente , 0 ) 
										+ Nvl ( Decode 
												( '%' , '%' , 0 , 
													( Decode 
														( Estoque . Tp_Estoque , 'D' , Nvl 
															( C_Conest . Qt_Entrada_Transferido , 0 ) 
														, 0 
														) 
													) 
												) , 0 
											) 
								) 
						) / Dbamv . Verif_Vl_Fator_Prod ( C_Conest . Cd_Produto ) , 4 ) Qt_Consumo 
		
			, Trunc ( 
						( 
							Sum 
								( Nvl 
									( C_Conest . Vl_Saida_Setor , 0 ) 
										+ Nvl ( C_Conest . Vl_Saida_Paciente , 0 ) 
										+ Nvl ( Decode 
												( '%' , '%' , 0 , 
													( Decode 
														( Estoque . Tp_Estoque , 'D' , Nvl 
															( C_Conest . Vl_Transferencia_Saida , 0 ) 
														, 0 ) 
													) 
												) 
										, 0 ) 
								) 
							- Sum 	
								( Nvl 
									( C_Conest . Vl_Devolucao_Setor , 0 ) 
										+ Nvl ( C_Conest . Vl_Devolucao_Paciente , 0 ) 
										+ Nvl ( Decode 
												( '%' , '%' , 0 , 
													( Decode (
														Estoque . Tp_Estoque , 'D' , Nvl 
															( C_Conest . Vl_Entrada_Transferido , 0 ) 
														, 0 ) 
													) 
												) , 0 
											) 
								) 
						) 
						
					, 4 ) Vl_Custo_Periodo From Dbamv . C_Conest 
			, Dbamv . Produto 
			, Dbamv . Estoque 
			, Dbamv . Especie 
			, Dbamv . Empresa_produto 
				Where Produto.cd_produto = Empresa_produto.cd_produto 
					And Estoque . Cd_Estoque = C_Conest . Cd_Estoque 
					And Produto . Cd_Produto = C_Conest . Cd_Produto 
					And Produto . Cd_Especie = Especie . Cd_Especie 
					And Estoque . Cd_Multi_Empresa = 1 
					And Empresa_Produto . Cd_Multi_Empresa = 1
					And Produto . Tp_Ativo = 'S'
					And To_Date ( '01/' || LPad ( To_Char ( C_Conest . Cd_Mes ) , 2 , '0' ) || '/' || To_Char ( C_Conest . Cd_Ano ) , 'DD/MM/YYYY' ) 
						Between TRUNC ( &INI ) 
					And Last_Day ( &FIN )
AND PRODUTO.CD_ESPECIE In ( '2' ,'1' ,'6' ) Group By DECODE ( 'N' , 'S' , PRODUTO . CD_PRODUTO_TEM , PRODUTO . CD_PRODUTO ) , C_Conest . Cd_Produto ) consumo , dbamv . produto , dbamv . empresa_produto 
				Where 
					consumo . qt_consumo > 0 
					And consumo . cd_produto = produto . cd_produto 
					And Empresa_Produto . cd_produto = produto . cd_produto 
					And Empresa_Produto . Cd_Multi_Empresa = 1
					And Produto . Sn_Mestre = Nvl ( 'N' , 'N' ) 
				GROUP BY PRODUTO . DS_PRODUTO , PRODUTO . CD_PRODUTO , EMPRESA_PRODUTO . TP_CLASSIFICACAO_XYZ , VERIF_DS_UNID_PROD ( PRODUTO . CD_PRODUTO ) 
		order by vl_custo_periodo desc
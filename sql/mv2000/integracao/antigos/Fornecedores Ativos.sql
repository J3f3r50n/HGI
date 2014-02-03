select 
  f.cd_fornecedor Código, 
  f.nm_fornecedor Fornecedor, 
  f.nm_fantasia Nome_Fantasia, 
  f.tp_fornecedor Tipo,
  f.ds_rua Rua_Av,
  f.ds_endereco Endereço,
  f.nr_endereco Número,
  f.ds_complemento Complemento,
  f.ds_bairro Bairro,
  f.cd_cidade Cód_Cidade,
  c.cd_cidade Cód_Cidade,
  c.nm_cidade Cidade,
  f.nr_cep CEP,
  f.nr_cgc_cpf CNPJ,
  f.nr_insc_est IE,
  f.sn_simples Simples,
  f.sn_ativo Ativo
from 
	dbamv.fornecedor f,
	dbamv.cidade c
where 
	f.sn_ativo = 'S'
	and f.cd_cidade = c.cd_cidade
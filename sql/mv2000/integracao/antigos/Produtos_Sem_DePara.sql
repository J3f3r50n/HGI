-- #Tecnologia da Informação
-- #Hospital Geral de Itapevi
SELECT * FROM 
  (SELECT
  p.cd_produto
  ,p.ds_produto
  ,p.cd_especie
  FROM 
  dbamv.produto p)
MINUS 
  (SELECT 
  f.cd_produto_de
  ,f.ds_produto_de
  ,f.cd_especie_de
  FROM 
  dbamv.de_para_produto f
  )
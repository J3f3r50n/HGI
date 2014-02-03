-- #Tecnologia da Informação
-- #Hospital Geral de Itapevi
SELECT
  p.cd_produto
  ,p.ds_produto 
  ,p.cd_especie
  ,p.cd_classe
  ,f.cd_produto_de
  ,f.ds_produto_de
  ,f.cd_especie_de
  ,f.cd_produto_para
  ,f.cd_especie_para
  ,f.cd_classe_para
FROM 
  dbamv.produto p
  ,dbamv.de_para_produto f
WHERE
  f.cd_produto_para not in
  ( select 
    cd_produto_para
    from
      dbamv.de_para_produto
  ) and
  p.cd_produto = f.cd_produto_de
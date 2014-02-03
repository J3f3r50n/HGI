Select c.*

From dbamv.est_consig_forn c,

dbamv.ent_pro e,

dbamv.itent_pro i

Where e.cd_ent_pro = i.cd_ent_pro

And e.cd_estoque = c.cd_estoque

And e.cd_fornecedor = c.cd_fornecedor

And i.cd_produto = c.cd_produto

And e.cd_ent_pro = 32593 

select f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf from dbamv.fornecedor f, dbamv.ent_pro p
where f.cd_fornecedor not in (select cd_fornecedor_de from de_para_fornecedor)
      and f.SN_ativo = 'S'
      and f.cd_fornecedor = p.cd_fornecedor
      and p.dt_entrada between to_date ('01/01/2011', 'dd/mm/yyyy') and to_date ('31/05/2013', 'dd/mm/yyyy')
group by f.cd_fornecedor, f.nm_fornecedor, f.nr_insc_est
order by 1


select f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf from dbamv.fornecedor f, dbamv.ent_serv s
where f.cd_fornecedor not in (select cd_fornecedor_de from de_para_fornecedor)
      and f.SN_ativo = 'S'
      and f.cd_fornecedor = s.cd_fornecedor
      and s.dt_entrada between to_date ('01/01/2011', 'dd/mm/yyyy') and to_date ('31/05/2013', 'dd/mm/yyyy')
group by f.cd_fornecedor, f.nm_fornecedor, f.nr_cgc_cpf
order by 1
select      DISTINCT 
             TRUNC(Itmvto_Estoque.Dh_Mvto_Estoque) DATA
             ,prestador.nm_prestador         AS "PRESTADOR DO ATENDIMENTO"
             ,PACIENTE.NM_PACIENTE           AS "NOME PACIENTE"
             ,('RUA: '||PACIENTE.DS_ENDERECO||', '||PACIENTE.NR_ENDERECO||' / '||PACIENTE.NM_BAIRRO||' - '||CIDADE.NM_CIDADE) ENDERECO
             ,PACIENTE.CD_PACIENTE           PRONTUARIO
             ,ATENDIME.CD_ATENDIMENTO        RA
             ,ATENDIME.CD_CID                CID
             ,ItMvto_Estoque.Cd_Produto      AS "CÓDIGO DO PRODUTO"
             , Produto.Ds_Produto            AS "DESC. PRODUTO"
             , Uni_Pro.Ds_Unidade            AS "UNIDADE"
             ,    sum(DECODE(NVL(PRODUTO.SN_MESTRE,'N'),'N',Nvl(ItMvto_Estoque.Qt_Movimentacao,0) ,'S',0)) AS "QTD. ATENDIDA"

FROM   dbamv.MVTO_ESTOQUE                                  MVTO_ESTOQUE,
             dbamv.ITMVTO_ESTOQUE                          ITMVTO_ESTOQUE,
             dbamv.ESTOQUE                                 ESTOQUE,
             dbamv.PRESTADOR                               PRESTADOR,
             dbamv.SETOR                                   SETOR,
             dbamv.ATENDIME                                ATENDIME,
             dbamv.PACIENTE                                PACIENTE,
             dbamv.UNI_PRO                                 UNI_PRO,
             dbamv.PRODUTO                                 PRODUTO,
             dbamv.PRODUTO                                 PRODUTO_KIT,
             dbamv.AVISO_CIRURGIA                          AVISO_CIRURGIA,
             DBAMV.CIDADE                                  CIDADE
WHERE      MVTO_ESTOQUE.CD_MVTO_ESTOQUE =   ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE(+)
AND        MVTO_ESTOQUE.CD_ESTOQUE             =   ESTOQUE.CD_ESTOQUE
AND        MVTO_ESTOQUE.CD_PRESTADOR        =   prestador.CD_PRESTADOR
AND        MVTO_ESTOQUE.CD_SETOR                  =   SETOR.CD_SETOR
AND        MVTO_ESTOQUE.CD_ATENDIMENTO    =    ATENDIME.CD_ATENDIMENTO
AND        ATENDIME.CD_PACIENTE                        =   PACIENTE.CD_PACIENTE(+)
AND        ITMVTO_ESTOQUE.CD_UNI_PRO           =   UNI_PRO.CD_UNI_PRO(+)
AND        ITMVTO_ESTOQUE.CD_PRODUTO         =   PRODUTO.CD_PRODUTO(+)
AND        ITMVTO_ESTOQUE.CD_PRODUTO_KIT =   PRODUTO_KIT.CD_PRODUTO(+)
AND        CIDADE.CD_CIDADE=PACIENTE.CD_CIDADE
AND        PRODUTO.CD_PRODUTO= '&COD'  -- 51018
AND        AVISO_CIRURGIA.CD_AVISO_CIRURGIA (+) = MVTO_ESTOQUE.CD_AVISO_CIRURGIA
AND        PACIENTE.CD_PACIENTE IS NOT NULL
and        Itmvto_Estoque.Dh_Mvto_Estoque between to_date ('&INI','dd/mm/yyyy')
and        to_date ('&FIN','dd/mm/yyyy')

group by
ItMvto_Estoque.Cd_Produto
             , Produto.Ds_Produto
             , Uni_Pro.Ds_Unidade
             ,Itmvto_Estoque.Dh_Mvto_Estoque
             ,PACIENTE.DS_ENDERECO
             ,PACIENTE.NM_PACIENTE
             ,PACIENTE.CD_PACIENTE
             ,ATENDIME.CD_CID
             ,PACIENTE.NR_ENDERECO
             ,PACIENTE.NM_BAIRRO
             ,CIDADE.NM_CIDADE
             ,prestador.nm_prestador
             ,ATENDIME.CD_ATENDIMENTO

ORDER BY DATA, PACIENTE.NM_PACIENTE 

-- 51018 MISOPROSTOL 25MCG
-- 54102 MISOPROSTOL 200MCG

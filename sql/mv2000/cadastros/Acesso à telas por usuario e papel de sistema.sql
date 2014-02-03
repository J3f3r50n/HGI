--- Consulta de Papeis e Telas por Usuarios X Papel 
--- SGU 
--- Wagner Saraiva 
--- Criado em 15/06/2007




---Ve o acesso geral em todas os papeis e acesso por fora 
SELECT DISTINCT U.cd_usuario 
,P.cd_papel
, M.cd_modulo 
,U.nm_usuario
,U.tp_privilegio
,U.sn_ativo
,P.cd_papel
,P.ds_papel
,S.cd_sistema
,S.nm_sistema

FROM 
 DBASGU.USUARIOS U
,DBASGU.PAPEL_USUARIOS PU
,DBASGU.SISTEMA S
,DBASGU.MODULOS M
,dbasgu.aut_mod AM
,DBASGU.MOD_SIS MS
,DBASGU.PAPEL_MOD PM
,DBASGU.PAPEL P

WHERE U.cd_usuario=PU.cd_usuario
AND PU.cd_papel=PM.cd_papel
AND PU.cd_papel=P.cd_papel
AND PM.cd_modulo=M.cd_modulo
AND S.cd_sistema=M.cd_sistema_dono
AND AM.cd_modulo=M.cd_modulo
AND MS.cd_modulo=M.cd_modulo
AND S.cd_sistema=MS.cd_sistema
--AND U.cd_usuario='DSVIEIRA' --USUARIO DE ANDAR NAO DEVE TER ACESSO AS TELA DE FATURAMENTO
AND U.sn_ativo='S'
AND M.cd_modulo in ('C_CID')
--AND M.cd_modulo in ('M_FORNEC')
ORDER BY 1,2,6,8



-- Ve acesso por fora do papel direto na tela 
select  * from dbasgu.aut_mod  a
where a.cd_modulo='C_CID'


--verifica em quantos papeis a tela esta configurado 
select DISTINCT P.CD_PAPEL ,P.cd_modulo from dbasgu.papel_mod p
where p.cd_modulo='C_CID'

ORDER BY 1


-- verifica o total de papeis criados 
SELECT COUNT (cd_papel) FROM DBASGU.PAPEL 

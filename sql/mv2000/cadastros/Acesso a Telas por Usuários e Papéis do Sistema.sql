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
where a.cd_modulo='M_FORNEC'


--verifica em quantos papeis a tela esta configurado 
select DISTINCT P.CD_PAPEL ,P.cd_modulo from dbasgu.papel_mod p
where p.cd_modulo='C_CID'

ORDER BY 1


-- verifica o total de papeis criados 
SELECT COUNT (cd_papel) FROM DBASGU.PAPEL 

=============================================================
-- Thais Mauer

SELECT CD_USUARIO, NM_USUARIO
FROM DBASGU.USUARIOS
WHERE CD_USUARIO IN ( SELECT  CD_USUARIO 
                      FROM DBASGU.AUT_MOD
                      WHERE CD_MODULO = 'M_CENTRO_CUSTO')
OR CD_USUARIO IN ( SELECT CD_USUARIO
                   FROM DBASGU.PAPEL_USUARIOS 
                   WHERE CD_PAPEL IN ( SELECT CD_PAPEL 
                                       FROM DBASGU.PAPEL_MOD
                                       WHERE CD_MODULO = 'M_CENTRO_CUSTO'))
ORDER BY NM_USUARIO

--------------------------------------------------------------------------------
-- papeis que possuem o módulo
SELECT 
 pm.cd_modulo
,pm.cd_papel
,p.ds_papel
FROM 
 DBASGU.PAPEL_MOD pm
,dbasgu.papel p
WHERE 
    pm.cd_papel = p.cd_papel
and pm.CD_MODULO in ('M_CENTRO_CUSTO','M_CENTRO_CUSTO_COMP')
order by
 pm.cd_modulo
,pm.cd_papel

-- usuários que tem o papel
select 
 pu.cd_usuario
,u.nm_usuario
,p.ds_papel
from 
 dbasgu.papel_usuarios pu
,dbasgu.usuarios u
,dbasgu.papel p
,dbamv.usuario_multi_empresa ue
where 
    pu.cd_usuario = u.cd_usuario
and pu.cd_usuario = ue.cd_id_usuario
and u.sn_ativo = 'S'
and ue.cd_multi_empresa = 1
and pu.cd_papel = p.cd_papel
and pu.cd_papel in (1,2,24,25,39)
order by
 ds_papel
,cd_usuario


-- usuários que tem acesso ao módulo sem ter o papel
SELECT  
 um.CD_USUARIO 
,u.nm_usuario
,um.cd_modulo
FROM 
 DBASGU.AUT_MOD um
,dbasgu.usuarios u
,dbamv.usuario_multi_empresa ue
WHERE 
    um.cd_usuario = u.cd_usuario
and u.cd_usuario = ue.cd_id_usuario
and u.sn_ativo = 'S'
and ue.cd_multi_empresa = 1
and CD_MODULO in ('M_CENTRO_CUSTO','M_CENTRO_CUSTO_COMP')
and u.cd_usuario not in (select 
 pu.cd_usuario
from 
 dbasgu.papel_usuarios pu
,dbasgu.usuarios u
,dbasgu.papel p
,dbamv.usuario_multi_empresa ue
where 
    pu.cd_usuario = u.cd_usuario
and u.cd_usuario = ue.cd_id_usuario
and u.sn_ativo = 'S'
and ue.cd_multi_empresa = 1
and pu.cd_papel = p.cd_papel
and pu.cd_papel in (1,2,24,25,39))
order by
 um.cd_modulo
,um.cd_usuario

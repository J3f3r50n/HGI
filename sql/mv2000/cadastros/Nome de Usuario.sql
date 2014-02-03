-- Nome de usuário:
-- Script 01
select nm_usuario from dbasgu.usuarios where cd_usuario = user

-- Script 02
select nm_prestador from dbamv.prestador
where cd_prestador = (select cd_prestador from dbasgu.usuarios where cd_usuario = user)

-- Script 03
show user

-- Script 04 
select nm_usuario from dbasgu.usuarios where cd_usuario = &CD_USUARIO
-- Script para cria��o de novos usuarios do sistema MV2000
-- Sistema MV2000
-- Dt Cria��o: 30/05/2011
-- Desenvolvido por: Tiago Selusniaki
-- Hospital S�o Vicente - T�c. Informa��o - Curitiba PR

--SELECT seq_prestador.NEXTVAL FROM dual --Caso tenha adicionado o prestador deve rodar esse select depois.

-- AP�S RODAR ESSE SCRIPT � NECESS�RIO ENTRAR NO MV M�DULO SGU, BUSCAR O NOVO COLABORADOR E CLICAR EM "RECONCILIAR"

-- N�O ESQUECER DE COLOCAR OS NOMES DE USU�RIOS SEMPRE EM LETRAS MAI�SCULAS
DECLARE Login           VARCHAR(50)   := 'OTAVIO131119'   ;     -- INSIRA O LOGIN DO NOVO USUARIO NOME.ULTIMOSOBRENOME
        NomeUsu         VARCHAR(50)   := 'OTAVIO AUGUSTO VASQUES MOREIRA'   ;     -- INSIRA O NOME DO NOVO COLABORADOR
        CpfUsu          VARCHAR(11)   := '32730576886'        ;     -- INSIRA O CPF DO NOVO COLABORADOR
        NomeGuerra      VARCHAR(20)   := 'OTAVEIO MOREIRA';     -- INSIRA O NOME DE GUERRA DO COLABORADOR QUE SER� CADASTRADO NO M�DULO AMDC
        Conselho        VARCHAR(15)   :=  131119            ;     -- INSIRA O NUM�RO DO CONSELHO (EX: CRM SE M�DICO)
        UsuarioModelo   VARCHAR(50)   := 'TENNYSON852'  ;     -- INSIRA O USU�RIO MODELO
        PrestadorModelo NUMBER        :=  474               ;     -- INSIRA O C�DIGO DO PRESTADOR MODELO

BEGIN
--CADASTRA O PRESTADOR CASO O NOVO COLABORADOR NECESSITE (AMDC)
IF PrestadorModelo IS NOT NULL
THEN
INSERT INTO prestador (cd_prestador                 ,
                       sn_atuante                   ,
                       sn_outros                    ,
                       sn_cirurgiao                 ,
                       sn_auxiliar                  ,
                       sn_anestesista               ,
                       nr_cpf_cgc                   ,
                       nm_prestador                 ,
                       nm_mnemonico                 ,
                       cd_conselho                  ,
                       ds_codigo_conselho           ,
                       cd_tip_presta                ,
                       tp_situacao                  ,
                       tp_corpo_clinico             ,
                       sn_repasse_fatura_amb_sus
                       )
    SELECT  (SELECT Max (cd_prestador) + 1 FROM prestador), --Deixar com sequence: Caso tiver problema informar ao Ferpa
            sn_atuante                    ,
            sn_outros                     ,
            sn_cirurgiao                  ,
            sn_auxiliar                   ,
            sn_anestesista                ,
            CpfUsu                        ,
            NomeUsu                       ,
            NomeGuerra                    ,
            cd_conselho                   ,
            Conselho                      ,
            cd_tip_presta                 ,
            tp_situacao                   ,
            tp_corpo_clinico              ,
            sn_repasse_fatura_amb_sus
        FROM prestador
          WHERE cd_prestador = PrestadorModelo
          GROUP BY cd_prestador,
                  sn_atuante                    ,
                  sn_outros                      ,
                  sn_cirurgiao                   ,
                  sn_auxiliar                    ,
                  sn_anestesista                 ,
                  CpfUsu                         ,
                  NomeUsu                        ,
                  NomeGuerra                     ,
                  cd_conselho                    ,
                  Conselho                       ,
                  cd_tip_presta                  ,
                  tp_situacao                    ,
                  tp_corpo_clinico               ,
                  sn_repasse_fatura_amb_sus        ;
END IF;
-- CADASTRA O NOVO USU�RIO
INSERT INTO dbasgu.usuarios (cd_usuario                   ,
                             nm_usuario                   ,
                             sn_senha_plogin              ,
                             tp_privilegio                ,
                             cd_senha                     ,
                             tp_status                    ,
                             cd_prestador                 ,
                             sn_abre_fecha_conta          ,
                             cpf                          ,
                             sn_cadastra_paciente         ,
                             sn_altera_cadastro_paciente  )
    SELECT  Login                        ,                -- LOGIN DO NOVO COLABORADOR
            NomeUsu                      ,                -- NOME DO NOVO COLABORADOR
            'S'                          ,                -- ALTERAR A SENHA NO PR�XIMO LOGIN
            tp_privilegio                ,                -- PRIVIL�GIO DE USUARIO OU ADMINISTRADOR
            cd_senha                     ,                -- SENHA DE ACESSO; FAZ A COPIA AUTOMATICA DO LOGIN
            tp_status                    ,                -- ATIVO OU INATIVO
            (SELECT Max(cd_prestador) FROM prestador WHERE PrestadorModelo IS NOT NULL),    -- VINCULA O PRESTADOR AO USUARIO
            sn_abre_fecha_conta          ,                -- PERMISS�O PARA ABRIR CONTA (CHECKBOX)
            CpfUsu                       ,                -- CPF DO NOVO COLABORADOR
            sn_cadastra_paciente         ,
            sn_altera_cadastro_paciente
       FROM    dbasgu.usuarios
        WHERE   cd_usuario = UsuarioModelo                -- USU�RIO MODELO
        GROUP BY Login                                ,
                 NomeUsu                              ,
                 tp_privilegio                        ,
                 cd_senha                             ,
                 tp_status                            ,
                 sn_abre_fecha_conta                  ,
                 CpfUsu                               ,
                 sn_cadastra_paciente                 ,
                 sn_altera_cadastro_paciente            ;

-- INSERE O(S) PAPEL(S) AO NOVO USU�RIO
INSERT INTO dbasgu.papel_usuarios (cd_usuario,
                                   cd_papel,tp_papel)
    SELECT Login    ,                                     -- LOGIN DO NOVO COLABORADOR
           cd_papel ,
           tp_papel
       FROM dbasgu.papel_usuarios
        WHERE cd_usuario = UsuarioModelo;                 -- USU�RIO MODELO

-- INSERE A(S) EMPRESA(S) AO NOVO USU�RIO
INSERT INTO usuario_multi_empresa (cd_multi_empresa,
                                   cd_id_usuario)
    SELECT cd_multi_empresa ,
           Login                                          -- USU�RIO MODELO
       FROM usuario_multi_empresa
        WHERE cd_id_usuario = UsuarioModelo;              -- USU�RIO MODELO

-- INSERE O(S) ESTOQUE(S) AO NOVO USU�RIO
INSERT INTO usu_estoque (cd_estoque                      ,
                         cd_id_do_usuario                ,
                         sn_autoriza_excl_solicitacao    ,
                         sn_autoriza_alte_solicitacao    ,
                         tp_usuario                      ,
                         sn_permite_alt_ord_compras      ,
                         sn_alt_vl_unit_oc               ,
                         vl_perc_var_vl_unit             ,
                         sn_trans_quant_cota             ,
                         sn_autoriza_alte_movimentacao   ,
                         sn_autoriza_excl_movimentacao   )
    SELECT cd_estoque                             ,
           Login                                  ,       -- LOGIN DO NOVO COLABORADOR
           sn_autoriza_excl_solicitacao           ,
           sn_autoriza_alte_solicitacao           ,
           tp_usuario                             ,
           sn_permite_alt_ord_compras             ,
           sn_alt_vl_unit_oc                      ,
           vl_perc_var_vl_unit                    ,
           sn_trans_quant_cota                    ,
           'N'                                    ,       -- sn_autoriza_alte_movimentacao
           'N'                                            -- sn_autoriza_excl_movimentacao
       FROM usu_estoque
        WHERE cd_id_do_usuario = UsuarioModelo;           -- USU�RIO MODELO

--INSERE A(S) UNIDADE(S) DE INTERNA��O AO NOVO USU�RIO
INSERT INTO usuario_unid_int ( cd_unid_int        ,
                               cd_id_usuario      ,
                               cd_setor           )
    SELECT cd_unid_int      ,
           Login            ,                             -- LOGIN DO NOVO COLABORADOR
           cd_setor
        FROM usuario_unid_int
        WHERE cd_id_usuario = UsuarioModelo;              --USU�RIO MODELO

-- INSERE O(S) SETOR(S) DE DIAN�STICO AO NOVO USU�RIO
INSERT INTO psdi_set_exa ( cd_set_exa     ,
                           nm_usuario     )
    SELECT cd_set_exa       ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM psdi_set_exa
        WHERE nm_usuario = UsuarioModelo;                 --USU�RIO MODELO

-- INSERE O(S) SETOR(S) DE EXAME(S) AO NOVO USU�RIO
INSERT INTO usuarios_set_exa ( cd_set_exa   ,
                               nm_usuario   )
    SELECT cd_set_exa     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usuarios_set_exa
        WHERE nm_usuario = UsuarioModelo;                 --USU�RIO MODELO

-- INSERE USU�RIO X SETOR SOLICITANTE X UNID. INTERNA��O (SCMA)
INSERT INTO usuario_setor (cd_setor     ,
                           nm_usuario   )
    SELECT cd_setor     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usuario_setor
        WHERE nm_usuario = UsuarioModelo;                 --USU�RIO MODELO

-- INSERE AS ORIGENS AO NOVO USU�RIO (GLOBAL)
INSERT INTO usu_origem (cd_ori_ate     ,
                           cd_usuario   )
    SELECT cd_ori_ate     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usu_origem
        WHERE cd_usuario = UsuarioModelo;                 --USU�RIO MODELO

-- INSERE OS CENTRO(S) CIR�RGICO(S) AO NOVO USU�RIO
INSERT INTO usu_cen_cir (cd_cen_cir     ,
                         nm_usuario     )
    SELECT cd_cen_cir     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usu_cen_cir
        WHERE nm_usuario = UsuarioModelo;                 --USU�RIO MODELO

-- LIBERA PARA O NOVO USU�RIO A PERMISS�O DE CANCELAR NOVA FISCAL (FFCV)
INSERT INTO usuario_cancela_nota (cd_formulario_nf     ,
                                  cd_usuario     )
    SELECT cd_formulario_nf     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usuario_cancela_nota
        WHERE cd_usuario = UsuarioModelo;                 --USU�RIO MODELO

--LIBERA COMPETENCIA PARA O USU�RIO (VISUALIZAR) FFCV->TABELAS->GERAIS->PERMISS�O A COMPRETNCIA DO FATURAMENTO
INSERT INTO usu_permissao_competencia (dt_cadastro       ,
                                       cd_usuario )
    SELECT dt_cadastro     ,
           Login                                          -- LOGIN DO NOVO COLABORADOR
        FROM usu_permissao_competencia
        WHERE cd_usuario = UsuarioModelo;                 --USU�RIO MODELO
-- LIBERA PARA O BIOQUIMICO PODER FAZER ASSINATURA NO PSSD -> TABELAS -> PERFIL DE USU�RIOS
INSERT INTO dbasgu.usuario_prestador_lab (cd_usuario      ,
                                          cd_prestador    ,
                                       tp_atividade )
    SELECT Login           ,                              -- LOGIN DO NOVO COLABORADOR
           cd_prestador    ,
           tp_atividade
        FROM dbasgu.usuario_prestador_lab
        WHERE cd_usuario = UsuarioModelo;                 --USU�RIO MODELO

END;
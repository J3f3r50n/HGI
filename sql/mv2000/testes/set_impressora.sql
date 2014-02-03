PROCEDURE SET_IMPRESSORA is

 

  v_feriado  Varchar2(1):= 'N';

 

  Cursor C_Feriado is

    select NVL('S','N') feriado

    from   dbamv.feriado

    where  feriado.nr_dia = to_char(sysdate,'DD')

    and    feriado.nr_mes = to_char(sysdate,'MM')

    and    feriado.nr_ano = to_char(sysdate,'YYYY');

 

Begin

 

    Open  C_Feriado;

    Fetch C_Feriado into v_feriado;

    Close C_Feriado;

 

 

-- TERÇA-FERIA DIA 07/08/07 FOI ALTERADO TODOS OS INTERPS PARA INTER3.

-- SEXTA-FEIRA DIAS 24/12 E 31/12 OS SETORES IRÃO TRABALHAR COMO FERIADO.

-- POR ISSO TENHO QUE FAZER ESTA REGRA PARA ENVIAR AS IMPRESSÕES NAS IMPRESSORAS

-- CORRETAS.

-- NÃO POSSO SIMPLESMENTE LANÇAR ESTAS DATAS COMO FERIADOS , PORQUE IRIA GERAR TRANSTORNOS NO FATURAMENTO

-- COM COBRANÇAS EM ACRÉSCIMO.

-- POR FAVOR VERIFIQUE SE O QUE FIZEMOS ESTA OK.

-- OBRIGADO , AÉCIO.

-- INICIO DO QG

--    if ( to_char(sysdate,'D') = '6'

--    and v_feriado = 'N')

--

--    then

--       update dbamv.tb_set_exa

--       set    ds_caminho_impressao_exame = 'interps'

--       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

--       and    cd_set_exa not in (9,32,54,55);

 

--      update dbamv.tb_set_exa

--      set    ds_caminho_impressao_exame = 'hctriag'

--      where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

--      and    cd_set_exa not in (9,32,54,55);

 

--    commit;

--    end if;

--  FIM DO QG....

 

 

 

-- Deverá Configurar as impressoras dos setores de exame de acordo com as regras abaixo.

-- Durante a semana e nao feriado diurno

 

    if ( to_char(sysdate,'HH24') = '07'

     and to_char(sysdate,'D') in ('2','3','4','5','6')

     and v_feriado = 'N')

    then

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'endo'

        where  cd_set_exa in (18,19,46,47);

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'cardio'

        where  cd_set_exa in (41,53);

 

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'ecg'

        where  cd_set_exa in (1,2,4,5,6,7,8,21,25,35,37,38,39,40,84,85,86);

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'lab'

        where  cd_set_exa in (9,32,54,55,72,74,78,79);

 

        update dbamv.tb_set_exa

-- dia 30/09/09 foi solicitado cancelar este serviço - pela Cristiane Internação

-- realizado pelo Aecio

--        set    ds_caminho_impressao_exame = 'inter3'

--        where  cd_set_exa in (20);

--        update dbamv.tb_set_exa

 

        set    ds_caminho_impressao_exame = 'hctriag'

        where  cd_set_exa in (3);

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'angio'

        where  cd_set_exa in (27,34,36);

 

        ---> criei em 02/02/2010, solicitado pela zanza

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'aviso_cirguias'

        where  cd_set_exa in (27,34,36);

        ---------------------------------------------------

 

        -- Aécio 01/04/05 liberei para a fono

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'fono'

        where  cd_set_exa in (28,59);

 

   commit;

    end if;

 

-- Durante a semana e nao feriado vespertino

    if ( to_char(sysdate,'HH24') = '17'

     and to_char(sysdate,'D') in ('2','3','4','5','6')

     and v_feriado = 'N')

    then

       -- dia 30/09/09 foi solicitado cancelar este serviço - pela Cristiane Internação

       -- realizado pelo Aecio

       --        update dbamv.tb_set_exa

       --        set    ds_caminho_impressao_exame = 'inter3'

       --        where  cd_set_exa in (18,19);

       commit;

    end if;

   

    ---< Exames solicitados na sexta-feira apos as 17:00 imprimir na recepcao do hnsl >---

    ---< solicitado pela sheyla da central de guias (27/08/2012) >--

    if ( to_char(sysdate,'HH24') = '17'

     and to_char(sysdate,'D') in ('6')

     and v_feriado = 'N')

    then

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_set_exa in (1,2,4,5,6,7,8,21,25,35,37,38,39,40,84,85,86);

       commit;

    end if;

   

 

    if ( to_char(sysdate,'HH24') = '18'

     and to_char(sysdate,'D') in ('2','3','4','5','6')

     and v_feriado = 'N')

    then

 

       update dbamv.tb_set_exa

 

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

       and    cd_set_exa not in (9,32,34,54,55,72,74,78,79,20);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'hctriag'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

       and    cd_set_exa not in (3,9,32,36,54,55,72,74,78,79);

 

    commit;

    end if;

 

-- Durante a semana e nao feriado noturno

    if ( to_char(sysdate,'HH24') = '22'

     and to_char(sysdate,'D') in ('2','3','4','5','6')

     and v_feriado = 'N')

    then

 

   -- Linhas abaixo com comentario, esta respeitando a regra acima (vespertino)

   -- update dbamv.tb_set_exa

   -- set    ds_caminho_impressao_exame = 'interps'

   -- where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

   -- and    cd_set_exa not in (9,32,54,55);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

       and    cd_set_exa not in (9,32,54,55,72,74,78,79,20);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'hctriag'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

       and    cd_set_exa not in (9,32,54,55,72,74,78,79);

 

    commit;

    end if;

 

-- Durante os Sabados e nao feriados

    if ( to_char(sysdate,'D') = '7'

         and v_feriado = 'N')

    then

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

       and    cd_set_exa not in (9,32,54,55,72,74,28,78,79,20);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'hctriag'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

       and    cd_set_exa not in (9,32,54,55,72,74,59,78,79);

 

    commit;

    end if;

 

    if ( to_char(sysdate,'HH24') = '07'

     and to_char(sysdate,'D')    = '7'

     and v_feriado = 'N')

    then

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'angio'

        where  cd_set_exa in (27,34,36);

       

        --> alterado em 02/02/2010, solicitado pela zanza

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'aviso_cirguias'

        where  cd_set_exa in (27,34,36);

        --------------------------------------------------

    commit;

    end if;

   

    

    -- Solicitado pela cristina (cd), nos dias 24 e 31 radiologia 1 andar so funciona até as 13:00 horas

    -- Alterado (23/12/2009)

--   if ( to_char(sysdate,'HH24') = '13'

--   and to_char(sysdate,'D')    = '5'

--   and v_feriado = 'N')

--   then

--       update dbamv.tb_set_exa

--       set    ds_caminho_impressao_exame = 'inter3'

--       where  cd_set_exa in (2);

--   commit;

--   end if;

 

--    ALTERADO POIS A ENDOSCOPIA NÃO IRA FUNCIONAR NO SABADO 24/12/2005

--    if ( to_char(sysdate,'HH24') = '08'

--     and to_char(sysdate,'D')    = '7'

--     and v_feriado = 'N')

--    then

 

--        update dbamv.tb_set_exa

--        set    ds_caminho_impressao_exame = 'endo'

--        where  cd_set_exa in (18,19,46,47);

 

--    commit;

--    end if;

 

    if ( to_char(sysdate,'HH24') = '12'

     and to_char(sysdate,'D')    = '7'

     and v_feriado = 'N')

    then

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'inter3'

        where  cd_set_exa in (18,19);

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'hctriag'

        where  cd_set_exa in (46,47);

 

    commit;

    end if;

 

    if ( to_char(sysdate,'HH24Mi') = '1430'

     and to_char(sysdate,'D')    = '7'

     and v_feriado = 'N')

    then

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'inter3'

        where  cd_set_exa in (27,34);

 

        update dbamv.tb_set_exa

        set    ds_caminho_impressao_exame = 'hctriag'

        where  cd_set_exa in (36);

 

    commit;

    end if;

 

-- Durante os Domingos e nao feriados

    if ( to_char(sysdate,'D') = '1'

         and v_feriado = 'N')

    then

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

       and    cd_set_exa not in (9,32,54,55,72,74,28,78,79,20);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'hctriag'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

       and    cd_set_exa not in (9,32,54,55,72,74,59,78,79);

 

    commit;

    end if;

 

-- Durante os Feriados

    if ( v_feriado = 'S')

    then

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'inter3'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 1)

       and    cd_set_exa not in (9,32,54,55,72,74,28,78,79,20);

 

       update dbamv.tb_set_exa

       set    ds_caminho_impressao_exame = 'hctriag'

       where  cd_setor in (select cd_setor from setor where cd_multi_empresa = 2)

       and    cd_set_exa not in (9,32,54,55,72,74,59,78,79);

 

    commit;

    end if;

 

end;
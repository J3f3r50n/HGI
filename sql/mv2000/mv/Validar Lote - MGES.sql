--<DS_SCRIPT>
-- DESCRIÇÃO..: Script Realiza a Inserção de LOTE E VALIDADE quando não ha esta informação na entrada da nota.
-- RESPONSAVEL: Igo Silva
-- DATA.......: 30/07/2012
-- APLICAÇÃO..: MGES/Gerenciamento de Estoque
--</DS_SCRIPT>
--<USUARIO=DBAMV>


DECLARE
   CURSOR citlotent
   IS
      SELECT i.cd_itent_pro, i.cd_uni_pro, i.qt_entrada
        FROM dbamv.itent_pro i, dbamv.itlot_ent l
       WHERE i.cd_ent_pro = 93497 --> código da entrada
         AND i.cd_produto = 59595  --> código do produto
         AND i.cd_itent_pro = l.cd_itent_pro (+)
         AND nvl(i.qt_entrada,0 ) <> nvl(l.qt_ent_pro,0);
                              

   vitlotent     citlotent%ROWTYPE;
   vcditlotent   NUMBER;
BEGIN
   pkg_mv2000.atribui_empresa (1); --> Informe o Código da Empresa

   SELECT seq_t_itlot_ent.NEXTVAL
     INTO vcditlotent
     FROM DUAL;

   OPEN citlotent;
   FETCH citlotent INTO vitlotent;
   CLOSE citlotent;

   INSERT INTO dbamv.itlot_ent
               (cd_itlot_ent, cd_itent_pro, cd_lote,
                dt_validade, qt_ent_pro, cd_uni_pro
               )
        VALUES (vcditlotent, vitlotent.cd_itent_pro, '402teste', --> Lote
                TO_DATE ('30/11/2013', 'dd/mm/yyyy'),     --> Validade2
                 vitlotent.qt_entrada,  
                vitlotent.cd_uni_pro
               );
commit;
END;


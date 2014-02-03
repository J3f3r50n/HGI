select  to_char(dt_registro, 'DD')
        || ' de ' ||
        to_char(dt_registro, 'Month')
        || ' de ' ||
        to_char(dt_registro, 'YYYY')
  from  dbamv.registro_documento where cd_registro_documento =&<CD_REGISTRO_DOCUMENTO>
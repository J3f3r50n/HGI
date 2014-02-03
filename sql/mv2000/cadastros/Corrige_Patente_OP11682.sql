declare
  cursor c1 is 
    select cd_logradouro
         , cd_localidade
         , nr_cep
         , ds_complemento
         , ds_titulo_patente
         , 'P' tipo
      from dbamv.cep_logradouros c
      where ((c.ds_complemento like ('% DOS')
          or c.ds_complemento like ('% DAS')
          or c.ds_complemento like ('% DO')
		      or c.ds_complemento like ('% DE')
          or c.ds_complemento like ('% DA')))
      and not (( c.ds_titulo_patente  like ('% DOS')      
          or c.ds_titulo_patente  like ('% DAS')
          or c.ds_titulo_patente  like ('% DO')
		      or c.ds_titulo_patente  like ('% DE')
          or c.ds_titulo_patente  like ('% DA')
          or c.ds_titulo_patente  like ('DOS')      
          or c.ds_titulo_patente  like ('DAS')
          or c.ds_titulo_patente  like ('DO')
		      or c.ds_titulo_patente  like ('DE')
          or c.ds_titulo_patente  like ('DA') ))
    union all
    select cd_logradouro
         , cd_localidade
         , nr_cep
         , ds_complemento
         , ds_titulo_patente
         , 'B' tipo
      from dbamv.cep_logradouros l
      where ((    l.ds_complemento like ('% DOS')
              or l.ds_complemento like ('% DAS')
              or l.ds_complemento like ('% DO')
		          or l.ds_complemento like ('% DE')
              or l.ds_complemento like ('% DA')))
          and l.ds_titulo_patente is null;  

  r1   c1%rowtype;
  nome varchar(200);
  cont number;
begin

    for r1 in c1 loop
        cont  := 0;
        cont  := length(r1.ds_complemento);
        nome  := '';

         for i in 1..cont loop

            if substr(r1.ds_complemento,cont,1) = ' ' then

               nome := substr(r1.ds_complemento,cont+1,length(r1.ds_complemento));
               exit;

            end if;

            cont := cont - 1;

         end loop;

         if nome is not null then
            Update dbamv.cep_logradouros
                set ds_titulo_patente = decode(r1.tipo, 'B', nome, trim(substr(ds_titulo_patente||' '||nome,1,200)))
            where cd_logradouro = r1.cd_logradouro
              and cd_localidade = r1.cd_localidade
              and nr_cep = r1.nr_cep;
         end if;    

    end loop;
	
    commit;
end;
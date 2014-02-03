----
Soma a quantidade de registros conforme campo
----
SELECT 
   `USER`,
   COUNT(`USER`) AS QTDE 
FROM 
   `TABELA` 
GROUP BY 
   `USER` 
ORDER BY 
   COUNT(`USER`) DESC 
LIMIT 1



----
Soma quantidade de horas em um determinado campo
----
SELECT SEC_TO_TIME( 
	SUM( TIME_TO_SEC( nome_campo ) ) ) 
	AS total_horas 
FROM nome_tabela");



----
Seleção entre datas
----
SELECT * FROM tabela 
	WHERE data 
	BETWEEN ('data1') AND ('data2') 
	ORDER BY data DESC";


----
Soma quantidade de horas
----
SELECT TIMEDIFF(
	(SELECT TIMEDIFF(data_fechamento, data_abertura)),
	(SELECT TIMEDIFF(hora_abertura, hora_fechamento))
	) 
FROM
	chamados;

----
Soma a quantidade de chamados por setor e total de horas gastas no setor
----
SELECT setor, horas_total, 
	COUNT(´setor´) AS qtde,
	SEC_TO_TIME(SUM(TIME_TO_SEC(horas_total))) AS h_total
FROM rel_chmd_horas_setor
	GROUP BY setor
	ORDER BY COUNT('SETOR') DESC LIMIT 100;


----
Soma a quantidade de chamados por setor, total de horas gastas no setor em determinado período por data de abertura
----
SELECT setor, data_abertura, setor, data_fechamento, horas_total,
	COUNT('setor') AS qtde,
	SEC_TO_TIME(SUM(TIME_TO_SEC(hotas_rotal))) AS h_total
FROM rel_chmd_horas_setor
	WHERE data_abertura BETWEEN ('2011-12-01') AND ('2012-01-31')
	GROUP BY setor 
	ORDER BY COUNT('setor')
	DESC LIMIT 100;


----
Query simples
---
SELECT 
	idchamados,
	data_abertura,
	hora_abertura,
	analista,
	setor,
	contato_setor,
	ramal,
	prioridade,
	motivo,
	ip_vnc,
	detalhe_chamado,
	feed_back,
	status,
	data_fechamento,
	hora_fechamento
FROM
	chamados
ORDER BY
	setor, data_abertura

----
Querys
----
SELECT * FROM `helpdesk`.`setores` ORDER BY setor;

SELECT idsetores, setor FROM `helpdesk`.`setores` ORDER BY setor;

<?php
if (!isset($_SESSION)) session_start();

if (!isset($_SESSION['UsuarioID'])) {

	session_destroy();

	header("Location: login.php"); exit;

}

$data_i = implode("-",array_reverse(explode("/",$_POST["data_i"])));
$data_f = implode("-",array_reverse(explode("/",$_POST["data_f"])));

$host="10.0.14.15"; 
$login="root"; 
$senha="asd951357"; 
$database="helpdesk"; 
$tabela="rel_chmd_horas_setor";
$conn = mysql_connect($host, $login, $senha);
$db = mysql_select_db($database);
$query = "SELECT setor, data_abertura, horas_total, COUNT('setor') AS qtde, SEC_TO_TIME(SUM(TIME_TO_SEC(horas_total))) AS h_total FROM $tabela WHERE data_abertura BETWEEN ('$data_i') AND ('$data_f') GROUP BY setor ORDER BY COUNT('setor')";
$sql = mysql_query($query, $conn);
// extract($dados); 

echo "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
echo "<html xmlns='http://www.w3.org/1999/xhtml'>";
echo "<head>";
echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />";
echo "<style type='text/css'>
<!--
h1 {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 16px;
}
h2 {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 14px;
}
h3 {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 12px;
}
table {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 10px;
}
p {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 10px;
}
body {
	font-family:Verdana, Geneva, sans-serif;
	font-size: 12px;
}
span {
	font-family:Verdana, Geneva, sans-serif;
	font-size:10px;
}
-->
</style>";
echo "<title>Relatório de Chamados: Horas por Setor</title>";
echo "</head>";
echo "<body>";
echo "<h3>Relatório de Chamados - Quantidade e Horas por Setor:</h3>";
echo "<p>Data Inicial: $_POST[data_i]</p>";
echo "<p>Data Final: $_POST[data_f]</p>";
echo "<table width='700' height='53' border='1' cellpadding='0' cellspacing='0'>";
echo "  <tr>";
echo "    <td width='200' align='center'><strong>Setor</strong></td>";
echo "    <td width='100' align='center'><strong>Chamados por Setor</strong></td>";
echo "    <td width='200' align='center'><strong>Horas - Setor</strong></td>";
// echo "    <td width='150' align='center'></td>";
echo "  </tr>";

while ($dados = mysql_fetch_array($sql)) {
$setor = $dados["setor"];
$qtde = $dados["qtde"];
$data_abertura = $dados["data_abertura"];
$horas_total = $dados["horas_total"];
$h_total = $dados["h_total"];
echo "
	<tr>
		<td align='center'>$setor</td>
		<td align='center'>$qtde</td>
		<td align='center'>$h_total</td>
	</tr>";
	}
echo "</table>";
echo "</body>";
echo "</html>";

mysql_close($conn);

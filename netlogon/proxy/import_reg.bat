REM FOR /F "TOKENS=2* DELIMS=:" %%a in ('IPCONFIG ^| find "IPv4" ^| find "10.0."') do for %%b in (%%a) Do set localIp=%%b

FOR /F "tokens=1 delims=:" %%d IN ('ping %computername% -4 -n 1 ^| find /i "resposta"') DO set localIp=%%d

set localIp=%localIp:~12,8%

if "%localIp" equ "10.0.18." (

rem REDE COM PROXY

regedit /s \\aplicacao\NETLOGON\browser\proxy_on.reg

) ELSE (

rem REDE EXCECAO DE PROXY

regedit /s \\aplicacao\NETLOGON\browser\proxy_off.reg

)

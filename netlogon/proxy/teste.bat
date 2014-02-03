FOR /F "tokens=1 delims=:" %%d IN ('ping %computername% -4 -n 1 ^| find /i "resposta"') DO set localIp=%%d

set localIp=%localIp:~12,8%
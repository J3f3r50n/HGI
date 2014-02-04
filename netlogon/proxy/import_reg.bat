REM FOR /F "TOKENS=2* DELIMS=:" %%a in ('IPCONFIG ^| find "IPv4" ^| find "10.0."') do for %%b in (%%a) Do set localIp=%%b
REM Autor: Jeferson Lopes @2014
FOR /F "tokens=1 delims=:" %%d IN ('ping %computername% -4 -n 1 ^| find /i "resposta"') DO set lip=%%d
set lip=%lip:~12,8%
set pon=10.0.18.
set po1=10.0.16.
set po2=10.0.15.
set po3=10.0.14.

if %lip%==%pon% (
	C:\Windows\regedit.exe /s \\aplicacao\NETLOGON\browser\proxy_on.reg
	GOTO :FIM
) ELSE (
GOTO :REDE1
)
:REDE1
if %lip%==%po1% (
	C:\Windows\regedit.exe /s \\aplicacao\NETLOGON\browser\proxy_off.reg
	GOTO :FIM
) ELSE (
GOTO :REDE2
)
:REDE2
if %lip%==%po2% (
	C:\Windows\regedit.exe /s \\aplicacao\NETLOGON\browser\proxy_on.reg
	GOTO :FIM
) ELSE (
GOTO :REDE3
)
:REDE3
if %lip%==%po3% (
	C:\Windows\regedit.exe /s \\aplicacao\NETLOGON\browser\proxy_on.reg
	GOTO :FIM
) ELSE (
	C:\Windows\regedit.exe /s \\aplicacao\NETLOGON\browser\proxy_on.reg
	GOTO :FIM
)
:FIM

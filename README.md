
Příkazy pro spuštění serveru:

- git clone <link> #stáhnutí repozitáře
- cd zabbix02
- vagrant up

Co se děje na pozadí?

Vagrant si nainstaluje Ubuntu, nainstaluje balíčky jako zabbix-nginx-conf, zabbix-agent2, zabbix-server-mysql, zabbix-frontend-php. Vytvoří databázi zabbix. Poté se automaticky importuje certifikát pro monitorování.
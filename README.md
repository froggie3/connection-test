# Connection-test

Ping per two seconds, if it is lost it tries traceroute. This script was written so I can monitor my internet connectivity for a while.

# Usage: 
```bash
php ping.php
```
Please note that the destination was hardcoded so if you want to change them you need to tweak both codes in `*.ps1` and `*.php`.
# Requisites

```bash
> pwsh -v
PowerShell 7.2.8
```

```bash
> php -v
PHP 8.1.11 (cli) (built: Sep 28 2022 11:08:01) (NTS Visual C++ 2019 x64)
Copyright (c) The PHP Group
Zend Engine v4.1.11, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.11, Copyright (c), by Zend Technologies
    with Xdebug v3.1.5, Copyright (c) 2002-2022, by Derick Rethans
```
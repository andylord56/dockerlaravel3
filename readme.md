Before using on windows install Chocolatey
This will allow to use the makefile

```sh
Step 1) install: https://chocolatey.org/install
Step 2) run in cmd: choco install make
```

Make sure you have your .env setup
```sh
cp .env.example .env

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

Key generate, migrate, seed, npm:

```sh
make setup
```

Run App

```sh
make dshell
```

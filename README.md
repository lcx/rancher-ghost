# rancher-ghost
Ghost on Docker that work fine on rancher environment (and all other system ;))

This container support out of the box the following external database :
- MySQL

PostgreSQL Support was dropped by Ghost. https://dev.ghost.org/dropping-support-for-postgresql/

## Run ghost with Database

### Use ghost with external MySQL Database

First, run the official MySQL container:
```bash
docker run -d --name mysql-ghost -e 'MYSQL_DATABASE=ghost' -e 'MYSQL_USER=ghost' -e 'MYSQL_PASSWORD=password'  mysql:5.7
```

Then run Ghost with the `link` option. The init script will get all Database parameters with the environment variable provided by the `link` option:
```bash
docker run -d --name ghost --link mysql-ghost:db -e 'GHOST_URL=http://my-blog.mydomain.com' -p 80:2368 quay.io/webcenter/rancher-ghost:0.8.0-1
```

You can use directly the `docker-compose` file called `docker-compose_mysql.yml`:
```bash
docker-compose -f docker-compose_mysql.yml up
```

## Extra parameters

### The server mail setting
#### Use external SMTP server

Run ghost container with this extras environment variables:
- `MAIL_HOST`: the DNS or IP of your SMTP server
- `MAIL_SSL`: set `true` if your SMTP server use SSL/TLS

If you need authentication, also set:
- `MAIL_USER`: you use accounts
- `MAIL_PASSWORD`: your password

### Set the from mail address
Run ghost container with this extras environment variables:
- `MAIL_FROM_ADDRESS="No reply" <no-replay@my-domain.com`

## All parameters availables

- `DB_TYPE`: the DB type you should use (sqlite, postgresql or mysql). Default is `sqlite`
- `DB_HOST`: The DNS or IP of the remote database server. No default value.
- `DB_DATABASE`: The database name. Default is `ghost`
- `DB_USER`: The user to access on remote database. No default value
- `DB_PASS`: The password to access on remote database. No default value
- `DB_PORT`: The database port. Default is 5432 for Postgres and 3306 for MySQL.
- `GHOST_PORT`: The ghost port. Default is `2368`
- `GHOST_URL`: The full public URL to access on your blog. Default is `http://0.0.0.0:2368`
- `MAIL_HOST`: The DNS or IP of the remote mail server. No default value.
- `MAIL_TRANSPORT`: The mail protocol to speak with the mail server. Default is `SMTP`
- `MAIL_SSL`: Enable or disable the SSL/TLS to speak with the mail server. Default is `false`.
- `MAIL_PORT`: The port to access on remote mail server. Default is `25`.
- `MAIL_USER`: The user to access on remote mail server. No default value.
- `MAIL_PASSWORD`: The password to access on remote mail server. No default value.
- `MAIL_SERVICE`: Choose the extra mail provider (SES, Gmail or Mailgun). No default value
- `MAIL_FROM_ADDRESS`: The mail address used to send mail. No default value

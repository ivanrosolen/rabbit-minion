# Rabbit HTTP API Minion

- [Minion Helper Usage](Minion.md)

- [Minion Importer Usage](Minion_Importer.md)

## Dependências

```
rabbitmq-plugins enable rabbitmq_management
```

## Acesso

 - Ideal seria ter um user específico de managment, porém podemos utilziar o
 guest:guest que deve ter acesso a todos os vhosts e tudão

## Verificar se tem o vhost

```
$ curl -i -u guest:guest http://host:15672/api/vhosts
```

```
HTTP/1.1 200 OK
Server: MochiWeb/1.1 WebMachine/1.10.0 (never breaks eye contact)
Date: Mon, 16 Sep 2013 12:00:02 GMT
Content-Type: application/json
Content-Length: 30

[{"name":"/","tracing":false}]
```

## Criar o vhost

```
$ curl -i -u guest:guest -H "content-type:application/json" \
   -XPUT http://host:15672/api/vhosts/ivan
```

```
HTTP/1.1 204 No Content
Server: MochiWeb/1.1 WebMachine/1.10.0 (never breaks eye contact)
Date: Mon, 16 Sep 2013 12:03:00 GMT
Content-Type: application/json
Content-Length: 0
```

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


## Lista de Vhosts

```
curl -i -u USER:PWD http://HOST:15672/api/vhosts
```

## Criar um vhost

- VHOST_NAME: Nome do novo Vhost

```
curl -i -u USER:PWD -H "content-type:application/json" \
   -XPUT http://HOST:15672/api/vhosts/VHOST_NAME
```

## Lista de Exchanges de um Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"

```
curl -i -u USER:PWD http://HOST:15672/api/exchanges/VHOST_NAME
```

## Criar uma exchange

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"
- EXCHANGE_NAME: Nome da nova Exchange
- type: tipo da exchange (direct, topic, fanout, headers)
- durable: true|false

```
curl -i -u USER:PWD -H "content-type:application/json" \
    -XPUT -d'{"type":"direct","durable":true}' \
    http://HOST:15672/api/exchanges/VHOST_NAME/EXCHANGE_NAME
```

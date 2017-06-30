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

## Informações de um Vhost

- VHOST_NAME: Nome do Vhost

```
curl -i -u USER:PWD http://HOST:15672/api/vhosts/VHOST_NAME
```

## Criar um vhost

- VHOST_NAME: Nome do novo Vhost

```
curl -i -u USER:PWD -H "content-type:application/json" \
   -XPUT http://HOST:15672/api/vhosts/VHOST_NAME
```

## Lista de Exchanges

```
curl -i -u USER:PWD http://HOST:15672/api/exchanges
```

## Lista de Exchanges de um Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"

```
curl -i -u USER:PWD http://HOST:15672/api/exchanges/VHOST_NAME
```

## Informações de uma Exchange

- VHOST_NAME: Nome do Vhost
- EXCHANGE_NAME: Nome da Exchange

```
curl -i -u USER:PWD http://HOST:15672/api/exchanges/VHOST_NAME/EXCHANGE_NAME
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

## Lista de Queues

```
curl -i -u USER:PWD http://HOST:15672/api/queues
```

## Lista de Queues de um Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"

```
curl -i -u USER:PWD http://HOST:15672/api/queues/VHOST_NAME
```

## Informações de uma Queue

- VHOST_NAME: Nome do Vhost
- QUEUE_NAME: Nome da Queue

```
curl -i -u USER:PWD http://HOST:15672/api/queues/VHOST_NAME/QUEUE_NAME
```

## Criar uma Queue

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"
- QUEUE_NAME: Nome da nova Queue
- auto-delete: true|false
- durable: true|false

```
curl -i -u USER:PWD -H "content-type:application/json" \
    -XPUT -d'{"auto_delete":"false","durable":true}' \
    http://HOST:15672/api/queues/VHOST_NAME/QUEUE_NAME
```

## Lista de Bindings

```
curl -i -u USER:PWD http://HOST:15672/api/bindings
```

## Lista de Bindings de um Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"

```
curl -i -u USER:PWD http://HOST:15672/api/bindings/VHOST_NAME
```

## Lista de Bindings de uma Queue/Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"
- QUEUE_NAME: Nome da  Queue

```
curl -i -u USER:PWD http://HOST:15672/api/queues/VHOST_NAME/QUEUE_NAME/bindings/
```

## Lista de Bindings de uma Exchange/Queue/Vhost

- VHOST_NAME: Nome do Vhost ou default "/" utilizar "%2f"
- EXCHANGE_NAME: Nome da exchange
- QUEUE_NAME: Nome da Queue

```
curl -i -u USER:PWD http://HOST:15672/api/bindings/VHOST_NAME/e/EXCHANGE_NAME/q/QUEUE_NAME
```
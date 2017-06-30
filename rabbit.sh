#!/usr/bin/env bash

# rabbit minion functions
_help()
{
    echo "Daa hahaha hana dul sae aaaaaah bannnaaaaaaa"
}

_checkVhost()
{

    echo "Vhost name:"
    read vhost
    echo "Checking Vhost ..."
    VHOSTS=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/vhosts/$vhost)
    VHOST_CHECK=",\"name\":\"$vhost\",\"tracing\":false}"

    if [[ $VHOSTS == *"$VHOST_CHECK"* ]]
    then
        echo "Yeah! It's Alive"
    else
        echo "Nope! You may create a new one"
    fi
}

_createVhost()
{

    echo "Vhost name:"
    read vhost
    echo "Creating Vhost ..."
    result=$(curl -s -i -u $rabbit_user:$rabbit_pwd -H "content-type:application/json" \
    -XPUT http://$rabbit_host:15672/api/vhosts/$vhost)
    result_check="HTTP/1.1 204 No Content"

    if [[ $result == *"$result_check"* ]]
    then
        echo "Vhost Created"
    else
        echo "Ops! Something went wrong :("
    fi
}

_checkExchange()
{

    echo "Vhost name:"
    read vhost
    echo "Exchange name:"
    read exchange
    echo "Checking Exchange ..."
    EXCHANGES=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/exchanges/$vhost/$exchange)
    EXCHANGE_CHECK="\"name\":\"$exchange\",\"vhost\":\"$vhost\","

    if [[ $EXCHANGES == *"$EXCHANGE_CHECK"* ]]
    then
        echo "Yeah! It's Alive"
    else
        echo "Nope! You may create a new one"
    fi
}

_createExchange()
{
    echo "Vhost name:"
    read vhost
    echo "Exchange name:"
    read exchange
    echo "Exchange type (direct|topic|fanout|headers):"
    read exchange_type
    echo "Exchange durable (true|false):"
    read exchange_durable
    echo "Creating Exchange ..."
    result=$(curl -s -i -u $rabbit_user:$rabbit_pwd -H "content-type:application/json" \
    -XPUT -d "{\"type\":\"$exchange_type\",\"durable\":$exchange_durable}" \
    http://$rabbit_host:15672/api/exchanges/$vhost/$exchange)
    result_check="HTTP/1.1 204 No Content"
    exists_check="{\"error\":\"bad_request\",\"reason\":\"406 PRECONDITION_FAILED - cannot redeclare exchange"

    if [[ $result == *"$result_check"* ]]
    then
        echo "Exchange Created"
    elif [[ $result == *"$exists_check"* ]]
    then
        echo "Exchange Already Exists :/"
    else
        echo "Ops! Something went wrong :("
    fi
}

_checkQueue()
{

    echo "Vhost name:"
    read vhost
    echo "Queue name:"
    read queue
    echo "Checking Queue ..."
    QUEUES=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/queues/$vhost)
    EXCHANGE_QUEUE="\"name\":\"$queue\",\"vhost\":\"$vhost\",\"durable\""

    if [[ $QUEUES == *"$EXCHANGE_QUEUE"* ]]
    then
        echo "Yeah! It's Alive"
    else
        echo "Nope! You may create a new one"
    fi
}

_createQueue()
{
    echo "Vhost name:"
    read vhost
    echo "Queue name:"
    read queue
    echo "Queue durable (true|false):"
    read durable
    echo "Queue auto-delete (true|false):"
    read autodelete
    echo "Creating Queue ..."
    result=$(curl -s -i -u $rabbit_user:$rabbit_pwd -H "content-type:application/json" \
    -XPUT -d "{\"durable\":$durable,\"auto_delete\":$autodelete}" \
    http://$rabbit_host:15672/api/queues/$vhost/$queue)
    result_check="HTTP/1.1 204 No Content"
    exists_check="{\"error\":\"bad_request\",\"reason\":\"406 PRECONDITION_FAILED - parameters for queue '$queue' in vhost '$vhost' not equivalent\"}"

    if [[ $result == *"$result_check"* ]]
    then
        echo "Queue Created"
    elif [[ $result == *"$exists_check"* ]]
    then
        echo "Queue Already Exists :/"
    else
        echo "Ops! Something went wrong :("
    fi
}

_checkBinding()
{

    echo "Vhost name:"
    read vhost
    echo "Queue name:"
    read queue
    echo "Exchange name:"
    read exchange
    echo "Checking Binding ..."
    BINDING=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/bindings/$vhost/e/$exchange/q/$queue)
    BINDING_EXCHANGE_QUEUE="{\"source\":\"$exchange\",\"vhost\":\"$vhost\",\"destination\":\"$queue\","

    if [[ $BINDING == *"$BINDING_EXCHANGE_QUEUE"* ]]
    then
        echo "Yeah! It's Alive"
    else
        echo "Nope! You may create a new one"
    fi
}

_createBinding()
{
    echo "Vhost name:"
    read vhost
    echo "Queue name:"
    read queue
    echo "Exchange name:"
    read exchange
    echo "Routing Key name (optional):"
    read routingkey
    echo "Creating Binding ..."
    result=$(curl -s -i -u $rabbit_user:$rabbit_pwd -H "content-type:application/json" \
    -XPOST -d "{\"routing_key\":\"$routingkey\"}" \
    http://$rabbit_host:15672/api/bindings/$vhost/e/$exchange/q/$queue)
    result_check="HTTP/1.1 201 Created"
    exchange_exists_check="{\"error\":\"not_found\",\"reason\":\"NOT_FOUND - no exchange '$exchange' in vhost '$vhost'\"}"
    queue_exists_check="{\"error\":\"not_found\",\"reason\":\"NOT_FOUND - no queue '$queue' in vhost '$vhost'\"}"

    if [[ $result == *"$result_check"* ]]
    then
        echo "Binding Created"
    elif [[ $result == *"$exchange_exists_check"* ]]
    then
        echo "Exchange Not Exists :/"
    elif [[ $result == *"$queue_exists_check"* ]]
    then
        echo "Queue Not Exists :/"
    else
        echo "Ops! Something went wrong :("
    fi
}


echo "Rabbit Host:"
read rabbit_host
echo "Rabbit Administrator User:"
read rabbit_user
echo "Rabbit Administrator Password:"
read rabbit_pwd
echo "
Rabbit Minion Options:"

PS3='bannnaaaaaaa: '
options=(
"Help"
"Check Vhost"
"Create Vhost"
"Check Exchange"
"Create Exchange"
"Check Queue"
"Create Queue"
"Check Binding"
"Create Binding"
"Quit"
)

select opt in "${options[@]}"
do
    case $opt in
        "Help")
            _help
            break
            ;;
        "Check Vhost")
            _checkVhost
            break
            ;;
        "Create Vhost")
            _createVhost
            break
            ;;
        "Check Exchange")
            _checkExchange
            break
            ;;
        "Create Exchange")
            _createExchange
            break
            ;;
        "Check Queue")
            _checkQueue
            break
            ;;
        "Create Queue")
            _createQueue
            break
            ;;
        "Check Binding")
            _checkBinding
            break
            ;;
        "Create Binding")
            _createBinding
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

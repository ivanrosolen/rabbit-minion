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
    VHOSTS=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/vhosts)
    VHOST_CHECK="{\"name\":\"$vhost\",\"tracing\":false}"

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
    -XPUT http://$rabbit_host:15672/api/vhosts/foo)
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
    EXCHANGES=$(curl -s -i -u $rabbit_user:$rabbit_pwd http://$rabbit_host:15672/api/exchanges/$vhost)
    EXCHANGE_CHECK="{\"name\":\"$exchange\","

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

    if [[ $result == *"$result_check"* ]]
    then
        echo "Exchange Created"
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
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

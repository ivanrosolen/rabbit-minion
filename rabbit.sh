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


echo "Rabbit Host:"
read rabbit_host
echo "Rabbit Managment User:"
read rabbit_user
echo "Rabbit Managment Password:"
read rabbit_pwd
echo "
Rabbit Minion Options:"

PS3='bannnaaaaaaa: '
options=(
"Help"
"Check Vhost"
"Create Vhost"
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
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

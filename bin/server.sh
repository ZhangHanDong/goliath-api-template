#!/bin/bash


export PATH="/usr/local/ruby/bin:${PATH}"
server_name=$2

start () {
  cd /alidata1/var/apps/mobile-api/current
  bundle exec rake server:start[$server_name]
}

stop () {
  cd /alidata1/var/apps/mobile-api/current
  bundle exec rake server:stop
}

case $1 in
  start)
    start
  ;;
  stop)
    stop
  ;;
  *)
  echo $"Usage: $0 {start|stop}"
  exit 1
  ;;
esac

exit 0

# rabbitmq-to-zabbix
Node script to poll for RabbitMQ status and push to Zabbix using zabix_sender

## Installation on Ubuntu 14.04

### Prerequisites
```sudo apt-get install nodejs```

```sudo apt-get install npm```

```sudo ln -s /usr/bin/nodejs /usr/bin/node```

### NPM package global

```npm install -g rabbitmq-to-zabbix```

### Start

```ADDRESS=localhost:15672 USER=guest PASS=guest ZABBIX=10.117.9.199 HOST=opc1 ITEM=queue.messages rabbitmq-to-zabbix &```

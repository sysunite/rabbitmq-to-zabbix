#!/usr/bin/env node

process.title = 'rabbitmq-zabbix-sender';

try {
    require('coffee-script/register');
} catch(e) {}

require('./../lib/index');
# Libs
request = require('request')
exec    = require('child_process').exec

# Config
address  = process.env.ADDRESS
user     = process.env.USER
pass     = process.env.PASS
zabbix   = process.env.ZABBIX
host     = process.env.HOST
item     = process.env.ITEM

configured = ->
  address? and user? and pass? and zabbix? and host? and item?

# Test for config
if not configured()
  console.log('Missing configuration')
  return

# Get messages from RabbitMQ
getMessages = (callback) ->
  request.get(address + '/api/vhosts', {proxy: false, auth: {'user':user, 'pass': pass}}, (error, response, body) ->
    messages = JSON.parse(body)[0].messages
    callback(messages)
  )

# Send to Zabbix
sendToZabbix = (value, callback) ->
  cmd = """zabbix_sender --zabbix-server="#{zabbix}" --host="#{host}" --key="#{item}" --value="#{value}" """
  exec(cmd, callback)

# Run forever
(poll = ->
  getMessages((messages) ->
    sendToZabbix(messages, ->
      setTimeout(poll, 10000)
    )
  ))()
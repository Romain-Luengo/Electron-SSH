class ssh
  constructor: (host, name, password, port) ->
    @ssh_config = {
      host: host,
      port: port,
      username: name,
      password: password
    }
    Client = require('ssh2').Client
    @conn = new Client
    @conn.connect @ssh_config
  send: (request, callback) ->
    @conn.on 'ready', =>
      #console.log 'Co ready'
      @conn.exec request, (err, stream) =>
        if err
          throw err
        stream.on('close', (code, signal) =>
          #console.log 'Stream :: close :: code: ' + code + ', signal: ' + signal
        ).on('data', (data) ->
          callback data
        ).stderr.on 'data', (data) ->
          callback data
window.ssh = ssh

###conn.exec 'uptime', (err, stream) ->
    if err
      throw err
    stream.on('close', (code, signal) ->
      console.log 'Stream :: close :: code: ' + code + ', signal: ' + signal
      conn.end()
      return
    ).on('data', (data) ->
      console.log 'STDOUT: ' + data
      return
    ).stderr.on 'data', (data) ->
      console.log 'STDERR: ' + data###

class ssh
  constructor: (host, name, password, port, callback) ->
    Client = require 'ssh2'
    @conn1 = new Client()
    @conn1.on('ready', () =>
      console.log 'FIRST :: connection ready'
      callback()
    )
    @conn1.connect {
      host: host
      username: name
      password: password
      }

  send: (request, callback) ->
    @conn1.shell request, (err, stream) ->
      if err
        console.log err
        return
      stream.on 'data', (data) ->
        callback "" + data

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

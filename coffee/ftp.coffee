class ftp
  constructor: (host, name, password, port, callback) ->
    Client = require 'ftp'
    @conn = new Client()
    @conn.on('ready', () =>
      @conn.list(err, list) ->
        if err
          throw err
        console.dir list
        @conn.end()
    )
    @conn.connect {
      host: "5.196.69.227"
      user: "root"
      password: "nicolas95"
      port: "22"
      }

window.ftp = ftp

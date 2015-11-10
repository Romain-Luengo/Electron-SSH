(function() {
  var IndexController;

  IndexController = (function() {
    function IndexController(app, conn) {
      this.app = app;
      this.conn = conn;
      this.button();
      this.app.controller('IndexCtrl', (function(_this) {
        return function($scope) {
          $('[data-menu="click"]').click(function() {
            return console.log("yep");
          });
          return $('[data-menu="test"]').click(function() {
            var monssh;
            return monssh = new ssh($("#ip").val(), $("#name").val(), $("#pass").val(), "22", function() {
              return monssh.send("ls", function(retour) {
                console.log(retour);
                return monssh.send("cd node_modules", function(retour) {
                  console.log(retour);
                  return setTimeout(function() {
                    return monssh.send("ls", function(retour) {
                      return console.log(retour);
                    });
                  }, 1000);
                });
              });
            });
          });
        };
      })(this));
      this.app.controller('IndexTest', function($scope, $routeParams) {
        $scope.message = "Je suis une variable";
        return $scope.orderId = $routeParams.orderId;
      });
    }

    IndexController.prototype.button = function() {
      var remote;
      remote = require('remote');
      $(".bubble-red").click(function() {
        return remote.getCurrentWindow().close();
      });
      $(".bubble-green").click(function() {
        return remote.getCurrentWindow().minimize();
      });
      return $(".bubble-orange").click(function() {
        if (remote.getCurrentWindow().isMaximized()) {
          return remote.getCurrentWindow().unmaximize();
        } else {
          return remote.getCurrentWindow().maximize();
        }
      });
    };

    return IndexController;

  })();

  window.IndexController = IndexController;

}).call(this);

(function() {
  var Main;

  Main = (function() {
    function Main() {
      var indexController;
      this.app = angular.module('perplexe', ["ngRoute"]);
      this.app.config([
        "$routeProvider", function($routeProvider, $scope) {
          return $routeProvider.when('/', {
            templateUrl: 'partials/index.html',
            controller: 'IndexCtrl'
          }).when('/test/:orderId', {
            templateUrl: 'partials/test.html',
            controller: 'IndexTest'
          });
        }
      ]);
      indexController = new IndexController(this.app);
      this.app.run(function($rootScope, $templateCache) {
        return console.log('Started');
      });
    }

    return Main;

  })();

  $(function() {
    var main;
    return main = new Main();
  });

  window.Main = Main;

}).call(this);

(function() {
  var ssh;

  ssh = (function() {
    function ssh(host, name, password, port, callback) {
      var Client;
      Client = require('ssh2');
      this.conn1 = new Client();
      this.conn1.on('ready', (function(_this) {
        return function() {
          console.log('FIRST :: connection ready');
          return callback();
        };
      })(this));
      this.conn1.connect({
        host: host,
        username: name,
        password: password
      });
    }

    ssh.prototype.send = function(request, callback) {
      return this.conn1.exec(request, function(err, stream) {
        if (err) {
          console.log(err);
          return;
        }
        return stream.on('data', function(data) {
          return callback("" + data);
        });
      });
    };

    return ssh;

  })();

  window.ssh = ssh;


  /*conn.exec 'uptime', (err, stream) ->
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
        console.log 'STDERR: ' + data
   */

}).call(this);

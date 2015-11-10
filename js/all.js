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
          $('[data-menu="test"]').click(function() {
            var monssh;
            monssh = new ssh($("#ip").val(), $("#name").val(), $("#pass").val(), "22");
            return monssh.send("cd../", function(retour) {
              return console.log(retour);
            });
          });
          $("#explorerbutton").click(function() {
            if ($("#consolebutton").hasClass("active")) {
              $("#explorerbutton").addClass("active");
              $("#consolebutton").removeClass("active");
              $("#explorermain").addClass("active");
              $("#explorermain").removeClass("disable");
              $("#consolemain").addClass("disable");
              return $("#consolemain").removeClass("active");
            }
          });
          return $("#consolebutton").click(function() {
            if ($("#explorerbutton").hasClass("active")) {
              $("#consolebutton").addClass("active");
              $("#explorerbutton").removeClass("active");
              $("#consolemain").addClass("active");
              $("#consolemain").removeClass("disable");
              $("#explorermain").addClass("disable");
              return $("#explorermain").removeClass("active");
            }
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
    function ssh(host, name, password, port) {
      var Client;
      this.ssh_config = {
        host: host,
        port: port,
        username: name,
        password: password
      };
      Client = require('ssh2').Client;
      this.conn = new Client;
      this.conn.connect(this.ssh_config);
    }

    ssh.prototype.send = function(request, callback) {
      return this.conn.on('ready', (function(_this) {
        return function() {
          return _this.conn.exec(request, function(err, stream) {
            if (err) {
              throw err;
            }
            return stream.on('close', function(code, signal) {
              return _this.conn.end();
            }).on('data', function(data) {
              return callback("" + data);
            }).stderr.on('data', function(data) {
              return callback('' + data);
            });
          });
        };
      })(this));
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

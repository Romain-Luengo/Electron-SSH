class Main
  constructor: ->
    mysql = require "mysql"
    @app = angular.module('perplexe', ["ngRoute"])

    #connexion mysql
    connection = mysql.createConnection {
      socketPath : '/Applications/MAMP/tmp/mysql/mysql.sock',
      user       : 'root',
      password   : "root"
    }
    connection.query "USE kingoloto"
    # Setup routes
    @app.config ["$routeProvider", ($routeProvider, $scope) ->
      $routeProvider
        .when '/', {
          templateUrl: 'partials/index.html',
          controller: 'IndexCtrl'
        }

        .when '/test/:orderId', {
          templateUrl: 'partials/test.html',
          controller: 'IndexTest'
        }

    ]
    indexController = new IndexController @app, connection
    @app.run ($rootScope, $templateCache) ->
      console.log 'Started'

$ ->
  main = new Main()

window.Main = Main

class IndexController
  constructor: (@app, @conn) ->
    @button()
    @app.controller 'IndexCtrl', ($scope) =>

      $('[data-menu="click"]').click ->
        console.log "yep"

      #$('#myModal').modal('show')

      $('[data-menu="test"]').click ->
        monssh = new ssh $("#ip").val(), $("#name").val(), $("#pass").val(), "22", ->
          monssh.send "ls", (retour) ->
            console.log retour
            monssh.send "cd node_modules", (retour) ->
              console.log retour
              setTimeout ->
                monssh.send "ls", (retour) ->
                  console.log retour
              ,1000
            
    @app.controller 'IndexTest', ($scope, $routeParams) ->
      $scope.message = "Je suis une variable"
      $scope.orderId = $routeParams.orderId
  button: () ->
    remote = require 'remote'
    $(".bubble-red").click ->
      remote.getCurrentWindow().close()
    $(".bubble-green").click ->
      remote.getCurrentWindow().minimize()
    $(".bubble-orange").click ->
      if remote.getCurrentWindow().isMaximized()
        remote.getCurrentWindow().unmaximize()
      else
        remote.getCurrentWindow().maximize()


window.IndexController = IndexController

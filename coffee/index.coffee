class IndexController
  constructor: (@app, @conn) ->
    @button()
    @app.controller 'IndexCtrl', ($scope) =>

      $('[data-menu="click"]').click ->
        console.log "yep"
        
      $('#myModal').modal('show')

      $('[data-menu="test"]').click ->
        monssh = new ssh $("#ip").val(), $("#name").val(), $("#pass").val(), "22"
        console.log monssh.send("ls")

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

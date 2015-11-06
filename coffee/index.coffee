class IndexController
  constructor: (@app, @conn) ->
    @button()
    @app.controller 'IndexCtrl', ($scope) =>

      $('[data-menu="click"]').click ->
        console.log "yep"

      $('[data-test="test"]').click ->
        monssh = new ssh $("#ip").val(), $("#name").val(), $("#pass").val(), "22"
        console.log monssh.send("ls")

    @app.controller 'IndexTest', ($scope, $routeParams) ->
      $scope.message = "Je suis une variable"
      $scope.orderId = $routeParams.orderId
  button: () ->
    remote = require 'remote'
    $(".bubble-red").click ->
      remote.getCurrentWindow().close()
    $(".bubble-orange").click ->
      remote.getCurrentWindow().minimize()
window.IndexController = IndexController

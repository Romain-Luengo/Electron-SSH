class IndexController
  constructor: (@app, @conn) ->
    @button()
    @app.controller 'IndexCtrl', ($scope) =>

      $('[data-menu="click"]').click ->
        console.log "yep"

      #$('#myModal').modal('show')

      $('[data-menu="test"]').click ->
        monssh = new ftp($("#ip").val(), $("#name").val(), $("#pass").val(), "22")
        monssh.send "cd../", (retour) ->
          console.log retour

      $("#explorerbutton").click ->
        if $("#consolebutton").hasClass("active")
          $("#explorerbutton").addClass("active")
          $("#consolebutton").removeClass("active")
          $("#explorermain").addClass("active")
          $("#explorermain").removeClass("disable")
          $("#consolemain").addClass("disable")
          $("#consolemain").removeClass("active")

      $("#consolebutton").click ->
        if $("#explorerbutton").hasClass("active")
          $("#consolebutton").addClass("active")
          $("#explorerbutton").removeClass("active")
          $("#consolemain").addClass("active")
          $("#consolemain").removeClass("disable")
          $("#explorermain").addClass("disable")
          $("#explorermain").removeClass("active")

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

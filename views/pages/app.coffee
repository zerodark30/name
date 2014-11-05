(->
  "use strict"
  app = undefined
  app = angular.module("app", [ "ngRoute", "ngAnimate", "ui.bootstrap", "easypiechart", "mgo-angular-wizard", "textAngular", "ui.tree", "ngMap", "ngTagsInput", "app.ui.ctrls", "app.ui.directives", "app.ui.services", "app.controllers", "app.directives", "app.form.validation", "app.ui.form.ctrls", "app.ui.form.directives", "app.tables", "app.map", "app.task", "app.localization", "app.chart.ctrls", "app.chart.directives", "app.page.ctrls" ])
  app.config [ "$routeProvider", ($routeProvider) ->
    $routeProvider.when("/",
      redirectTo: "/login"
    ).when("/login",
      templateUrl: "views/pages/signin.html"
    ).when("/dashboard",
      templateUrl: "views/dashboard.html"
    ).when("/dispatch",
      templateUrl: "views/dynamic.html"
    ).when("/pages/signin",
      templateUrl: "views/pages/signin.html"
    ).when("/pages/blank",
      templateUrl: "views/pages/blank.html"
    ).when("/dispatch",
      templateUrl: "views/tables/dynamic.html"
    ).when("/management",
      templateUrl: "views/tables/management.html"
    ).otherwise redirectTo: "/404"
   ]
  app.run (authentication, $rootScope, $location) ->
    $rootScope.$on "$routeChangeStart", (evt) ->
      $location.url "/login"  unless authentication.isAuthenticated
      event.preventDefault()


  app.controller "AppCtrl", ($scope, $location, authentication) ->
    appId = undefined
    authKey = undefined
    params = undefined
    secret = undefined
    $scope.templates = [
      url: "/login"
    ,
      url: "/dashboard"
     ]
    appId = "10259"
    authKey = "wNqperJjtfd9qpf"
    secret = "sMcJzFmZqggSUby"
    token = undefined
    $scope.template = $scope.templates[0]
    $scope.session = QB.init(appId, authKey, secret, true)
    $scope.token = QB.createSession((err, result) ->
      if err
        $scope.loginError = "Invalid username/password combination"
      else
        token = result.token
    )
    $scope.login = (username, password) ->
      QB.login
        login: username
        password: password
      , (err, result) ->
        if err
          $scope.loginError = "Invalid username/password combination"
        else
          console.log token
          authentication.isAuthenticated = true
          $location.path "/dashboard"


  app.factory "authentication", ->
    isAuthenticated: false
    user: null

).call this
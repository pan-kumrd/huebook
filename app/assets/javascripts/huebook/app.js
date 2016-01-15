var huebook = angular.module('huebook', [
    'templates',
    'ngRoute',
    'controllers',
])

huebook.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'wall.html',
        controller: 'WallController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);

var controllers = angular.module('controllers', [])

controllers.controller("WallController", [ '$scope',
    function($scope) {

    }]);

var huebook = angular.module('huebook', [
    'templates',
    'ngRoute',
    'controllers',
    'services',
    'directives',
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

angular.module('controllers', []);
angular.module('services', []);
angular.module('directives', []);
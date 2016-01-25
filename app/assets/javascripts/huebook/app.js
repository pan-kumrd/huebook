var huebook = angular.module('huebook', [
    'templates',
    'ngRoute',
    'controllers',
    'services',
    'directives',
    'filters',
    'angularModalService'
])

huebook.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'wall.html',
        controller: 'WallController'
      }).
      when('/search/:query', {
        templateUrl: 'search.html',
        controller: 'SearchController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);

angular.module('controllers', []);
angular.module('services', []);
angular.module('directives', []);
angular.module('filters', []);

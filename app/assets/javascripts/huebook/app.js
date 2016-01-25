var huebook = angular.module('huebook', [
    'templates',
    'ngRoute',
    'controllers',
    'services',
    'directives',
    'filters',
    'angularModalService'
])

/*huebook.run(['$location', function($rootScope, $location) {
    $rootScope.go = function(path) {
        $location.path(where);
    };
}]);
*/

huebook.run(function($rootScope, $location) {
    $rootScope.go = function(path) {
        $location.path(path);
    }
});


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
      when('/profile/:id', {
        templateUrl: 'profile.html',
        controller: 'ProfileController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);

angular.module('controllers', []);
angular.module('services', []);
angular.module('directives', []);
angular.module('filters', []);

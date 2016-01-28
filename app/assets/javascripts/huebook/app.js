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

huebook.run(function($rootScope, $location, users) {
    $rootScope.go = function(path) {
        $location.path(path);
    };
    users.self().then(function(resp) {
        $rootScope.currentUser = resp.user;
        $rootScope.$broadcast("userChanged", $rootScope.currentUser);
    });

    $rootScope.search = function() {
        $location.path('/search/' + $('#hb-search').val());
    };
});


huebook.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'home.html',
        controller: 'HomeController'
      }).
      when('/search/:query', {
        templateUrl: 'search.html',
        controller: 'SearchController'
      }).
      when('/profile/:id', {
        templateUrl: 'profile.html',
        controller: 'ProfileController'
      }).
      when('/events', {
        templateUrl: 'events.html',
        controller: 'EventsController'
      }).
      when('/events/new', {
        templateUrl: 'event-editor.html',
        controller: 'EventEditorController'
      }).
      when('/events/:id', {
        templateUrl: 'event.html',
        controller: 'EventController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }]);

angular.module('controllers', []);
angular.module('services', []);
angular.module('directives', []);
angular.module('filters', []);

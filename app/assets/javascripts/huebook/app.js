var huebook = angular.module('huebook', [
    'templates',
    'ngRoute',
    'controllers',
    'services',
    'directives',
    'filters',
    'angularModalService'
]);

angular.module('controllers', []);
angular.module('directives', []);
angular.module('filters', []);
angular.module('services', []);

huebook.config(['$routeProvider',
function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'profile.html',
        controller: 'ProfileController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/search/:query', {
        templateUrl: 'search.html',
        controller: 'SearchController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/profile/:id', {
        templateUrl: 'profile.html',
        controller: 'ProfileController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/events', {
        templateUrl: 'events.html',
        controller: 'EventsController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/events/:id', {
        templateUrl: 'event.html',
        controller: 'EventController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/messages', {
        templateUrl: 'messages.html',
        controller: 'MessagesController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      when('/messages/:id', {
        templateUrl: 'messages.html',
        controller: 'MessagesController',
        resolve: { currentUser: function(users) { return users.currentUser(); } }
      }).
      otherwise({
        redirectTo: '/'
      });
}]);

huebook.run(['$rootScope', '$location', 'users', 'ModalService',
function($rootScope, $location, users, ModalService) {
    $rootScope.go = function(path) {
        $location.path(path);
    };

    //var split = $location.path().split("/");
    //$rootScope.location = split.length > 1 ? split[1] : 'profile';
    $rootScope.$on("$routeChangeSuccess", function() {
        var split = $location.path().split("/");
        $rootScope.location = split.length > 1 ? split[1] : 'profile';
    });

    $rootScope.search = function() {
        $location.path('/search/' + $('#hb-search').val());
    };


    $rootScope.currentUser = null;

    $rootScope.createEvent = function() {
        ModalService.showModal({
            templateUrl: 'modals/event-editor.html',
            controller: 'EventEditorController',
            inputs: {}
        }).then(function(modal) {
            modal.element.modal();
        });
    };
}]);


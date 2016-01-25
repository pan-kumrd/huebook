var controllers = angular.module("controllers");
controllers.controller("SearchController", [ '$scope', '$routeParams', '$location', 'posts', 'events', 'users',
function($scope, $routeParams, $location, posts, events, users) {

    $scope.users = [];
    $scope.events = [];
    $scope.posts = [];
    $scope.currentTab = '';

    $scope.$watch('currentTab', function(newValue, oldValue) {
        if ($scope.currentTab == 'users') {
            users.search($routeParams.query).then(function(results) {
                $scope.users = results.users;
            });
        } else if ($scope.currentTab == 'events') {
            events.search($routeParams.query).then(function(results) {
                $scope.events = results.events;
            });
        } else if ($scope.currentTab == 'posts') {
            posts.search($routeParams.query).then(function(results) {
                $scope.posts = results.posts;
            });
        }
    });

    $scope.go = function(where) {
        $location.path(where);
    }

    $scope.currentTab = 'users';

}]);

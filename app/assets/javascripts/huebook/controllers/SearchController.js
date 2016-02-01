var controllers = angular.module("controllers");
controllers.controller("SearchController", [ '$scope', '$routeParams', '$location', 'posts', 'events', 'users', 'friends',
function($scope, $routeParams, $location, posts, events, users, friends) {

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

    $scope.$on('updatePost', function(event, args) {
        for (var i = 0; i < $scope.posts.length; i++) {
            if ($scope.posts[i].id == args.post.id) {
                $scope.posts[i] = args.post;
                return;
            }
        }
    });

    $scope.sendFriendRequest = function(id) {
        friends.request(id).then(function(resp) {
            for (var i = 0; i < $scope.users.length; i++) {
                if ($scope.users[i].id == id) {
                    $scope.users[i].friendship = resp.friendship;
                    return;
                }
            }
        });
    };

    $scope.currentTab = 'users';

}]);

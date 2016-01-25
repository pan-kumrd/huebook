var controllers = angular.module('controllers');
controllers.controller("ProfileController", [ '$scope', '$routeParams', 'users', 'walls', 'friends',
function($scope, $routeParams, users, walls, friends) {

    $scope.wallId = $routeParams.id;
    $scope.wallType = "user";

    users.get($routeParams.id).then(function(resp) {
        $scope.user = resp.user;
    });

    walls.get('user', $routeParams.id).then(function(resp) {
        $scope.posts = resp.wall.posts;
    });

    $scope.sendFriendRequest = function() {
        friends.request($scope.user.id).then(function(resp) {
            $scope.user.friendship = resp.friendship;
        });
    };

    $scope.unfriend = function() {
        friends.unfriend($scope.user.id).then(function(resp) {
            $scope.user.friendship = null;
            $scope.$broadcast('reloadPosts');
        });
    };

}]);

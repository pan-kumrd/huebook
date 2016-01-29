var controllers = angular.module('controllers');
controllers.controller("ProfileController", [ '$scope', '$rootScope', '$routeParams', 'users', 'walls', 'friends',
function($scope, $rootScope, $routeParams, users, walls, friends) {

    $scope.wallId = $routeParams.id;
    $scope.wallType = "user";

    if ($scope.wallId !== undefined) {
        users.get($routeParams.id).then(function(resp) {
            $scope.user = resp.user;
        });
    } else {
        $scope.user = $rootScope.currentUser;
    }

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
   friends.pending().then(function(resp) {
        $scope.pendingFriendRequest = resp.friendships;
    });


    function removePendingFriend(id) {
        for (var i = 0; i < $scope.pendingFriendRequest.length; i++) {
            if ($scope.pendingFriendRequest[i].initiator.id == id) {
                $scope.pendingFriendRequest.splice(i, 1);
                return;
            }
        }
    };

    $scope.acceptFriend = function(id) {
        friends.accept(id).then(function(resp) {
            $scope.user.friendship = resp.friendship;
            removePendingFriend(id);
            // Load posts from new friend
            $scope.$broadcast('reloadPosts');
        });
    };
    $scope.rejectFriend = function(id) {
        friends.reject(id).then(function(resp) {
            $scope.user.friendship = null;
            removePendingFriend(id);
            $scope.$broadcast('reloadPosts');
        });
    };
}]);

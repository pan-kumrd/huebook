var controllers = angular.module('controllers');
controllers.controller("UserSidePaneController", [ '$scope', 'users', 'friends',
function($scope, users, friends) {

    users.self().then(function(resp) {
        $scope.user = resp.user;
    });

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
            removePendingFriend(id);
            // Load posts from new friend
            $scope.$broadcast('reloadPosts');
        });
    };
    $scope.rejectFriend = function(id) {
        friends.reject(id).then(function(resp) {
            removePendingFriend(id);
        });
    };
}]);


var controllers = angular.module('controllers');
controllers.controller("ProfileController", [ '$scope', '$rootScope', '$routeParams',
                                              'users', 'walls', 'friends',
                                              'messages',
function($scope, $rootScope, $routeParams, users, walls, friends, messages) {

    $scope.wallId = $routeParams.id;
    $scope.wallType = "user";
    $scope.unreadMessagesCount = 0;

    var messagesCheckTimer = null;

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

    function checkMessages() {
        var count = 0;
        messages.conversations().then(function(resp) {
            for (var i = 0; i < resp.conversations.length; i++) {
                count += (resp.conversations[i].received_cnt - resp.conversations[i].delivered_cnt);
            }
            $scope.unreadMessagesCount = count;
        });
    }

    checkMessages();
    messagesCheckTimer = setInterval(checkMessages, 5000);

    $scope.$on("$destroy", function() {
        clearInterval(messagesCheckTimer);
    });
}]);

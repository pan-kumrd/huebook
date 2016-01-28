var controllers = angular.module('controllers');
controllers.controller("InviteController", [ '$scope', '$location', 'eventId', 'eventrsvps', 'friends', 'eventrsvps',
function($scope, $location, eventId, eventrsvps, friends, eventrsvps) {

    $scope.eventId = eventId;
    $scope.rsvps = [];
    $scope.friends = [];

    $scope.close = function(result) {
        close(result, 500);
    };

    eventrsvps.getAll(eventId).then(function(resp) {
        for (var i = 0; i < resp.rsvps.length; i++) {
            $scope.rsvps.push(resp.rsvps[i].user.id);
        }
        friends.getAll().then(function(resp) {
            for (var i = 0; i < resp.friendships.length; i++) {
                var f = resp.friendships[i];
                if (f.friend.id == $scope.currentUser.id) {
                    $scope.friends.push(f.initiator);
                } else {
                    $scope.friends.push(f.friend);
                }
            }
        });
    });

}]);

var controllers = angular.module('controllers');
controllers.controller("EventRsvpsController", [ '$scope', '$location', 'eventId', 'status', 'statusLabels', 'eventrsvps',
function($scope, $location, eventId, status, statusLabels, eventrsvps) {

    $scope.eventId = eventId;
    $scope.status = status;
    $scope.statusLabels = statusLabels;

    eventrsvps.filter($scope.eventId, $scope.status).then(function(resp) {
        $scope.rsvps = resp.rsvps;
    });

    $scope.close = function(result) {
        close(result, 500);
    };

    $scope.openProfile = function(userId) {
        $location.path('profile/' + userId)
    };
}]);

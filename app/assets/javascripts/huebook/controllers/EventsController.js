var controllers = angular.module("controllers")
controllers.controller('EventsController', [ '$scope', 'events',
function($scope, events) {

    events.myEvents().then(function(resp) {
        $scope.events = resp.events;
    });

}]);

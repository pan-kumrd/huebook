var controllers = angular.module('controllers');
controllers.controller("EventEditorController", [ '$scope', '$routeParams', 'events',
function($scope, $routeParams, events) {

    $scope.newEventData = {};

    $scope.close = function(result) {
        close(result, 500); // close, but give 500ms for bootstrap to animate
    };

    $scope.createEvent = function(result) {
        var data = $scope.newEventData;
        data['event']['start'] =
            moment(angular.element(document.querySelector('#hb-new-event-start-input')).val()).unix();
        data['event']['end'] =
            moment(angular.element(document.querySelector('#hb-new-event-end-input')).val()).unix();
        events.create(data).then(function(resp) {
            close(false, 500);
            $scope.go('/events/' + resp.event.id);
        });
    };
}]);

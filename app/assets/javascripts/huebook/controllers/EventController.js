var controllers = angular.module("controllers");
controllers.controller("EventController", [ '$scope', '$routeParams', 'events', 'eventrsvps', 'walls', 'ModalService',
function($scope, $routeParams, events, eventrsvps, walls, ModalService) {

    $scope.statusLabels = { 'accepted': "Yeah, I\'m in!",
                            'tentative': "Hmm, maybe?",
                            'rejected': "Nooooope"
                    };

    // This will be undefined if we are only in preview mode
    $scope.wallId = $routeParams.id;
    $scope.wallType = 'event';

    $scope.$on('updateEvent', function(event, args) {
        $scope.event = args.event;
    });

    $scope.rsvp = function(status) {
        eventrsvps.changeRsvp($scope.event.id, status).then(function(resp) {
            $scope.$emit('updateEvent', { event: $scope.event });
        });
    };

    $scope.leave = function(status) {
        eventrsvps.leave($scope.event.id).then(function(resp) {
            $scope.$emit('updateEvent', { event: $scope.event });
        });
    };

    $scope.showRsvps = function(status) {
        ModalService.showModal({
            templateUrl: 'modals/event-rsvps.html',
            controller: 'EventRsvpsController',
            inputs: {
                eventId: $scope.event.id,
                status: status,
                statusLabels: $scope.statusLabels
            }
        }).then(function(modal) {
            modal.element.modal();
        });
    };

    $scope.invite = function() {
        ModalService.showModal({
            templateUrl: 'modals/invite.html',
            controller: 'InviteController',
            inputs: {
                eventId: $scope.event.id
            }
        }).then(function(modal) {
            modal.element.modal();
        });
    };


    // Only load wall if the ID is in URL, otherwise assume this is used in
    // EventPreview.
    if ($scope.wallId) {
        events.get($routeParams.id).then(function(resp) {
            $scope.event = resp.event;
        });
        walls.get('event', $routeParams.id).then(function(resp) {
            $scope.posts = resp.wall.posts;
        });
    }

}]);

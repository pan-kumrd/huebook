 var huebook = angular.module('huebook');
huebook.directive("eventPreview",
function() {
    return {
        restrict: 'E',
        templateUrl: 'partials/event-preview.html'
    };
});

var huebook = angular.module('huebook');
huebook.directive("message",
function() {
    return {
        restrict: 'E',
        templateUrl: 'partials/message.html'
    };
});

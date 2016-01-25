var huebook = angular.module('huebook');
huebook.directive("userPreview",
function() {
    return {
        restrict: 'E',
        templateUrl: 'partials/user-preview.html'
    };
});

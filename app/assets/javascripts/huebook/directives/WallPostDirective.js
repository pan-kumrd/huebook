var huebook = angular.module('huebook');
huebook.directive("wallPost",
function() {
    return {
        restrict: 'E',
        templateUrl: 'partials/wall-post.html'
    };
});

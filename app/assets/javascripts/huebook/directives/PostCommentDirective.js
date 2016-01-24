var huebook = angular.module('huebook');
huebook.directive("postComment",
function() {
    return {
        restrict: 'E',
        templateUrl: 'partials/post-comment.html'
    };
});

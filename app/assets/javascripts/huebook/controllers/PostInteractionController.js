var controllers = angular.module('controllers');
controllers.controller("PostInteractionController", [ '$scope', '$location', 'postId', 'action', 'postInteractions',
function($scope, $location, postId, action, postInteractions) {

    $scope.postId = postId;
    $scope.action = action;

    postInteractions.likes(postId).then(function(likes) {
        $scope.users = likes.users;
    });

    $scope.close = function(result) {
        close(result, 500); // close, but give 500ms for bootstrap to animate
    };

    $scope.openProfile = function(userId) {
        $location.path('profile/' + userId)
    };
}]);

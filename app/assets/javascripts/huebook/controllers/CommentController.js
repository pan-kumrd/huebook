var controllers = angular.module('controllers');
controllers.controller("CommentController", [ '$scope', 'comments', 'ModalService',
function($scope, comments, ModalService) {

    function showPostInteractionDialog(postId, commentId, action) {
            ModalService.showModal({
            templateUrl: 'modals/post-interaction.html',
            controller: 'PostInteractionController',
            inputs: {
                action: action,
                postId: postId,
                commentId: commentId
            }
        }).then(function(modal) {
            modal.element.modal();
        });
    }

    $scope.like = function() {
        comments.like($scope.post.id, $scope.comment.id).then(function(resp) {
            $scope.$emit('updateComment', { comment: resp.comment });
        });
    };

    $scope.unlike = function() {
        comments.unlike($scope.post.id, $scope.comment.id).then(function(resp) {
            $scope.$emit('updateComment', { comment: resp.comment });
        });
    };

    $scope.showLikes = function() {
        showPostInteractionDialog($scope.post.id, $scope.comment.id, 'Likes')
    };

    $scope.remove = function() {
        comments.remove($scope.post.id, $scope.comment.id).then(function(resp) {
            $scope.$emit('removeComment', { comment_id: $scope.comment.id });
            $scope.$emit('refreshPost');
        });
    };
}]);


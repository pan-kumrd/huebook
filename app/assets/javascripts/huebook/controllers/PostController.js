var controllers = angular.module('controllers');
controllers.controller("PostController", [ '$scope', 'posts', 'comments', 'ModalService',
function($scope, posts, comments, ModalService) {

    $scope.commentsVisible = false;
    $scope.comments = [];

    $scope.toggleComments = function() {
        $scope.commentsVisible = !$scope.commentsVisible;
        if ($scope.commentsVisible) {
            comments.get($scope.post.id).then(function(data) {
                $scope.comments = data.comments;
            });
        }
    };

   $scope.$on('updateComment', function(event, args) {
        for (var i = 0; i < $scope.comments.length; i++) {
            if ($scope.comments[i].id == args.comment.id) {
                $scope.comments[i] = args.comment;
                $scope.apply;
                return;
            }
        }
    });

    $scope.$on('appendComments', function(event, args) {
        $scope.comments = args.comments.push($scope.comments);
        $scope.apply;
    });

    $scope.$on('removeComment', function(event, args) {
        for (var i = 0; i < $scope.comments.length; i++) {
            if ($scope.comments[i].id == args.comment_id) {
                $scope.comments.splice(i, 1);
                $scope.apply;
                return;
            }
        }
    });

    $scope.$on('refreshPost', function(event, args) {
        posts.get($scope.post.id).then(function(post) {
            $scope.$emit("updatePost", { post: post.post });
        });
    });

    $scope.like = function() {
        posts.like($scope.post.id).then(function(post) {
            $scope.$emit("updatePost", { post: post.post });
        });
    };

    $scope.unlike = function() {
        posts.unlike($scope.post.id).then(function(post) {
            $scope.$emit("updatePost", { post: post.post });
        });
    };

    $scope.share = function() {
        // TODO
    };


    function showPostInteractionDialog(action) {
            ModalService.showModal({
            templateUrl: 'modals/post-interaction.html',
            controller: 'PostInteractionController',
            inputs: {
                action: action,
                postId: $scope.post.id
            }
        }).then(function(modal) {
            modal.element.modal();
        });
    }

    $scope.showLikes = function() {
        showPostInteractionDialog($scope.post.id, 'Likes')
    };

    $scope.showShares = function() {
        showPostInteractionDialog($scope.post.id, 'Shares')
    };

    $scope.remove = function() {
        posts.remove($scope.post.id).then(function() {
            $scope.$emit("removePost", { postId: $scope.post.id });
        });
    };


    function defaultCommentData() {
        return { 'comment' : {} };
    }

    $scope.newCommentData = defaultCommentData();

    $scope.submitComment = function() {
        var commentData = $scope.newCommentData;
        $scope.newCommentData = defaultCommentData();
        comments.create($scope.post.id, commentData).then(function(resp) {
            $scope.comments.push(resp.comment);
            $scope.$emit('updatePost', { post: resp.post });
            $scope.apply;
        });
    };


}]);

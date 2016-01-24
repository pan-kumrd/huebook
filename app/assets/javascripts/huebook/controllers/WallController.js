var controllers = angular.module('controllers');
controllers.controller("WallController", [ '$scope', 'posts', 'walls', 'ModalService',
function($scope, posts, walls, ModalService) {


    function updatePost(post) {
        for (var i = 0; i < $scope.posts.length; i++) {
            if ($scope.posts[i].id == post.post.id) {
                $scope.posts[i] = post.post;
                $scope.apply;
                return;
            }
        }
    };

    function prependPosts(posts) {
        $scope.posts = posts.concat($scope.posts);
        $scope.apply;
    }

    function defaultPostData() {
        return { 'post' : { 'private': true } };
    }

    function showPostInteractionDialog(postId, action) {
            ModalService.showModal({
            templateUrl: 'modals/post-interaction.html',
            controller: 'PostInteractionController',
            inputs: {
                action: action,
                postId: postId
            }
        }).then(function(modal) {
            modal.element.modal();
        });
    }

    $scope.newPostData = defaultPostData();

    walls.getDefault().then(function(data) {
        wall = data.walls[0]
        $scope.wallId = wall.id;
        $scope.wallType = wall.wall_type;
        $scope.posts = wall.posts;
    })

    $scope.like = function(postId) {
        posts.like(postId).then(updatePost);
    };

    $scope.unlike = function(postId) {
        posts.unlike(postId).then(updatePost);
    };

    $scope.share = function(postId) {
        // TODO
    };

    $scope.showLikes = function(postId) {
        showPostInteractionDialog(postId, 'Likes')
    };

    $scope.showShares = function(postId) {
        showPostInteractionDialog(postId, 'Shares')
    };

    $scope.remove = function(postId) {
        posts.remove(postId).then(function(data) {
            for (var i = 0; i < $scope.posts.length; i++) {
                if ($scope.posts[i].id == postId) {
                    $scope.posts.splice(i, 1);
                    $scope.apply;
                    return;
                }
            }
        });
    };

    $scope.submitWallPost = function() {
        var postData = $scope.newPostData;
        postData['post']['wall_id'] = $scope.wallId;
        postData['post']['wall_type'] = $scope.wallType;
        $scope.newPostData = defaultPostData();
        posts.create(postData).then(function(post) {
            prependPosts([post.post]);
        });
    };

}]);

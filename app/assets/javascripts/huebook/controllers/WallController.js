var controllers = angular.module('controllers');
controllers.controller("WallController", [ '$scope', 'posts',
function($scope, posts) {
    posts.getAll().then(function(posts) {
        $scope.posts = posts.posts;
    })

    $scope.like = function(postId) {
        posts.like(postId).then(function(post) {
            for (var i = 0; i < $scope.posts.length; i++) {
                if ($scope.posts[i].id == post.post.id) {
                    $scope.posts[i] = post.post;
                    $scope.apply;
                    return;
                }
            }
        });
    };
    $scope.unlike = function(postId) {
        posts.unlike(postId).then(function(post) {
            for (var i = 0; i < $scope.posts.length; i++) {
                if ($scope.posts[i].id == post.post.id) {
                    $scope.posts[i] = post.post;
                    $scope.apply;
                    return;
                }
            }
        });
    };
    $scope.share = function(postId) {

    };

}]);

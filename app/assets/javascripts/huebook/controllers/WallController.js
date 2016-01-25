var controllers = angular.module('controllers');
controllers.controller("WallController", [ '$scope', 'posts', 'walls',
function($scope, posts, walls) {

    $scope.posts = []

    $scope.$on('updatePost', function(event, args) {
        for (var i = 0; i < $scope.posts.length; i++) {
            if ($scope.posts[i].id == args.post.id) {
                $scope.posts[i] = args.post;
                return;
            }
        }
    });

    $scope.$on('prependPosts', function(event, args) {
        $scope.posts = args.posts.concat($scope.posts);
    });

    $scope.$on('removePost', function(event, args) {
        for (var i = 0; i < $scope.posts.length; i++) {
            if ($scope.posts[i].id == args.postId) {
                $scope.posts.splice(i, 1);
                return;
            }
        }
    });

    function defaultPostData() {
        return { 'post' : { 'private': true } };
    }

    $scope.newPostData = defaultPostData();

    walls.getDefault().then(function(resp) {
        wall = resp.walls[0]
        $scope.wallId = wall.id;
        $scope.wallType = wall.wall_type;
        $scope.posts = wall.posts;
    })

    $scope.submitWallPost = function() {
        var postData = $scope.newPostData;
        postData['post']['wall_id'] = $scope.wallId;
        postData['post']['wall_type'] = $scope.wallType;
        $scope.newPostData = defaultPostData();
        posts.create(postData).then(function(resp) {
            $scope.$emit("prependPosts", { posts: [ resp.post ] });
        });
    };


}]);

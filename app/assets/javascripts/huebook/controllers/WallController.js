var controllers = angular.module('controllers');
controllers.controller("WallController", [ '$scope', 'posts', 'walls',
function($scope, posts, walls) {

    $scope.posts = [];

    var isDefaultWall = ($scope.wallId === undefined);  // could be set by parent controller

    var lastCheck = 0;
    var refreshTimer = null;

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

    $scope.$on('reloadPosts', function(event, args) {
        function wallResponse(resp) {
            var wall = resp.wall
            $scope.wallId = wall.id;
            $scope.wallType = wall.wall_type;
            $scope.wallName = wall.wall_name;
            var postsCount = $scope.posts.length;
            for (var i = wall.posts.length - 1; i >= 0; i--) {
                var found = false;
                for (var j = postsCount - 1; j >= 0; j--) {
                    if ($scope.posts[j].id == wall.posts[i].id) {
                        $scope.posts[j] = wall.posts[i];
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    $scope.$emit('prependPosts', { posts: [ wall.posts[i] ] });
                }
            }
            lastCheck = Math.floor(Date.now() / 1000);
        }
        if (isDefaultWall) {
            walls.getDefault({ 'since': lastCheck }).then(wallResponse);
        } else {
            walls.get($scope.wallType, $scope.wallId, { 'since': lastCheck }).then(wallResponse);
        }
    });


    function defaultPostData() {
        return { 'post' : { 'private': true } };
    }
    $scope.newPostData = defaultPostData();

    $scope.submitWallPost = function() {
        var postData = $scope.newPostData;
        postData['post']['wall_id'] = $scope.wallId;
        postData['post']['wall_type'] = $scope.wallType;
        $scope.newPostData = defaultPostData();
        posts.create(postData).then(function(resp) {
            $scope.$emit("prependPosts", { posts: [ resp.post ] });
        });
    };


    refreshTimer = setInterval(function() {
        $scope.$emit('reloadPosts');
    }, 30 * 1000);
    $scope.$emit('reloadPosts');

    $scope.$on('$destroy', function() {
        clearInterval(refreshTimer);
    });
}]);

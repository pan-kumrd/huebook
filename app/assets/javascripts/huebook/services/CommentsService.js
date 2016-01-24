var services = angular.module('services');
services.factory('comments', [ '$http',
function($http) {
    return {
        get: function(postId) {
            return $http.get('/posts/' + postId + '/comments.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        like: function(postId, commentId) {
            return $http.post('/posts/' + postId + '/comments/' + commentId + '/like.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        unlike: function(postId, commentId) {
            return $http.post('/posts/' + postId + '/comments/' + commentId + '/unlike.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        create: function(postId, data) {
            return $http({
                            method: 'POST',
                            url: '/posts/' + postId + '/comments.json',
                            data: $.param(data),
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                        }).then(function(result) {
                            return result.data;
                        });
        },

        remove: function(postId, commentId) {
            return $http({
                            method: 'DELETE',
                            url: '/posts/' + postId + '/comments/' + commentId + '.json'
                        }).then(function(result) {
                            return result.data;
                        });
        }
    }
}]);

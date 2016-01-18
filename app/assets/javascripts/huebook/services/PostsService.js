var services = angular.module('services');
services.factory('posts', [ '$http',
function($http) {
    return {
        getAll: function() {
            //return the promise directly.
            return $http.get('/posts.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        like: function(id) {
            return $http.post('/posts/' + id + '/like.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        unlike: function(id) {
            return $http.post('/posts/' + id + '/unlike.json')
                        .then(function(result) {
                            return result.data;
                        });
        }

    }
}]);

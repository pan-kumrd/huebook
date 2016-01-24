var services = angular.module('services');
services.factory('postInteractions', [ '$http',
function($http) {
    return {
        likes: function(postId) {
            return $http.get('/posts/' + postId + '/likes.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);

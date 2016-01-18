var services = angular.module('services');
services.factory('users', [ '$http',
function($http) {
    return {
        getAll: function() {
            //return the promise directly.
            return $http.get('/users.json')
                        .then(function(result) {
                            return result.data;
                        });
        },
        get: function(id) {
            return $http.get('/users/' + id + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
   }
}]);


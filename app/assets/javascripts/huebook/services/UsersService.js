var services = angular.module('services');
services.factory('users', [ '$http',
function($http) {
    return {
        self: function() {
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


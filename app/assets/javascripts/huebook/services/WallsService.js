var services = angular.module('services');
services.factory('walls', [ '$http',
function($http) {
    return {
        getDefault: function() {
            return $http.get('/walls.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        get: function(type, id) {
            return $http.get('/walls/' + type + '/' + id + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);

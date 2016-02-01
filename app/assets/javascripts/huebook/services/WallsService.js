var services = angular.module('services');
services.factory('walls', [ '$http',
function($http) {
    return {
        getDefault: function(params) {
            return $http.get('/walls.json?' + jQuery.param(params))
                        .then(function(result) {
                            return result.data;
                        });
        },

        get: function(type, id, params) {
            return $http.get('/walls/' + type + '/' + id + '.json?' + jQuery.param(params))
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);

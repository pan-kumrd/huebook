var services = angular.module('services');
services.factory('events', [ '$http',
function($http) {
    return {

        search: function(query) {
            return $http.get('/search/events/' + query + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);

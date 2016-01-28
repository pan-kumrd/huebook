var services = angular.module('services');
services.factory('events', [ '$http',
function($http) {
    return {

        search: function(query) {
            return $http.get('/search/events/' + query + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        get : function(id) {
            return $http.get('/events/' + id + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        myEvents: function(query) {
            return $http.get('/events/my.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        create: function(data) {
            return $http({
                        method: 'POST',
                        url: '/events.json',
                        data: $.param(data),
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                    }).then(function(result) {
                        return result.data;
                    });
        }
    }
}]);

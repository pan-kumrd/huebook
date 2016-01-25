var services = angular.module('services');
services.factory('friends', [ '$http',
function($http) {
    return {
        getAll: function() {
            return $http.get('/friends.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        request: function(id) {
            return $http.post('/friends/' + id + '/request.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        accept: function(id) {
            return $http.post('/friends/' + id + '/accept.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        reject: function(id) {
            return $http.post('/friends/' + id + '/reject.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        unfriend: function(id) {
            return $http.delete('/friends/' + id + '/unfriend.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);
 

var services = angular.module('services');
services.factory('users', [ '$q', '$http', '$rootScope',
function($q, $http, $rootScope) {

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
        },
        search: function(query) {
            return $http.get('/search/users/' + query + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        currentUser: function() {
           var deferred = $q.defer();
           if ($rootScope.currentUser) {
               deferred.resolve();
           } else {
                $http.get('/users.json').success(function(result) {
                    if (result == null) {
                        deferred.reject();
                    } else {
                        $rootScope.currentUser = result.user;
                        deferred.resolve();
                    }
                });
           }

           return deferred.promise;
        }
   }
}]);


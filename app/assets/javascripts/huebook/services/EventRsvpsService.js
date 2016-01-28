var services = angular.module('services');
services.factory('eventrsvps', [ '$http',
function($http) {
    return {

        changeRsvp: function(eventId, status) {
            return $http.post('/events/' + eventId + '/rsvp/' + status + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        getAll: function(eventId) {
            return $http.get('/events/' + eventId + '/rsvp.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        filter: function(eventId, status) {
            return $http.get('/events/' + eventId + '/rsvp/' + status + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        leave: function(eventId) {
            return $http.delete('/events/' + eventId + '/rsvp.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        create: function(eventId, userId) {
            return $http.post('/events/' + eventId + '/invite/' + userId + '.json')
                        .then(function(result) {
                            return result.data;
                        });
        }
    }
}]);
 

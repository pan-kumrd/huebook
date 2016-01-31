var services = angular.module('services');
services.factory('messages', [ '$http',
function($http) {
    return {
        conversations: function() {
            return $http.get('/messages/conversations.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        messages: function(userId, since) {
            url = '/messages/' + userId;
            if (since > 0) {
                url += '?since=' + since;
            }
            return $http.get(url)
                        .then(function(result) {
                            return result.data;
                        });
        },

        ack: function(id) {
            return $http.post('/messages/' + id + '/ack.json')
                        .then(function(result) {
                            return result.data;
                        });
        },

        send: function(data) {
            return $http({
                        method: 'POST',
                        url: '/messages/send.json',
                        data: $.param(data),
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                    }).then(function(result) {
                        return result.data;
                    });
        }
    }
}]);

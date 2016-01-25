var controllers = angular.module('controllers');
controllers.controller("UserSidePaneController", [ '$scope', 'users',
function($scope, users) {

    users.self().then(function(resp) {
        $scope.user = resp.user
    });
}]);


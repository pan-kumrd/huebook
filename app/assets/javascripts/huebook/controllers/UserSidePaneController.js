var controllers = angular.module('controllers');
controllers.controller("UserSidePaneController", [ '$scope', 'users',
function($scope, users) {
    users.get(1).then(function(user) {
        $scope.user = user;
    })
}]);


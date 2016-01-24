var controllers = angular.module('controllers');
controllers.controller("UserSidePaneController", [ '$scope', 'users',
function($scope, users) {
    users.self().then(function(user) {
        $scope.user = user.user
    })
}]);


var huebook = angular.module('huebook');
huebook.filter('profilePic', function() {
    return function(str) {
        if (str === null || str === undefined || str === "") {
            return "/images/hue_avatar.png";
        } else {
            return str;
        }
    }
});

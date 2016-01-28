var huebook = angular.module('huebook');
huebook.filter('friendshipFilter', function() {
    return function(items, name) {
        if (!items) {
            return [];
        }
        if (!name || name === '') {
            return items;
        }
        var nameLc = name.toLowerCase();
        function nameFilter(friend) {
            return friend.first_name.toLowerCase().startsWith(nameLc)
                    || friend.last_name.toLowerCase().startsWith(nameLc);
        }

        return items.filter(nameFilter);
    }
});

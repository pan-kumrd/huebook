var huebook = angular.module('huebook');
huebook.filter('parsePastDate', function() {
    return function(str) {
        dt = moment(str, "YYYY-MM-DDTHH:mm:ss.SSSZ");
        return dt.fromNow();
    }
});
huebook.filter("parseDate", function() {
    return function(str) {
        dt = moment(str, "YYYY-MM-DDTHH:mm:ss.SSSZ");
        return dt.format("LLL");
    }
});


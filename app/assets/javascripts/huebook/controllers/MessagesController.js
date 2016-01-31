var controllers = angular.module('controllers');
controllers.controller("MessagesController", [ '$scope', '$routeParams', 'messages',
function($scope, $routeParams, messages) {

    $scope.conversations = new Array();
    $scope.messages = new Array();

    $scope.newMessage = ""
    $scope.userId = ($routeParams.id ? $routeParams.id : 0);

    var lastMsgCheck = 0;
    var msgRefreshTimer = null;

    var convRefreshTimer = null;

    function refreshMessages() {
        messages.messages($scope.userId, lastMsgCheck).then(function(resp) {
            var localMessageCount = $scope.messages.length;
            for (var i = 0; i < resp.messages.length; i++) {
                var dupl = false;
                for (var j = localMessageCount - 1; j >= 0; j--) {
                    if ($scope.messages[j].id == resp.messages[i].id) {
                        dupl = true;
                        break;
                    }
                }
                if (!dupl) {
                    $scope.messages.push(resp.messages[i]);
                }
            }
            messages.ack($scope.userId);
            lastMsgCheck = Math.floor(Date.now() / 1000);
        });
    }

    function refreshConversations() {
        messages.conversations().then(function(resp) {
            $scope.conversations = resp.conversations;
        });
    };

    $scope.openConversation = function(id) {
        for (var i = 0; i < $scope.conversations.length; i++) {
            if ($scope.conversations[i].user.id == id) {
                $scope.conversations[i].delivered_cnt = $scope.conversations[i].received_cnt;
                break;
            }
        }
        $scope.messages = new Array();
        $scope.userId = id;
        lastMsgCheck = 0;
        clearInterval(msgRefreshTimer);
        refreshMessages();
        msgRefreshTimer = setInterval(refreshMessages, 2000);
    };

    $scope.sendMessage = function() {
        var msgData = {
            "message" : {
                "text": $scope.newMessage,
                "to_id": $scope.userId
            }
        }
        messages.send(msgData).then(function(resp) {
            $scope.messages.push(resp.message);
            $scope.newMessage = "";
        });
    }

    $scope.$on("$destroy", function(){
        clearInterval(msgRefreshTimer);
        clearInterval(convRefreshTimer);
    });

    convRefreshTimer = setInterval(refreshConversations, 5000);
    refreshConversations();
    if ($scope.userId > 0) {
        $scope.openConversation($scope.userId);
    }
}]);

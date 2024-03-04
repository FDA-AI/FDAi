angular.module("starter").controller("AnalyzingCtrl", [
    "$scope", "$state", "qmService", "$stateParams", "$timeout",
    function($scope, $state, qmService, $stateParams, $timeout){
    $scope.controller_name = "AnalyzingCtrl";
    qmService.navBar.setFilterBarSearchIcon(false);
    $scope.$on("$ionicView.beforeEnter", function(){
        if (document.title !== "Study") {document.title = "Study";}
        qmService.hideLoader(); // Hide before robot is called in afterEnter
    });
    $scope.$on("$ionicView.enter", function(){
        qmService.navBar.hideNavigationMenu();
        qmService.fab();
    });
    $scope.$on("$ionicView.afterEnter", function(){
        $timeout(function() {
            qm.loaders.robots();
        }, 1);
    });
}]);

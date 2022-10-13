// Database
//var db = null;
/** @namespace window.qmLog */
angular.module('starter',
    [
        'ionic',
        'oc.lazyLoad',
        'highcharts-ng',
        'ng-mfb',
        'angular-clipboard',
        'ngMaterialDatePicker',
        'ngMaterial',
        'ngMessages',
        'angular-cache',
        'ngFileUpload',
        'angular-web-notification',
        'ngFitText',
        'ngMdIcons',
        'angularMoment',
    ]
)
    .run(["$ionicPlatform", "$ionicHistory", "$state", "$rootScope", "qmService",
        function($ionicPlatform, $ionicHistory, $state, $rootScope, qmService){
            if(qm.urlHelper.getParam('logout')){
                qm.storage.clear();
                qmService.setUser(null);
            }
            qmService.setPlatformVariables();
            $ionicPlatform.ready(function(){
                //$ionicAnalytics.register();
                if(ionic.Platform.isIPad() || ionic.Platform.isIOS()){
                    window.onerror = function(error, url, lineNumber){
                        var name = error.name || error.message || error;
                        var message = ' Script: ' + url + ' Line: ' + lineNumber;
                        qmLog.error(name, message, error);
                    };
                }
                if(window.StatusBar){
                    window.StatusBar.styleDefault();
                } // org.apache.cordova.statusbar required
            });
            $rootScope.goToState = function(stateName, stateParameters, ev){
                if(stateName === 'toggleRobot'){
                    qm.robot.toggle();
                    return;
                }
                if(stateName.indexOf('button') !== -1){
                    var showVariableSearchDialog = false; // Disabled until I can get it to add new variables properly and write tests for it
                    var buttonName = stateName;
                    const button = $rootScope.appSettings.appDesign.floatingActionButton.active[buttonName];
                    /** @namespace $rootScope.appSettings.appDesign.floatingActionButton */
                    stateName = button.stateName;
                    stateParameters = button.stateParameters;
                    const stateNames = qm.staticData.stateNames;
                    if(stateName === stateNames.reminderSearch && showVariableSearchDialog){
                        qmService.search.reminderSearch(null, ev, stateParameters.variableCategoryName);
                        return;
                    }
                    if(stateName === stateNames.measurementAddSearch && showVariableSearchDialog){
                        qmService.search.measurementAddSearch(null, ev, stateParameters.variableCategoryName);
                        return;
                    }
                }
                qmService.goToState(stateName, stateParameters, {reload: stateName === $state.current.name});
            };
            $ionicPlatform.registerBackButtonAction(function(event){
                if(qmService.backButtonState){
                    qmService.goToState(qmService.backButtonState);
                    qmService.backButtonState = null;
                    return;
                }
                if($ionicHistory.currentStateName() === 'app.upgrade'){
                    console.debug('registerBackButtonAction from upgrade: Going to default state...');
                    qmService.goToDefaultState();
                    return;
                }
                /** @namespace qm.getAppSettings().appDesign.defaultState */
                if($ionicHistory.currentStateName() === qm.getAppSettings().appDesign.defaultState){
                    ionic.Platform.exitApp();
                    return;
                }
                if($ionicHistory.backView()){
                    $ionicHistory.goBack();
                    return;
                }
                if(qm.storage.getItem(qm.items.user)){
                    qmService.navBar.showNavigationMenuIfHideUrlParamNotSet();
                    window.qmLog.debug('registerBackButtonAction: Going to default state...');
                    qmService.goToDefaultState();
                    return;
                }
                window.qmLog.debug('registerBackButtonAction: Closing the app');
                ionic.Platform.exitApp();
            }, 100);
            //var intervalChecker = setInterval(function(){if(qm.getAppSettings()){clearInterval(intervalChecker);}}, 500);
            if(qm.urlHelper.getParam('existingUser') || qm.urlHelper.getParam('introSeen') ||
                qm.urlHelper.getParam('refreshUser') || window.designMode){
                qmService.intro.setIntroSeen(true, "Url params have existingUser or introSeen or refreshUser or designMode");
                qm.storage.setItem(qm.items.onboarded, true);
            }
        }])
    .config(["$stateProvider", "$urlRouterProvider", "$compileProvider", "$ionicConfigProvider", "ngMdIconServiceProvider",
        function($stateProvider, $urlRouterProvider, $compileProvider, $ionicConfigProvider
        ){
            if(qm.urlHelper.getParam(qm.items.apiOrigin)){
                qm.storage.setItem(qm.items.apiOrigin, qm.urlHelper.getParam(qm.items.apiOrigin));
            }
            //$ionicCloudProvider.init({"core": {"app_id": "42fe48d4"}}); Trying to move to appCtrl
            $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|file|ftp|mailto|chrome-extension|ms-appx-web|ms-appx):/);
            $ionicConfigProvider.tabs.position("bottom"); //Places them at the bottom for all OS
            $ionicConfigProvider.navBar.alignTitle('center');
            if(ionic.Platform.isIPad() || ionic.Platform.isIOS()){
                $ionicConfigProvider.views.swipeBackEnabled(false);  // Prevents back swipe white screen on iOS when caching is disabled https://github.com/driftyco/ionic/issues/3216
            }
            Array.prototype.contains = function(obj){
                var i = this.length;
                while(i--){
                    if(this[i] === obj){
                        return true;
                    }
                }
            };
            var config_resolver = {
                appSettingsResponse: function($q){
                    var deferred = $q.defer();
                    deferred.resolve(qm.staticData.appSettings);
                    return deferred.promise;
                }
            };
            //config_resolver.loadMyService = ['$ocLazyLoad', function($ocLazyLoad) {return $ocLazyLoad.load([qm.appsManager.getAppConfig(), qm.appsManager.getPrivateConfig()]);}];
            var clientId = qm.api.getClientIdFromBuilderQueryOrSubDomain();
            if(clientId){
                qm.storage.setItem(qm.items.clientId, clientId);
            }
            qmStates.forEach(function(state){
                    if(state.name === ''){
                        return;
                    }
                    if(state.name === 'app'){
                        state.resolve = config_resolver;
                    }
                    var isPhysicianState = state.views && state.views.menuContent.templateUrl.indexOf('physician') !== -1;
                    if(isPhysicianState && !qm.appMode.isPhysician()){
                        return;
                    }
                    $stateProvider.state(state.name, state);
                });
            function setFallbackRoute(){
                if(qm.appMode.isPhysician()){
                    $urlRouterProvider.otherwise('/app/physician');
                } else if(qm.appMode.isBuilder()){
                    $urlRouterProvider.otherwise('/app/configuration');
                }else if(!qm.storage.getItem(qm.items.introSeen)){
                    $urlRouterProvider.otherwise('/app/intro');
                }else if(!qm.storage.getItem(qm.items.onboarded)){
                    $urlRouterProvider.otherwise('/app/onboarding');
                }else{
                    $urlRouterProvider.otherwise('/app/api-portal');
                }
            }
            setFallbackRoute();
        }])
angular.module('exceptionOverride', []).factory('$exceptionHandler', function(){
    return function(exception, cause){
        if(typeof bugsnag !== "undefined"){
            window.bugsnagClient = bugsnag("ae7bc49d1285848342342bb5c321a2cf");
            bugsnagClient.notify(exception, {metaData: {cause: cause}});
        }
    };
});

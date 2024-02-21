angular.module('starter').controller('PresentationCtrl', ["$scope", "$state", "$ionicSlideBoxDelegate", "$ionicLoading",
    "$rootScope", "$stateParams", "qmService", "appSettingsResponse", "$timeout",
    function($scope, $state, $ionicSlideBoxDelegate, $ionicLoading,
             $rootScope, $stateParams, qmService, appSettingsResponse, $timeout){
        qmService.initializeApplication(appSettingsResponse);
        qmService.navBar.setFilterBarSearchIcon(false);
        $scope.state = {
            autoplay: false,
            title: null,
            image: null,
			backgroundImg: null,
            hideTriangle: false,
            backgroundVideo: null,
            triangleName: {
                lineOne: "FDA",
                lineTwo: "Ai"
            },
	        slideIndex: 0,
	        start: function(){
		        qm.music.play();
		        $scope.state.next();
	        },
	        next: function(index){
		        $ionicSlideBoxDelegate.next();
	        },
	        previous: function(){
		        $ionicSlideBoxDelegate.previous();
	        },
	        slideChanged: function(index){
                var lastSlide = $scope.state.slides[$scope.state.slides.length - 1];
                if(lastSlide && lastSlide.cleanup){lastSlide.cleanup($scope);}
                qm.speech.shutUpRobot();
                //qm.music.play();
                qm.robot.openMouth();
				//debugger
		        qm.visualizer.showCircleVisualizer()
		        slide = $scope.state.slides[index];
		        $scope.state.hideTriangle = slide.img || slide.backgroundImg || slide.backgroundVideo || slide.title;
				if(slide.animation){slide.animation($scope);}
                $scope.state.backgroundImg = slide.backgroundImg || null;
                $scope.state.title = slide.title || null;
                $scope.state.image = slide.img || null;
                $scope.state.backgroundVideo = slide.backgroundVideo || null;
		        $scope.state.slideIndex = index;
                function callback(){
                    $timeout(function(){
                        if($scope.state.autoplay){
                            $scope.state.next();
                        }
                    },0.1 * 1000);
                }
                qm.speech.setCaption(slide.speech)
		        qm.speech.talkRobot(
			        slide.speech
			        , callback // $scope.state.next
			        , function(error){
				        qmLog.info("Could not read intro slide because: " + error);
			        }, false, false
		        );
	        },
	        slides: []
        };
        $scope.$on('$ionicView.beforeEnter', function(e){
            $rootScope.hideNavigationMenu = true;
	        qmService.rootScope.setProperty('speechEnabled', true);
	        $scope.showRobot = true;
	        qm.speech.setSpeechEnabled(true);
	        $scope.state.slides = slides;
        });
        $scope.$on('$ionicView.afterEnter', function(){
            qmService.navBar.hideNavigationMenu();
            qm.robot.onRobotClick = $scope.state.next;
			qmService.hideLoader();
        });
        $scope.$on('$ionicView.beforeLeave', function(){
            qm.music.fadeOut();
            qm.robot.onRobotClick = null;
			qmService.showFullScreenLoader();
        });
        $scope.$watch('state.backgroundVideo', function(newValue, oldValue) {
            if (newValue !== oldValue) {
                var videoElement = document.getElementById('presentation-background-video');
                if (videoElement) {
                    var slide = $scope.state.slides[$scope.state.slideIndex];
                    videoElement.playbackRate = 1;
                    if(slide.playbackRate){
                        videoElement.playbackRate = 0.5; // 50% of the normal speed
                    }
                    videoElement.load();
                }
            }
        });
    }]);

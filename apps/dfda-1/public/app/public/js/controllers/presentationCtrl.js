angular.module('starter').controller('PresentationCtrl', ["$scope", "$state", "$ionicSlideBoxDelegate", "$ionicLoading",
    "$rootScope", "$stateParams", "qmService", "appSettingsResponse", "$timeout",
    "$document",
    function($scope, $state, $ionicSlideBoxDelegate, $ionicLoading,
             $rootScope, $stateParams, qmService, appSettingsResponse, $timeout, $document){
        qmService.initializeApplication(appSettingsResponse);
        qmService.navBar.setFilterBarSearchIcon(false);
        $scope.state = {
            autoplay: true,
            musicPlaying: false,
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
                if($stateParams.music && !$scope.state.musicPlaying){
                    qm.music.play();
                    $scope.state.musicPlaying = true;
                }
                //qm.music.play();
                qm.robot.openMouth();
				//debugger
		        qm.visualizer.showCircleVisualizer()
		        slide = $scope.state.slides[index];
		        $scope.state.hideTriangle = slide.img || slide.backgroundImg ||
                    slide.backgroundVideo || slide.title || slide.video;
				if(slide.animation){slide.animation($scope);}
                $scope.state.backgroundImg = slide.backgroundImg || null;
                $scope.state.title = slide.title || null;
                $scope.state.image = slide.img || null;
                $scope.state.backgroundVideo = slide.backgroundVideo || null;
                $scope.state.video = slide.video || null;
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
            if($stateParams.slides === 'slidesConvo'){
                $scope.state.slides = slidesConvo;
            }else {
                $scope.state.slides = slides;
            }
            if($stateParams.autoplay !== undefined){
                $scope.state.autoplay = $stateParams.autoplay;
            }
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
        function updateVideo(newValue, oldValue, id){
            if (newValue !== oldValue) {
                var videoElement = document.getElementById(id);
                if (videoElement) {
                    var slide = $scope.state.slides[$scope.state.slideIndex];
                    videoElement.playbackRate = 1;
                    if(slide.playbackRate){
                        videoElement.playbackRate = slide.playbackRate; // 50% of the normal speed
                    }
                    videoElement.load();
                }
            }
        }
        $scope.$watch('state.backgroundVideo', function(newValue, oldValue) {
            updateVideo(newValue, oldValue, 'presentation-background-video');
        });
        $scope.$watch('state.video', function(newValue, oldValue) {
            updateVideo(newValue, oldValue, 'presentation-video')
        });

        $document.bind("keydown", function(event) {
            switch(event.which) {
                case 32: // Spacebar code
                case 39: // Right arrow code
                    $scope.$apply(function () {
                        $scope.state.next();
                    });
                    break;
                case 37: // Left arrow code
                    $scope.$apply(function () {
                        $scope.state.previous();
                    });
                    break;
            }
        });

    }]);

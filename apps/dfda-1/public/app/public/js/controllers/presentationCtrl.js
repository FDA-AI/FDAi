angular.module('starter').controller('PresentationCtrl', ["$scope", "$state", "$ionicSlideBoxDelegate", "$ionicLoading",
    "$rootScope", "$stateParams", "qmService", "appSettingsResponse", "$timeout",
    "$document", '$sce',
    function($scope, $state, $ionicSlideBoxDelegate, $ionicLoading,
             $rootScope, $stateParams, qmService, appSettingsResponse, $timeout, $document, $sce){
        qmService.initializeApplication(appSettingsResponse);
        qmService.navBar.setFilterBarSearchIcon(false);
        var audio;
        $scope.state = {
            autoPlayMusic: true,
            autoplay: true,
            playing: false,
            title: null,
            image: null,
            music: $stateParams.music,
			backgroundImg: null,
            hideTriangle: false,
            backgroundVideo: null,
            triangleName: {
                lineOne: "FDA",
                lineTwo: "Ai"
            },
	        slideIndex: 0,
            toggleMusic: function(){
                if(qm.music.isPlaying($stateParams.music)){
                    qm.music.fadeOut($stateParams.music);
                }else{
                    qm.music.play($stateParams.music);
                }
            },
            pause: function(){
                if($scope.state.playing) {
                    $scope.state.autoplay = false;
                    $scope.state.playing = false;
                    qm.speech.shutUpRobot();
                } else {
                    $scope.state.autoplay = true;
                    $scope.state.playing = true;
                    $scope.state.slideChanged($scope.state.slideIndex);
                }
            },
	        start: function(){
		        $scope.state.next();
	        },
	        next: function(index){
		        $ionicSlideBoxDelegate.next();
	        },
	        previous: function(index){
		        $ionicSlideBoxDelegate.previous();
	        },
	        slideChanged: function(index){
                if(!$scope.state.playing){$scope.state.playing = true;}
                var lastSlide = $scope.state.slides[index - 1];
                if(lastSlide && lastSlide.cleanup){
                    lastSlide.cleanup($scope);
                }
                qm.speech.shutUpRobot();
                if(!qm.music.isPlaying($stateParams.music) && index === 1 && $stateParams.music){
                    qm.music.play($stateParams.music);
                }
                //qm.music.play();
				//debugger
		        qm.visualizer.showCircleVisualizer()
                //qm.visualizer.showSiriVisualizer();
		        slide = $scope.state.slides[index];
                if(slide.goToState){
                    qmService.goToState(slide.goToState);
                }
                if(audio){
                    fadeOut(audio, 1);
                    audio = null;
                }
                if(slide.audio){
                    audio = new Audio(slide.audio);
                    if(slide.volume){audio.volume = slide.volume;}
                    audio.play();
                }
                if(slide.autoplay !== undefined){
                    $scope.state.autoplay = slide.autoplay;
                }
		        $scope.state.hideTriangle = slide.img || slide.backgroundImg ||
                    slide.backgroundVideo || slide.title || slide.video;
				if(slide.animation){slide.animation($scope);}
                $scope.state.backgroundImg = slide.backgroundImg  ? $sce.trustAsResourceUrl(slide.backgroundImg) : null;
                $scope.state.title = slide.title || null;
                $scope.state.image = slide.img ? $sce.trustAsResourceUrl(slide.img) : null;
                $scope.state.backgroundVideo = slide.backgroundVideo  ? $sce.trustAsResourceUrl(slide.backgroundVideo) : null;
                $scope.state.video = slide.video  ? $sce.trustAsResourceUrl(slide.video) : null;
		        $scope.state.slideIndex = index;
                function callback(){
                    $timeout(function(){
                        if($scope.state.autoplay){
                            $scope.state.next();
                        }
                    },0.1 * 1000);
                }
                if(slide.humanSpeech){
                    human.talkHuman(
                        slide.humanSpeech
                        , callback
                        , function(error){
                            qmLog.info("Could not read intro slide because: " + error);
                        }
                    );
                }
                if(!slide.speech){return;}
                //qm.speech.setCaption(slide.speech)
                qm.robot.openMouth();
		        qm.speech.talkRobot(
			        slide.speech
			        , callback // $scope.state.next
			        , function(error){
				        qmLog.info("Could not read intro slide because: ", error);
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
            if($stateParams.showHuman){
                //human.showHuman();
            }
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
                        videoElement.playbackRate = slide.playbackRate;
                    }
                    videoElement.muted = false;
                    videoElement.loop = false;
                    videoElement.load();
                    // Add event listener for 'ended' event
                    videoElement.addEventListener('ended', function() {
                        this.loop = false; // prevent looping after video ends
                    }, false);
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
        // Fade out function
        function fadeOut(audio, duration) {
            var step = 0.01; // volume change step
            duration = duration || 1; // duration in seconds
            var interval = duration * 1000 / (1/step); // calculate interval length
            var fade = setInterval(function() {
                if (audio.volume > 0) {
                    audio.volume -= step;
                } else {
                    // Stop the audio when volume reaches 0
                    audio.pause();
                    audio.currentTime = 0;
                    clearInterval(fade);
                }
            }, interval);
        }
    }]);

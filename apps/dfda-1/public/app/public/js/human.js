const human = {
    talkHuman(text, successHandler, errorHandler) {
        if (!window.speechSynthesis) {
            errorHandler('Speech synthesis not supported');
            return;
        }

        const utterance = new SpeechSynthesisUtterance(text);
        utterance.voice = speechSynthesis.getVoices().find(voice => voice.lang === 'en-US' && voice.gender === 'male');
        utterance.onend = successHandler;
        utterance.onerror = errorHandler;

        document.getElementById('human-mouth').style.animation = 'moveMouth 0.2s infinite';

        speechSynthesis.speak(utterance);

        utterance.onend = () => {
            document.getElementById('human-mouth').style.animation = '';
            successHandler();
        };
    },
    shutUpHuman() {
        speechSynthesis.cancel();
    },
    showHuman() {
        document.getElementById('human-container').style.display = 'block';
    },
    hideHuman() {
        document.getElementById('human-container').style.display = 'none';
    }
};

// Example usage:
// human.talkHuman('Hello world', () => console.log('Finished speaking'), (error) => console.log(error));

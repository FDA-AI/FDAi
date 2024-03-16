// Define your questions, options, and callbacks
const questions = [
  {
    text: "Should the governments of the world use 1% of military spending to use AI to automate clinical research to find cures for the 2 billion people suffering from chronic diseases?",
    options: [
      { text: "Yes", callback: () => showPetitionPage() },
      { text: "No", callback: () => showCommentPage() },
    ],
  },
  // {
  //   text: "What's your favorite fruit?",
  //   options: [
  //     { text: "Apple", callback: () => console.log("Apple selected") },
  //     { text: "Banana", callback: () => console.log("Banana selected") },
  //     { text: "Orange", callback: () => console.log("Orange selected") },
  //   ],
  // },
];

// Google Analytics tracking code
const trackEvent = (category, action, label) => {
  if (window.ga) {
    window.ga("send", "event", category, action, label);
  }
};

// Function to move to the next question
let currentQuestionIndex = 0;
const nextQuestion = () => {
  if (currentQuestionIndex < questions.length - 1) {
    currentQuestionIndex++;
    renderQuestion();
  } else {
    showPetitionPage();
  }
};

// Function to show the petition page
const showPetitionPage = () => {
  overlay.innerHTML = `
    <div class="petition-page">
      <button class="close-btn">&#10005;</button>
      <h2 class="petition-title">Great!  Let's do it!</h2>
      <p class="petition-description">Please sign this petition to support the <a href="">FDAi Act</a> to automate clinical research to find cures for the 2 billion people suffering from chronic diseases and your will shall be done.</p>
      <form>
        <input type="text" placeholder="Name" required>
        <input type="email" placeholder="Email" required>
        <input type="text" placeholder="Country" required>
        <input type="text" placeholder="Zip Code" required>
        <button type="submit">Submit</button>
      </form>
    </div>
  `;

  const form = overlay.querySelector("form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = {};
    for (const [key, value] of formData.entries()) {
      data[key] = value;
    }
    // Send data to your server or handle it as needed
    console.log(data);
    trackEvent("Petition", "Signed", "");
    //closeOverlay();
    showSharingButtons();
  });

  const closeBtn = overlay.querySelector(".close-btn");
  closeBtn.addEventListener("click", closeOverlay);
};

// Function to show the comment page
const showCommentPage = () => {
  overlay.innerHTML = `
    <div class="comment-page">
      <h2>What's a more effective way to help people suffering from chronic illness?</h2>
      <form>
        <input type="text" placeholder="Name" required>
        <input type="email" placeholder="Email" required>
        <textarea placeholder="Comment" required></textarea>
        <button type="submit">Submit</button>
      </form>
      <button class="close-btn">&#10005;</button>
    </div>
  `;

  const form = overlay.querySelector("form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = {};
    for (const [key, value] of formData.entries()) {
      data[key] = value;
    }
    // Send data to your server or handle it as needed
    console.log(data);
    trackEvent("Comment", "Submitted", "");
    closeOverlay();
  });

  const closeBtn = overlay.querySelector(".close-btn");
  closeBtn.addEventListener("click", closeOverlay);
};

// Function to render the current question
const renderQuestion = () => {
  const currentQuestion = questions[currentQuestionIndex];
  overlay.innerHTML = `
      <button class="close-btn">&#10005;</button>
    <div class="question-container">
      <h2>${currentQuestion.text}</h2>
      <div class="options">
        ${currentQuestion.options
    .map(
      (option, index) => `
          <button class="option-btn" data-index="${index}">
            ${option.text}
          </button>
        `
    )
    .join("")}
      </div>
    </div>
  `;

  const optionBtns = overlay.querySelectorAll(".option-btn");
  optionBtns.forEach((btn, index) => {
    btn.addEventListener("click", () => {
      const selectedOption = currentQuestion.options[index];
      selectedOption.callback();
      trackEvent("Question", currentQuestion.text, selectedOption.text);
      nextQuestion();
    });
  });

  const closeBtn = overlay.querySelector(".close-btn");
  closeBtn.addEventListener("click", closeOverlay);
};

// Function to close the overlay
const closeOverlay = () => {
 // overlay.style.display = "none";
  showSharingButtons();

};

const showSharingButtons = () => {
  overlay.innerHTML = `
    <div class="sharing-buttons">
      <button class="close-btn">&#10005;</button>
      <h2>Thank you for your support!</h2>
      <p>Please share this petition with your friends and family to help us reach our goal.</p>
      <div class="social-share">
<a href="https://twitter.com/intent/tweet?text=Support%20the%20FDAi%20Act%20to%20automate%20clinical%20research%20to%20find%20cures%20for%20the%202%20billion%20people%20suffering%20from%20chronic%20diseases&url=https://fdai.earth" target="_blank"><i class="fab fa-twitter"></i> Share on Twitter</a>
<a href="https://www.facebook.com/sharer/sharer.php?u=https://fdai.earth" target="_blank"><i class="fab fa-facebook-f"></i> Share on Facebook</a>
<a href="https://www.linkedin.com/shareArticle?mini=true&url=https://fdai.earth&title=Support%20the%20FDAi%20Act&summary=Support%20the%20FDAi%20Act%20to%20automate%20clinical%20research%20to%20find%20cures%20for%20the%202%20billion%20people%20suffering%20from%20chronic%20diseases" target="_blank"><i class="fab fa-linkedin-in"></i> Share on LinkedIn</a>
<a href="whatsapp://send?text=Support%20the%20FDAi%20Act%20to%20automate%20clinical%20research%20to%20find%20cures%20for%20the%202%20billion%20people%20suffering%20from%20chronic%20diseases%20https://fdai.earth" target="_blank"><i class="fab fa-whatsapp"></i> Share on Whatsapp</a>
<a href="mailto:?subject=Support%20the%20FDAi%20Act&body=Support%20the%20FDAi%20Act%20to%20automate%20clinical%20research%20to%20find%20cures%20for%20the%202%20billion%20people%20suffering%20from%20chronic%20diseases%20https://fdai.earth"><i class="fas fa-envelope"></i> Share via Email</a>
      </div>
    </div>
  `;

  const closeBtn = overlay.querySelector(".close-btn");
  closeBtn.addEventListener("click", closeOverlay);

}


// Create the overlay
const overlay = document.createElement("div");
overlay.className = "overlay";
document.body.appendChild(overlay);

// Show the first question on page load
window.addEventListener("load", () => {
  renderQuestion();
  overlay.style.display = "flex";
});

// Fetch styles from petition.css
const styles = `

`;

const styleSheet = document.createElement("style");
styleSheet.innerText = styles;
document.head.appendChild(styleSheet);

const link = document.createElement("link");
link.rel = 'stylesheet';
link.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css';
document.head.appendChild(link);

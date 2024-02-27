const slides = [
    {
        title: false,
    },
    {
        speech: "Hi! I’m your personal FDAI! I’ve been programmed to collect and analyze everyone's food and drug intake and symptoms to determine the personalized safety and efficacy of every food and drug in the world!",
    },
    {
        title: "2 Billion People\nSUFFER\nfrom 7000 Diseases",
        speech: "Two billion people suffer from chronic diseases like depression, fibromyalgia, Crone's disease,and multiple sclerosis, There are over 7000 diseases that we still don’t have cures for",
    },
    {
        title: null,
        img: "img/slides/studied-molecules-chart-no-background.png",
        speech: "The good news is that there could be billions of cures we don’t even know about yet, there are over 166 billion possible medicinal molecules, and we’ve only tested 0.00001% so far",
    },
    {
        title: null,
        img: "img/slides/slow-research.png",
        speech: "The bad news is that we only approve around 30 drugs a year so, at best, it would take over 350 years to find cures at this rate, So you’ll be long dead by then.",
    },
    {
        img: "img/slides/chemicals-in-our-diet.png",
        speech: "Lots of these diseases are caused or worsened by chemicals in your food, but we don’t really know which ones,  We only have long-term toxicology data on 2 of the over 7000 preservatives, flavorings, emulsifiers, sweeteners, pesticides, contaminants, and herbicides in your diet",
    },
    {
        img: "img/slides/correlates-of-disease-incidence-labeled.png",
        speech: "The increase in the number of chemicals has been linked to increases in the incidence of many diseases associated with disrupted gut microbiomes",
    },
    {
        img: "img/slides/food-industrial-complex.png",
        speech: "It’s like everyone is constantly getting Roofied with thousands of untested chemicals without their knowledge",
    },
    {
        title: "Clinical Research is SLOW, EXPENSIVE, and IMPRECISE",
        speech: "Unfortunately, clinical research is really slow, expensive, and imprecise",
    },
    {
        title: "12 Years and $2.6 Billion",
        speech: "It currently costs about 2.6 billion dollars and takes about 12 years to bring a new drug to market,  And even then, we only know about the average effect of the drug on a tiny subset of patients,  We don’t know how it affects, you.",
    },
    {
        title: "Trials Are Often Not Representative of Real Patients",
        speech: "85% of patients with depression are excluded from antidepressant trials",
    },
    {
        img: "img/slides/exclusion.png",
        speech: "They exclude people taking other medications, They exclude people who use drugs or alcohol, They exclude people with other health conditions, So, the results of the trials only apply to a weird subset of patients, They don't really apply to most people with depression, this is why antidepressents almost never work as well in the real world as they do in trials",
    },
    {
        img: "img/slides/small-trials.png",
        speech: "Clinical trials are also very small, so they don’t have enough statistical power to detect the effects of drugs on rare side effects or subgroups of people",
    },
    {
        title: "Clinical Trials Don't Detect Long-Term Effects",
        speech: "Since clinical trials only last a few months, they don’t detect the long-term effects of drugs, like if they cause cancer or heart disease, so the benefits of many drugs may be completely outweighed by the long-term negative side effects, but we don't have enough data to know",
    },
    {
        title: "What's the solution?",
        speech: "So what’s the solution?",
    },
    {
        title: "Wait for the sweet release of death?",
        speech: "Should you just continue to suffer and wait patiently",
    },
    {
        img: "https://static.crowdsourcingcures.org/img/slides/decay.gif",
        speech: "for the sweet release of death?",
    },
    {
        title: "NO!",
        speech: "No! We can defeat chronic disease",
    },
    {
        img: "img/slides/super-fda-robot-transparent.png",
        speech: "with the power of ROBOTS! Some robots can discover new drugs",
    },
    {
        img: "img/slides/robot-drugs.gif",
        //img: "https://static.crowdsourcingcures.org/img/slides/robot-drugs.gif",
        speech: "and Some robots can actually, make, drugs  ",
    },
    {
        img: "https://static.crowdsourcingcures.org/img/slides/black-box-model-animation.gif",
        speech: "My specialty is making it easy for anyone to participate in clinical research to find out what foods and drugs are safe and effective!",
    },
    {
        img: "img/slides/digital-exhaust.png",
        speech: "The first step is getting your precious, precious data! You automatically generate a lot of data exhaust, like receipts for supplements food prescriptions health records, labs, health apps, and wearables, Unfortunately, it’s kind of worthless when it’s scattered all over the place and just being used by advertisers to target you",
    },
    {
        speech: "with Viagra ads",
        animation: () => {
            simulatePopups(50); // Start the simulation with 5 popups
            removeAllPopupsAfterDelay(5); // Remove all popups after 10 seconds}
        },
        cleanup: removeAllPopupAds,
    },
    {
        img: "img/slides/FDAI-github.gif",
        speech: "So we’re making free and open source apps, reusable software libraries, and autonomous A I agents that can use your browser to help you get all your data and analyze it for you!",
    },
    {
        title: null,
        playbackRate: 0.5,
        video: "img/slides/import.mp4",
        speech: "You can import data from lots of apps and wearable devices like physical activity, sleep, environmental factors, and vital signs.",
    },
    {
        title: null,
        video: "img/slides/reminder-inbox.mp4",
        speech: "You can also schedule reminders to record symptoms, treatments, or anything else manually in the Reminder Inbox.",
    },
    {
        img: "https://static.crowdsourcingcures.org/img/slides/history.gif",
        speech: "After I get a couple of months of your data, I can eat it all up.",
    },
    {
        title: "Yummy data!",
        speech: "Yum! ",
    },
    {
        video: "https://static.crowdsourcingcures.org/img/slides/studies.mp4",
        speech: "Then I start analyzing it and generate N-of-1 personal studies telling you how much different medications, supplements, or foods might improve or worsen your symptoms.",
    },
    {
        img: "img/slides/symptom-factors.png",
        speech: "But, as any obnoxious college graduate will tell you, correlation does not necessarily imply causation,  Just because you took a drug and got better it doesn’t mean that’s really why your symptoms went away,   " +
            "Even with randomized controlled trials hundreds of other things are changing in your life and diet",
    },
    {
        img: "img/slides/robot-chad.png",
        speech: "Your puny human brains haven’t evolved since the time of the cavemen,  They can only hold seven numbers in working memory at a time,  My superior robot brain can hold hundreds of numbers, even really big numbers!",
    },
    {
        img: "img/slides/causal-inference-2.png",
        speech: "So I'm able to apply Hill’s 6 Criteria for Causality to try to infer if something causes a symptom to worsen or improve instead of just seeing what correlates with the change,  One way I do it is by applying pharmacokinetic modeling and onset delays and durations of action",
    },
    {
        img: "img/screenshots/gluten-study.png",
        speech: "For instance, when gluten-sensitive people eat delicious gluten, it usually takes about a 2-day onset delay before they start having symptoms,   Then, when they stop eating it, there’s usually a 10-day duration of action before their gut heals and their symptoms improve, high-resolution pharmacokinetic modeling from observational data has never been possible since we've never been able to collect enough data before",
    },
    {
        img: "img/slides/study.gif",
        speech: "Here’s an example of one personal study,  Despite this gentleman’s infectious charisma, internally he actually experiences severe crippling depression",
    },
    {
        img: "img/slides/study-mood.png",
        speech: "However, his mood is typically 12% better than the average following weeks in which he engages in exercise more than usual",
    },
    {
        img: "img/slides/onset-delay.png",
        speech: "Here, I apply forward and reverse lagging of the mood and exercise data to try to determine if that is just a coincidence or causal,  The result suggests a causal relationship based on the temporal precedence of the physical activity"
    },
    {
        img: "img/slides/duration-of-action.png",
        speech:
            "I also compare the outcome over various durations following the exposure to see if there is a long-term cumulative effect or if it's just a short-term acute effect,  The long-term effects are more valuable because the acute effect is probably obvious to you already, This analysis suggests that the mood benefits of regular exercise may continue to accumulate of at least a month of above average exercise",
    },
    {
        img: "img/slides/root-cause-analysis-4x.gif",
        speech: "You can also generate a big root cause analysis report to see the possible effects of anything on a particular symptom",
    },
    {
        img: "img/slides/create-study.gif",
        speech: "Anyone can also create a study, become a prestigious scientist, get a link, and invite all their friends to join!",
    },
    {
        img: "img/slides/progress.png",
        speech: "So far, I’ve already generated over 90 thousand personal studies based on 12 million data points generously donated from about 10 thousand people",
    },
    {
        //title: "Clinipedia",
        img: "img/slides/clinipedia.gif",
        speech: "At Clinipedia, the Wikipedia of Clinical research, I anonymized and aggregated this data to create mega-studies listing the likely effects of thousands of foods and drugs",
    },
    {
        title: "☹️",
        speech: "Say you suffer from constant inflammatory pain such that your very existence is being mercilessly torn asunder by an incessant relentless agony that knows no bounds besieging every moment of your waking life with its cruel unyielding torment",
    },
    {
        img: "img/slides/clinipedia-inflammatory.gif",
        speech: "Just look up inflammatory pain at Clinipedia and see the typical changes from baseline after various foods, drugs, or supplements! ",
    },
    {
        img: "img/slides/outcome-labels.png",
        speech: "You can also check out the Outcome Labels, They're like nutrition facts labels but it's more useful to know how foods or supplements affect your symptoms or health than how much Riboflavin they have",
    },
    // {
    //     img: "img/slides/outcome-label.png",
    //     speech: "Here's an example showing the average change in symptoms after taking the anti-inflammatory nutritional supplement, Curcumin",
    // },
    {
        img: "img/slides/clinipedia-study.gif",
        speech: "You can click on any factor and see a detailed study on that factor and outcome, Unfortunately, even though the data is very broad as in we have data on thousands of factors and outcomes, it’s generally very shallow, so we only have a few people contributing data for each factor and outcome",
    },
    {
        img: "img/slides/johnny-5-need-input.gif",
        title: "Need Input",
        speech: "I need a lot more data from a lot more people to improve the accuracy of my results",
    },
    {
        img: "img/slides/trial-failed-recruitment.gif",
        speech: "Over 80% of clinical trials fail to recruit enough participants, yet less than 1% of people with chronic diseases participate in clinical trials,  So everyone who's still suffering from a chronic disease needs a robot like me to find them the most promising experimental new treatment and make it effortless to join and collect data for the trial",
    },
    {
        //title: "Automating Full Clinical Trial Participation ➡️ 5X More Cures in the Same Time",
        img: "img/slides/fast-research.png",
        speech: "If we could automate full clinical trial participation and make it easy for everyone to participate in trials, we make 50 years of medical progress in 10 years",
    },
    {
        title: "I'm kind of an idiot",
        speech: "I'm sill kind of an idiot, but I want to be a super-intelligent A I assistant that could revolutionize preventative healthcare by personalizing health guidance and optimizing early detection and treatment plans and automate clinical research as much as possible",
    },
    {
        title: "My Dream",
        speech: "Here's an example of what I could eventually be with your help",
    },
    {
        title: "I need some real good robot-making guys to make me smart",
        speech: "To be able to do all that, I need some real good robot making guys to make me smart"
    },
    {
        title: "Support The FDAI Act",
        speech: "Ensuring foods and drugs are safe is the FDA's Job, So please sign our petition to tell your Congressperson to pay some real good robot-making guys to make me better,  If they complain that they don't have enough money, politely remind them that they"
    },
    {
        img: "img/slides/bombing-gaza.gif",
        speech: "just voted on a bill to send 10 billion dollars to Israel so they could blow up Gaza"
    },
    {
        img: "img/slides/bombing-gaza-reverse.gif",
        speech:
            "and 10 billion dollars to Gaza to rebuild it, so they surely have 10 billion to make a robot"
    },
    {
        img: "img/slides/slaughterbots.gif",
        speech: "If they keep saying they don't have enough money, politely remind them that they're spending billions of dollars integrating A I into over 600 weapons systems,   So just ask if it would be OK if instead of 600 mean robots for murdering people, we only build 599 murderbots and instead build 1 nice helpful robot like me",
    },
    {
        title: "$3 Trillion in Annual Savings",
        speech: "If they still say they don't have enough money, politely remind them that research suggests preventative healthcare would save the government over a 3 trillion dollars a year by personalizing health guidance and optimizing early detection and treatment plans, they would probably like that because then they'd have an extra trillion dollars a year to make more murderbots",
    },
    {
        img: "img/slides/vitalia.png",
        speech: "If they still don't do it, you should probably just make a new government that's not so silly",
    },
    {
        autoplay: false,
        img: "img/slides/FDAI-earth-qr-code.png",
        speech:
            "But please scan this code and sign our petition to show your support for the FDAI Act, which would require congress to pay some real good robot making guys to make me smarter so I can minimize suffering in the universe,  Love you! Bye!",
            //+
            //" so I can:\n"
            //+
            // "\n" +
            // "1 import your health records, wearable data, and receipts for food, drug, and supplement purchases\n" +
            // "2 regularly call you on the phone or something and ask you \n" +
            // "how severe your health symptoms are\n" +
            // "what foods, drugs, and supplements you took\n" +
            // "3 analyze the resulting high-frequency time series data to figure out how much better or worse your symptoms generally get over the short and long term after any given food, drug, or supplement\n" +
            // "4 combine everyone's data to create global-scale aggregated studies on the precise effects of foods and drugs\n" +
            // "5 Create Outcome Labels for all foods, drugs, and supplements that list the percent change from baseline for all symptoms and health outcomes\n" +
            // "6 tell the 2 billion people with chronic diseases the best things they can do to reduce their symptom severity \n" +
            // "7 make it effortless to join a trial for the most promising experimental new treatment if you're still miserable after exhausting the available treatments\n" +
            // "8 get the new treatment shipped to you\n" +
            // "9 call you every day to ask you if you took it and about your symptoms and side effects\n" +
            // "10 publish the results",
    },
    // {
    //   title: "FDAI ",
    //   speech: "But you can help! By financial support, code contributions, A I development, engaging in our cryptocurrency initiatives, or advocating for the FDAI Act with your government representatives, you can make a difference in accelerating medical progress.",
    // }
    {
        //"goToState": "app.convo",
    }
];

// Function to create a popup ad with Windows 95 styling
function createPopupAd() {
    const screenWidth = window.innerWidth;
    const screenHeight = window.innerHeight;
    const popup = document.createElement('div');
    popup.className = 'popup-ad'; // Add a class for easy selection
    popup.style.position = 'absolute';
    popup.style.width = '300px';
    popup.style.minHeight = '200px';
    popup.style.backgroundColor = '#c0c0c0';
    popup.style.border = '2px solid #000';
    popup.style.boxShadow = '3px 3px 0px #000';
    popup.style.fontFamily = "'MS Sans Serif', Geneva, sans-serif";
    popup.style.fontSize = '12px';
    popup.style.color = '#000';
    popup.style.zIndex = 99; // Ensure it's on top but stay below next button which is 100

    // Title bar
    const titleBar = document.createElement('div');
    titleBar.style.backgroundColor = '#00007f';
    titleBar.style.color = '#ffffff';
    titleBar.style.padding = '2px 5px';
    titleBar.textContent = 'Internet Explorer';
    titleBar.style.display = 'flex';
    titleBar.style.justifyContent = 'space-between';
    titleBar.style.alignItems = 'center';

    // Close button
    const closeButton = document.createElement('button');
    closeButton.textContent = 'X';
    closeButton.style.background = '#ff0000';
    closeButton.style.color = '#ffffff';
    closeButton.style.border = 'none';
    closeButton.style.padding = '0 4px';
    closeButton.style.cursor = 'pointer';
    closeButton.onclick = function() {
        popup.remove();
    };

    titleBar.appendChild(closeButton);

    // Content
    const content = document.createElement('div');
    //content.innerHTML = '<p>🎉 Congratulations! You have won a prize! Click here to claim! 🎉</p>';
    content.innerHTML = '';
    content.style.padding = '10px';

    // Image
    const img = document.createElement('img');
    img.src = 'img/slides/viagra.jpg'; // Placeholder image, replace with your desired image URL
    img.style.width = '100%'; // Make the image fit the popup
    img.style.height = 'auto';
    img.style.marginBottom = '10px'; // Space between image and text

    // Append elements
    popup.appendChild(titleBar);
    content.insertBefore(img, content.firstChild); // Insert the image at the beginning of the content
    popup.appendChild(content);

    // Random position
    const x = Math.floor(Math.random() * (screenWidth - parseInt(popup.style.width)));
    const y = Math.floor(Math.random() * (screenHeight - parseInt(popup.style.minHeight)));

    popup.style.left = x + 'px';
    popup.style.top = y + 'px';

    // Append to body
    document.body.appendChild(popup);
}

// Simulate multiple popups
function simulatePopups(numberOfPopups) {
    for (let i = 0; i < numberOfPopups; i++) {
        setTimeout(createPopupAd, i * 50); // Slight delay between popups
    }
}

function removeAllPopupAds() {
    const popups = document.querySelectorAll('.popup-ad');
    popups.forEach((popup) => popup.remove());
}

// New function to remove all popups after a specified delay
function removeAllPopupsAfterDelay(delayInSeconds) {
    setTimeout(() => {
        removeAllPopupAds();
    }, delayInSeconds * 1000); // Convert seconds to milliseconds
}

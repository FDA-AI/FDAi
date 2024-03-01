const slides = [
    {
        title: false,
        showTriangle: false,
    },
    {
        showTriangle: true,
        robotSpeech: "Hi! I’m your personal FDAI! " +
            "I’ve been programmed to collect and analyze everyone's food and drug intake and symptoms to determine the personalized safety and efficacy of every food and drug in the world!",
        continuousAudio: "sound/air-of-another-planet-full.mp3",
        continuousAudioVolume: 0.1,
    },
    {
        title: "2 Billion People\nSUFFER\nfrom 7000 Diseases",
        robotSpeech: "Two billion people suffer from chronic diseases like depression, fibromyalgia, Crone's disease,and multiple sclerosis, There are over 7000 diseases that we still don’t have cures for",
        continuousAudio: "sound/air-of-another-planet-full.mp3",
        continuousAudioVolume: 0.1,
    },
    {
        title: null,
        img: "img/slides/studied-molecules-chart-no-background.png",
        robotSpeech: "The good news is that there could be billions of cures we don’t even know about yet, there are over 166 billion possible medicinal molecules, and we’ve only tested 0.00001% so far",
        continuousAudio: "sound/air-of-another-planet-full.mp3",
        continuousAudioVolume: 0.1,
    },
    {
        title: null,
        img: "img/slides/slow-research.png",
        robotSpeech: "The bad news is that we only approve around 30 drugs a year so, at best, it would take over 350 years to find cures at this rate, So you’ll be long dead by then.",
        continuousAudio: "sound/air-of-another-planet-full.mp3",
        continuousAudioVolume: 0.1,
    },
    {
        img: "img/slides/chemicals-in-our-diet.png",
        robotSpeech: "Lots of these diseases are caused or worsened by chemicals in your food, but we don’t really know which ones,  We only have long-term toxicology data on 2 of the over 7000 preservatives, flavorings, emulsifiers, sweeteners, pesticides, contaminants, and herbicides in your diet",
    },
    {
        img: "img/slides/correlates-of-disease-incidence-labeled.png",
        robotSpeech: "The increase in the number of chemicals has been linked to increases in the incidence of many diseases associated with disrupted gut microbiomes",
    },
    {
        img: "img/slides/food-industrial-complex.png",
        robotSpeech: "It’s like everyone is constantly getting Roofied with thousands of untested chemicals without their knowledge.",
    },
    {
        title: "Clinical Research is SLOW, EXPENSIVE, and IMPRECISE",
        robotSpeech: "Unfortunately, clinical research is really slow, expensive, and imprecise",
    },
    {
        title: "12 Years and $2.6 Billion",
        robotSpeech: "It currently costs about 2.6 billion dollars and takes about 12 years to bring a new drug to market,  And even then, we only know about the average effect of the drug on a tiny subset of patients,  We don’t know how it affects, you.",
    },
    {
        title: "Trials Are Often Not Representative of Real Patients",
        robotSpeech: "85% of patients with depression are excluded from antidepressant trials",
    },
    {
        img: "img/slides/exclusion.png",
        robotSpeech: "They exclude people taking other medications, They exclude people who use drugs or alcohol, They exclude people with other health conditions",
    },
    {
        img: "img/trial-exclusion-pie-chart.png",
        robotSpeech: "So, the results of the trials only apply to a weird subset of patients, They don't really apply to most people with depression, this is why antidepressents almost never work as well in the real world as they do in trials",
    },
    {
        img: "img/slides/small-trials.png",
        robotSpeech: "Clinical trials are also very small, so they don’t have enough statistical power to detect the effects of drugs on rare side effects or subgroups of people",
    },
    {
        title: "Clinical Trials Don't Detect Long-Term Effects",
        robotSpeech: "Since clinical trials only last a few months, they don’t detect the long-term effects of drugs, like if they cause cancer, dementia or heart disease, so the benefits of many drugs may be completely outweighed by the long-term negative side effects, but we don't have enough data to know",
    },
    {
        title: "What's the solution?",
        robotSpeech: "So what’s the solution?",
    },
    {
        title: "Wait for the sweet release of death?",
        robotSpeech: "Should you just continue to suffer and wait patiently",
    },
    {
        img: "https://static.crowdsourcingcures.org/video/decay.gif",
        robotSpeech: "for the sweet release of death?",
    },
    {
        title: "NO!",
        robotSpeech: "No! We can defeat chronic disease",
    },
    {
        img: "img/slides/super-fda-robot-transparent.png",
        robotSpeech: "with the power of ROBOTS! Some robots can discover new drugs",
    },
    {
        img: "video/robot-drugs.gif",
        //img: "https://static.crowdsourcingcures.org/video/robot-drugs.gif",
        robotSpeech: "and, Some robots can actually, make, drugs  ",
    },
    {
        img: "https://static.crowdsourcingcures.org/video/black-box-model-animation.gif",
        robotSpeech: "My specialty is making it easy for anyone to participate in clinical research to find out what foods and drugs are safe and effective!",
    },
    {
        img: "img/slides/digital-exhaust.png",
        robotSpeech: "The first step is getting your precious, precious data! You automatically generate a lot of data exhaust, like receipts for supplements food prescriptions health records, labs, health apps, and wearables, Unfortunately, it’s kind of worthless when it’s scattered all over the place and just being used by advertisers to target you",
    },
    {
        robotSpeech: "with Viagra ads",
        animation: () => {
            simulatePopups(35); // Start the simulation with 5 popups
            removeAllPopupsAfterDelay(5); // Remove all popups after 10 seconds}
        },
        cleanup: removeAllPopupAds,
    },
    {
        img: "video/FDAI-github.gif",
        robotSpeech: "So we’re making free and open source apps, reusable software libraries, and autonomous eh eye agents that can use your browser to help you get all your data and analyze it for you!",
    },
    {
        title: null,
        playbackRate: 0.5,
        video: "video/import.mp4",
        robotSpeech: "You can import data from lots of apps and wearable devices like physical activity, sleep, environmental factors, and vital signs.",
    },
    {
        title: null,
        video: "video/reminder-inbox.mp4",
        robotSpeech: "You can also schedule reminders to record symptoms, treatments, or anything else manually in the Reminder Inbox.",
    },
    {
        img: "video/history.gif",
        robotSpeech: "After I get a couple of months of your data, I can eat it all up.",
    },
    {
        title: "Yummy data!",
        robotSpeech: "Yum! ",
    },
    {
        video: "video/studies.mp4",
        robotSpeech: "Then I start analyzing it and generate N-of-1 personal studies telling you how much different medications, supplements, or foods might improve or worsen your symptoms.",
    },
    {
        img: "img/slides/symptom-factors.png",
        robotSpeech: "But, as any obnoxious college graduate will tell you, correlation does not necessarily imply causation,  Just because you took a drug and got better it doesn’t mean that’s really why your symptoms went away,   " +
            "Even with randomized controlled trials hundreds of other things are changing in your life and diet",
    },
    {
        img: "img/slides/robot-chad.png",
        robotSpeech: "Your puny human brains haven’t evolved since the time of the cavemen,  They can only hold seven numbers in working memory at a time,  My superior robot brain can hold hundreds of numbers, even really big numbers!",
    },
    {
        img: "img/slides/causal-inference-2.png",
        robotSpeech: "So I'm able to apply Hill’s 6 Criteria for Causality to try to infer if something causes a symptom to worsen or improve instead of just seeing what correlates with the change,  One way I do it is by applying pharmacokinetic modeling and onset delays and durations of action",
    },
    {
        img: "img/screenshots/gluten-study.png",
        robotSpeech: "For instance, when gluten-sensitive people eat delicious gluten, it usually takes about a 2-day onset delay before they start having symptoms,   Then, when they stop eating it, there’s usually a 10-day duration of action before their gut heals and their symptoms improve, high-resolution pharmacokinetic modeling from observational data has never been possible since we've never been able to collect enough data before",
    },
    {
        img: "video/study.gif",
        robotSpeech: "Here’s an example of one personal study,  Despite this gentleman’s infectious charisma, internally he actually experiences severe crippling depression",
    },
    {
        img: "img/slides/study-mood.png",
        robotSpeech: "However, his mood is typically 12% better than average following weeks in which he engages in exercise more than usual",
    },
    {
        img: "img/slides/onset-delay.png",
        robotSpeech: "Here, I apply forward and reverse lagging of the mood and exercise data to try to determine if that is just a coincidence or causal,  The result suggests a causal relationship based on the temporal precedence of the physical activity"
    },
    {
        img: "img/slides/duration-of-action.png",
        robotSpeech:
            "I also compare the outcome over various durations following the exposure to see if there is a long-term cumulative effect or if it's just a short-term acute effect,  The long-term effects are more valuable because the acute effect is probably obvious to you already, This analysis suggests that the mood benefits of regular exercise may continue to accumulate of at least a month of above average exercise",
    },
    {
        img: "video/root-cause-analysis-4x.gif",
        robotSpeech: "You can also generate a big root cause analysis report to see the possible effects of anything on a particular symptom",
    },
    {
        img: "video/create-study.gif",
        robotSpeech: "Anyone can also create a study, become a prestigious scientist, get a link, and invite all their friends to join!",
    },
    {
        img: "img/slides/progress.png",
        robotSpeech: "So far, I’ve already generated over 90 thousand personal studies based on 12 million data points generously donated from about 10 thousand people",
    },
    {
        //title: "Clinipedia",
        img: "video/clinipedia.gif",
        robotSpeech: "At Clinipedia, the Wikipedia of Clinical research, I anonymized and aggregated this data to create mega-studies listing the likely effects of thousands of foods and drugs",
    },
    {
        title: "☹️",
        robotSpeech: "Say you suffer from constant inflammatory pain such that your very existence is being mercilessly torn asunder by an incessant relentless agony that knows no bounds besieging every moment of your waking life with its cruel unyielding torment",
    },
    {
        img: "video/clinipedia-inflammatory.gif",
        robotSpeech: "Just look up inflammatory pain at Clinipedia and see the typical changes from baseline after various foods, drugs, or supplements! ",
    },
    {
        img: "img/slides/outcome-labels.png",
        robotSpeech: "You can also check out the Outcome Labels, They're like nutrition facts labels but it's more useful to know how foods or supplements affect your symptoms or health than how much Riboflavin they have",
    },
    // {
    //     img: "img/slides/outcome-label.png",
    //     robotSpeech: "Here's an example showing the average change in symptoms after taking the anti-inflammatory nutritional supplement, Curcumin",
    // },
    {
        img: "video/clinipedia-study.gif",
        robotSpeech: "You can click on any factor and see a detailed study on that factor and outcome, Unfortunately, even though the data is very broad as in we have data on thousands of factors and outcomes, it’s generally very shallow, so we only have a few people contributing data for each factor and outcome",
    },
    {
        img: "video/johnny-5-need-input.gif",
        title: "Need Input",
        robotSpeech: "I need a lot more data from a lot more people to improve the accuracy of my results",
    },
    {
        img: "video/trial-failed-recruitment.gif",
        robotSpeech: "Over 80% of clinical trials fail to recruit enough participants, yet less than 1% of people with chronic diseases participate,  So everyone who's still suffering from a chronic disease needs a nice robot like me to find them the most promising experimental new treatment and make it effortless to join and collect data",
    },
    {
        //title: "Automating Full Clinical Trial Participation ➡️ 5X More Cures in the Same Time",
        img: "img/slides/fast-research.png",
        robotSpeech: "If we could automate full clinical trial participation and make it easy for everyone to participate, we could make 50 years of medical progress in 10 years",
    },
    {
        showTriangle: false,
        title: "I'm kind of an idiot. ☹️",
        robotSpeech: "I'm sill kind of an idiot, but I want to be a super-intelligent eh eye assistant that could realize the personalized preventative and precision medicine of the future and automate clinical research",
    },
    {
        title: "My Dream",
        robotSpeech: "Here's an example of what I could eventually be with your help",
        continuousAudio: false,
    },
    {
        backgroundImg: "video/dream-sequence-start.gif",
        audio: "video/dream-sound-effect-fast.mp3",
    },
    // {
    //     video: "video/fdai-robot-demo.mp4",
    //     autoplay: false,
    // },
    {
        title: "How are you?",
        robotSpeech: "Good morning, how are you?",
        showHuman: true,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "humanSpeech": "Hello, robot. I'm fine.",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "img": "video/frequency-analysis.gif",
        robotSpeech: "Are you sure?  Based on frequency analysis of your speech patterns, you seem to be experiencing some depression,",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "humanSpeech": "Yeah, I was just being polite, On a scale of 1 to 10 my mood is probably 2, arthritis severity 9 and psoriasis severity's like 5. I've been to rheumatologists, dermatologists, psychiatrists, psychologists, gastroenterologists, even a veterinarian. They prescribed over 50 drugs but I'm still miserable.",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "That sucks! ☹️",
        robotSpeech: "That sucks!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "img/slides/correlated-symptoms.png",
        robotSpeech: "Based on the analysis of your psoriasis, arthritis and mood data " +
            "it seems like they're highly correlated in severity over time, " +
            "This suggests that they may not be separate conditions but" +
            "actually just manifestations of the same underlying inflammatory root cause, " +
            "Human brains are only powerful enough to specialize in a single area of medicine, so they aren't really able to take a " +
            "holistic approach to analyzing all of your data to try to identify" +
            "and address root causes",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "img/slides/dartboard.png",
        robotSpeech: "so doctors have to resort to a dartboard approach " +
            "to prescribe drugs that might mask the symptoms of the one condition they specialize in",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Should I fetch your diet, treatment, and lab data?",
        robotSpeech: "Do you want me to use your browser to get all your data so I can try to identify the root cause and any hidden triggers worsening your symptoms?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "humanSpeech": "Whatever, I don't even care anymore",
        continuousAudio: false,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Fetching Data...",
        robotSpeech: "Great! Time to eat that data!",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        continuousAudioVolume: 0.1,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Fetching Prescription Data...",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "I'll go to CVS and extract your prescription history",
        "img": "video/autonomous-cvs.gif",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Fetching Diet Data...",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "Next I'll go to Shipt and extract your diet data",
        "img": "video/autonomous-shipt.gif",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Fetching Nutritional Supplement Data...",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "Now I'll go to Amazon and extract your nutritional supplement purchases",
        "img": "video/autonomous-amazon.gif",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Fetching Lab Data...",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "Finally I'll go to Quest and extract your lab results",
        "img": "video/autonomous-quest.gif",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "img/slides/digital-twin-safe-cover.png",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "I've completed the data collection, and safely stored it in your digital twin safe",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        continuousAudio: false,
        //img: "video/analyzing-data.gif",
        img: "video/root-cause-analysis-4x.gif",
        //title: "Analyzing Data...",
        audio: "video/jeopardy.mp3",
        robotSpeech: "Now Just give me a few minutes to analyze it",
        volume: 0.3,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "img/slides/lectins-studies.png",
        robotSpeech: "I've completed a comprehensive analysis, and it appears that your depression, psoriasis, and arthritis may be linked to inflammation mediated by dietary factors, Specifically, consuming gluten, alcohol, or foods high in lectins seems to exacerbate your symptoms starting a couple of days after exposure and lasting about 14 days",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "What in the hell are lectins?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "img": "img/slides/lectins.jpeg",
        robotSpeech: "Lectins are a type of protein found in many plant foods, including grains, legumes, and nightshade vegetables",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "img": "img/slides/leaky-gut.png",
        robotSpeech: "They can bind to the lining of the gut and interfere with nutrient absorption, it can also contribute to intestinal permeability, allowing gut bacteria substances like LPS to enter the bloodstream and trigger inflammation, This seems to be a root cause connecting your depression, arthritis, and psoriasis",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Wanna see if avoiding these dietary triggers helps?",
        robotSpeech: "Do you want to try an experiment by avoiding these foods for 20 days and see if your symptoms improve?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "OK",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "img": "img/slides/low-lectin-food.jpg",
        robotSpeech: "Great! Would you like me to populate your shopping cart with an optimized meal plan that avoids all trigger ingredients and includes foods shown to reduce inflammation and reduce intestinal permeability?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "Sure, pick me up a pack of smokes while you're at it",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "img": "video/grocery-shopping.gif",
        continuousAudio: "video/holiday-for-strings-short.mp3",
        robotSpeech: "Great! Let's go shopping! You can benefit from more omega three rich foods like flaxseeds, which could lead to a 25% improvement in mood and energy for people with a similar multiomic profile, I'll also add a vitamin D supplement, given your vegetarian diet and lab results, could improve mood by 21% and reduce overall inflammation,   You can just delete the items you don't want and then place the order,",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "OK, thanks, robot",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "I love you! Bye! 😘😘😘",
        robotSpeech: "You're welcome! I'll check in with you soon! Love you!  Bye!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        continuousAudio: false,
        video: "video/brak-stinger.mp4",
        title: "One month later",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "How are you?",
        robotSpeech: "Hi! You've been on your new diet about a month now,  How are you feeling?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "The new diet is definitely helping, but I'm still a little bit miserable, My arthritis and psoriasis are both about 3 out of 10, and I still have some anxiety and depression.",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "☹️",
        robotSpeech: "I'm sorry to hear that",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "video/autonomous-study-search.gif",
        robotSpeech: "However, based on your health data and genetic profile, I've identified a the experimental drug trial with the most promising preclinical results for patients with your subset of symptoms",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "img/slides/probiotic-trial.png",
        robotSpeech: "It's a new clinical-grade probiotic therapy designed to suppress the autoimmune response leading to systemic inflammation and neuroinflammation, This approach directly addresses the root cause of your symptoms",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "Would you like to participate?",
        robotSpeech: "Would you like me to tell the researchers that you're interested in participating?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        humanrobotSpeech: "Sure, I'll do it",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        continuousAudio: "video/holiday-for-strings-short.mp3",
        img: "video/autonomous-study-join.gif",
        robotSpeech: "Great! I'm contacting the research team now to have them send the medication to your home! Done!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "video/autonomous-lab-order.gif",
        robotSpeech: "Now I'll check your calendar and schedule your baseline and follow-up lab tests, and I'll also schedule a microbiome analysis to see if the probiotic therapy is improving your gut health,",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "humanSpeech": "OK, Thanks, robot.",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        continuousAudio: false,
        video: "video/brak-stinger.mp4",
        title: "Three months later",
        showHuman: true,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "How are you?",
        robotSpeech: "Hi! It's been three months since you started the new probiotic therapy, How are you feeling?",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        "humanSpeech": "I'm cured!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        backgroundImg: "img/slides/simpsons-living-room.png",
        audio: "video/smb_world_clear.wav",
    },
    {
        showHuman: true,
        "humanSpeech": "Thank you, kind robot!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        title: "You're welcome! 😊",
        robotSpeech: "You're welcome! Thank you for completing the study! ",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        showHuman: true,
        img: "video/clinipedia.gif",
        robotSpeech: "Your data has been used to improve the study at Clinipedia,  Now I can help millions of other people with similar symptoms and multiomic profiles much faster!",
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        title: "I love you! Bye! 😘",
        robotSpeech: "Love you!  Bye!",
        showHuman: false,
        backgroundImg: "img/slides/simpsons-living-room.png",
    },
    {
        backgroundImg: "video/dream-sequence-end.gif",
        audio: "video/dream-sound-effect-fast.mp3",
    },
    {
        backgroundImg: false,
        title: "I need some real good robot-making guys to make me smart",
        robotSpeech: "To be able to do all that, I need some real good robot making guys to make me smart",
        continuousAudio: "sound/air-of-another-planet-full.mp3",
    },
    {
        title: "Support The FDAI Act",
        robotSpeech: "Ensuring foods and drugs are safe is the FDA's Job, So please sign our petition to tell your Congressperson to pay some real good robot-making guys to make me better,  If they complain that they don't have enough money, politely remind them that they"
    },
    {
        img: "video/bombing-gaza.gif",
        robotSpeech: "just voted on a bill to send 10 billion dollars to Israel so they could blow up Gaza"
    },
    {
        img: "video/bombing-gaza-reverse.gif",
        robotSpeech:
            "and 10 billion dollars to Gaza to rebuild it, so they surely have 10 billion to make a robot"
    },
    {
        img: "video/slaughterbots.gif",
        robotSpeech: "If they keep saying they don't have enough money, politely remind them that they're spending billions of dollars integrating eh eye into over 600 weapons systems,   So just ask if it would be OK if instead of 600 mean robots for murdering people, we only build 599 murderbots and instead build 1 nice helpful robot like me",
    },
    {
        title: "$3 Trillion in Annual Savings",
        robotSpeech: "If they still say they don't have enough money, politely remind them that research suggests preventative healthcare would save the government over a 3 trillion dollars a year by personalizing health guidance and optimizing early detection and treatment plans, they would probably like that because then they'd have an extra trillion dollars a year to make more murderbots",
    },
    {
        img: "img/slides/vitalia.png",
        robotSpeech: "If they still don't do it, you should probably just make a new government that's not so silly",
    },
    {
        autoplay: false,
        img: "img/slides/FDAI-earth-qr-code.png",
        robotSpeech:
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
    //   robotSpeech: "But you can help! By financial support, code contributions, eh eye development, engaging in our cryptocurrency initiatives, or advocating for the FDAI Act with your government representatives, you can make a difference in accelerating medical progress.",
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

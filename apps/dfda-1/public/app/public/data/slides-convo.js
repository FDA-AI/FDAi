const slidesConvo = [
    {
        title: false,
        speech: false,
    },
    {
        title: "How are you?",
        speech: "Good morning, how are you?",
    },
    {
        "humanSpeech": "Hello, robot. I'm fine."
    },
    {
        iframe: "https://root-cause.curedao.org",
        iframeScrollSpeed: 10,
        "img": "video/frequency-analysis.gif",
        speech: "Are you sure?  Based on frequency analysis of your speech patterns, you seem to be experiencing some depression,",
    },
    {
        "humanSpeech": "Yeah, I was just being polite, On a scale of 1 to 10 my mood is probably 2, arthritis severity 9 and psoriasis severity's like 5. I've been to rheumatologists, dermatologists, psychiatrists, psychologists, gastroenterologists. They prescribed over 50 drugs but I'm still miserable."
    },
    {
        title: "That sucks! ☹️",
        speech: "That sucks!",
    },
    {
        img: "img/slides/correlated-symptoms.png",
        speech: "Based on the analysis of your psoriasis, arthritis and mood data " +
            "it seems like they're highly correlated in severity over time, " +
            "This suggests that they may not be separate conditions but" +
            "actually just manifestations of the same underlying inflammatory root cause, " +
            "Human brains are only powerful enough to specialize in a single area of medicine, so they aren't really able to take a " +
            "holistic approach to analyzing all of your data to try to identify" +
            "and address root causes",
    },
    {
        img: "img/slides/dartboard.png",
        speech: "so specialists typically just use a dartboard approach " +
            "to prescribe drugs that might mask the symptoms of the one condition they specialize in",
    },
    {
        title: "Should I fetch your diet, treatment, and lab data?",
        speech: "Do you want me to use your browser to get all your data so I can try to identify the root cause and any hidden triggers worsening your symptoms to figure out how to improve them",
    },
{
    "humanSpeech": "Whatever, I don't even care anymore"
},
    {
        title: "Fetching Data...",
        speech: "Great! Time to eat that data!",
    },
    {
        title: "Fetching Prescription Data...",
        speech: "I'll go to CVS and extract your prescription history",
        "img": "video/autonomous-cvs.gif"
    },
    {
        title: "Fetching Diet Data...",
        speech: "Next I'll go to Shipt and extract your diet data",
        "img": "video/autonomous-shipt.gif"
    },
    {
        title: "Fetching Nutritional Supplement Data...",
        speech: "Now I'll go to Amazon and extract your nutritional supplement purchases",
        "img": "video/autonomous-amazon.gif"
    },
    {
        title: "Fetching Lab Data...",
        speech: "Finally I'll go to Quest and extract your lab results",
        "img": "video/autonomous-quest.gif"
    },
    {
        img: "img/slides/digital-twin-safe-cover.png",
        speech: "I've completed the data collection, and safely stored it in your digital twin safe",
    },
    {
        //img: "video/analyzing-data.gif",
        img: "video/root-cause-analysis-4x.gif",
      //title: "Analyzing Data...",
        audio: "video/jeopardy.mp3",
      speech: "Now Just give me a few minutes to analyze it",
        volume: 0.3
    },
    {
        img: "img/slides/lectins-studies.png",
        speech: "I've completed a comprehensive analysis, and it appears that your depression, psoriasis, and arthritis may be linked to inflammation mediated by dietary factors, Specifically, consuming gluten, alcohol, or foods high in lectins seems to exacerbate your symptoms starting a couple of days after exposure and lasting about 14 days"
    },
    {
        humanSpeech: "What in the hell are lectins?"
    },
    {
        "img": "img/slides/lectins.jpeg",
        speech: "Lectins are a type of protein found in many plant foods, including grains, legumes, and nightshade vegetables",
    },
    {
        "img": "img/slides/leaky-gut.png",
        speech: "They can bind to the lining of the gut and interfere with nutrient absorption, it can also contribute to intestinal permeability, allowing gut bacteria substances like LPS to enter the bloodstream and trigger inflammation, This seems to be a root cause connecting your depression, arthritis, and psoriasis",
    },
    {
        title: "Wanna see if avoiding these foods helps?",
        speech: "Do you want to try an experiment by avoiding these foods for 20 days and see if your symptoms improve?",
    },
    {
        humanSpeech: "OK"
    },
    {
        "img": "img/slides/low-lectin-food.jpg",
        speech: "Great! Would you like me to populate your shopping cart with an optimized meal plan that avoids these foods and includes ingredients that have been shown to reduce inflammation and reduce intestinal permeability?",
    },
    {
        humanSpeech: "Sure, pick me up a pack of smokes while you're at it"
    },
    {
      "img": "video/grocery-shopping.gif",
      speech: "You can benefit from more omega three rich foods like flaxseeds, which could lead to a 25% improvement in mood and energy for people with a similar multiomic profile, I'll also add vitamin D supplement, given your vegetarian diet and lab results, could improve mood by 12% and reduce overall inflammation,   You can just delete the items you don't want and then place the order,",
    },
    {
        humanSpeech: "OK, thanks, robot",
    },
    {
      title: "I love you! Bye! 😘😘😘",
      speech: "You're welcome! I'll check in with you soon! Love you!  Bye!",
    },
    {
        video: "video/brak-stinger.mp4",
        title: "One month later"
    },
    {
        title: "How are you?",
        speech: "Hi, Mike! You've been on your new diet about a month now,  How are you feeling?",
    },
    {
        humanSpeech: "The new diet is definitely helping, but I'm still a little bit miserable, My arthritis and psoriasis are both about 3 out of 10, and I still have some anxiety and depression.",
    },
    {
        title: "☹️",
        speech: "I'm sorry to hear that"
    },
    {
        img: "video/autonomous-study-search.gif",
      speech: "However, based on your health data and genetic profile, I've identified a the experimental drug trial with the most promising preclinical results for patients with your subset of symptoms",
    },
    {
        img: "img/slides/probiotic-trial.png",
        speech: "It's a new clinical-grade probiotic therapy designed to suppress the autoimmune response leading to systemic inflammation and neuroinflammation, This approach directly addresses the root cause of your symptoms",
    },
    {
        title: "Would you like to participate?",
        speech: "Would you like me to tell the researchers that you're interested in participating?",
    },
    {
        humanSpeech: "Sure, I'll do it",
    },
    {
        img: "video/autonomous-study-join.gif",
        speech: "Great! I'm contacting the research team now to have them send the medication to your home! Done!",
    },
    {
      img: "video/autonomous-lab-order.gif",
      speech: "Now I'll check your calendar and schedule your baseline and follow-up lab tests, and I'll also schedule a microbiome analysis to see if the probiotic therapy is improving your gut health,",
    },
    {
        "humanSpeech": "OK, Thanks, robot."
    },
    {
        video: "video/brak-stinger.mp4",
        title: "Three months later"
    },
    {
        title: "How are you?",
        speech: "Hi, Mike! It's been three months since you started the new probiotic therapy, How are you feeling?",
    },
    {
        "humanSpeech": "I'm cured! I feel great!  Thank you so much, kind robot!"
    },
    {
      title: "You're welcome! 😊",
      speech: "You're welcome! I'm so happy to hear that!  Thank you for completing the study! ",
    },
    {
        img: "video/clinipedia.gif",
        speech: "Your data has been used to improve the study at Clinipedia,  Now I can help millions of other people with similar symptoms and multiomic profiles much faster!",
    },
    {
        title: "I love you! Bye! 😘😘😘",
        speech: "Love you!  Bye!",
    }
]

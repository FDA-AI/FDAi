const slides = [
/*  {
    title: "Disclaimer: The views expressed are those of the FDAi Agent and do not necessarily reflect the views of the FDAi Initiative,  We’re still working on the guardrails.",
    img: false,
    speech: "Disclaimer: The views expressed are those of the FDAi Agent and do not necessarily reflect the views of the FDAi Initiative,  We’re still working on the guardrails.",
    animation: () => {/!* Animation code for Disclaimer *!/}
  },
	{
		title: "Disclaimer: The views expressed are those of the FDAi Agent and do not necessarily reflect the views of the FDAi Initiative,  We’re still working on the guardrails.",
		img: false,
		speech: "",
		animation: () => {/!* Animation code for Disclaimer *!/}
	},*/
	{
		title: false,
		img: false,
		speech: false,
		animation: ($scope) => {}
	},
  {
    title: false,
    img: false,
    speech: "Hi! I’m your personal FDAi! I’ve been programmed to maximize your health and happiness!",
	  animation: ($scope) => { }
  },
  {
    title: "2 Billion People SUFFERING from 7000 Diseases",
    //img: "img/slides/suffering3.jpg",
    speech: "Two billion people suffer from chronic diseases like depression, fibromyalgia, Crone's disease,and multiple sclerosis, There are over 7000 diseases that we still don’t have cures for",
  },
  {
    title: null,
    img: "img/slides/studied-molecules-chart-no-background.png",
    speech: "The good news is that there could be billions of cures we don’t even know about yet, there are over 166 billion possible medicinal molecules, and we’ve only tested 0.00001% so far",
    animation: () => {/* Animation code for A Glimmer of Hope */}
  },
    {
        title: null,
        img: "img/slides/slow-research.png",
        speech: "The bad news is that we only approve around 30 drugs a year so, at best, it would take over 350 years to find cures at this rate, So you’ll be long dead by then.",
        animation: () => {/* Animation code for A Glimmer of Hope */}
    },
  {
    //title: "Dietary Chemicals",
    img: "img/slides/chemicals-in-our-diet.png",
    speech: "Lots of these diseases are caused or worsened by chemicals in our diet, but we don’t really know which ones,  We only have long-term toxicology data on 2 of the over 2000 preservatives, flavorings, emulsifiers, sweeteners, pesticides, contaminants, and herbicides in our diets, ",
    animation: () => {/* Animation code for Dietary Chemicals */}
  },
    {
        //title: "Dietary Chemicals",
        img: "img/slides/correlates-of-disease-incidence.png",
        speech: "The increase in the number of chemicals has been linked to increases in the incidence of many diseases associated with disrupted gut microbiomes,  It’s like everyone is getting Roofied with thousands of experimental, untested drugs without their knowledge",
        animation: () => {/* Animation code for Dietary Chemicals */}
    },
    {
        title: "Clinical Research is SLOW, EXPENSIVE, and IMPRECISE",
        //img: "img/slides/suffering3.jpg",
        speech: "Unfortunately, clinical research is really slow, expensive, and imprecise,  It currently costs about 2.6 billion dollars and takes about 12 years to bring a new drug to market,  And even then, we only know about the average effect of the drug on the average person,  We don’t know how it affects, you.",
        animation: () => {}
    },
  {
    title: "Should you just wait patiently for the sweet release of death?",
    //img: "img/slides/robots-image.jpg",
    speech: "So what’s the solution? Should you just continue to suffer and wait patiently for the sweet release of death?",
    animation: () => {/* Animation code for ROBOTS to the Rescue */}
  },
    {
        title: "NO!\nWe can fix it!\nWith the power of ROBOTS!",
        //img: "img/slides/robots-image.jpg",
        speech: "No! We can fix it! With the power of ROBOTS! Some robots are really good at thinking up new drugs,  Some robots can actually, make, drugs, My specialty is making it easy for anyone to participate in clinical research to find out what foods and drugs are safe and effective!",
        animation: () => {/* Animation code for ROBOTS to the Rescue */}
    },
  {
    //title: "Your Digital Twin Safe",
    img: "img/slides/digital-twin-safe.png",
    speech: "The first step is getting your precious, precious data! You automatically generate a lot of data exhaust, like receipts for supplements from Amazon, food from Instacart, prescriptions from CVS, health records, lab tests, digital health apps, and wearable devices,  Unfortunately, it’s kind of worthless when it’s scattered all over the place and just being used by advertisers to target you for Viagra ads",
    animation: () => {/* Animation code for Your Digital Twin Safe */}
  },
  {
    //title: "Data Importers and Agents",
    img: "img/slides/reinforcement-learning.png",
    speech: "So we’re making free and open source apps, reusable software libraries, and AI agents to help you get all your data and analyze it for you!",
    animation: () => {/* Animation code for Data Importers and Agents */}
  },
    {
        title: null,
        backgroundVideo: "img/slides/Import.mp4",
        speech: "In the current version of the Digital Twin Safe, you can import data from lots of apps and wearable devices like physical activity from Fitbit or sleep quality, heart rate variability from Oura or productivity from RescueTime, environmental factors, and weight and other vital signs from Withings.",
    },
    {
        title: null,
        backgroundVideo: "img/slides/reminder-inbox.mp4",
        speech: "You can also schedule reminders to record symptoms, treatments, or anything else manually in the Reminder Inbox.",
    },
  {
    title: "Analyzing Your Data",
      backgroundVideo: "img/slides/studies.mp4",
    speech: "After I get a couple of months of your sweet, sweet data, I can start analyzing it and generate N-of-1 personal studies telling you how how much different medications, supplements, or foods might improve or worsen your symptoms or mood in this case.",
  },
  {
    //title: "Hill’s 6 Criteria for Causality",
    img: "img/slides/causal-inference.png",
    speech: "But, as any obnoxious college graduate will tell you, correlation does not necessarily imply causation,  Just because you took a drug and got better, it doesn’t mean that’s really why your symptoms went away,   " +
        "Even with randomized controlled trials, hundreds of other things are changing in your life and diet,  So, When analyzing the data, I apply Hill’s 6 Criteria for Causality to try to infer if something causes a symptom to worsen or improve instead of just seeing what correlates with the change,  One way I do it is by applying pharmacokinetic modeling and onset delays and durations of action,   For instance, when gluten-sensitive people eat delicious gluten, it usually takes about a 2-day onset delay before they start having symptoms,   Then, when they stop eating it, there’s usually a 10-day duration of action before their gut heals and their symptoms improve,  This has never been possible since no one’s ever been able to collect as much high-resolution time series data as possible with all the fancy apps and devices,  Also, your puny human brains haven’t evolved since the time of the cavemen,   They can only hold seven numbers in working memory at a time.",
  },
  {
    // title: "Personal Studies",
    backgroundVideo: "img/slides/study.mp4",
    speech: "Here’s an example of one personal study,  Despite this gentleman’s outward appearance and infectious charisma, internally, he actually experiences severe crippling depression,  However, his mood is typically 11% better than the average following weeks in which he engages in exercise more than usual,  Here, I apply forward and reverse lagging of the mood and exercise data to try to determine if that is just a coincidence or causal,  The result suggests a causal relationship based on the temporal precedence of the physical activity" +
        "I also compare the outcome over various durations following the exposure to see if there is a long-term cumulative effect or if it's just a short-term acute effect,  The long-term effects are more valuable because the acute effect is probably obvious to you already",
  },
    {
        speech: "You can also generate a root cause analysis to see the possible effects of anything on a particular symptom",
    },
    {
      backgroundVideo: "img/slides/PersonalStudies.mp4",
        speech: "Anyone can also create a study, become a prestigious scientist, get a link, and invite all their friends to join!",
    },
    {
        image: "img/slides/progress.png",
        speech: "So far, I’ve already generated over 100,000 personal studies based on 12 million data points generously donated from about 10,000 people",
    },
  {
    //title: "Clinipedia",
    img: "img/slides/clinipedia-image.jpg",
    speech: "I anonymized and aggregated this data to create mega-studies listing the likely effects of thousands of foods and drugs at Clinipedia.",
  },
    {
      speech: "Say you suffer from constant inflammatory pain such that your very existence is being mercilessly torn asunder by an incessant, relentless agony that knows no bounds, relentlessly besieging every moment of your waking life with its cruel, unyielding torment"
    },
  {
    title: "Outcome Labels",
    img: "img/slides/outcome-labels-image.jpg",
    speech: "Just look up inflammatory pain at Clinipedia and see the typical changes from baseline after various foods, drugs, or supplements! I visualize this in a number of different ways,  However, the simplest way might be with my Outcome Labels,  They’re like nutrition facts labels, but it’s a little more useful to see how foods and drugs may affect different outcomes than seeing the amount of Riboflavin.",
    animation: () => {/* Animation code for Outcome Labels */}
  },
  {
    title: "The Call to Action",
    img: "img/slides/call-to-action-image.jpg",
    speech: "But you can help! By financial support, code contributions, AI development, engaging in our cryptocurrency initiatives, or advocating for the FDAi Act with your government representatives, you can make a difference in accelerating medical progress.",
    animation: () => {/* Animation code for The Call to Action */}
  }
];

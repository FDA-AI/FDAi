const slidesConvo = [
    {
        "title": false,
        "speech": false,
    },
    {
        "title": "Good morning, mike, how are you?",
        "speech": "Good morning, mike, how are you?",
    },
    // Hello, robot. I'm fine.
    {
        "title": "Good morning, mike, how are you?",
        "speech": "Are you sure?  Based on frequency analysis of your speech patterns, you seem to be experiencing some depression,",
    },
    // Yeah, I'm all fucked up,
    // I kind of want to blow my brains out,
    // My arthritis severity is about 9/10,
    // My psoriasis severity's like 5 out of 10
    // and my mood is probably 2 out of 10
    {
        "title": "Should I fetch your diet, treatment, and lab data?",
        "speech": "That sucks!  Do you want me autonomously control your browser to get all your food, drug, and supplement purchase data from your Instacart, Amazon, and CVS accounts and your lab results from Quest so I can try to identify any hidden triggers worsening your symptoms and figure out how to improve them?",
    },
    {
      "title": "Analyzing Data...",
      "speech": "Great! Just give me a few minutes",
    },
    {
        "title": "Analysis Complete",
        "speech": "I've completed a comprehensive analysis, including recent dietary inputs, pharmacy records, and lab results, Based on the data, it appears that your symptoms, including depression, may be linked to inflammation mediated by dietary factors, Specifically, consuming gluten, alcohol, or foods high in lectins seems to exacerbate your symptoms starting a couple of days after exposure and lasting about 10 days,  So I'd recommend you try an experiment by avoiding these foods for 20 days and see if your symptoms improve,  Does that sound good to you?",
    },
    //  What the hell are lectins?
    {
        "title": "What are Lectins?",
        "speech": "Lectins are a type of protein found in many plant foods, including grains, legumes, and nightshade vegetables, They can bind to the lining of the gut and interfere with nutrient absorption, potentially leading to inflammation and other symptoms,  So I'd recommend you try an experiment by avoiding these foods for 20 days and see if your symptoms improve,  Does that sound good to you?",
    },
    // Fine, I'll try it,
    {
        "speech": "Great! Would you like me to populate your Instacart shopping cart with an optimized meal plan that avoids these foods and includes ingredients that have been shown to reduce inflammation and reduce intestinal permeability?",
    },
    // Sure, that'd be great,
    {
      "title": "Groceries",
      "speech": "I'll also avoid gluten as it can contribute to intestinal permeability, allowing gut bacteria substances like LPS to enter the bloodstream and trigger inflammation, This seems to be a root cause connecting your depression, arthritis, acne, and psoriasis, As a vegetarian, you can benefit from more omega-3-rich foods like flaxseeds and chia seeds, which could lead to a 25% improvement in mood and energy for people with a similar multi-omic profile to you, I'll also add vitamin D supplement, given your vegetarian diet, could improve mood by 12% and reduce overall inflammation,   You can just delete the items you don't want and then place the order,",
    },
    // Ok, thank you, kind robot.
    {
      "title": "Further Assistance",
      "speech": "You're welcome! Don't hesitate to reach out if you have any questions or need further assistance",
      "animation": () => {/* animations regarding Further Assistance */}
    },
    {
        "title": "One month later"
    },
    {
        "title": "Exploring Treatment Avenues",
        "speech": "Hi, Mike!  How are you?",
    },
    // My arthritis and psoriasis are a little better, but I'm still pretty depressed.
    {
      "title": "Experimental Drug Trial",
      "speech": "I'm sorry to hear that, However, based on your health data and genetic profile, I've identified a the experimental drug trial with the most promising preclinical results for patients with your subset of depressive symptoms, Participating in this trials not will not only give you access to cutting-edge treatments but also contributes to accelerating clinical discovery, potentially helping others with similar conditions",

    },
    // OK. What is it?
    {
      "title": "Trial Information",
      "speech": "It's a new biologic therapy designed to suppress the autoimmune response leading to systemic inflammation and neuroinflammation, This approach directly addresses the root cause of your symptoms, including depression, arthritis, acne, and psoriasis, Would you like me to tell the researchers that you're interested in participating? Your involvement could be pivotal in bringing new solutions to many,",
    },
    // Sure, I'll do it,
    {
        "speech": "Great! I'll have the research team contact you and send the medication to your home,",
    },
    {
      "title": "Microbiome Analysis Recommendation",
      "speech": "A balanced gut microbiome is crucial for overall health, especially for conditions influenced by inflammation, I just ordered a microbiome analysis to check for dysbiosis, which could be contributing to your symptoms,\n\nBased on the results, we can order specific strains of probiotics to optimize it,",
    },
    // OK. Thanks, robot.
    {
      "title": "Guidance and Support",
      "speech": "I'm here to guide you through each step and ensure you have all the information and support you need, Thanks for contributing your data to a brighter future in clinical discovery",
    }
]

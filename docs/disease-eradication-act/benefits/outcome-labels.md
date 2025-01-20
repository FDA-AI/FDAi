# 🏷 Outcome Labels: A Proposal for Improved Health Information

Current nutrition labels provide information on components like Riboflavin, but their effectiveness in guiding individuals towards healthier choices and disease prevention is questionable, as evidenced by the continued rise in many diseases.

A more impactful approach involves **Outcome Labels**, which would indicate the degree to which a food or drug is likely to improve or worsen specific health outcomes or symptoms. This concept leverages real-world data to provide more directly relevant information to consumers.

![](https://crowdsourcingcures.org/wp-content/uploads/2021/05/nutrition-facts-vs-outcome-labels-melatonin-1024x592.png)

## Data Quantity

The effectiveness of Outcome Labels relies on the analysis of substantial amounts of data regarding symptom severity and influencing factors. Predictive machine learning algorithms can be applied to this data to reveal the effectiveness and side effects of various treatments and the impact of dietary and environmental factors on chronic illnesses.

## Data Quality and Validation

Ensuring the reliability of Outcome Labels requires rigorous data quality control measures. These include automated checks for inconsistencies, manual review of flagged data points, and the application of statistical methods to identify and address outliers. Strategies for handling missing data are also crucial to minimize bias.

## Addressing Biases and Confounding Factors

Large datasets help mitigate the impact of random confounding factors. Advanced statistical techniques, such as multivariate regression analysis and propensity score matching, can be employed to address systematic biases and create comparable groups for analysis. Continuous exploration and implementation of new methods are essential to further reduce the impact of bias and confounding on the accuracy of Outcome Labels.

## Phased Implementation and Pilot Program

A phased implementation of Outcome Labels, beginning with a pilot program focused on specific categories of foods and drugs, would ensure a smooth and effective rollout. This approach allows for a thorough evaluation of the labels' impact on consumer behavior and health outcomes and provides valuable insights for refining the labeling system before broader adoption.

## Transparency and Openness to Review

Transparency in the development and application of Outcome Labels is crucial. The methodologies used to generate these labels should be made available for review by the FDA and other qualified bodies. Exploring mechanisms for secure data sharing that protect individual privacy while allowing for independent validation of findings is also important.

## Benefits for Individuals

Outcome Labels offer several key benefits for the average person:

*   **Empowered Decision-Making:**  Individuals can make more informed choices about the foods and drugs they consume based on real-world outcome data, rather than just nutritional content or limited clinical trial results.
*   **Improved Health Outcomes:** By choosing products with labels indicating a likelihood of positive outcomes for their specific symptoms or health goals, people can potentially improve their health and well-being.
*   **Personalized Choices:** Outcome Labels provide insights into how different products affect specific symptoms, allowing for more personalized health management.

## Limitations and Interpretation

It's important to remember that Outcome Labels represent the average experience of many individuals. While they provide valuable insights, individual results may vary. These labels should be used as one factor among many when making health decisions, in consultation with healthcare professionals. They are not a substitute for professional medical advice.

These analytical results have been used to publish 90,000 studies on the effects of various treatments and food ingredients on symptom severity at [studies.dfda.earth](https://studies.dfda.earth).

Although 10 million data points sound like a lot, currently, the usefulness and accuracy of these Outcome Labels are currently limited. This is due to the fact there are only a few study participants have donated data for a particular food paired with a particular symptom. In observational research such as this, a very large number of participants are required to cancel out all the errors and coincidences that can influence the data for a single individual.

For instance, someone with depression may have started taking an antidepressant at the same time they started seeing a therapist. Then, if their depression improves, it's impossible to know if the improvement was a result of the antidepressant, the therapist, both, or something else. These random factors are known as confounding variables. However, random confounding factors can cancel each other out when looking at large data sets. This is why it's important to collect as much data as possible.

![](https://static.crowdsourcingcures.org/video/johnny-5-need-input.gif)

## Data Sources

Several types of data are used to derive the Outcome Labels:

1. **Individual Micro-Level Data** – This could include data manually entered or imported from other devices or apps at [safe.dfda.earth](http://safe.dfda.earth), This could also include shopping receipts for foods, drugs, or nutritional supplements purchased and insurance claim data.
2. **Macro-Level Epidemiological Data** – This includes the incidence of various diseases over time combined with data on the amounts of different drugs or food additives. This is how it was initially discovered that smoking caused lung cancer. With macro-level data, it's even harder to distinguish correlation from causation. However, different countries often enact different policies that can serve as very useful natural experiments. For instance, 30 countries have banned the use of glyphosate. If the rates of Alzheimer's, autism, and depression declined in these countries and did not decline in the countries still using glyphosate, this would provide very powerful evidence regarding its effects. Unfortunately, there is no global database that currently provides easy access to the incidence of these conditions in various countries over time and the levels of exposure to various chemicals.
3. **Clinical Trial Data** – This is the gold standard with regard to the level of confidence that a factor is truly the cause of an outcome. However, it's also the most expensive to collect. As a result, clinical trials are often very small (less than 50 people). Exclusion criteria in trials often prevent study participants from being representative of real patients. There are ethical considerations that prevent us from running trials that have any risk of harm to participants. Due to the expense involved we have very few trials run on anything other than a molecule that can be patented and sold as a drug.

## Calculating Change from Baseline

A straightforward process can be used to measure how treatments affect symptoms:

1. **Baseline**: Track each person's symptom severity for 2 weeks before they start a treatment to establish their normal level.
2. **Severity Scale**: Participants rate their symptoms from 1-10:

    *   1: No symptoms
    *   5: Moderate symptoms
    *   10: Severe symptoms
3. **Measuring Change**: Subtract the treatment period severity from the baseline severity. A positive number indicates improvement, while a negative number indicates worsening.
4. **Results**: Classify changes as:

    *   Major Improvement: 2+ points better
    *   Moderate Improvement: 1-2 points better
    *   Slight Improvement: 0.5-1 point better
    *   No Change: Less than 0.5 points different
    *   Worse: 0.5+ points worse

These measurements can form the basis of Outcome Labels, showing at a glance whether a treatment typically helps, harms, or has no effect on specific symptoms. An initial implementation of these outcome labels can be found at [studies.dfda.earth](https://studies.dfda.earth).

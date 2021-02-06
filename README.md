
# Large-scale Twitter Analysis on COVID-19 and Anti-Asian Climate

The preprint version of this project is available at https://osf.io/preprints/socarxiv/dvm7r/ (invited to revise and resubmit at *Perspectives on Politics*)

This analysis traces how COVID-19 has shaped an anti-Asian climate on Twitter, drawing on more than 1 million US-located tweets. The other part of the project is based on multi-racial survey data. This is a joint work with Nathan Chan (UCI) and [Vivien Leung](https://sites.google.com/view/vivienleung/home) (UCLA). The paper version will be presented at the 2020 American Political Science Association annual meeting.

The objective of this article is to document the data collection, analysis, and visualization process for my future self, co-authors, and other researchers. In the research process, I also developed an R package called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), which could be useful to social scientists interested in using social media data for their own research. The entire research process is computationally reproducible. All the code used in the analysis is available in this Git repository. I automated parts that could be automatable by writing functions and putting some of these functions as a package.

I welcome any suggestions, comments, or questions. Please feel free to create issues in this Git repository or send an email to [jaeyeonkim@berkeley.edu](mailto:jaeyeonkim@berkeley.edu).

## Key questions

1. To what extent has anti-Asian public sentiment increased since the outbreak of COVID-19?
2. What has contributed to the rise of anti-Asian public sentiment (e.g., President Trump's referring to COVID-19 as either 'Chinese flu' or 'Kung flu')?

## Data collection [[Shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)] [[R package](https://github.com/jaeyk/tidytweetjson)]

1. The data source is [the large-scale COVID-19 Twitter chatter dataset (v.15)](https://zenodo.org/record/3902855#.XvZFBXVKhEZ) created by [Panacealab](http://www.panacealab.org/). The keywords used to search the tweets related to COVID-19 were 'COVD19, CoronavirusPandemic, COVID-19, 2019nCoV, CoronaOutbreak,coronavirus , WuhanVirus, covid19, coronaviruspandemic, covid-19, 2019ncov, coronaoutbreak, wuhanvirus'. These Tweets were created between January and June 2020. Of them, I used 59,650,755 Tweets composed in English. I wrote a [shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh) that automatically reruns this part of the data collection.

2. The original dataset only provided tweet IDs, not tweets, following the Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases). I turned these tweet IDs back into a JSON file (tweets) using [Twarc](https://github.com/DocNow/twarc). This process is called hydrating and often very time-consuming. To ease the process, I randomly selected 10% of the Tweet IDs from the original dataset (N = 5,719,216), stratifying by the months in which the tweets were created. Even this sample dataset is larger than 5 gigabytes. I created an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that efficiently parses this large JSON file into a tidyverse-ready dataframe. The package also helps to turn the timestamp variable in the tweet JSON file into a date variable and identifies whether the location indicated by Twitter users is in the United States or not. Using this package, I identified and selected 1,394,468 tweets (37% of the sample dataset) created by the users located in the United States. This data is used for further analysis.


## Descriptive analysis [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/03_explore.Rmd)]

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/animated_twitter_plot.gif" width = 500>

Figure 1. Animated Twitter trends.

COVID-19 has many names. COVID-19 and Coronavirus are epidemiological terms. Chinese flu, Wuhan virus, and especially Kung flu are politically charged terms. The latter terms have negative associations with Chinese/Asian communities and justify racial attacks against them. Figure 1 shows the trends of these terms, namely 'Chinese flu,' 'Wuhan virus,' and 'Kung flu,' and anti-racism-related terms, such as 'racist,' 'racism,' and 'anti-Asian' among the COVID-19-related tweets created by users in the United States. The X-axis indicates when these tweets were created and the Y-axis represents the count of these tweets normalized to a 0–100 range. The blue dashed line indicates the date when President Trump referred to COVID-19 as the 'Chinese virus.' 'Wuhan virus' was already a popular term among Twitter users, as it was related to the origin of the virus. **Trump's remark on the 'Chinese virus' caused 'Chinese flu' and 'Kung flu' to trend on social media as the counts of them surged after Trump made the controversial speech.** Anti-racism-related words became trendy at the outset of the COVID-19 outbreak (January-February 2020) and the resurgence of the Black Lives Matter movement (May-June 2020).

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/overall_trend.png" width = 500>

Figure 2. Comparison between Google search and Twitter trends.

In Figure 2, I compare the Twitter trend (bottom panel) with the Google search trend (top panel). Twitter users do not represent the US population because people do not sign up to Twitter randomly. Moreover, in this case, we are only analyzing a subset of Twitter users who tweeted about COVID-19. To address this concern about generalizability, I also traced similar trends using Google search API. (Thanks to Tyler Reny for sharing his code used for [his co-authored PRI paper](https://www.tandfonline.com/doi/full/10.1080/21565503.2020.1769693) with Matt Barreto. I [modified](https://github.com/jaeyk/covid19antiasian/blob/master/code/01_google_trends.R) his code to query and save the Google API data.)

Figure 2 demonstrates that to a large extent the Twitter and Google trends are in parallel: **after Trump referred to COVID-19 as Chinese flu, people paid attention to 'Chinese flu' and 'Kung flu' substantially more.** 'Wuhan virus' was popular only at the outset. Anti-racism-related words gained popularity thanks to the Black Lives Matter movement.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/stacked_bar_plots2.png)

Figure 3. Broader Twitter trends in stacked line plots.

The above keyword trend analysis is effective at examining how Trump's speech contributed to the rise of anti-Asian public sentiment. However, if we take a look at the proportions of the tweets mentioning **Chinese virus, Kung flu, Wuhan virus** or **anti-racism-related words** (see Figure 6), they were extremely **marginal**. By contrast, the proportions of the tweets that mentioned **Asian, Chinese, or Wuhan** were far **larger**. Therefore, if I trace the rise of anti-Asian sentiment on social media exclusively focusing on these key word trends, the conclusion I draw from the data analysis could be strongly biased.

## Topic modeling [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/05_topic_modeling.Rmd)]

However, analyzing the tweets related to Chinese or Wuhan is challenging because, in this case, what the keywords imply is not obvious. If someone tweeted 'Chinese flu' or 'Kung flu', the political and racial context is relatively clear. However, if someone tweeted about 'COVID-19' and 'China,' it could be about the country, the virus, anti-Asian sentiment, or something else. In other words, many latent themes exist within these tweets. We need to distinguish these themes to make an inference about these tweets. To do so, I employed a machine learning technique called topic modeling. Simply put, I assumed that these themes (or topics) are the clusters of tweets, and I can identify these topics based on how words in different tweets hang together. An algorithm, such as Latent Dirichlet Allocation (LDA), estimates the relationship between the documents (in this case, tweets). Using the `stm` package in R, I found that, in this case, three would be optimal to balance between exclusivity and semantic coherence (see [this figure](https://github.com/jaeyk/covid19antiasian/blob/master/functions/date2index.R) for the model diagnostics).

### Hashtags (keywords)

Topic modeling does not tell what estimated topics are about. To learn what these topics are, researchers should read some samples of these topics and make decisions. This aspect of topic modeling is time-consuming and, more fundamentally, could lead to post-hoc theorizing. To avoid this problem, I used a topic modeling method called [keyword assisted topic models (keyATM)](https://arxiv.org/abs/2004.05964), an extension of [Jagarlamudi, Jagadeesh, Hal Daum´e III and Raghavendra Udupa (2012)](https://www.aclweb.org/anthology/E12-1021.pdf) and [Li et al (2019)](https://dl.acm.org/doi/abs/10.1145/3238250?casa_token=Ggi-9sdzcH0AAAAA:AwdX6tro6RY1lJdcuKD9uGKcLa8DPhHsVDftlfZPJK4YnNosixeP5dO6hdqmApllmOT-IhMAcTk), developed by Shusei Eshima, Koshuke Imai, and Tomoya Sasaki (2020).Their paper demonstrated how providing a small number of keywords can generate better classification performance and interpretable outcomes against the LDA benchmark. The associated R package is available [here](https://keyatm.github.io/keyATM/).

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/hash_cloud.png)

Figure 4. Hashtags of the Tweets mentioned COVID-19 and either Asian, Chinese, or Wuhan

keyATM is especially applicable to tweets, as Twitter hashtags are literally keywords. In addition, the above keyword trend analyses demonstrated the conceptual validity of these measures. I extracted hashtags of the tweets that mentioned COVID-19 and either Asian, Chinese, or Wuhan and visualized them using a word cloud in Figure 5. I also created an [interactive version of the word cloud](https://rpubs.com/jaeyeonkim/hashcloud) for further exploration. If you hover a cursor over a hashtag, you can find how many times that particular hashtag was mentioned in the corpus. The Shiny app version is available [here](https://jaeyeonkim.shinyapps.io/covid19antiasian_hashcloud/). 

```r
keywords <- list(

    "Anti-Asian" = c("wuhanvirus", "chinesevirus", "chinavirus", "wuhancoronavirus", "wuhanpneumonia", "ccpvirus", "chinaliedpeopledied"),

     "Anti-racism" = c("antiasian", "racism", "racist")

    )

```

Based on the hashtags, I created two list of words: **anti-Asian** (sentiment) and **anti-racism**. Figure 5 shows that the relative frequency of keywords in the corpus by topic. Keywords appeared fewer in documents are less meaningful.

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/keyword.png" width = 500>

Figure 5. Topic word distribution

### Base

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/topic_modeling_static.png" width = 600>

Figure 6. Base topic modeling analysis results

Provided that the number of topics is three, the base topic modeling shows that the proportions of anti-Asian and anti-racism topics are slightly above 30% and close to each other (to be precise, respectively, 34% and 33%).

### Dynamic

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/anti_asian_topic_dynamic_trend.png" width = 600>

Figure 7. Dynamic topic modeling analysis results

Provided that the number of topics is three, the dynamic topic modeling shows that the proportions of both anti-Asian and anti-racism topics surged in January when COVID-19 began to spread in the United States. Then, the proportions of both topics became stable (30–40%). For the dynamic topic modeling, you need to turn a date variable into a time index variable. I created a function called [date2index](https://github.com/jaeyk/covid19antiasian/blob/master/functions/date2index.R), which automatically makes that transition.

## Conclusions

In the Twitter sphere, anti-Asian public sentiment surged in January when COVID-19 began to spread in the United States. Afterward, the pattern became stable. Trump's racially charged speeches made anti-Asian terms, such as the 'Chinese flu' and 'Kung flu' popular. Yet, it is also important to note that anti-Asian public sentiment was already present before Trump pushed the xenophobic language for COVID-19.

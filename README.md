
# Large-scale Twitter Analysis on COVID-19 and Anti-Asian Climate

The preprint version of this project is available at https://osf.io/preprints/socarxiv/dvm7r/ (invited to be revised and resubmitted at *Perspectives on Politics*)

This analysis traces how COVID-19 has shaped an anti-Asian climate on Twitter, drawing on more than 1 million US-located tweets. The other part of the project is based on multi-racial survey data. This is a joint work with [Nathan Chan](https://scholar.google.com/citations?user=3NKNlWwAAAAJ&hl=en) (UCI) and [Vivien Leung](https://sites.google.com/view/vivienleung/home) (UCLA). The paper version will be presented at the 2020 American Political Science Association annual meeting.

The objective of this article is to document the data collection, analysis, and visualization process for my future self, co-authors, and other researchers. In the research process, I also developed an R package called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), which could be useful to social scientists interested in using social media data for their own research. The entire research process is computationally reproducible. All the code used in the analysis is available in this Git repository. I automated parts that could be automatable by writing functions and putting some of these functions as a package.

I welcome any suggestions, comments, or questions. Please feel free to create issues in this Git repository or send an email to [jaeyeonkim@berkeley.edu](mailto:jaeyeonkim@berkeley.edu).

## Key questions

1. To what extent has anti-Asian public sentiment increased since the outbreak of COVID-19?
2. What has contributed to the rise of anti-Asian public sentiment (e.g., President Trump's referring to COVID-19 as either 'Chinese flu' or 'Kung flu')?

## Data collection [[Shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)] [[R package](https://github.com/jaeyk/tidytweetjson)]

1. The data source is [the large-scale COVID-19 Twitter chatter dataset (v.15)](https://zenodo.org/record/3902855#.XvZFBXVKhEZ) created by [Panacealab](http://www.panacealab.org/). The keywords used to search the tweets related to COVID-19 were 'COVD19, CoronavirusPandemic, COVID-19, 2019nCoV, CoronaOutbreak,coronavirus , WuhanVirus, covid19, coronaviruspandemic, covid-19, 2019ncov, coronaoutbreak, wuhanvirus'. These Tweets were created between January and June 2020. Of them, I used 59,650,755 Tweets composed in English. I wrote a [shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh) that automatically reruns this part of the data collection.

2. The original dataset only provided tweet IDs, not tweets, following the Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases). I turned these tweet IDs back into a JSON file (tweets) using [Twarc](https://github.com/DocNow/twarc). This process is called hydrating and often very time-consuming. 
 
    - To ease the process, I randomly selected 10% of the Tweet IDs from the original dataset (N = 5,719,216), stratifying by the months in which the tweets were created. Even this sample dataset is larger than 5 gigabytes. I created an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that efficiently parses this large JSON file into a tidyverse-ready dataframe. The package also helps to turn the timestamp variable in the tweet JSON file into a date variable and identifies whether the location indicated by Twitter users is in the United States or not. I also saved the IDs of the tweets by typing the following command in the terminal: `grep "INFO archived" twarc.log | awk '{print $5}' > tweet_ids` 
   
    - Using the R package, I identified and selected 1,394,468 tweets (37% of the sample dataset) created by the users located in the United States. This data is used for further analysis.


## Descriptive analysis [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/03_explore.Rmd)]

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/animated_twitter_plot.gif" width = 500>

Figure 1. Animated Twitter trends.

<img src = "https://github.com/jaeyk/covid19antiasian/blob/master/outputs/overall_trend.png" width = 500>

Figure 2. Comparison between Google search and Twitter trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/stacked_bar_plots2.png)

Figure 3. Broader Twitter trends in stacked line plots.

## Topic modeling [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/05_topic_modeling.Rmd)]

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

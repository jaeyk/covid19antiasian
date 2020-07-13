
# Twitter Analysis on COVID-19 and Anti-Asian Climate

This analysis traces how COVID-19 shaped anti-Asian climate drawing on more than 1 million US-located Tweets. The other part of the project is based on the multi-racial survey data. This is a joint work with Nathan Chan (UCI) and [Vivien Leung](https://sites.google.com/view/vivienleung/home) (UCLA). I am responsible for the social media data analysis. The paper version will be presented at the 2020 American Political Science Association annual meeting.

The objective of this article is to document the data collection, analysis, and visualization process for my future self, co-authors, and other researchers. In the research process, I also developed an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that could be useful to social scientists interested in using social media data for their own research. The entire research process is computationally reproducible. All the code used in the analysis is available in this Git repository. I automated parts that could be automatable by writing functions and putting some of these functions as a package.

I welcome any suggestions, comments, or questions. Please feel free to create issues in this Git repository or send an email to [jaeyeonkim@berkeley.edu](mailto:jaeyeonkim@berkeley.edu).

## Key questions

1. To what extent has anti-Asian public sentiment increased since the outbreak of COVID-19?
2. What has contributed to the rise of anti-Asian public sentiment (e.g., president Trump's referring COVID-19 as either `Chinese flu` or `kung flu`)?

## Data collection [[Shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)] [[R package](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)]

1. The data source is [the large-scale COVID-19 Twitter chatter dataset (v.15)](https://zenodo.org/record/3902855#.XvZFBXVKhEZ) created by [Panacealab](http://www.panacealab.org/). The keywords used to search the tweets related to COVID-19 were `COVD19, CoronavirusPandemic, COVID-19, 2019nCoV, CoronaOutbreak,coronavirus , WuhanVirus, covid19, coronaviruspandemic, covid-19, 2019ncov, coronaoutbreak, wuhanvirus`. These tweets were created between January and June 2020. Of them, I used 59,650,755 tweets composed in English. I wrote a [shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh) that automatically reruns this part of the data collection.

2. The original dataset only provided Tweet IDs, not tweets, following the Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases). I turned these Tweet IDs back into a JSON file (Tweets) using [Twarc](https://github.com/DocNow/twarc). This process is called hydrating and often very time-consuming. To ease the process, I randomly selected 10% of the Tweet IDs from the original dataset (N = 5,719,216) stratifying on the months in which the tweets were created. Even this sample dataset is larger than 5 gigabytes. I created an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that efficiently parses this large JSON file into a tidyverse-ready dataframe. The package also helps to turn the timestamp variable in the Tweet JSON file into a date variable and identifies the location indicated by the Twitter users is in the United States or not. Using this package, I identified and selected 1,394,468 tweets (37% of the sample dataset) created by the users located in the United States. This data is used for the further analysis.


## Descriptive analysis [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/03_explore.Rmd)]

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/animated_twitter_plot.gif)

Figure 1. Animated Twitter trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/overall_trend.png)

Figure 2. Comparison between Google search and Twitter trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/stacked_bar_plots2.png)

Figure 3. Broader Twitter trends in stacked line plots.


## Topic modeling [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/05_topic_modeling.Rmd)]

### Hashtags (keywords)

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/hash_cloud.png)

Figure 4. Hashtags of the Tweets mentioned Asian, Chinese, or Wuhan

### Base

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/topic_modeling_static.png)

Figure 5. Base topic modeling analysis results

### Dynamic

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/anti_asian_topic_dynamic_trend.png)

Figure 6. Dynamic topic modeling analysis results

## Conclusions

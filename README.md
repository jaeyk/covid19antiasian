
# Twitter Analysis on COVID-19 and Anti-Asian Climate

This analysis traces how COVID-19 shaped anti-Asian climate drawing on more than 1 million US-located Tweets. The other part of the project is based on the multi-racial survey data. This is a joint work with Nathan Chan (UCI) and [Vivien Leung](https://sites.google.com/view/vivienleung/home) (UCLA). I am responsible for the social media data analysis. The paper version will be presented at the 2020 American Political Science Association annual meeting.

The objective of this article is to document the data collection, analysis, and visualization process for my future self, co-authors, and other researchers. In the research process, I also developed an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that could be useful to social scientists interested in using social media data for their own research. The entire research process is computationally reproducible. All the code used in the analysis is available in this Git repository. I automated parts that could be automatable by writing functions and putting some of these functions as a package.

I welcome any suggestions, comments, or questions. Please feel free to create issues in this Git repository or send an email to [jaeyeonkim@berkeley.edu](mailto:jaeyeonkim@berkeley.edu).

## Key questions

1. To what extent has anti-Asian public sentiment increased since the outbreak of COVID-19?
2. What has contributed to the rise of anti-Asian public sentiment (e.g., president Trump's referring COVID-19 as either `Chinese flu` or `kung flu`)?

## Data collection [[Shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)] [[R package](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)]

1. The data source is [the large-scale COVID-19 Twitter chatter dataset (v.15)](https://zenodo.org/record/3902855#.XvZFBXVKhEZ) created by [Panacealab](http://www.panacealab.org/). The keywords used to search the Tweets related to COVID-19 were `COVD19, CoronavirusPandemic, COVID-19, 2019nCoV, CoronaOutbreak,coronavirus , WuhanVirus, covid19, coronaviruspandemic, covid-19, 2019ncov, coronaoutbreak, wuhanvirus`. These Tweets were created between January and June 2020. Of them, I used 59,650,755 Tweets composed in English. I wrote a [shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh) that automatically reruns this part of the data collection.

2. The original dataset only provided Tweet IDs, not Tweets, following the Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases). I turned these Tweet IDs back into a JSON file (Tweets) using [Twarc](https://github.com/DocNow/twarc). This process is called hydrating and often very time-consuming. To ease the process, I randomly selected 10% of the Tweet IDs from the original dataset (N = 5,719,216) stratifying on the months in which the Tweets were created. Even this sample dataset is larger than 5 gigabytes. I created an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that efficiently parses this large JSON file into a tidyverse-ready dataframe. The package also helps to turn the timestamp variable in the Tweet JSON file into a date variable and identifies the location indicated by the Twitter users is in the United States or not. Using this package, I identified and selected 1,394,468 Tweets (37% of the sample dataset) created by the users located in the United States. This data is used for the further analysis.


## Descriptive analysis [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/03_explore.Rmd)]

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/animated_twitter_plot.gif)

Figure 1. Animated Twitter trends.

COVID-19 has many names. COVID-19 or Coronavirus are epidemiological terms. Chinese flu, Wuhan virus, and especially Kung flu are political charged terms. The latter terms have negative associations with Chinese/Asian communities and justify racial attacks against them. Figure 1 shows the trends of these terms, namely `Chinese flu`, `Wuhan virus`, and `Kung flu`, and anti-racism related terms, such as `racist`, `racism`, and `anti-Asian` among the COVID-19 related Tweets created by the users located in the United States. The X-axis indicates when these Tweets were created and the Y-axis represents the count of the these Tweets normalized to a 0-100 range. The blue dashed line indicates the date when president Trump referred COVID-19 as `Chinese virus`. Wuhan virus was already a popular term among the Twitter users as it was related to the origin of the virus. Trump's remark on Chinese virus made `Chinese flu` and `Kung flu` trendy in the social media as the counts of them surged after Trump made the controversial speech. Anti-racism related words became trendy at the outset of the COVID-19 outbreak (January-February 2020) and the period of the Black Lives Matter movement (May-June 2020).

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/overall_trend.png)

Figure 2. Comparison between Google search and Twitter trends.

In Figure 2, I compare the Twitter trend (bottom panel) with the Google search trend (top panel). Twitter users do not represent the US population because people do not sign up Twitter randomly. Moreover, in this case, we are only analyzing a subset of the Twitter users tweeted about COVID-19. To address this concern about generalizability, I also traced similar trends using Google search API. (Thanks Tyler Reny for sharing his code used for [his co-authored PRI paper](https://www.tandfonline.com/doi/full/10.1080/21565503.2020.1769693) with Matt Barreto. I [modified](https://github.com/jaeyk/covid19antiasian/blob/master/code/01_google_trends.R) his code to query and save the Google API data.)

Figure 2 demonstrates that to a large extent the Twitter and Google trends are in parallel: after Trump referred COVID-19 as Chinese flu, people paid attention to `Chinese flu` and `Kung flu` substantially. Wuhan virus was popular only at the outset. Anti-racism related words gained popularity during the Black Lives Matter movement.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/stacked_bar_plots2.png)

Figure 3. Broader Twitter trends in stacked line plots.

The above keyword trend analysis is effective in examining how Trump's speech contributed to the rise of anti-Asian public sentiment. However, if we take a look at the proportions of the Tweets mentioned `Chinese virus`, `Kung flu`, `Wuhan virus` or anti-racism related words (see Figure 6), they were extremely marginal. By contrast, the proportions of the Tweets mentioned Wuhan, Chinese, or Asian were far larger. Therefore, if I trace the rise of anti-Asian sentiment in the social media exclusively focusing on these key word trends, the conclusion I draw from the data analysis could be strongly biased.


## Topic modeling [[R Markdown](https://github.com/jaeyk/covid19antiasian/blob/master/code/05_topic_modeling.Rmd)]

Therefore, I selected the


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

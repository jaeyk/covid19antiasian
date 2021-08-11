
# Replication data and code for Study 1 (Social Media Data Analysis)

Author: Jae Yeon Kim (jkim638@jhu.edu)

**Session information**

1. Programming languages

* R version 4.0.4 (2021-02-15)
* Python 3.8.8
* Bash 5.1.4(1)-release

2. Operation system

Platform: x86_64-pc-linux-gnu (64-bit)

Running under: Ubuntu 21.04

## Data collection [[Shell script](https://github.com/jaeyk/covid19antiasian/blob/master/code/00_setup.sh)] [[R package](https://github.com/jaeyk/tidytweetjson)]

**Raw data: tweet_ids**

The data source is [the large-scale COVID-19 Twitter chatter dataset (v.15)](https://zenodo.org/record/3902855#.XvZFBXVKhEZ) created by [Panacealab](http://www.panacealab.org/). The original dataset only provided tweet IDs, not tweets, following Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases). I turned these tweet IDs back into a JSON file (tweets) using [Twarc](https://github.com/DocNow/twarc). This process is called hydrating and is very time-consuming. To ease the process, I created an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that efficiently parses this large JSON file into a tidyverse-ready data frame. To help replication, I also saved the IDs of the tweets by typing the following command in the terminal: `grep "INFO archived" twarc.log | awk '{print $5}' > tweet_ids`

**Replication code**

* 00_setup.sh: Shell script for collecting Tweets and their related metadata based on Tweet IDs

* 01_google_trends.r: R script for collecting Google search API data

* 01_sample.Rmd: R markdown file for sampling Twitter data

* 02_parse.r: R script for parsing Twitter data. This script produced a cleaned and wrangled data named 'parsed.rds.' This file is not included in this repository to not violate Twitter's Developer Terms. Also, its file size is quite large (**1.4 GB**).

## Descriptive analysis

**Replication code**

* 03_explore.Rmd: R markdown file for further wrangling and exploring data. This file creates **Figure 2.** (overall_trend.png)

* 04_01_hashtags.R: R script file for creating a wordlcoud of hashtags. This file creates **Figure 1.** (hash_cloud.png)

* 04_clean.ipynb: Python notebook for cleaning texts

## Topic modeling

**Replication code**

* 05_topic_modeling.Rmd: R markdown for topic modeling analysis. This file creates **Figure 3** (dynamic_topic_day.png)

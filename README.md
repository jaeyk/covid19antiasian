
# Twitter Analysis on COVID-19 and Anti-Asian Climate

This analysis traces how COVID-19 shaped anti-Asian climate drawing on more than 1 million US-located Tweets. The other part of the project is based on the multi-racial survey data. This is a joint work with Nathan Chan (UCI) and [Vivien Leung](https://sites.google.com/view/vivienleung/home) (UCLA). The paper version will be presented at the 2020 American Political Science Association annual meeting.

The objective of this article is to document the data collection, analysis, and visualization process for my future self, co-authors, and other researchers. In the research process, I also developed an R package, called [tidytweetjson](https://github.com/jaeyk/tidytweetjson), that could be useful to social scientists interested in using social media data for their own research. The entire research process is computationally reproducible. I automated parts that could be automatable by writing functions and putting some of these functions as a package.

I welcome any suggestions, comments, or questions. Feel free to create issues in this Git repository or send an email to [jaeyeonkim@edu](maito:jaeyeonkim@edu.).

## Key questions

1. To what extent has anti-Asian public sentiment increased since the outbreak of COVID-19?
2. What has contributed to the rise of anti-Asian public sentiment? Specifically, has president Trump's exclusionary speeches (e.g., Chinese virus, kung flu) contributed to it?

## Data collection

## Descriptive analysis

![](https://github.com/jaeyk/covid19antiasian/raw/master/outputs/animated_gtrends_plot.gif)

Figure 1. Animated Google search trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/animated_twitter_plot.gif)

Figure 2. Animated Twitter trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/overall_trend.png)

Figure 3. Non-animated Google search and Twitter trends.

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/stacked_bar_plots2.png)

Figure 4. Broader Twitter trends in stacked line plots.

## Topic modeling

### Hashtags (keywords)

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/hash_cloud.png)

Figure 5. Hashtags of the Tweets mentioned Asian, Chinese, or Wuhan

### Base

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/topic_modeling_static.png)

Figure 6. Base topic modeling analysis results

### Dynamic

![](https://github.com/jaeyk/covid19antiasian/blob/master/outputs/anti_asian_topic_dynamic_trend.png)

Figure 7. Dynamic topic modeling analysis results

## Conclusions

## Workflow
1. Download and unzip [the large-scale COVID-19 Twitter chatter dataset](https://zenodo.org/record/3902855#.XvZFBXVKhEZ), created by [Panacealab](http://www.panacealab.org/) (v.15) and remove all extracted files except the English Twitter data (2.3 GB).

- I took all of these steps in the command-line interface to increase efficiency, transparency and reproducibility. The tsv file (`clean_language_en.tsv`) contains 59,650,755 observations.

```bash
# Download the file in the raw_data subdirectory of the project directory

$ curl -O https://zenodo.org/record/3902855/files/clean_languages.tar.gz?download=1

# Check the downloaded file, including information on its size
# $ ls -lh

# Unpack the .tar.gz file
$ tar -xzf 'clean_languages.tar.gz?download=1'

# The above command will create combined_languages subdirectory.

# Change directory to the subdirectory then move the English twitter data to the parent directory and then remove the subdirectory

$ cd combined_languages | mv clean_language_en.tsv ../ | rm-r combined_languages/

# Inspect the English Twitter data
# $ head clean_language_en.tsv

# Count the number of rows in the tsv file: 59,650,755
$ wc -l clean_language_en.tsv

# 59,650,755
```

```bash

```

```bash
chmod 755 setup.sh

./test
```
2. Hydrate the Tweet IDs

- The publicly available Twitter data only contains Tweet IDs to comply with Twitter's [Terms of Service](https://developer.twitter.com/en/developer-terms/agreement-and-policy). I turned these Tweet IDs back into a JSON file (Tweets) using [Twarc](https://github.com/DocNow/twarc). If you were using Twarc for the first time, refer to [this tutorial](https://github.com/alblaine/twarc-tutorial).

- To ease hydration, I first randomly selected 5,719,216 Tweet IDs (10%) from the dataset starifying on the months in which these tweets were created. I then saved the sampled data in a new file named `sampled.tsv`. The tsv file has four columns: `Tweet IDs`, `date`, `time`, and `month`. Since we only need the first column, I selected it and saved it as a separate file named `sampled1.tsv`. I took this step in R as the `fread()` function from `data.table` package is fast enough even for importing and wrangling a 2.3 GB tsv file.

- Now, hydrate in the terminal using `twarc`.

```bash
# Hydrate
$ twarc hydrate sampled1.tsv > sampled.jsonl

```

- The next step is turn the JSON file into a csv file. `tidyjson` is a great tool to turn a messy JSON file, ingested from the Twitter API, into a tidyverse-ready dataframe. I wrote an R function (`twitter_json2csv.R`). The problem is the JSON file is too huge to be parsed into a R session. (Your session will be killed automatically.) To get around this problem, I split the JSON file into smaller chunks and applied the parser.

```bash
# Create a subdirectory and move the file there
$ mkdir splitted_data
$ mv sampled.jsonl splitted_data/ | cd splitted_data/

# Divide the json file by 1000 lines (Tweets)
$ split -1000 sampled.jsonl --verbose
```

The above command created a series of smaller files all named like this "xab", "xac", "xad", etc. This pattern can be summarized as `[^x]` in the regular expression.

- I created an R package

- I modified the function

- I saved it in an R script and run it in a terminal.

```bash
$ Rscript 02_parse_data.R
```

`nrow(parsed.rds)` = 5,050,042

```bash
# If you want to remove these sliced JSON files except the original one then type

$ rm -v !("sampled.jsonl")
$ mv sampled.jsonl ../

$ rmdir splitted_data/
````
3. Exploratory data analysis

4. Topic modeling

https://www.aclweb.org/anthology/E12-1021/

https://keyatm.github.io/keyATM/index.html

"the specification of keywords before fitting the model, thereby avoiding post-hoc
interpretation and adjustments of topics." (page 2)

"this model provides more interpretable topics, more accurate classification performance, and less sensitivity to starting values than the dynamic model without keywords. Finally, the model appears to better capture the dynamic trend of topic prevalence." (page 2)

Lit. review

https://arxiv.org/abs/2004.11692

https://arxiv.org/abs/2005.03082

https://www.jmir.org/2020/4/e19016/

https://link.springer.com/chapter/10.1007/978-3-319-06608-0_13

# hateasiancovid
Investigation the relationship between COVID-19 and the Anti-Asian Climate

## Workflow
1. Downalod and unzip [the large-scale COVID-19 Twitter chatter dataset](https://zenodo.org/record/3902855#.XvZFBXVKhEZ), created by [Panacealab](http://www.panacealab.org/) (v.15) and remove all extracted files except the English Twitter data (2.3 GB).

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

- The next step is turn the JSON file into a csv file. `tidyjson` is a great tool to turn a messy JSON file, ingested from the Twitter APID, into a tidyverse-ready dataframe. I wrote an R function (`twitter_json2csv.R`). The problem is the JSON file is too huge to be parsed into a R session. (Your session will be killed automatically.) To get around this problem, I split the JSON file into smaller chunks and applied the parser.

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

# hateasiancovid
Investigation the relationship between COVID-19 and the Anti-Asian Climate

## Workflow
1. Downalod and unzip [the large-scale COVID-19 Twitter chatter dataset](https://zenodo.org/record/3902855#.XvZFBXVKhEZ), created by [Panacealab](http://www.panacealab.org/) (v.15) and remove all extracted files except the English Twitter data (2.3 GB).

- I took all of these steps in the command-line interface to increase efficiency, transparency and reproducibility. The tsv file (`clean_language_en.tsv`) contains 59,650,755 observations.

```bash
# Download the file in the raw_data subdirectory of the project directory

$ curl -O https://zenodo.org/record/3902855/files/clean_languages.tar.gz?download=1

# Check the downloaded file, including information on its size
$ ls -lh

# Unpakcg the .tar.gz file
$ tar -xzf 'clean_languages.tar.gz?download=1'

# The above command will create combined_languages subdirectory.

# Change directory to the subdirectory then move the English twitter data to the parent directory and then remove the subdirectory

$ cd combined_languages | mv clean_language_en.tsv ../ | rm-r combined_languages/

# Inspect the English Twitter data
$ head clean_language_en.tsv

# Count the number of rows in the tsv file
$ wc -l clean_language_en.tsv

# 59,650,755
```

2. Hydrate the Tweet IDs

- The publicly available Twitter data only contains Tweet IDs to comply with Twitter's [Terms of Service](https://developer.twitter.com/en/developer-terms/agreement-and-policy). I turned these Tweet IDs back into JSON data (Tweets) using [Twarc](https://github.com/DocNow/twarc). If you were using Twarc for the first time, refer to [this tutorial](https://github.com/alblaine/twarc-tutorial).

- I first randomly selected 10 Tweet IDs from the dataset and then save it in a new file named `test.tsv`.

```bash
$ shuf -n 10 clean_language_en.tsv > test.tsv
```

- `test.tsv` has three columns: `Tweeter IDs`, `date`, and `time` I need only the first column for hydration. I select

```bash
$ cut -f1 test.tsv > test1.tsv
```

- Now, hydrate.

```bash
# Hydrate
$ twarc hydrate test1.tsv > test.jsonl
# Check
$ head -n5 test.jsonl 
```

3. Subset Asians
4. Classify hate speech
5. Classify race
6. Classify partisanship https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/AEZPLU
7. Topic modeling (keyATM) https://keyatm.github.io/keyATM/index.html
8. Creating a dashboard

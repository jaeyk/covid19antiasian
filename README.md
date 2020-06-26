# hateasiancovid
Investigation the relationship between COVID-19 and the Anti-Asian Climate

## Workflow
1. Downalod and unzip [the large-scale COVID-19 Twitter chatter dataset](https://zenodo.org/record/3902855#.XvZFBXVKhEZ), created by [Panacealab](http://www.panacealab.org/) (v.15) and remove all extracted files except the English Twitter data (2.3 GB)

```bash
# Download the file in the raw_data subdirectory of the project directory

curl -O https://zenodo.org/record/3902855/files/clean_languages.tar.gz?download=1

# Check the downloaded file, including information on its size
ls -lh

# Unpakcg the .tar.gz file
tar -xzf 'clean_languages.tar.gz?download=1'

# The above command will create combined_languages subdirectory.

# Change directory to the subdirectory then move the English twitter data to the parent directory and then remove the subdirectory

cd combined_languages | mv clean_language_en.tsv ../ | rm-r combined_languages/

# Inspect the English Twitter data
head clean_language_en.tsv
```

3. Hydrate tweet-ids
4. Subset Asians
5. Classify hate speech
6. Classify race
7. Classify partisanship https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/AEZPLU
8. Topic modeling (keyATM) https://keyatm.github.io/keyATM/index.html
9. Creating a dashboard

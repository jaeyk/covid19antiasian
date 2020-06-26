# hateasiancovid
Investigation the relationship between COVID-19 and the Anti-Asian Climate

## Workflow
1. Downalod and unzip [the large-scale COVID-19 Twitter chatter dataset](https://zenodo.org/record/3902855#.XvZFBXVKhEZ), created by [Panacealab](http://www.panacealab.org/) (v.15)

```bash
# Download the file in the raw_data subdirectory of the project directory

wget https://zenodo.org/record/3902855/files/clean_languages.tar.gz?download=1

# If you want to check the downloaded file, including information on its size, type `ls -lh`

# Unpakcg the .tar.gz file
tar -xzf 'clean_languages.tar.gz?download=1'
```

2. Chose the English tsv
3. Hydrate tweet-ids
4. Subset Asians
5. Classify hate speech
6. Classify race
7. Classify partisanship https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/AEZPLU
8. Topic modeling (keyATM) https://keyatm.github.io/keyATM/index.html
9. Creating a dashboard

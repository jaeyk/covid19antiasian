#!/bin/bash

# Set up automatically

# Download the file in the raw_data subdirectory of the project directory

curl -O https://zenodo.org/record/3902855/files/clean_languages.tar.gz?download=1

# Check the downloaded file, including information on its size
# $ ls -lh

# Unpack the .tar.gz file
tar -xzf 'clean_languages.tar.gz?download=1'

# The above command will create combined_languages subdirectory.

# Change directory to the subdirectory then move the English twitter data to the parent directory and then remove the subdirectory

cd combined_languages | mv clean_language_en.tsv ../ | rm-r combined_languages/

# Inspect the English Twitter data
# $ head clean_language_en.tsv

# Count the number of rows in the tsv file: 59,650,755
wc -l clean_language_en.tsv

# 59,650,755

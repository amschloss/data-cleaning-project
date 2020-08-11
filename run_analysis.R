######################
# Coursera Project: Getting and Cleaning Data
# Author: Adam Schloss
# Date: 10 Aug 2020
######################

# Establish baseline file structure

if(!file.exists("./data")) {
    dir.create("./data")
}

# Download data

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipLoc <- "./data/dataset.zip"
if(!file.exists(zipLoc)) {
    download.file(zipUrl, zipLoc, method="auto", mode="wb")
}
unzip(zipLoc)
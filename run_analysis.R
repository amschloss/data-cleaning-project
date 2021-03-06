######################
# Coursera Project: Getting and Cleaning Data
# Author: Adam Schloss
# Date: 10-14 Aug 2020
######################

# Establish baseline file structure

if(!file.exists("./data")) {
    dir.create("./data")
}

# Download and decompress data

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipLoc <- "./data/dataset.zip"
if(!file.exists(zipLoc)) {
    download.file(zipUrl, zipLoc, method="auto", mode="wb")
}
if(!file.exists("./UCI HAR Dataset")) {unzip(zipLoc)}

# Load data files

# features
featureFile <- read.table("./UCI HAR Dataset/features.txt", sep=" ")
featureNames <- featureFile[, 2]

# activity names
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")

# test/train data sets
# these use the same logic, just in different folders, so encapsulate it
loadData <- function(dataset = character()) {
    if(!(tolower(dataset) %in% c("test", "train"))) {
        stop("Can only use loadData with test or train")
    }
    
    # set up our file names, programmatically
    dataLocBase <- paste0("./UCI HAR Dataset/", dataset)
    dataLocs <- paste0(dataLocBase, c(paste0("/X_", dataset, ".txt"), 
                         paste0("/y_", dataset, ".txt"), 
                         paste0("/subject_", dataset, ".txt")))
    names(dataLocs) <- c("X", "y", "subject")
    
    # read the base data into a dataframe
    outDF <- read.table(dataLocs["X"], header = FALSE, sep = "")
    colnames(outDF) <- featureNames
    
    # read the data labels and convert to activity factors
    activityCodes <- readLines(dataLocs["y"])
    activity <- factor(activityCodes, levels = activityLabels[, 1],
                              labels = activityLabels[, 2])
    
    # read the subject IDs
    subjectIDs <- read.table(dataLocs["subject"])
    colnames(subjectIDs) <- "subjectid"
    
    # extract the columns we want, then combine with metadata
    # we only want the columns containing means or standard deviations
    outDF <- outDF[, grep("mean[^F]|std", featureFile[, 2])]
    cbind(subjectIDs, activity, outDF)
}
full <- rbind(loadData("train"), loadData("test"))

# rename columns
newnames <- colnames(full)
newnames <- gsub("[()]", "", newnames)
newnames <- sub("tBody", "time-body-", newnames)
newnames <- sub("tGravity", "time-gravity-", newnames)
newnames <- sub("Acc", "accelerometer-", newnames)
newnames <- sub("fBodyBody", "fBody", newnames)
newnames <- sub("fBody", "fourier-body-", newnames)
newnames <- sub("Gyro", "gyroscope-", newnames)
newnames <- sub("Mag", "-magnitude", newnames)
newnames <- sub("std", "stdev", newnames)
newnames <- sub("-Jerk", "Jerk", newnames)
newnames <- tolower(sub("--", "-", newnames))
newnames <- sub("magnitude-mean", "mean-magnitude", newnames)
newnames <- sub("magnitude-stdev", "stdev-magnitude", newnames)
colnames(full) <- newnames

# reorder columns
# this reorder puts each magnitude column next to its respective components
# resulting order:
#   subjectid
#   activity
#   time-domain columns, ordered alphabetically
#   frequency-domain (Fourier transformed) columns, ordered alphabetically
types <- c(1, 2, rep(3,40), rep(4,26))
full <- full[, order(types, colnames(full))]

# sort and export the full data set
library(dplyr)
full <- full %>% 
    group_by(subjectid, activity) %>%
    arrange(subjectid, activity)
if(!file.exists("./ouptut")) {dir.create("./output")}
write.csv(full, "./output/fullset.csv", row.names = FALSE)

sums <- summarize(full, across(everything(), mean))
write.csv(sums, "./output/summary.csv", row.names = FALSE)

######################
# Coursera Project: Getting and Cleaning Data
# Author: Adam Schloss
# Date: 10 Aug 2020
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

# test/train -- these use the same logic, so encapsulate it
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
    
    # read the base data and convert it to a matrix
    dataLines <- readLines(dataLocs["X"])
    baseMat <- as.numeric(sapply(strsplit(dataLines, " "), function(x) {
        x[!is.na(x) & x != ""]}))
    outDF <- as.data.frame(t(baseMat))
    colnames(outDF) <- featureNames
    
    # read the data labels and convert to activity factors
    activityCodes <- readLines(dataLocs["y"])
    activity <- factor(activityCodes, levels = activityLabels[, 1],
                              labels = activityLabels[, 2])
    
    # read the subject IDs
    subjectIDs <- read.table(dataLocs["subject"])
    colnames(subjectIDs) <- "subjectid"
    
    # extract the values we want, then combine with metadata
    outDF <- outDF[, grep("mean[^F]|std", featureFile[, 2])]
    cbind(subjectIDs, activity, outDF)
}

full <- rbind(loadData("train"), loadData("test"))
colnames(full) <- gsub("[()]", "", colnames(full))
colnames(full) <- sub("tBody", "time-body-", colnames(full))


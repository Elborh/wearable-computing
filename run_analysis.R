## Module:        RunAnalysis.R
##
## Description:   Conducts the data cleaning and summarization required by the 
##                course work objectives (see README.md for detailes)
##
## Input:         UCI HAR Dataset from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
## 
## Output:        tidy_grouped_data.txt - space delimited file with data processing results
##
## Prerequisites: 1. The input dataset is unzipped into the folder where this module is
##                2. The "dplyr" library package is installed in R


setwd("UCI HAR Dataset/")

# Load features names list
featureNames <- read.table("features.txt", col.names=c("id", "name"), stringsAsFactors=FALSE)

# Load and merge feature (x) vectors from train and test data sets
features_train <- read.fwf("train/X_train.txt", rep(c(-1, 15), nrow(featureNames)))
features_test <- read.fwf("test/X_test.txt", rep(c(-1, 15), nrow(featureNames)))
features <- rbind(features_train, features_test)
names(features) <- featureNames$name

# Load and merge subject id from train and test data sets
subjects_train <- read.table("train/subject_train.txt", col.names = "subjectId")
subjects_test <- read.table("test/subject_test.txt", col.names = "subjectId")
subjects <- rbind(subjects_train, subjects_test)

# Load and merge activity values from train and test data sets.
# Also load and assign meaningful activity factor labels 
activities_train <- read.table("train/y_train.txt", col.names = "activity", colClasses = "factor")
activities_test <- read.table("test/y_test.txt", col.names = "activity", colClasses = "factor")
activities <- rbind(activities_train, activities_test)
activityNames <- read.table("activity_labels.txt", col.names=c("id", "name"), stringsAsFactors = FALSE)
levels(activities$activity) <- tolower(activityNames$name)

# Join subjects, activities and features together in one resulting tidy dataset
# taking only those features which are mean or std
meanOrStd <- grep("mean\\(\\)|std\\(\\)", names(features))
tidyData <- cbind(subjects, activities, features[, meanOrStd])

# Clean data labels
names(tidyData) <- 
    names(tidyData) %>% 
    sub("BodyBody", "Body", .) %>%       # Fix BodyBody typo
    sub("^t", "Time", .) %>%             # Extend description of "t" prefix
    sub("^f", "Freq", .) %>%             # Extend description of "f" prefix
    sub("Gravity", "Grav", .) %>%        # Unify "Grav" spelling
    sub("-(mean)\\(\\)", "Mean", .) %>%  # Unify "Mean" spelling
    sub("-(std)\\(\\)", "Std", .) %>%    # Unify "Std" spelling
    sub("-([XYZ])", "\\1", .)            # Unify XYZ spelling

# Average all variables by subject and activity
# Update the variable labels respectively
library(dplyr)
outputData <- tidyData %>% group_by(subjectId, activity) %>% summarise_all(mean)
names(outputData)[-(1:2)] <- lapply(names(outputData)[-(1:2)],
                                    function(x) paste("avg", x, sep = ""))

# Save output data to disk
write.table(outputData, "../tidy_grouped_data.txt", row.names = FALSE)

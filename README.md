# wearable-computing

## Introduction

This repository contains the course project files for the ["Getting and Cleaning data"](https://www.coursera.org/learn/data-cleaning/) course.

The goal of the course project is to take measurement data collected from the Samsung Galaxy S smartphone accelerometers and prepare it for the later processing. 

The original data is available in [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) in the form of several flat files, containing measurements from smartphone sensors (feature sets), persons (subject) who were wearing the smartphone and activity that persons did at the moment of measurements. The files are additionally split into training and testing data partitions. 

The main result of the course project is the data processing script that should:
* Merge the training and the test data sets
* Extract only the measurements on the mean and standard deviation
* Give appropriate and descriptive variable names and categorical data labels
* Produce output file containing tidy data set with the average of each variable for each activity and each subject

## Repository items
The contents of the repository include 
1. Source data set files in "UCI HAR Dataset" directory:

File | Description
---- | -----------
features.txt | List of all features
activity_labels.txt | Links the activity id with activity name
train/X_train.txt | Features in the training data set
train/y_train.txt | Activity predictions in the training data set
train/subject_train.txt | Subject who performed the activity in the training data set
test/X_test.txt | Features in the test data set
test/y_test.txt | Activity predictions in the test data set
test/subject_train.txt | Subject who performed the activity in the test data set

2. The solution files and description:

File | Description
---- | -----------
run_analysis.R | The R solution script which does the processing
tidy_grouped_data.txt | The output file containing the tidy data set
CodeBook.md | The markdown file describing the tidy data set
README.md | This file

## Processing steps
All data transformation steps converting the original data sets into the output file reside in the run_analysis.R script file. These steps are the following:

1. Load and merge features from training (X_train.txt) and test (X_test.txt) data sets. Load feature names from features.txt file and assign them as labels to the features data frame.
1. Load and merge subject id values from the training (subject_train.txt) and test (subject_test.txt) data sets. Give the column "subjectId" name.
1. Load and merge activity values from the training (y_train.txt) and test (y_test.txt) data sets. Load activity labels from activity_labels.txt, convert the labels lowercase and link them to the activity values.
1. Join (cbind) subjects, activities and features data sets together into one resulting data set. When doing so, take only those features which are mean or std.
1. Clean and unify the resulting data set labels, specifically
	1. Replace "BodyBody" with "Body"
	1. Replace "t" prefix with "Time"
	1. Replace "f" prefix with "Freq"
	1. Replace "-mean()" and "-std()" suffixes with "Mean" and "Std" respectively
	1. Replace "-X", "-Y", "-Z" suffixes with "X", "Y" and "Z" respectively
1. Group the data set received on the previous step by subjectId and activity and calculate averages for each variable. Also add the "avg" prefix to all variable lable names.
1. Save the data set from the previous step into the "tidy_grouped_data.txt"

In order for the run_analysis.R script to work, the dplyr library package should be preliminary installed.

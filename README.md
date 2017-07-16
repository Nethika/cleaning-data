# cleaning-data

This project collects, works with, and cleans a data set. The goal is to prepare tidy data that can be used for later analysis. 

## data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description of data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## required packages:
dplyr

reshape2

## ```run_analysis.R``` does the following.

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement.

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names.

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

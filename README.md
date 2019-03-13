##README## Lalith Kumar##
##Getting and Cleaning Data Course Project## 

The purpose of this document is to provide how to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

This repo explains how all of the scripts work and how they are connected.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 

This readme document describes step by step how to prepare and clean the dataset presented in the Coursera Project.

a) Unzip the source file with the data in a local directory of your machine (Find the zip files in following URL:      
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

b) Run the "run_analysis.R" script in R working directory.

c) Make sure that all the files are read from the unzipped folder, are placed in working directory...

features.txt
activity_labels.txt
X_train.txt
subject_train.txt
y_train.txt
X_test.txt
subject_test.txt
y_test.txt

d) Run the "run_analysis.R" script.

Following steps to be performed in the "run_analysis.R" script:

1. Reads data from each single .txt file using the read.table command
2. Merge train data horizontally with its corrspondent subject and activity coloumns, using cbind function. Same to be done with test data.
3. Merge train & test data vertically using the rbind function.
4. Assign activity_num to their correspondent activity_type values using a lookup table, & finally add the activity_type column to the merged data set
5. Subset only measurement of the mean & standard deviation
6. Create a new idependent data set with the average of each variable for each activity & each subject, using the aggregate function.
7. Write the resulting data set into a .txt file names "LKtidydata.txt".

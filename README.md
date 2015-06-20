# GettingAndCleaningDataProject
This repository is for my "Getting and Cleaning Data Course Project".

The goal of the project was to produce a tidy data set to be used for later analysis.

This README.md file explains how the script to tidy the data works: the environment used,
set up required before execution, script execution, and resulting data file. 
For information on the variables, the data, and the transformations, 
see the CodeBook.md file.

Environment
===========

The data transformation was done with the run_analysis.R script on a Windows PC running R version 3.1.3 and 
RStudio Version 0.98.1103. The R packages dplyr and reshape2 had been previously installed.

Set up for and execution of script
==================================

On a computer with R installed, perform the following steps.

1. Download original data (zip file)  
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the file to a directory named "data" that is at the same level where the script
   is (or will be placed)
3. Download the run_analysis.R script 
4. Ensure the directory from which the script will be executed contains:
      - run_analysis.R
	  - data/
	    - features.txt
		- test/
		  - subject_test.txt
		  - X_test.txt
		  - y_test.txt
		- train/
		  - subject_train.txt
		  - X_train.txt
		  - y_train.txt
5. In R:  
     a. install the R packages dplyr and reshape2, if not already installed  
     b. set the working directory to the location of the script and the data directory  
     c. source the script (run_analysis.R)  
     d. execute the script: run_analysis()  
   
 The script generates the tidy_data2.txt file in current working directory.
 This file can be read in with the following R code:
    read.table("tidy_data2.txt", header = TRUE)
 

Inside run_analysis.R
=====================

This section details steps taken within run_analysis.R to achieve the 
course project's five steps.  
  The instructions for this progect are below:  
    You should create one R script called run_analysis.R that does the following:  
        1. Merges the training and the test sets to create one data set.  
        2. Extracts only the measurements on the mean and standard deviation for each measurement.  
        3. Uses descriptive activity names to name the activities in the data set  
        4. Appropriately labels the data set with descriptive variable names.  
        5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
		   
The flow of run_analysis.R is as follows:  
  - read in all the necessary data files:  
  	    - features.txt  
		- subject_test.txt  
		- X_test.txt  
		- y_test.txt  
		- subject_train.txt  
		- X_train.txt  
		- y_train.txt  
  - add subject data (from subject_test.txt and subject_train.txt) and activity data(from y_test.txt and y_train.txt) as the first two columns with the test and training data sets (X_test and X_train)
  - combine the test and training data sets (with subject and activity included) into one data set
  - determine from features.txt which columns contain mean and standard deviation measurements
  - extract those columns from the data set 
  - using the activity lables from activity_labels.txt, change the values in the activity column from numbers to descriptive activity names
  - add descriptive variable names based on features.txt 
  - transform the data into long format
  - group the data by "subject, activity, variable" and calculate the mean
  - write the data out to tidy_data2.txt
  
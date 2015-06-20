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
  a. Install the R packages dplyr and reshape2, if not already installed
  b. set the working directory to the location of the script and the data directory
  c. source the script (run_analysis.R)
  d. execute the script: run_analysis()
   
 The script generates the tidy_data2.txt file in current working directory.
	    
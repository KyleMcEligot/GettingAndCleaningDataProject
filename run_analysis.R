##
##  This file contains the code for the "Getting and Cleaning Data"
##  course project.The function is run_analysis()
##
##  1.  Merges the training and the test sets to create one data set.
##  2.	Extracts only the measurements on the mean and standard deviation for 
##      each measurement. 
##  3.  Uses descriptive activity names to name the activities in the data set
##  4.	Appropriately labels the data set with descriptive variable names. 
##  5.	From the data set in step 4, creates a second, independent tidy data 
##      set with the average of each variable for each activity and 
##      each subject.
##

run_analysis <- function() {

## --------------------------------------------------------------------------
##
##  Read in the data files:
##  
##     data/train/X_train.txt       - training data set
##     data/train/y_train.txt       - training/activity type
##     data/train/subject.txt       - subject performing training activity
##     data/test/X_test.txt         - test data set
##     data/test/y_test.txt         - test/activity type
##     data/test/subject.txt        - subject performing test activity
##     data/features.txt            - list of features 
##                                    ("names" for data columns)
##     
##  

## read in training data
train_file_path <- "data/train/X_train.txt"
train_data <- read.table(train_file_path, header = FALSE)

## read in test data
test_file_path <- "data/test/X_test.txt"
test_data <- read.table(test_file_path, header = FALSE)

## Read in file containing header information; 
## use for column names for training & test data
features_file_path <- "data/features.txt"
features_data <- read.table(features_file_path, header = FALSE)
features <- features_data[,2]

## read in the acitivies data - for test data
test_activities_file_path <- "data/test/y_test.txt"
test_activities_data <- read.table(test_activities_file_path, header = FALSE)
names(test_activities_data) <- "activity"

## read in the activities data - for training data
train_activities_file_path <- "data/train/y_train.txt"
train_activities_data <- read.table(train_activities_file_path, header = FALSE)
names(train_activities_data) <- "activity"

## read in the subject data - for test data
test_subject_file_path <- "data/test/subject_test.txt"
test_subject_data <- read.table(test_subject_file_path, header = FALSE)
names(test_subject_data) <- "subject"

## read in the subject data - for training data
train_subject_file_path <- "data/train/subject_train.txt"
train_subject_data <- read.table(train_subject_file_path, header = FALSE)
names(train_subject_data) <- "subject"

##  Create data set for test data with subject & activity column added
test_data2 <- cbind(test_subject_data, test_activities_data, test_data)

##  Create data set for training data with subject & activity column added
train_data2 <- cbind(train_subject_data, train_activities_data, train_data)


## -----------------------------------------------------------------------------
##
## Step 1 of assignment
##        Merge the training and the test sets to create one data set
merged_data <- rbind(train_data2, test_data2)


## -----------------------------------------------------------------------------
##
## Step 2 of assignment
##        Extract only the measurements on the mean and standard deviation for 
##        each measurement.

## Determine which columns contain "mean(" or "std("
mean_cols <-  grep(".*-mean\\(.*", features, perl=TRUE, value=TRUE)
std_cols <- grep(".*-std\\(.*", features, perl=TRUE, value=TRUE)

## Obtain column numbers for mean & std columns
mean_col_nums <-  grep(".*-mean\\(.*", features_data[,2], perl=TRUE, value=FALSE)
std_col_nums <- grep(".*-std\\(.*", features_data[,2], perl=TRUE, value=FALSE)
col_nums <- sort(c(mean_col_nums, std_col_nums))

## Eliminate all measurement columns that are not mean or std columns
mean_std_data <- merged_data[,c(1,2,col_nums + 2)]

## -----------------------------------------------------------------------------
##
## Step 3 of assignment
##        Use descriptive activity names to name the activities in the data set

## key for descriptive labels comes from data/activity_labels.txt
mean_std_data$activity[mean_std_data$activity == 1] <- "Walking"
mean_std_data$activity[mean_std_data$activity == 2] <- "Walking Upstairs"
mean_std_data$activity[mean_std_data$activity == 3] <- "Walking Downstairs"
mean_std_data$activity[mean_std_data$activity == 4] <- "Sitting"
mean_std_data$activity[mean_std_data$activity == 5] <- "Standing"
mean_std_data$activity[mean_std_data$activity == 6] <- "Laying"

## -----------------------------------------------------------------------------
##
## Step 4 of assignment
##        Appropriately labels the data set with descriptive variable names. 

## the names come from data/features.txt, which was read in earlier
names(mean_std_data) <- 
    c("subject", "activity", c(as.character(features[c(col_nums)])))

## -----------------------------------------------------------------------------
##
## Step 5 of assignment
##      From the data set in step 4, creates a second, independent tidy data 
##      set with the average of each variable for each activity and 
##      each subject.

## Step 4 results in tidy data in the wide form. In step 5, we first 
## translate this to the long form.
library(reshape2)
long_form_data <- melt(mean_std_data, id.vars = c("subject", "activity"))

library(dplyr)
long_form_grouped <- group_by(long_form_data, subject, activity, variable)
long_form_means <- summarize(long_form_grouped, mean(value))

## -----------------------------------------------------------------------------
##
##  Write out the resulting tidy file

write.table(long_form_means, file = "tidy_data2.txt", row.names = FALSE)

}
